# 📌URL Status Checker

## 📖 Description
This PowerShell script allows users to input multiple URLs and checks their HTTP status codes using the `Invoke-WebRequest` command. The results are displayed on the output screen.

## ✨ Features
✅ Accepts multiple URLs as user input.  
✅ Fetches the HTTP status code for each URL.  
✅ Displays the results directly on the output screen.  
✅ Handles errors gracefully for unreachable URLs.  

## 🔍 Why is this useful?
This tool is particularly useful for system administrators, security researchers, and penetration testers. It can be used in cybersecurity for:
- **Reconnaissance & Information Gathering:** Checking the availability of web services.
- **Web Security Testing:** Identifying broken links, misconfigured servers, and error pages.
- **Pentesting Automation:** Automating the process of checking the response of multiple target URLs.
- **Bug Bounty Hunting:** Detecting HTTP status codes that may indicate vulnerabilities (e.g., `403` Forbidden, `500` Internal Server Error, `301/302` Redirects).

## ⚠️ Prerequisites
🔹 PowerShell (Windows 10/11 or Windows Server)  
🔹 Internet access to check the URLs  
🔹 **Set Execution Policy** (By default, PowerShell execution policy is restricted. To run scripts, execute the following command in PowerShell as Administrator):  
```powershell
Set-ExecutionPolicy Unrestricted -Scope Process
```

## 🚀 Usage
1️⃣ Open PowerShell.  
2️⃣ Run the script.  
3️⃣ Enter URLs one by one when prompted.  
4️⃣ Type `done` when you have finished entering URLs.  
5️⃣ The script will check the status of each URL and display the results on the screen.  

## 📌 Example Execution
```
ads.snapchat.com
am-api.snapchat.com
```

### 🖼️ Sample Output
![Output Screenshot](https://github.com/21Lalit/Powershell-Scripting/blob/main/Url-Status-Checker/Output.png)
