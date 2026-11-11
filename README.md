# 😴 NoSleep

**Stop jiggling your mouse. Stop holding spacebar in Notepad. Stop playing videos on loop.**

NoSleep keeps your Windows session — and your Teams status — **Available** with one tiny PowerShell script and a live dashboard. No installs, no admin rights, no weird tricks.

![Windows](https://img.shields.io/badge/Windows-0078D6?logo=windows&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white)
![Admin](https://img.shields.io/badge/Admin-Not%20required-brightgreen)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

![NoSleep live dashboard](docs/assets/demo.svg)

## Not technical? Start here — 2 minutes, nothing to type

1. Click the green **Code** button at the top of this page, then **Download ZIP**.
2. Open the downloaded ZIP and click **Extract All**.
3. Open the extracted folder and **double-click the launcher you want**:
   - `Start-NoSleep.bat` — for Teams (normal use)
   - `Start-NoSleep-Presentation.bat` — for screen shares
   - `Start-NoSleep-Focus.bat` — with a focus timer
   - If Windows says "protected your PC", click **More info → Run anyway**. If Windows blocks the file, right-click the ZIP → Properties → tick **Unblock** → OK, then extract again.
4. A black window opens with the dashboard. **Leave it open** — while it's open, your system stays awake and your Teams stays Available.
5. To stop, just close the window.

That's it. No installs, no accounts, no commands. Keep all the files together in the folder.

## The tricks everyone uses (and why they suck)

| Trick | The problem |
|---|---|
| Mouse jiggler app / auto mouse mover | Extra software, IT flags it, looks dodgy |
| Notepad + holding the spacebar | Fills your document with spaces and blocks your keyboard |
| Video on loop | Wastes bandwidth, obvious on a screen share |
| Taping a key down | Really? |
| **NoSleep** | One script, an honest heartbeat, a dashboard that shows it working ✅ |

## What it does

- Sends a **Scroll Lock heartbeat** every 60 seconds, so Windows never thinks you're idle
- Your **Teams status stays Available (green)** instead of flipping to Away
- Live **Insomnia System Dashboard** in the terminal: status, uptime, cycle count, progress bars
- Stops cleanly with `Ctrl+C` — nothing keeps running after you close it

## Why Scroll Lock?

Scroll Lock does nothing in almost every app, so toggling it is invisible. It registers as activity with Windows without typing anything, moving anything, or touching any window. That's the whole trick — there is no trick.

## Quick start (for developers)

**Fork it first** — that's the point. Hit **Fork** (top-right), then clone *your* fork:

```powershell
git clone https://github.com/<your-username>/nosleep.git
cd nosleep
.\nosleep.ps1
```

Prefer a fresh copy with no fork link? Hit **Use this template** instead. Or just download `nosleep.ps1` and run it.

Press `Ctrl+C` to stop.

## Modes

One script, three presets. Pick the one that fits what you're doing:

| Mode | Interval | What changes | Run it / double-click |
|---|---|---|---|
| **Teams** (default) | 60s | Full dashboard — for keeping Teams Available | `.\nosleep.ps1` / `Start-NoSleep.bat` |
| **Presentation** | 240s | Quiet — one line per cycle, no screen clearing, stays out of the way on a screen share | `.\nosleep.ps1 -mode Presentation` / `Start-NoSleep-Presentation.bat` |
| **Focus** | 45s | Full dashboard + a focus-session timer | `.\nosleep.ps1 -mode Focus` / `Start-NoSleep-Focus.bat` |

An explicit `-sleep` always overrides the mode's interval:

```powershell
.\nosleep.ps1 -mode Presentation -sleep 120
```

### Make it yours — add your own mode

That's what the fork is for. One line in `nosleep.ps1`, in the `$modes` table:

```powershell
DeepWork = @{ Interval = 90; Quiet = $false }
```

Then run it:

```powershell
.\nosleep.ps1 -mode DeepWork
```

## How it works

Each cycle:

1. **Heartbeat** — toggles Scroll Lock twice (on, off) via `WScript.Shell`. Windows sees activity; nothing on screen changes.
2. **Countdown** — a live progress bar counts down the cycle.
3. **Dashboard** — uptime, cycles, session progress and uptime indicators refresh.
4. **Repeat** — until you stop the script.

## Parameters

| Parameter | Default | Description |
|---|---|---|
| `-mode` | `Teams` | Preset: `Teams`, `Presentation`, or `Focus` — sets the interval and dashboard style |
| `-sleep` | mode's interval | Cycle length in seconds (the countdown bar steps at `sleep * 10` ms per percent); overrides the mode's interval |

## Requirements

- Windows
- PowerShell 5.1+ (Windows PowerShell or PowerShell 7+)

## Notes

- Keep the PowerShell window open while you want to stay awake.
- Scroll Lock may briefly flash on keyboards that have an LED for it.
- Local only — nothing leaves your machine, no admin rights needed for normal use.

## License

MIT — see [LICENSE](LICENSE).
