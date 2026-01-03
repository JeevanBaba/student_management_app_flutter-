# Student Management Dashboard 🎓

A modern, high-performance Flutter application featuring a clean design system, real-time data integration, and dynamic performance analytics.

---

## 📺 Project Previews

To demonstrate the full capability of the system, I have provided two distinct demonstrations:

### 1. Mobile Experience & UI/UX
This video showcases the app running natively on a mobile device. It highlights the smooth navigation between the **Dashboard** and **Performance** screens, the **Lottie animations**, custom **NUSAR** typography, and the seamless **Dark/Light mode** transition.
* **[Watch Mobile Demo](PASTE_LINK_1_HERE)**

### 2. Live Data Sync (REST API in Action)
This video demonstrates the core engineering feat: **Data Persistence and Synchronization**. 
* **Step 1**: Real-time data modification on the **MockAPI.io** cloud dashboard.
* **Step 2**: Using the **Pull-to-Refresh** feature in the Flutter app to trigger an asynchronous `GET` request.
* **Step 3**: Instant update of scores, automated letter grades, and the overall CGPA calculation.
* **[Watch Live Sync Demo](PASTE_LINK_2_HERE)**

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
