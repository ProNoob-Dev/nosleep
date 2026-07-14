param($sleep = 60)

Clear-Host

$WShell = New-Object -com "Wscript.Shell"
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

$cycle = 0

function Draw-Bar($percent,$color)
{
    $barLength = 30
    $filled = [math]::Floor(($percent/100)*$barLength)
    $empty = $barLength - $filled

    Write-Host "[" -NoNewline -ForegroundColor DarkGray

    for ($i=0;$i -lt $filled;$i++)
    {
        Write-Host "█" -NoNewline -ForegroundColor $color
    }

    for ($i=0;$i -lt $empty;$i++)
    {
        Write-Host "░" -NoNewline -ForegroundColor DarkGray
    }

    Write-Host "] $percent%" -ForegroundColor White
}

while ($true)
{

Clear-Host

Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor DarkCyan
Write-Host "║          INSOMNIA SYSTEM DASHBOARD         ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor DarkCyan

Write-Host ""
Write-Host "STATUS  : ACTIVE" -ForegroundColor Green
Write-Host "UPTIME  : $($stopwatch.Elapsed.ToString('dd\.hh\:mm\:ss'))" -ForegroundColor Magenta
Write-Host "CYCLES  : $cycle" -ForegroundColor Yellow
Write-Host ""

Write-Host "Heartbeat Signal" -ForegroundColor Red
$WShell.SendKeys("{SCROLLLOCK}")
Start-Sleep -Milliseconds 200
$WShell.SendKeys("{SCROLLLOCK}")

Write-Host ""
Write-Host "Signal Countdown:" -ForegroundColor Gray

for ($i=0;$i -le 100;$i++)
{
    Write-Host "`r" -NoNewline
    Draw-Bar $i "Green"

    Start-Sleep -Milliseconds ($sleep*10)
}

Write-Host ""
Write-Host "Session Progress:" -ForegroundColor Gray

$sessionPercent = ($cycle % 20) * 5
Draw-Bar $sessionPercent "Cyan"

Write-Host ""
Write-Host "Uptime Indicator:" -ForegroundColor Gray

$uptimePercent = [math]::Min(100,$stopwatch.Elapsed.TotalMinutes)
Draw-Bar $uptimePercent "Magenta"

$cycle++

Start-Sleep -Milliseconds 500

}