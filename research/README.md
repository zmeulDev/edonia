# 🛡️ Edonia

**Edonia** is a high-precision privacy watcher designed for Android 15+ (API 35). It moves the user from "blind trust" to "informed control" by correlating app usage time with network data volume to expose stealth trackers.

## 🚀 Core Vision
Most privacy tools only show you *what* permissions an app has. **Edonia** shows you *how* those permissions are used. By comparing foreground usage time against background data transfer, Edonia identifies "stealth uploaders"—apps that send data while the user is not interacting with them.

## 🛠️ Technical Architecture

### UI & UX
- **Framework:** Flutter 3.24+
- **Design System:** Material 3 (M3) with Dynamic Color & Edge-to-Edge layout.
- **State Management:** Riverpod.

### The "Watcher" Engine
- **Usage Analysis:** `flutter_app_usage_kit` & `screen_time_kit` (Foreground vs. Background time).
- **Privilege Mapping:** `device_apps` & `permission_handler` (Permission audit).
- **Network Telemetry:** Custom Kotlin Bridge $\rightarrow$ `NetworkStatsManager` (Byte counts per UID).
- **Storage:** `Hive` (NoSQL) for the "Trust Verdict" database.

### Target OS
- **Android 15 (API 35):** Full support for Private Space and latest foreground service restrictions.

## 🛣️ Roadmap
- [ ] **Phase 1: Enrollment** - Multi-stage permission onboarding.
- [ ] **Phase 2: Baseline** - App inventory and privilege mapping.
- [ ] **Phase 3: Behavioral Analysis** - Correlating time vs. data.
- [ ] **Phase 4: Verdict System** - Safe/Suspicious marking.

## ⚖️ Privacy Commitment
Edonia is a local-first tool. No data ever leaves the device. All auditing and verdict storage happen on-device using Hive.
