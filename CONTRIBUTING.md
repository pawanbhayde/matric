# Contributing to Matric

Thank you for your interest in contributing to **Matric**! We are committed to building the fastest, most privacy-respecting, and most delightful system monitor and developer companion for macOS.

---

## 🛠️ Development Setup

### Prerequisites
- **macOS 14.0 (Sonoma)** or **macOS 15.0+ (Sequoia)**
- **Xcode 15.0+** or **Xcode 16.0+**
- Command Line Tools: `xcode-select --install`
- Swift 5.10+ / Swift 6

### Getting the Code
```bash
git clone https://github.com/pawanbhayde/matric.git
cd matric
```

### Building & Running
You can open the project in Xcode:
```bash
open matric.xcodeproj
```
Or build from the terminal using `xcodebuild`:
```bash
xcodebuild -project matric.xcodeproj -scheme matric -configuration Debug build
```

---

## 🧭 Code Architecture & Guidelines

1. **Pure Swift & SwiftUI**:
   - UI views use modern declarative SwiftUI with `@Observable` (Swift Observation framework).
   - Core telemetry managers reside in `matric/Core/`.
   - UI components and views reside in `matric/UI/`.

2. **Native Darwin & Kernel APIs**:
   - Zero third-party runtime dependencies.
   - Low-overhead system calls (`mach_host_self`, `host_processor_info`, `vm_statistics64`, `libproc`, `IOKit`, `sysctl`).
   - All filesystem and process calls must be efficient and non-blocking (offload heavy scanning to background `Task.detached` or GCD queues).

3. **Privacy by Design**:
   - Matric **never** makes network requests for telemetry, tracking, or metric uploading.
   - Do not introduce analytics or cloud sync libraries.
   - All persistence is strictly local.

4. **Code Style**:
   - Keep files focused and clean.
   - Provide meaningful commit messages following the Conventional Commits specification (e.g. `feat(projects): add port inspector`, `fix(memory): correct wired memory calculation`).

---

## 🚀 Submitting Changes

1. **Fork the repository** on GitHub.
2. **Create a branch** for your feature or bug fix:
   ```bash
   git checkout -b feat/my-new-feature
   ```
3. **Write clean, tested code**:
   - Ensure the app compiles cleanly with zero errors or major warnings.
   - Verify performance and memory footprint in Instruments or Activity Monitor.
4. **Commit your changes**:
   ```bash
   git commit -m "feat: describe your change"
   ```
5. **Push to your fork**:
   ```bash
   git push origin feat/my-new-feature
   ```
6. **Open a Pull Request** against the `main` branch.

---

## 🐛 Reporting Bugs & Suggesting Features

- Use GitHub Issues to submit bug reports and feature ideas.
- Before submitting, search existing issues to avoid duplicates.
- For bug reports, include your macOS version, Mac hardware model (e.g. M1, M2, M3, M4, Intel), and reproduction steps.

---

## 📜 Code of Conduct

Please adhere to our [Code of Conduct](CODE_OF_CONDUCT.md) in all community interactions.
