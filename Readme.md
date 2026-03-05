<div align="center">

![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)



| | |
|---|---|
| 👤 **Student** | Sanjok Rai |
| 🆔 **Student ID** | 250452 / 17107765 |
| 👨‍🏫 **Tutor** | Mr. Rupak Rajbanshi |
| 📅 **Submitted** | 5st March 2026 |

</div>

---

## 📋 Overview

This project explores three fundamental areas of computing through code demonstrations:

| # | Task | Topic |
|---|------|-------|
| 1 | 🔡 **Encoding & Secure Transmission** | ASCII, Base64, URL Encoding, HTTPS, TLS |
| 2 | 🪑 **Classroom Seating Problem** | P vs NP, Brute Force O(n!), Heuristics |
| 3 | 🗄️ **Database Normalisation** | 1NF → 2NF → 3NF, SQL, ER Diagram |

---

## 📁 Project Structure

```
ST4015CMD/
│
├── 📂 task1_encoding/
│   ├── demo_encoding.py          # ASCII, Base64 & URL encoding demos
│   └── demo_sql.py     # How URL encoding blocks SQL injection
│
├── 📂 task2_seating/
│   ├── BruteForce.py            # Tries every permutation — O(n!)
│   └── heuristics.py             # Greedy + local improvement strategy
│
├── 📂 task3_database/
│   ├── Normalization.sql                # Normalised table structure (1NF→3NF)
│   ├── basic_operations.sql           # Sample club membership data
│   └── join_query.sql               # SELECT, INSERT & JOIN operations
│
├── docker-compose.yml            # MySQL 8.0 container setup
└── README.md
```

---

## 🚀 Getting Started

### Clone the Repository
```bash
git clone https://github.com/<your-username>/ST4015CMD.git
cd ST4015CMD
```

### Prerequisites
- Python 3.8+
- Docker & Docker Compose

---

### ▶️ Task 1 — Encoding Demos

```bash
# Run encoding demonstration (ASCII, Base64, URL)
python task1_encoding/encoding_demo.py

# Run SQL injection prevention demo
python task1_encoding/sql_injection_demo.py
```

---

### ▶️ Task 2 — Seating Problem

```bash
# Brute force approach (slow for large inputs)
python task2_seating/brute_force.py

# Heuristic approach (fast & practical)
python task2_seating/heuristics.py
```

> 💡 **Tip:** Try increasing the student count in `brute_force.py` to see the factorial explosion in action.

---

### ▶️ Task 3 — SQL with Docker

**Step 1 — Start the MySQL container**
```bash
docker-compose up -d
```

**Step 2 — Connect to MySQL**
```bash
docker exec -it <container_name> mysql -u root -p
```

**Step 3 — Run the SQL scripts**
```sql
SOURCE task3_database/schema.sql;
SOURCE task3_database/insert_data.sql;
SOURCE task3_database/queries.sql;
```

**Step 4 — Stop the container when done**
```bash
docker-compose down
```

---

## 🗃️ Database Schema (Final — 3NF)

```sql
Student    (StudentID PK, Name, Email)
Club       (ClubID PK, ClubName, ClubRoom, ClubMentor)
Membership (StudentID FK, ClubID FK, JoinDate)
```

**JOIN Query Example:**
```sql
SELECT s.Name, c.ClubName, m.JoinDate
FROM Membership m
JOIN Student s ON m.StudentID = s.StudentID
JOIN Club c    ON m.ClubID    = c.ClubID
ORDER BY m.JoinDate;
```



