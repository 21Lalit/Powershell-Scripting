# User Log Activities

The **User Log Activities** is a PowerShell script designed to track and log user activities on a Windows system. It captures login/logout events, running processes, and active window titles. This tool is ideal for monitoring user behavior, auditing, or troubleshooting purposes.

---

## 🚀 Features

1. **Login and Logout Monitoring**
   - Captures user login (event ID 4624) and logout (event ID 4634) events from the Windows Security Event Log.
   - Logs are saved to `LoginLogoutLogs.txt`.

2. **Running Processes Tracking**
   - Records the list of currently running processes, including process names, IDs, and start times.
   - Logs are saved to `RunningProcesses.txt`.

3. **Active Window Monitoring**
   - Captures the title of the currently active window along with timestamps.
   - Logs are saved to `ActiveWindowLogs.txt`.

4. **Scheduled Task Support**
   - Includes optional setup for periodic execution via the Windows Task Scheduler.

---

## 📂 File Structure

- **Script File**:
  - `Log_Activities.ps1`: PowerShell script to execute the monitoring tasks.

- **Generated Log Files**:
  - **Login/Logout Logs**: `C:\UserActivityLogs\LoginLogoutLogs.txt`
  - **Running Processes Logs**: `C:\UserActivityLogs\RunningProcesses.txt`
  - **Active Window Logs**: `C:\UserActivityLogs\ActiveWindowLogs.txt`

---

## 📸 Screenshots

### 1. Login/Logout Events
![Login Logout Activity](https://github.com/21Lalit/Powershell-Scripting/blob/main/User%20Log%20Activities/Login_Logout_Activity.png)

### 2. Running Processes
![Running Processes](https://github.com/21Lalit/Powershell-Scripting/blob/main/User%20Log%20Activities/Running_Processes.png)

### 3. Active Window Logs
![Active Window Logs](https://github.com/21Lalit/Powershell-Scripting/blob/main/User%20Log%20Activities/Active_Window_Logs.png)

### 4. Result Files Location
![Result Files Location](https://github.com/21Lalit/Powershell-Scripting/blob/main/User%20Log%20Activities/Result_Files_Location.png)

### 5. Expected Output
![Expected Output](https://github.com/21Lalit/Powershell-Scripting/blob/main/User%20Log%20Activities/Expected_Output.png)

---

## 📌 How to Use

### Prerequisites

- **PowerShell**: Ensure PowerShell is installed (default on Windows).
- **Administrative Privileges**: Required to access Security Event Logs and configure scheduled tasks.

### Running the Script

1. Save the script as `Log_Activities.ps1`.
2. Open PowerShell with **administrative privileges**.
3. Run the script using the following command:

   ```powershell
   .\Log_Activities.ps1
   ```
4. Logs will be saved in the directory `C:\UserActivityLogs`.

### Automating with Task Scheduler (Optional)

To set up periodic execution:

1. Uncomment and modify the following lines in the script:

   ```powershell
   $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-File `$PSCommandPath"
   $trigger = New-ScheduledTaskTrigger -AtStartup -Once -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration ([TimeSpan]::MaxValue)
   Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "UserActivityMonitor" -Description "Monitor user activities (login/logout, processes, active window)"
   ```

2. Run the script to register the scheduled task.

---

## 🤝 Contribution

Suggestions and improvements are welcome! Feel free to fork this repository, open issues, or submit pull requests.

---

## ⚠️ Disclaimer

- Ensure compliance with local laws and policies before monitoring user activity.
- Use responsibly and only on systems where you have permission to perform such activities.

> "Monitoring isn’t just about tracking—it’s about accountability and process improvement."

