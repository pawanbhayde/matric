# Matric

<p align="center">
  <strong>The open-source, high-performance macOS system monitor and developer workspace companion.</strong><br>
  <em>Understand apps, background workers, developer runtimes, listening ports, and performance spikes — 100% locally and privately.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-macOS%2014.0%2B%20%7C%20Apple%20Silicon%20%26%20Intel-000000?style=flat-square&logo=apple&logoColor=white" alt="Platform: macOS 14.0+">
  <img src="https://img.shields.io/badge/Swift-5.10%2B%20%2F%20Swift%206-FA7343?style=flat-square&logo=swift&logoColor=white" alt="Swift 5.10+">
  <img src="https://img.shields.io/badge/UI-SwiftUI%20%2B%20AppKit-0A84FF?style=flat-square" alt="SwiftUI + AppKit">
  <img src="https://img.shields.io/badge/Telemetry-0%25%20Offline-34C759?style=flat-square" alt="100% Offline">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="License: MIT">
  <img src="https://img.shields.io/badge/PRs-Welcome-brightgreen?style=flat-square" alt="PRs Welcome">
</p>

---

## 🌟 Why Matric?

The standard macOS **Activity Monitor** is powerful, but it presents a flat, cluttered wall of disconnected UNIX threads, anonymous helpers, and obscure daemon processes. It offers zero awareness of development servers, open TCP ports, or project repositories, and forgets everything the moment you close it.

**Matric** is an open-source, native macOS system monitor and developer workspace companion built with **SwiftUI** and **AppKit**.

### Core Tenets
1. **Intelligent App Grouping**: Helper processes, web renderers, and background workers are automatically rolled up into their parent applications.
2. **Developer-First Command Center**: Instantly discovers local dev servers, listening TCP ports, project folders, and active Git branches with 1-click IDE and browser launchers.
3. **30-Day Historical Time-Travel**: Scrub backward in time to see exactly what applications and processes caused CPU or memory spikes hours or days ago.
4. **100% Local & Private**: Zero cloud sync, zero telemetry, zero analytics. Everything runs locally on your Mac.
5. **Battery & Resource Friendly**: Highly optimized Darwin/Mach kernel polling with adaptive refresh rates (faster when visible, throttled when minimized).

---

