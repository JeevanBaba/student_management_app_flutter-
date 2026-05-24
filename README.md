# Student Management Platform 🎓

A high-performance, production-grade Flutter application built using a fully decoupled state management architecture and powered by an optimized Supabase PostgreSQL backend. Designed specifically with school operations in mind, this platform features real-time relational data syncing, complex state notifications, and adaptive custom themes.

---

## 📺 Project Previews

To demonstrate the full capability of the architecture, I have provided two distinct demonstrations:

### 1. Unified UI/UX & Global Theme Persistence
This video showcases the app running natively. It highlights smooth navigation using **GoRouter**, custom interactive typography, and an instantaneous global Light/Dark mode transition powered by a centralized Riverpod state layer.
* **[Watch Mobile UI Demo](PASTE_YOUR_NEW_LINK_HERE)**

### 2. Live Enterprise Data Sync (Supabase RPC in Action)
This video demonstrates the full-stack synchronization engine:
* **Step 1**: Modifying numerical grades with real-time numeric inputs on the Teacher Marks Portal.
* **Step 2**: Executing secure, batch updates directly to PostgreSQL tables via a Supabase Remote Procedure Call (RPC).
* **Step 3**: Instant, reactive cross-screen updates of student scores, automated letter grades, and the overall CGPA calculations across the entire app workspace.
* **[Watch Live Backend Sync Demo](PASTE_YOUR_NEW_LINK_HERE)**

---

## ✨ Features & Architecture Highlights

* **Full-Stack Relational Database Layer**: Powered by a cloud-hosted **Supabase PostgreSQL** instance, utilizing strict foreign key constraints and optimized data structures.
* **The "Rollix SQL Pattern" (RPC)**: Zero heavy data manipulation is handled client-side. The application invokes server-side Remote Procedure Calls (`get_scheduled_timetable` and batch updates) utilizing SQL `INNER JOIN` operations to return streamlined, single-payload JSON sequences.
* **Modern State Management (Riverpod)**: Business and data access layers are cleanly abstracted from presentation views using modern `AsyncNotifier` structures, ensuring data is proactively cached and updated seamlessly across multiple screens.
* **Declarative Routing Engine**: Implements path-based decoupled routing via **GoRouter** for scalable, robust screen-stack management.
* **Robust Security Protocols**: Hardcoded tokens are completely eliminated. The production build utilizes `flutter_dotenv` to load environment configurations dynamically at runtime via a strictly secure `.env` container ignored by version control.
* **Dynamic Analytics Matrix**: Features a horizontal sliding weekday timetable matrix, an automated numeric grade mapper, and a live tracking Cumulative Grade Point Average (CGPA) engine.

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
