# PostgreSQL Installation Guide

This guide covers installing PostgreSQL on Windows, Linux, via Docker, and setting up pgAdmin.

## Table of Contents

1. [Installing PostgreSQL on Windows](#installing-postgresql-on-windows)
2. [Installing PostgreSQL on Linux (Ubuntu/Debian)](#installing-postgresql-on-linux-ubuntudebian)
3. [Installing PostgreSQL with Docker](#installing-postgresql-with-docker)
4. [Installing pgAdmin](#installing-pgadmin)
5. [Verification](#verification)
6. [Troubleshooting](#troubleshooting)

---

## Installing PostgreSQL on Windows

### Prerequisites

- Windows 10 or later (64-bit recommended)
- 2GB RAM, 500MB free disk space
- Internet connection

### Steps

1. **Download the Installer**:

   - Visit [postgresql.org/download/windows](https://www.postgresql.org/download/windows/).
   - Choose the latest version (e.g., 16.x as of February 2025).
   - Download the `.exe` (e.g., `postgresql-16.x-windows-x64.exe`).

2. **Run the Installer**:

   - Double-click the `.exe`.
   - Install to `C:\Program Files\PostgreSQL\16` (default) or customize.
   - Select components: PostgreSQL Server, Command Line Tools (pgAdmin optional).

3. **Configure**:

   - Set `postgres` user password (e.g., `MySecurePass123`).
   - Port: `5432` (default).
   - Locale: Default or `English_United States`.

4. **Install**:

   - Finish the setup. Skip Stack Builder unless adding extras (e.g., PostGIS).

5. **Start Service**:

   - Runs as `postgresql-x64-16` service.
   - Check via `services.msc`.

---

## Installing PostgreSQL on Linux (Ubuntu/Debian)

### Prerequisites

- Ubuntu 20.04+ or Debian 11+
- Sudo access
- Internet connection

### Steps

1. **Update Packages**:

   ```bash
   sudo apt-get update
   ```

2. **Install PostgreSQL**:

   ```bash
   sudo apt-get install postgresql postgresql-contrib
   ```

   This installs the latest version from default repos (e.g., 16.x).

3. **(Optional) Install from Official Repository**:

   ```bash
   sudo apt-get install wget ca-certificates
   wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
   sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
   sudo apt-get update
   sudo apt-get install postgresql-16
   ```

4. **Manage Service**:

   ```bash
   sudo systemctl enable postgresql
   sudo systemctl start postgresql
   ```

5. **Check Status**:

   ```bash
   sudo systemctl status postgresql
   ```

---

## Installing PostgreSQL with Docker

### Prerequisites

- Docker installed ([Get it here](https://www.docker.com/get-started)).
- Basic Docker knowledge.

### Steps

1. **Pull PostgreSQL Image**:

   ```bash
   docker pull postgres:latest
   ```

2. **Run a Container**:

   ```bash
   docker run --name postgres-db \
     -e POSTGRES_PASSWORD=MySecurePass123 \
     -e POSTGRES_USER=postgres \
     -e POSTGRES_DB=my_database \
     -p 5432:5432 \
     -d postgres:latest
   ```

3. **Access the Container**:

   ```bash
   docker exec -it postgres-db psql -U postgres
   ```

4. **Stop/Start Container**:

   ```bash
   docker stop postgres-db
   docker start postgres-db
   ```

---

## Installing pgAdmin

### On Windows

#### Bundled:

- Included if selected during PostgreSQL install (`C:\Program Files\PostgreSQL\16\pgAdmin 4`).
- Launch via Start Menu: "pgAdmin 4".

#### Standalone:

- Download from [pgadmin.org/download](https://www.pgadmin.org/download/).
- Install via prompts.

### On Linux (Ubuntu/Debian)

#### Add Repository:

```bash
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
```

#### Install:

**Web mode:**

```bash
sudo apt-get update
sudo apt-get install pgadmin4-web
sudo /usr/pgadmin4/bin/setup-web.sh
```

**Desktop mode:**

```bash
sudo apt-get install pgadmin4-desktop
```

**Access:**

- Web: [http://localhost/pgadmin4](http://localhost/pgadmin4)
- Desktop: Launch from menu.

### With Docker

```bash
docker run -p 8080:80 \
  -e 'PGADMIN_DEFAULT_EMAIL=admin@example.com' \
  -e 'PGADMIN_DEFAULT_PASSWORD=adminpass' \
  -d dpage/pgadmin4:latest
```

- Access: [http://localhost:8080](http://localhost:8080)
- Log in with `admin@example.com` and `adminpass`.

---

## Verification

### PostgreSQL

#### Windows:

```cmd
psql -U postgres
```

#### Linux:

```bash
sudo -u postgres psql
```

#### Docker:

```bash
docker exec -it postgres-db psql -U postgres
```

- Run `\l` to list databases.

### pgAdmin

- Launch pgAdmin (desktop/browser).
- Add server:
  - **Host:** localhost (or `host.docker.internal` for Docker on Windows/Mac).
  - **Port:** 5432.
  - **User:** postgres.
  - **Password:** `<your-password>`.

---

## Troubleshooting

### Port Conflict

- **Windows:**
  ```cmd
  netstat -a -n -o | find "5432"
  ```
- **Linux:**
  ```bash
  sudo netstat -tulpn | grep 5432
  ```

### Docker Network Issues

- Use `--network host` if connecting to PostgreSQL container fails.

### Logs

- **Windows:** `C:\Program Files\PostgreSQL\16\data\log`
- **Linux:** `/var/log/postgresql/`
- **Docker:** `docker logs postgres-db`