## 🚀 Key Features

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  Matric Window Layout                                                                  │
├─────────────────────┬──────────────────────────────────────────────────────────────────┤
│ SIDEBAR             │ MAIN CONTENT VIEW                                                │
│                     │                                                                  │
│  RESOURCES          │  • Dynamic Header (Live KPI Metrics, Status Badges & Counters)   │
│   • Overview        │  • Summary KPI Cards Grid (CPU, RAM, Disk, Net, GPU, Battery)    │
│   • CPU             │  • Interactive Timeline Scrubbing Chart (1m / 5m / 10m)          │
│   • Memory          │  • High-Density Drill-Down Tables (Apps, Ports, Volumes, Trees)  │
│   • Disk            │                                                                  │
│   • Network         ├──────────────────────────────────────────────────────────────────┤
│   • Graphics        │ STATUS FOOTER                                                    │
│   • Battery         │  🔒 Local & Private  │  ● Live · 2s Refresh  │ Attribution Notes │
│   • Storage Space   │                                                                  │
│                     │                                                                  │
│  WORKSPACE          │                                                                  │
│   • Projects        │                                                                  │
│   • History         │                                                                  │
│   • Alerts          │                                                                  │
│   • Saved Moments   │                                                                  │
│   • System Cleanup  │                                                                  │
└─────────────────────┴──────────────────────────────────────────────────────────────────┘
```

### 1. 📊 Hardware & System Telemetry
- **CPU Deep Dive**: Total utilization, User vs. System kernel load, 1-minute/5-minute load averages, per-core utilization meters, and live timeline graphs.
- **Memory & Pressure**: Real-time breakdown of Active, Wired (unpageable kernel memory), Compressed, and Swap storage, accompanied by the native macOS memory pressure state (`Normal`, `Elevated`, `Critical`).
- **Disk I/O Throughput**: Live read and write throughput in MB/s via `IOKit`, mounted APFS volume breakdown, and per-app read/write statistics.
- **Network Bandwidth**: Inbound download and outbound upload bandwidth curves, active interface enumeration (`en0`, `bridge0`, `awdl0`, VPN tunnels), and physical vs. virtual interface classification.
- **Apple Silicon GPU**: Real-time GPU compute load percentage, driver-allocated graphics memory, and macOS thermal throttling state.
- **Battery & Power Draw**: Instantaneous wattage draw (W), battery temperature (°C), battery health percentage, cycle count, power source detection, and connected peripheral battery levels (Magic Keyboard, Trackpad, AirPods).

### 2. 🧩 Intelligent App & Process Grouping
- **Hierarchical Process Tree**: Automatically rolls up dozens of headless helper processes (e.g. Chrome Renderers, Electron Helpers, Slack Web Workers, VS Code Language Servers) into their visible parent application.
- **Process Inspector Sheet**: Click any app to open a detailed breakdown displaying every child process, its PID, dedicated CPU %, physical memory footprint, and quick actions (`Show in Finder`, graceful `SIGTERM` stop, force `SIGKILL`).

### 3. 🛠️ Developer Projects & Port Command Center
A purpose-built workspace for software engineers and creators:
- **Real-Time KPI Summary Bar**: Top-level metrics for **Active Services**, **Open TCP Ports**, **Dev Memory Usage**, and **Dev CPU Load**.
- **Dual-View Mode**:
  - **Rich Cards View**: Framework-branded project cards with live status pills, memory footprints, port badges, and quick IDE launchers.
  - **High-Density Ports Table**: Compact, columnar table displaying Port number, `LISTEN` socket status, Runtime badge, Project path, Git branch, PID, Resource usage, and inline action buttons.
- **Smart Filtering & Organization**:
  - Category pills with live counter badges: **All**, **Web / Frontend**, **Backend & APIs**, **Databases**, and **Tunnels & Tools**.
  - Multi-attribute sorting by Port Number, CPU Load, Memory Footprint, or Project Name.
  - Colon-agnostic search (e.g. `:3000` or `3000`, project name, path, branch).
- **Project Identity & Git Integration**:
  - Zero-subprocess `.git/HEAD` reader supporting standard repos, Git worktrees (`gitdir:` pointer), submodules, and detached HEAD commits.
  - Authentic framework icons and brand colors for Next.js, Vite, React, Node, Bun, Python, FastAPI, Django, Flask, Go, Rust, Ruby, Docker, PostgreSQL, Redis, MongoDB, and MySQL.
  - Real-time animated pulsing status dot (`ONLINE` / `LISTEN` vs. `IDLE`).
- **1-Click Developer Actions**:
  - Direct IDE launchers for **Cursor** (`cursor`), **VS Code** (`code`), **Terminal** (`cd <path>`), and **macOS Finder**.
  - 1-click localhost URL launcher in your default browser (`http://localhost:<PORT>`).
  - 1-click clipboard shortcuts for port URLs, project paths, and Git branches with floating feedback toasts.
  - Full right-click `.contextMenu` across cards and table rows.
- **Built-in Port Inspector Utility**:
  - Watchdog sheet to check whether any TCP port is available or in use.
  - Quick presets for common ports (`:3000`, `:5173`, `:8080`, `:8000`, `:5432`, `:6379`, `:27017`, `:3306`).
  - Occupied port conflict breakdown displaying Process Name, PID, User, CPU%, Memory, and Directory path.
  - 1-click graceful port release (`SIGTERM`) and force kill (`SIGKILL`).

### 4. ⏳ 30-Day Historical Time-Travel
- **Persistent Snapshots**: Automatically logs 1-minute historical snapshots into an embedded, high-performance local SQLite database.
- **Interactive Time Scrubber**: Scrub backwards across 12 hours, 24 hours, 7 days, or 30 days.
- **Time-Travel App State Inspection**: Dragging the scrubber doesn't just animate a chart — it **restores the exact list of apps and processes** running at that historical second so you can diagnose intermittent crashes or overnight memory leaks.

