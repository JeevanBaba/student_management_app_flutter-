# Student Management Platform 🎓

A high-performance, production-grade Flutter application built using a fully decoupled state management architecture and powered by an optimized Supabase PostgreSQL backend. Designed with an emphasis on seamless data synchronization, the platform features real-time relational data streams, custom input validation, and global theme persistence.

---

## 📺 Project Previews

To demonstrate the full capability of the architecture, the following live demonstrations showcase the system in action:

### 1. Unified UI/UX & Global Theme Persistence
This video highlights smooth navigation using **GoRouter**, custom interactive typography, explicit keyboard focus management, and an instantaneous global Light/Dark mode transition powered by a centralized Riverpod state layer.
* **[Watch Mobile UI Demo](https://github.com/user-attachments/assets/a1944222-89e5-4146-bc72-d3b8b7336ee8)**

### 2. Live Cloud Data Sync (Supabase RPC & Pull-to-Refresh)
This video demonstrates the full-stack synchronization engine side-by-side with the live cloud database view:
* **Step 1**: Modifying relational database rows directly inside the cloud dashboard database grid.
* **Step 2**: Executing a physical **Pull-to-Refresh** gesture on the Flutter app to invalidate the local cache and trigger an immediate re-fetch.
* **Step 3**: Seamlessly executing server-side batch updates via Remote Procedure Calls (RPC) to calculate automated letter grades and push live, reactive cross-screen metrics across the entire workspace.
* **[Watch Live Backend Sync Demo](https://github.com/user-attachments/assets/23176aa2-ee2f-4db9-a0de-d13338957866)**

---

## ✨ Features & Architecture Highlights

* **Full-Stack Relational Database Layer**: Powered by a cloud-hosted **Supabase PostgreSQL** instance, utilizing strict foreign key constraints, default value evaluation, and optimized data schemas.
* **Server-Driven Query Operations (RPC)**: Zero heavy data manipulation is handled client-side. The application invokes server-side Remote Procedure Calls (`get_scheduled_timetable` and batch updates) utilizing SQL `INNER JOIN` operations to return streamlined, single-payload JSON sequences directly to the client view.
* **Modern State Management (Riverpod)**: Business and data access layers are cleanly abstracted from presentation views using modern `AsyncNotifier` structures, ensuring data is proactively cached, managed safely, and updated seamlessly across multiple screens.
* **Declarative Routing Engine**: Implements path-based decoupled routing via **GoRouter** for scalable, robust, and clean screen-stack navigation management.
* **Robust Security Protocols**: Hardcoded tokens and configuration parameters are completely eliminated. The production build utilizes `flutter_dotenv` to load environment configurations dynamically at runtime via a strictly secure `.env` container ignored by version control.
* **Dynamic Analytics Matrix**: Features a horizontal sliding weekday timetable matrix with a native `RefreshIndicator`, an automated numeric grade mapper with keyboard focus tracking (`FocusNode`), and a live tracking Cumulative Grade Point Average (CGPA) calculation engine.

---

## 🛠️ Project Structure

The project follows a clean, modular layer-by-feature directory structure to isolate presentation, business logic, and core configuration assets:

```text
lib/
├── core/          # Core theme configurations, global styles, and application constants
├── providers/     # Centralized Riverpod state layers (Grades, Timetable, Theme management)
├── routing/       # GoRouter declarative path navigation and route definitions
├── screens/       # UI Presentation Views (Dashboard, Performance, Marks Entry, Timetable)
└── main.dart      # Global app entrypoint and initialized environment configurations
.env               # Local secure credentials file (Git ignored for security)
supabase_schema.sql # Relational database schema migration and custom RPC function script

🚀 Getting Started
Prerequisites

    Flutter SDK (Latest Stable Channel)

    A configured Supabase project instance

Installation & Setup

    Clone the repository:

Bash

git clone https://github.com/your-username/student_management_app.git
cd student_management_app

    Install project dependencies:

Bash

flutter pub get

    Configure Environment Variables:
    Create a .env file in the root directory of the project and supply your active Supabase credentials:

Code snippet

SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-actual-long-jwt-anon-public-key

    Database Initialization:
    Execute the query scripts inside supabase_schema.sql directly within your Supabase SQL Editor to generate the necessary subjects and timetable_slots tables alongside the relational get_scheduled_timetable RPC function.

    Run the application:

Bash

flutter run
