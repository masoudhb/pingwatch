# PingWatch

A lightweight bash-based service to continuously monitor the availability of an IP address using `ping`,  
and execute a custom script (e.g., send SMS, email) when the status changes from UP to DOWN or vice versa.

## 🚀 Features

- Detects server reachability with ICMP ping  
- Verifies failures with a second check after 30 seconds (to avoid false alerts)  
- Triggers custom PHP script on status change  
- Tracks state persistently using a temp file  
- Runs in the background via `systemd`

## 📦 Files

- `pingwatch.sh`: Main bash script  
- `pingwatch.service`: Example systemd service file  
- `send_alert.php`: Your custom alert logic (not included, user-defined)

## 🛠️ Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/masoudhb/pingwatch.git
   cd pingwatch
   ```

2. Edit `pingwatch.sh` and set your:
   - IP to monitor (e.g., `IP=8.8.8.8`)
   - Path to your PHP alert script

3. Make it executable:
   ```bash
   chmod +x pingwatch.sh
   ```

4. Create a systemd service at `/etc/systemd/system/pingwatch.service`:
   ```ini
   [Unit]
   Description=Ping Watcher Service
   After=network.target

   [Service]
   ExecStart=/full/path/to/pingwatch.sh
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

5. Enable and start:
   ```bash
   sudo systemctl daemon-reexec
   sudo systemctl enable pingwatch
   sudo systemctl start pingwatch
   ```

## 📋 Example Output

```
Sat May 24 11:51:07 BST 2025: First ping failed, waiting 30s to recheck...
Sat May 24 11:51:38 BST 2025: Status changed to DOWN
Sat May 24 11:57:18 BST 2025: Status changed to UP
```

## 📄 License

MIT License — feel free to use and modify.
