param(
    [ValidateSet("Teams", "Presentation", "Focus")]
    [string]$mode = "Teams",
    $sleep = 60
)

# Modes — one line per preset. Fork this repo and add your own here:
#   DeepWork = @{ Interval = 90; Quiet = $false }
# then run: .\nosleep.ps1 -mode DeepWork
$modes = @{
    Teams        = @{ Interval = 60;  Quiet = $false }
    Presentation = @{ Interval = 240; Quiet = $true  }
    Focus        = @{ Interval = 45;  Quiet = $false }
}

# An explicit -sleep always wins over the mode's interval.
if (-not $PSBoundParameters.ContainsKey('sleep')) { $sleep = $modes[$mode].Interval }
$quiet = $modes[$mode].Quiet

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

function Send-Heartbeat
{
    $WShell.SendKeys("{SCROLLLOCK}")
    Start-Sleep -Milliseconds 200
    $WShell.SendKeys("{SCROLLLOCK}")
}

while ($true)
{

if ($quiet)
{
    # Presentation mode: one quiet line per cycle, no screen clearing,
    # so it stays out of the way while you share your screen.
    Send-Heartbeat
    Write-Host "NoSleep [$mode] — cycle $cycle — uptime $($stopwatch.Elapsed.ToString('hh\:mm\:ss')) — next beat in ${sleep}s" -ForegroundColor DarkGray
    $cycle++
    Start-Sleep -Seconds $sleep
    continue
}

Clear-Host

Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor DarkCyan
Write-Host "║          INSOMNIA SYSTEM DASHBOARD         ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor DarkCyan

Write-Host ""
Write-Host "STATUS  : ACTIVE" -ForegroundColor Green
Write-Host "MODE    : $mode" -ForegroundColor White
Write-Host "UPTIME  : $($stopwatch.Elapsed.ToString('dd\.hh\:mm\:ss'))" -ForegroundColor Magenta
if ($mode -eq "Focus")
{
    Write-Host "FOCUS   : $($stopwatch.Elapsed.ToString('hh\:mm\:ss')) in the zone" -ForegroundColor Cyan
}
Write-Host "CYCLES  : $cycle" -ForegroundColor Yellow
Write-Host ""

Write-Host "Heartbeat Signal" -ForegroundColor Red
Send-Heartbeat

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
