param([string]$PageUrl = 'file:///C:/Users/divy1/OneDrive/Desktop/Divyansh%20all%20codes/Cafe%20WebSite/_qa/probe.html',
      [string]$OutFile = 'C:\Users\divy1\OneDrive\Desktop\Divyansh all codes\Cafe WebSite\_qa\probe-results.txt',
      [int]$TimeoutSec = 300)

$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$ud = "$env:TEMP\olive-cdp-profile"
$proc = Start-Process $chrome -ArgumentList @('--headless=new','--disable-gpu','--remote-debugging-port=9444',"--user-data-dir=$ud",'--allow-file-access-from-files','--hide-scrollbars','about:blank') -PassThru

try {
  $ver = $null
  $deadline = (Get-Date).AddSeconds(30)
  while (-not $ver -and (Get-Date) -lt $deadline) {
    Start-Sleep -Milliseconds 300
    try { $ver = Invoke-RestMethod 'http://127.0.0.1:9444/json/version' } catch { }
  }
  if (-not $ver) { throw 'CDP endpoint did not come up' }

  $tabs = Invoke-RestMethod 'http://127.0.0.1:9444/json'
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
    $buf = New-Object byte[] 1048576
    $seg = New-Object System.ArraySegment[byte] -ArgumentList @(,$buf)
    $sb = New-Object System.Text.StringBuilder
    do {
      $r = $ws.ReceiveAsync($seg, $ct).Result
      if ($r.Count -gt 0) { [void]$sb.Append([System.Text.Encoding]::UTF8.GetString($buf, 0, $r.Count)) }
    } while (-not $r.EndOfMessage)
    return $sb.ToString()
  }
  function Invoke-Eval([string]$expr) {
    $id = Send-Cdp @{ method = 'Runtime.evaluate'; params = @{ expression = $expr; returnByValue = $true; awaitPromise = $true } }
    $deadline = (Get-Date).AddSeconds(60)
    while ((Get-Date) -lt $deadline) {
      $raw = Receive-Cdp
      $m = $raw | ConvertFrom-Json
      if ($m.id -eq $id) {
        if ($m.result.exceptionDetails) { return $null }
        return $m.result.result.value
      }
    }
    return $null
  }

  $null = Send-Cdp @{ method = 'Page.enable' }
  $null = Send-Cdp @{ method = 'Page.navigate'; params = @{ url = $PageUrl } }

  $deadline = (Get-Date).AddSeconds($TimeoutSec)
  $state = ''
  while ((Get-Date) -lt $deadline) {
    Start-Sleep -Seconds 2
    $state = Invoke-Eval 'document.title'
    if ($state -eq 'probe-done') { break }
  }
  $data = Invoke-Eval 'document.getElementById("out").textContent'
  if ($data -and $data.StartsWith('@@RESULTS@@')) {
    [System.IO.File]::WriteAllText($OutFile, $data, (New-Object System.Text.UTF8Encoding($false)))
    Write-Output ("OK bytes=" + $data.Length)
  } else {
    $preview = '(null)'
    if ($data) { $preview = $data.Substring(0, [Math]::Min(120, $data.Length)) }
    Write-Output ("FAILED state=" + $state + " data=" + $preview)
  }
  $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, 'done', $ct).Wait(2000)
} finally {
  Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
  Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -like '*olive-cdp-profile*' } |
    ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
}
