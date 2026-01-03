# Student Management Dashboard 🎓

A modern, high-performance Flutter application featuring a clean design system, real-time data integration, and dynamic performance analytics.

---

## 📺 Preview
[Click here to watch the Demo Video](PASTE_YOUR_VIDEO_LINK_HERE)

---

## ✨ Features
* **Performance Analytics (REST API)**: Integrates with a live REST API (MockAPI.io) to fetch real-time student data.
* **Dynamic CGPA Calculator**: Automatically processes asynchronous API data to calculate and display a live Cumulative Grade Point Average.
* **Automated Grade Mapping**: Implemented logic to transform numerical scores into corresponding letter grades (A+, B, etc.).
* **Adaptive Theming**: Seamless transition between Light and Dark modes with a unified design system.
* **Rich Animations**: Integrated Lottie vector animations for a high-end, interactive user experience.
* **Pull-to-Refresh**: Uses the `RefreshIndicator` to sync with the cloud database instantly.

---

## 🛠️ Project Structure
```text
lib/
├── screens/       # Dashboard and Performance (REST API) screens
├── widgets/       # Modular components (GradeItem, StatCard, ClassTile)
├── core/          # Theme constants and App colors
└── main.dart      # Application entry point & Theme management
assets/
├── lottie/        # JSON animation files
└── fonts/         # Custom typography (NUSAR)