### 5. 🚨 Sustained Load Alerts
- Configurable anomaly detector that flags runaway processes (e.g. background apps holding >80% CPU for over 120 seconds).
- Session timeline with severity ratings (`Normal`, `Warning`, `Critical`) and 1-click process termination.

### 6. 📸 Saved Moments (Diagnostic Bookmarks)
- Press a hotkey or click **"Save a moment"** whenever your Mac feels laggy or stutters during a compilation task.
- Freezes a comprehensive diagnostic snapshot (top CPU apps, memory pressure, active window, battery draw, disk read/write) with space for developer notes.

### 7. 🧹 Storage Visualizer & System Cleaner
- **Storage Space Explorer**: 8-category breakdown (Downloads, Applications, Developer, Caches, Documents, Media, App Data, Other) with recursive directory size ranking.
- **System Cleaner**: Safely clean stale caches, Xcode `DerivedData`, simulator runtimes, package manager caches, and log files.

### 8. 🎛️ Menu Bar Companion & Floating HUD
- Native macOS menu bar status item (`NSStatusItem`) showing configurable figures, icons, or mini-graphs for CPU, Memory, Network, or Battery.
- Lightweight floating HUD overlay window for always-on-top monitoring during intense gaming, rendering, or compiling sessions.

---

## 🏗️ Architecture & Engineering Specs

Matric is written in **100% native Swift 5.10+** using Apple's modern **SwiftUI** and **Observation** framework (`@Observable`), interfacing directly with Darwin and Mach kernel subsystems.

```
matric/
├── App/
│   ├── MyApp.swift                      # Application entry point & Scene configuration
│   └── AppState.swift                   # Central observable environment state
│
├── Core/
│   ├── Sensors/                         # Native Mach & IOKit Telemetry Sensors
│   │   ├── CPUMonitor.swift             # Mach host_processor_info, per-core & total load
│   │   ├── MemoryMonitor.swift          # vm_statistics64, memory pressure, swap usage
│   │   ├── DiskMonitor.swift            # IOKit disk I/O read/write throughput
│   │   ├── NetworkMonitor.swift         # getifaddrs / sysctl bandwidth per interface
│   │   ├── GPUMonitor.swift             # IOAccelerator / Apple Silicon GPU utilization
│   │   ├── BatteryMonitor.swift         # IOPMPowerSource, cycle count, wattage, temperature
│   │   ├── HardwareInfo.swift           # Mac model, chip architecture, core counts
│   │   └── SystemTelemetryHub.swift     # 1-second coordinated telemetry heartbeat
│   │
│   ├── Process/                         # Process Tree & Parent-Child Attribution
│   │   ├── ProcessScanner.swift         # libproc process enumeration
│   │   ├── ProcessTreeResolver.swift    # Attributing helpers & daemons to parent apps
│   │   └── ProcessModels.swift          # ProcessRecord & AppGroupRecord models
│   │
│   ├── Projects/                        # Developer Workspace & Port Inspection
│   │   ├── ProjectsManager.swift        # Aggregations, filtering, sorting, IDE launching
│   │   ├── PortScanner.swift            # Mapping listening TCP ports via socket tables
│   │   ├── WorkingDirResolver.swift     # Zero-subprocess CWD & .git/HEAD branch reader
│   │   ├── DevRuntimeClassifier.swift   # Framework classifier (Node, Python, Go, Rust, etc.)
│   │   └── DevProjectModels.swift       # Categories, runtimes, port items, sort options
│   │
│   ├── History/                         # 30-Day Historical Time-Travel Engine
│   │   ├── HistoryStore.swift           # SQLite snapshot persistence & rolling pruning
│   │   └── HistoryModels.swift          # Snapshot data contracts & scrubber models
│   │
│   ├── Moments/                         # Saved Diagnostic Snapshots
│   │   ├── MomentsManager.swift         # Moment capture, serialization & persistence
│   │   └── MomentModels.swift           # Frozen diagnostic state structures
│   │
│   ├── Alerts/                          # Sustained Activity & Anomaly Detection
│   │   ├── AlertsManager.swift          # Threshold evaluation & session notifications
│   │   └── AlertModels.swift            # Alert severity & trigger rules
│   │
│   ├── Storage/                         # Storage Space Visualizer
│   │   ├── StorageManager.swift         # APFS volume info & Category aggregation
│   │   ├── DiskSpaceScanner.swift       # Background directory scanner & FDA handling
│   │   └── DiskSpaceModels.swift        # Directory tree and category models
│   │
│   └── Cleaner/                         # System Junk & Cache Cleaner
│       ├── CleanerManager.swift         # Cache categories & cleaning coordinator
│       ├── SystemCleanerEngine.swift    # Safe deletion & trash operations
│       └── CleanerModels.swift          # Scan items & cleanup rules
│
└── UI/
    ├── Navigation/                      # NavigationSplitView, Sidebar & Window Shell
    ├── Views/                           # Main Feature Views (Overview, CPU, Projects, etc.)
    ├── Components/                      # Reusable UI Elements (KPI Cards, Charts, Tables)
    ├── Modals/                          # Inspector Sheets & Conflict Watchdog Dialogs
    ├── MenuBar/                         # NSStatusItem Custom Popover
    └── HUD/                             # Always-On-Top Floating HUD Overlay
```

