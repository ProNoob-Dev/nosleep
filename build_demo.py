#!/usr/bin/env python3
"""Generate docs/assets/demo.svg — an animated terminal demo of nosleep.ps1.

SMIL animation: countdown bar fills and loops, uptime/cycles tick, the
SCROLL LOCK keycap flashes twice per cycle (the double SendKeys heartbeat).
Static attribute values are set to a mid-state so the first frame still
looks alive if the viewer never runs the animation.
"""
import os

SVG = """<svg xmlns="http://www.w3.org/2000/svg" width="760" height="470" viewBox="0 0 760 470" role="img" aria-label="NoSleep terminal dashboard demo">
  <rect x="6" y="6" width="748" height="458" rx="10" fill="#0d1117" stroke="#30363d"/>
  <circle cx="28" cy="26" r="6" fill="#ff5f57"/>
  <circle cx="48" cy="26" r="6" fill="#febc2e"/>
  <circle cx="68" cy="26" r="6" fill="#28c840"/>
  <text x="380" y="31" text-anchor="middle" fill="#8b949e" font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace" font-size="13">powershell  —  .\\nosleep.ps1</text>
  <line x1="6" y1="44" x2="754" y2="44" stroke="#30363d"/>
  <g font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace">
    <rect x="40" y="60" width="680" height="54" rx="6" fill="#0d1117" stroke="#164e63"/>
    <text x="380" y="94" text-anchor="middle" fill="#22d3ee" font-size="17" letter-spacing="3">INSOMNIA SYSTEM DASHBOARD</text>

    <text x="40" y="152" fill="#8b949e" font-size="15">STATUS  :</text>
    <circle cx="148" cy="147" r="5" fill="#3fb950">
      <animate attributeName="opacity" values="1;0.2;1" dur="1.2s" repeatCount="indefinite"/>
    </circle>
    <text x="162" y="152" fill="#3fb950" font-size="15">ACTIVE</text>

    <text x="40" y="180" fill="#8b949e" font-size="15">UPTIME  :</text>
    <text x="150" y="180" fill="#d2a8ff" font-size="15">00.00:04:12<animate attributeName="opacity" values="1;1;0;0;1" keyTimes="0;0.33;0.34;0.99;1" dur="6s" repeatCount="indefinite"/></text>
    <text x="150" y="180" fill="#d2a8ff" font-size="15" opacity="0">00.00:04:13<animate attributeName="opacity" values="0;0;1;1;0" keyTimes="0;0.33;0.34;0.66;1" dur="6s" repeatCount="indefinite"/></text>
    <text x="150" y="180" fill="#d2a8ff" font-size="15" opacity="0">00.00:04:14<animate attributeName="opacity" values="0;0;1;1;0" keyTimes="0;0.66;0.67;0.99;1" dur="6s" repeatCount="indefinite"/></text>

    <text x="40" y="208" fill="#8b949e" font-size="15">CYCLES  :</text>
    <text x="150" y="208" fill="#e3b341" font-size="15">12<animate attributeName="opacity" values="1;1;0;0;1" keyTimes="0;0.33;0.34;0.99;1" dur="6s" repeatCount="indefinite"/></text>
    <text x="150" y="208" fill="#e3b341" font-size="15" opacity="0">13<animate attributeName="opacity" values="0;0;1;1;0" keyTimes="0;0.33;0.34;0.66;1" dur="6s" repeatCount="indefinite"/></text>
    <text x="150" y="208" fill="#e3b341" font-size="15" opacity="0">14<animate attributeName="opacity" values="0;0;1;1;0" keyTimes="0;0.66;0.67;0.99;1" dur="6s" repeatCount="indefinite"/></text>

    <text x="40" y="246" fill="#f85149" font-size="15">Heartbeat Signal</text>
    <rect x="560" y="226" width="160" height="28" rx="5" fill="#21262d" stroke="#30363d">
      <animate attributeName="fill" values="#21262d;#3fb950;#21262d;#3fb950;#21262d" keyTimes="0;0.05;0.1;0.15;0.2;1" dur="8s" repeatCount="indefinite"/>
    </rect>
    <text x="640" y="245" text-anchor="middle" fill="#e6edf3" font-size="12">SCROLL LOCK</text>

    <text x="40" y="290" fill="#8b949e" font-size="13">Signal Countdown:</text>
    <text x="720" y="290" text-anchor="end" fill="#8b949e" font-size="12">next beat in 60s</text>
    <rect x="40" y="298" width="680" height="16" rx="3" fill="#21262d"/>
    <rect x="40" y="298" width="462" height="16" rx="3" fill="#3fb950">
      <animate attributeName="width" values="0;680" dur="8s" repeatCount="indefinite"/>
    </rect>

    <text x="40" y="348" fill="#8b949e" font-size="13">Session Progress:</text>
    <rect x="40" y="356" width="680" height="16" rx="3" fill="#21262d"/>
    <rect x="40" y="356" width="272" height="16" rx="3" fill="#22d3ee">
      <animate attributeName="width" values="0;680" dur="12s" repeatCount="indefinite"/>
    </rect>

    <text x="40" y="406" fill="#8b949e" font-size="13">Uptime Indicator:</text>
    <rect x="40" y="414" width="680" height="16" rx="3" fill="#21262d"/>
    <rect x="40" y="414" width="238" height="16" rx="3" fill="#d2a8ff">
      <animate attributeName="width" values="0;680" dur="16s" repeatCount="indefinite"/>
    </rect>

    <text x="40" y="452" fill="#6e7681" font-size="12">Press Ctrl+C to stop — nothing keeps running after you close it.</text>
  </g>
</svg>
"""

os.makedirs("docs/assets", exist_ok=True)
with open("docs/assets/demo.svg", "w", encoding="utf-8") as f:
    f.write(SVG)
print("wrote docs/assets/demo.svg", len(SVG), "bytes")
