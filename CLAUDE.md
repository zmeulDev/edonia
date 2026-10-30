# 🛡️ Edonia - Project Knowledge Base

## 🎯 Project Vision
Edonia is a high-precision privacy watcher for Android 15+ (API 35). It correlates app usage time with network data volume to identify "stealth trackers"—apps that exhibit high data activity despite low user interaction.

## 🛠️ Technical Stack
- **Framework:** Flutter 3.24+ (Edge-to-Edge, Material 3, Dynamic Color)
- **State Management:** Riverpod (Asynchronous state for auditing)
- **Local Storage:** Hive (NoSQL) for Trust Verdicts
- ** Android 15 Integration:**
  - `flutter_app_usage_kit` & `screen_time_kit` (Usage/Attention/Telemetry)
  - `device_apps` & `permission_handler` (Privilege Mapping)
  - Custom Kotlin Bridge $\rightarrow$ `NetworkStatsManager` (Byte counts per UID)

## 📐 Architecture
- `/lib/core`: Constants, Theme, and Riverpod Providers (Global State).
- `/lib/data`: Data models, Repositories, and Hive Local Storage.
- `/lib/domain`: Core "Watcher" logic and Risk Scoring algorithms.
- `/lib/presentation`: Material 3 screens (Enrollment $\rightarrow$ Dashboard $\rightarrow$ Detail).

## 🛡️ Security & Privacy Logic (The "Snooper" Algorithm)
- **Risk Indicator:** High `Network Data Volume` $\div$ Low `Foreground Usage Time` = High Risk.
- **Baseline:** Comparison between "Factory Reset" system state and current state.
- **Verdicts:** User-defined classification: `Safe` | `Suspicious` | `Dangerous`.

## 🛣️ Implementation Roadmap
- [x] Project Scaffolding & GitHub Repo.
- [x] Android 15 Baseline Audit.
- [x] Phase 1: Enrollment Screen (Permission Gate).
- [ ] Phase 2: App Inventory & Privilege Mapping.
- [ ] Phase 3: Network Data Bridge (Kotlin).
- [ ] Phase 4: Behavioral Analysis & Risk Scoring.
- [ ] Phase 5: User Verdict & Whitelist System.

## 📝 Development Notes
- **Package Name:** `com.zmeul.edonia`
- **Target SDK:** 35 (Android 15)
- **Critical Permissions:** `PACKAGE_USAGE_STATS`, `READ_PHONE_STATE`.