### Native macOS System APIs Utilized
- **Mach & Kernel**: `host_processor_info(mach_host_self(), ...)` for CPU core loads, `host_statistics64(mach_host_self(), ...)` for VM statistics and memory pressure, `getloadavg()` for UNIX load averages.
- **Process & Socket Tables**: `proc_listpids`, `proc_pidinfo` (`PROC_PIDTASKINFO`, `PROC_PIDVNODEPATHINFO`, `PROC_PIDTBSDINFO`), and `PROC_PIDFDSOCKETINFO` to identify open TCP sockets without shelling out to slow terminal commands.
- **IOKit & Hardware Registry**: `IOBlockStorageDriver` for disk throughput, `IOAccelerator` for Apple Silicon GPU compute load, `IOPMPowerSource` for battery health and wattage draw.
- **AppKit & Workspace**: `NSWorkspace`, `NSRunningApplication`, and `SMAppService` for application launching, Finder interaction, and login item management.

---

---

## 📦 Installation

### Option 1: Install via Homebrew Cask (Recommended)

Tap this repository directly and install Matric:

```bash
# 1. Tap this repository
brew tap pawanbhayde/matric https://github.com/pawanbhayde/matric

# 2. Install Matric
brew install --cask matric
```

> **Note on Homebrew 7+ Tap Trust:** If prompted with `Refusing to load cask from untrusted tap`, run:
> ```bash
> brew trust pawanbhayde/matric
> ```

To upgrade in the future:
```bash
brew upgrade --cask matric
```

To uninstall and clean up all app data:
```bash
brew uninstall --zap --cask matric
```

---

### Option 2: Download Disk Image (.dmg)

