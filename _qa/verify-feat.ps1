param([string]$PageUrl = 'file:///C:/Users/divy1/OneDrive/Desktop/Divyansh%20all%20codes/Cafe%20WebSite/gallery.html',
      [string]$ShotOut = 'C:\Users\divy1\OneDrive\Desktop\Divyansh all codes\Cafe WebSite\_qa\lb-open.png',
      [int]$Width = 1440,
      [int]$Height = 900,
      [int]$SettleMs = 2500)

$chrome = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$ud = "$env:TEMP\olive-cdp-profile"
$proc = Start-Process $chrome -ArgumentList @('--headless=new','--disable-gpu','--remote-debugging-port=9448',"--user-data-dir=$ud",'--allow-file-access-from-files','--hide-scrollbars','about:blank') -PassThru

try {
  $ver = $null
  $deadline = (Get-Date).AddSeconds(30)
  while (-not $ver -and (Get-Date) -lt $deadline) {
    Start-Sleep -Milliseconds 300
    try { $ver = Invoke-RestMethod 'http://127.0.0.1:9448/json/version' } catch { }
  }
  if (-not $ver) { throw 'CDP endpoint did not come up' }

  $tabs = Invoke-RestMethod 'http://127.0.0.1:9448/json'
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
  function Eval-JS([string]$expr) {
    $resp = Wait-Response (Send-Cdp @{ method = 'Runtime.evaluate'; params = @{ expression = $expr; returnByValue = $true; awaitPromise = $true } })
    if ($resp -and $resp.result.result) { return $resp.result.result.value }
    return $null
  }

  $null = Wait-Response (Send-Cdp @{ method = 'Page.enable' })
  $null = Wait-Response (Send-Cdp @{ method = 'Emulation.setDeviceMetricsOverride'; params = @{ width = $Width; height = $Height; deviceScaleFactor = 1; mobile = $false } })
  $null = Wait-Response (Send-Cdp @{ method = 'Page.navigate'; params = @{ url = $PageUrl } })
  Start-Sleep -Milliseconds $SettleMs

  $out = @{}
  $out.jsClass = Eval-JS 'document.documentElement.classList.contains("js")'
  $out.revealNodes = Eval-JS 'document.querySelectorAll("[data-reveal]").length'
  $out.revealVisible = Eval-JS 'document.querySelectorAll("[data-reveal].is-visible").length'
  $out.gItems = Eval-JS 'document.querySelectorAll(".gallery-item").length'
  $out.gRole = Eval-JS 'document.querySelector(".gallery-item").getAttribute("role")'
  $out.gTab = Eval-JS 'document.querySelector(".gallery-item").getAttribute("tabindex")'
  $out.lbExists = Eval-JS '!!document.querySelector(".lightbox")'
  $null = Eval-JS 'document.querySelector(".gallery-item").click(); 1'
  Start-Sleep -Milliseconds 500
  $out.lbOpen = Eval-JS 'document.querySelector(".lightbox").classList.contains("is-open")'
  $out.ovf = Eval-JS 'document.body.style.overflow'
  $out.cap1 = Eval-JS 'document.querySelector(".lightbox__caption").textContent.trim().slice(0,18)'
  $out.imgW = Eval-JS 'document.querySelector(".lightbox__img").src.slice(0,46)'
  $null = Eval-JS 'document.querySelector(".lightbox__nav--next").click(); 1'
  Start-Sleep -Milliseconds 300
  $out.cap2 = Eval-JS 'document.querySelector(".lightbox__caption").textContent.trim().slice(0,18)'
  $shot = Wait-Response (Send-Cdp @{ method = 'Page.captureScreenshot'; params = @{ format = 'png' } })
  if ($shot -and $shot.result.data) { [System.IO.File]::WriteAllBytes($ShotOut, [Convert]::FromBase64String($shot.result.data)) }
  $null = Eval-JS 'document.querySelector(".lightbox__close").click(); 1'
  Start-Sleep -Milliseconds 400
  $out.afterClose = Eval-JS 'document.querySelector(".lightbox").classList.contains("is-open")'
  $out.ovf2 = Eval-JS 'document.body.style.overflow||"empty"'

  ($out.GetEnumerator() | Sort-Object Name | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join " || "
  $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, 'done', $ct).Wait(2000)
} finally {
  Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
  Get-CimInstance Win32_Process -Filter "Name='chrome.exe'" -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -like '*olive-cdp-profile*' } |
    ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
}