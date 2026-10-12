param([string]$PageUrl = 'file:///C:/Users/divy1/OneDrive/Desktop/Divyansh%20all%20codes/Cafe%20WebSite/index.html',
      [string]$OutFile = 'C:\Users\divy1\OneDrive\Desktop\Divyansh all codes\Cafe WebSite\_qa\shot.png',
      [int]$Width = 1440,
      [int]$Height = 4800,
      [int]$SettleMs = 5000)

$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$ud = "$env:TEMP\olive-cdp-profile"
$proc = Start-Process $chrome -ArgumentList @('--headless=new','--disable-gpu','--remote-debugging-port=9446',"--user-data-dir=$ud",'--allow-file-access-from-files','--hide-scrollbars','about:blank') -PassThru

try {
  $ver = $null
  $deadline = (Get-Date).AddSeconds(30)
  while (-not $ver -and (Get-Date) -lt $deadline) {
    Start-Sleep -Milliseconds 300
    try { $ver = Invoke-RestMethod 'http://127.0.0.1:9446/json/version' } catch { }
  }
  if (-not $ver) { throw 'CDP endpoint did not come up' }

  $tabs = Invoke-RestMethod 'http://127.0.0.1:9446/json'
  $tab = $tabs | Where-Object { $_.type -eq 'page' } | Select-Object -First 1

  $ws = New-Object System.Net.WebSockets.ClientWebSocket
  $ct = [System.Threading.CancellationToken]::None
  $ws.ConnectAsync([Uri]$tab.webSocketDebuggerUrl, $ct).Wait()

  $msgId = 0
  function Send-Cdp($obj) {
    $script:msgId++
    $obj.id = $script:msgId
    $json = $obj | ConvertTo-Json -Depth 8 -Compress
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
    $seg = New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)
    $null = $ws.SendAsync($seg, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, $ct).Wait(5000)
    return $script:msgId
  }
  function Receive-Cdp() {
    $buf = New-Object byte[] 8388608
    $seg = New-Object System.ArraySegment[byte] -ArgumentList @(,$buf)
    $sb = New-Object System.Text.StringBuilder
    do {
      $r = $ws.ReceiveAsync($seg, $ct).Result
      if ($r.Count -gt 0) { [void]$sb.Append([System.Text.Encoding]::UTF8.GetString($buf, 0, $r.Count)) }
    } while (-not $r.EndOfMessage)
    return $sb.ToString()
  }
  function Wait-Response([int]$id) {
    $deadline = (Get-Date).AddSeconds(30)
    while ((Get-Date) -lt $deadline) {
      $raw = Receive-Cdp
      $m = $raw | ConvertFrom-Json
      if ($m.id -eq $id) { return $m }
    }
    return $null
  }

  $null = Wait-Response (Send-Cdp @{ method = 'Page.enable' })
  $null = Wait-Response (Send-Cdp @{ method = 'Emulation.setDeviceMetricsOverride'; params = @{ width = $Width; height = $Height; deviceScaleFactor = 1; mobile = $false } })
  $null = Wait-Response (Send-Cdp @{ method = 'Page.navigate'; params = @{ url = $PageUrl } })
  Start-Sleep -Milliseconds $SettleMs

  $shot = Wait-Response (Send-Cdp @{ method = 'Page.captureScreenshot'; params = @{ format = 'png' } })
  if ($shot -and $shot.result.data) {
    [System.IO.File]::WriteAllBytes($OutFile, [Convert]::FromBase64String($shot.result.data))
    Write-Output ("OK " + (Get-Item $OutFile).Length + " bytes")
  } else {
    Write-Output 'FAILED to capture screenshot'
  }
  $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, 'done', $ct).Wait(2000)
} finally {
  Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
  Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -like '*olive-cdp-profile*' } |
    ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
}