1. Download the latest Universal release (**Apple Silicon & Intel**) from [GitHub Releases](https://github.com/pawanbhayde/matric/releases/latest).
2. Double-click the downloaded `Matric-x.x.x.dmg`.
3. Drag **Matric** into your **Applications** folder.

---

### 🛡️ First Launch on macOS ("Apple could not verify Matric is free of malware...")

Because Matric is free and open-source software distributed outside the Mac App Store:

- **If signed with an Apple Developer ID & Notarized**: Matric opens immediately on double-click with zero prompts.
- **For community/open-source builds**: macOS Gatekeeper flags downloaded apps with a quarantine tag and displays:
  > **“Apple could not verify ‘Matric’ is free of malware that may harm your Mac or compromise your privacy.”**

You can permit and open Matric on any Mac in any of the following 3 ways:

#### Option 1: Right-Click "Open" in Finder (Recommended - No Terminal Needed)
1. In **Finder**, navigate to `/Applications` (or wherever you placed Matric).
2. **Right-Click** (or hold `Control` and click) on **Matric.app**.
3. Select **Open** from the context menu.
4. macOS will present a dialog with an explicit **Open** button. Click **Open**.

*(macOS will remember your choice and open Matric normally with a simple double-click from now on.)*

#### Option 2: 1-Second Terminal Command (Fastest)
Clear the Gatekeeper quarantine attribute directly:
```bash
xattr -cr /Applications/Matric.app
```
*(If the app is still in your Downloads folder, run `xattr -cr ~/Downloads/Matric.app`)*.

#### Option 3: System Settings ("Open Anyway")
1. Open **System Settings** on your Mac.
2. Go to **Privacy & Security** and scroll down to the **Security** section.
3. You will see: *"Matric was blocked from use because it is not from an identified developer."*
4. Click **Open Anyway** and enter your password.

---

## 💻 Building from Source & Packaging DMG

### Prerequisites
- **macOS 14.0 (Sonoma)** or **macOS 15.0+ (Sequoia)** (Apple Silicon M1/M2/M3/M4 or Intel)
- **Xcode 15.0+** or **Xcode 16.0+**
- Command Line Tools (`xcode-select --install`)
- Optional for visual DMG styling: `brew install create-dmg`

### Clone the Repository
```bash
git clone https://github.com/pawanbhayde/matric.git
cd matric
```

### 1-Click Build & Package Universal DMG
Run the automated packaging script to produce a signed, universal release DMG:
```bash
./scripts/build_dmg.sh
```
The output `.dmg` and `.dmg.sha256` will be generated in `build/dist/`.

### Run via Xcode
1. Open the project in Xcode:
   ```bash
   open matric.xcodeproj
   ```
2. Select the `matric` scheme and target **My Mac**.
3. Press `Cmd + R` to build and run.

---

## 🚀 Automated CI/CD & GitHub Releases

Matric includes a complete GitHub Actions workflow (`.github/workflows/release.yml`) that automatically builds universal binaries, signs, packages the DMG, generates SHA-256 checksums, and updates the Homebrew Cask formula upon publishing a new tag (e.g. `v1.0.0`).

### Code Signing & Apple Notarization Secrets (Maintainers)
To enable Developer ID signing and Apple Notarization in GitHub Actions, add the following repository secrets:
- `MACOS_CERTIFICATE`: Base64-encoded Developer ID Application `.p12` certificate.
- `MACOS_CERTIFICATE_PWD`: Password for the `.p12` certificate.
- `KEYCHAIN_PASSWORD`: Any temporary password for creating the runner keychain.
- `APPLE_ID`: Your Apple Developer account email.
- `APPLE_APP_SPECIFIC_PASSWORD`: App-specific password generated at [appleid.apple.com](https://appleid.apple.com).
- `APPLE_TEAM_ID`: Your 10-character Apple Developer Team ID.

*(Note: If these secrets are not configured, the workflow automatically falls back to hardened-runtime ad-hoc signing, ensuring the DMG build and release pipeline always succeeds.)*

---

## 🔒 Privacy & Permissions

- **100% Offline**: Matric makes **zero outbound network connections**. It contains no analytics trackers, crash-reporting SDKs, or cloud synchronization.
- **Local Persistence**: All historical snapshots, saved moments, and preferences are stored exclusively on your device in standard macOS application support directories (`~/Library/Application Support/Matric/`).
- **Standard User Privileges**: 95% of Matric's features run without any special permissions.
- **Optional Full Disk Access**: Only required by the **Storage Space Explorer** if you wish to calculate accurate folder sizes inside restricted system directories (such as `~/Library/Application Support` or `/System`). All other system sensors and developer tools function perfectly without it.

---

## 🤝 Contributing

We welcome contributions from developers, designers, and system performance enthusiasts!

- Please read our [Contributing Guide](CONTRIBUTING.md) for branch management and commit guidelines.
- Review our [Code of Conduct](CODE_OF_CONDUCT.md).
- To report bugs or suggest enhancements, please use our [GitHub Issue Templates](.github/ISSUE_TEMPLATE/).

---

## 📜 License

Matric is licensed under the [MIT License](LICENSE).

Developed with ❤️ for the macOS developer community. Inspired by [Pulse for Mac](https://pulsemac.app/).
