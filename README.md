# NoSleep

Keep your Windows session awake with a live terminal dashboard. Simulates activity by toggling Scroll Lock so the system does not idle or sleep while the script is running.

## Features

- Prevents idle sleep / lock by sending Scroll Lock key presses
- Live **Insomnia System Dashboard** in the console
- Uptime, cycle count, and progress bars
- Configurable heartbeat interval

## Requirements

- Windows
- PowerShell 5.1+ (Windows PowerShell or PowerShell 7+)

## Usage

From PowerShell:

```powershell
.\nosleep.ps1
```

Optional: set the countdown cycle length in seconds (default `60`):

```powershell
.\nosleep.ps1 -sleep 30
```

Press `Ctrl+C` to stop.

## How it works

Each cycle:

1. Toggles Scroll Lock twice (heartbeat) via `WScript.Shell`
2. Shows a countdown progress bar
3. Updates session and uptime indicators
4. Repeats until you stop the script

## Script parameter

| Parameter | Default | Description |
|-----------|---------|-------------|
| `-sleep`  | `60`    | Base interval used for the countdown bar timing (`sleep * 10` ms per percent step) |

## Notes

- Keep the PowerShell window open while you want the session kept awake.
- Scroll Lock may briefly flash on keyboards that have an LED for it.
- This is a local utility; it does not require admin rights for normal use.

## License

MIT — see [LICENSE](LICENSE).
