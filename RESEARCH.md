# 🔬 Edonia Research Log & Evidence Locker

This document stores the raw findings from initial device audits. These real-world examples serve as the basis for the "Risk Scoring" algorithms in Edonia.

## 📱 Case Study 1: The "Personal Driver" (Phone 1)
**Context:** Daily-use device with accumulated apps.

### Key Findings:
- **The "Snooper" Profile:** Identified `com.comarch.clm.mobileapp.petromro`.
- **Privilege Overreach:**
  - Requested `ACCESS_FINE_LOCATION`, `CAMERA`, and `CALL_PHONE`.
  - Combined with `RECEIVE_BOOT_COMPLETED` and `FOREGROUND_SERVICE`.
- **Observation:** The app had these permissions but did not prompt the user during interaction, indicating "Silent" privilege retention.
- **Conclusion:** This represents the primary "Enemy" Edonia is designed to detect: The high-privilege background actor.

## 📱 Case Study 2: The "Clean Slate" (Phone 2)
**Context:** Factory-reset Samsung SM-S938B (Android 15).

### Key Findings:
- **Manufacturer Telemetry:** Even on a reset device, third-party "Bloatware" is present:
  - `com.facebook.appmanager`, `com.facebook.services`, `com.facebook.system`.
  - `com.microsoft.appmanager`, `com.microsoft.skydrive`.
  - `com.hiya.star`.
- **Baseline Privilege Surface:**
  - **Location:** ~28 system apps have `ACCESS_FINE_LOCATION` by default.
  - **Camera:** ~9 system apps have `CAMERA` by default.
- **Conclusion:** The "Baseline" is not zero. The app must be able to distinguish between "Essential System Services" and "Third-Party Telemetry."

## 📉 Technical Discovery: Data Access
- **The "Wall":** `adb shell netstat` and `/proc/net` are restricted on non-rooted devices.
- **The "Door":** `NetworkStatsManager` (via Kotlin Bridge) provides the only reliable way to get per-UID byte counts for non-rooted Android 15 devices.
- **The "Lid":** `dumpsys package` reveals the *requested* permissions, but `UsageStatsManager` is required to see the *actual* activity.

## 🚩 Red Flag Definitions (For Algorithm Development)
Based on these audits, a "Suspicious" flag is triggered when:
1. **The Disconnect:** $\text{Foreground Time} \approx 0$ AND $\text{Network Volume} > \text{Threshold}$.
2. **The Overreach:** $\text{App Category (e.g., Calculator)} \neq \text{Permission (e.g., Camera)}$.
3. **The Persistence:** `RECEIVE_BOOT_COMPLETED` is present in an app with high-risk permissions.
