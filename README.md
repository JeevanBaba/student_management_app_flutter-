Open `README.md` in the root directory. Replace its entire contents with the updated full-stack architecture specification markdown text below. Ensure it highlights our migration to a live Supabase PostgreSQL backend, the server-side RPC functions utilizing relational INNER JOIN operations, the modern Riverpod AsyncNotifier caching layer, the native pull-to-refresh sync mechanics, and our runtime .env security protocols. Keep the placeholders for the video links intact so I can drag and drop my screen recordings directly inside the GitHub browser.

---

# Student Management Platform 🎓

A high-performance, production-grade Flutter application built using a fully decoupled state management architecture and powered by an optimized Supabase PostgreSQL backend. Designed specifically with school operations in mind, this platform features real-time relational data syncing, complex state notifications, and adaptive custom themes.

---

## 📺 Project Previews

To demonstrate the full capability of the architecture, I have provided two distinct demonstrations:

### 1. Unified UI/UX & Global Theme Persistence
This video showcases the app running natively. It highlights smooth navigation using **GoRouter**, custom interactive typography, and an instantaneous global Light/Dark mode transition powered by a centralized Riverpod state layer.
* **[Watch Mobile UI Demo](https://github.com/user-attachments/assets/a1944222-89e5-4146-bc72-d3b8b7336ee8)**

### 2. Live Enterprise Data Sync (Supabase RPC & Pull-to-Refresh)
This video demonstrates the full-stack synchronization engine side-by-side with the live cloud database:
* **Step 1**: Modifying relational database rows directly inside the **Supabase Dashboard Table Editor**.
* **Step 2**: Executing a physical **Pull-to-Refresh** gesture on the Flutter app to invalidate the cache and trigger a re-fetch.
* **Step 3**: Seamlessly executing server-side batch updates via Remote Procedure Calls (RPC) to calculate automated letter grades and push live, reactive cross-screen metrics across the entire workspace.
* **[Watch Live Backend Sync Demo](https://github.com/user-attachments/assets/23176aa2-ee2f-4db9-a0de-d13338957866)**

---

## ✨ Features & Architecture Highlights

* **Full-Stack Relational Database Layer**: Powered by a cloud-hosted **Supabase PostgreSQL** instance, utilizing strict foreign key constraints and optimized data structures.
* **The "Rollix SQL Pattern" (RPC)**: Zero heavy data manipulation is handled client-side. The application invokes server-side Remote Procedure Calls (`get_scheduled_timetable` and batch updates) utilizing SQL `INNER JOIN` operations to return streamlined, single-payload JSON sequences.
* **Modern State Management (Riverpod)**: Business and data access layers are cleanly abstracted from presentation views using modern `AsyncNotifier` structures, ensuring data is proactively cached and updated seamlessly across multiple screens.
* **Declarative Routing Engine**: Implements path-based decoupled routing via **GoRouter** for scalable, robust screen-stack management.
* **Robust Security Protocols**: Hardcoded tokens are completely eliminated. The production build utilizes `flutter_dotenv` to load environment configurations dynamically at runtime via a strictly secure `.env` container ignored by version control.
* **Dynamic Analytics Matrix**: Features a horizontal sliding weekday timetable matrix with a native `RefreshIndicator`, an automated numeric grade mapper with keyboard focus tracking, and a live tracking Cumulative Grade Point Average (CGPA) engine.

---

## 🛠️ Project Structure
```text
lib/
├── core/          # Core theme configurations, styles, and constants
├── providers/     # Centralized Riverpod state layers (Grades, Timetable, Theme)
├── routing/       # GoRouter declarative path navigation setup
├── screens/       # UI Presentation Views (Dashboard, Performance, Marks Entry, Timetable)
└── main.dart      # Global app entrypoint and initialized env configurations
.env               # Local secure credentials file (Git ignored)
supabase_schema.sql # Relational database schema migration file
