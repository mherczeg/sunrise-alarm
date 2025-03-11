const express = require("express");
const bodyParser = require("body-parser");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = 3000;
const ALARM_FILE = path.join(__dirname, "alarm.json");

app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "public"))); // Serve HTML UI

// Load alarm settings from file
let alarmData = { alarmTime: null, alarmEnabled: false };
if (fs.existsSync(ALARM_FILE)) {
    try {
        alarmData = JSON.parse(fs.readFileSync(ALARM_FILE, "utf8"));
    } catch (err) {
        console.error("Error reading alarm file:", err);
    }
}

// Save alarm settings to file
function saveAlarmData() {
    fs.writeFileSync(ALARM_FILE, JSON.stringify(alarmData, null, 2), "utf8");
}

// Set alarm time
app.post("/set-alarm", (req, res) => {
    const { time } = req.body;
    if (!time) {
        return res.status(400).json({ message: "Alarm time is required" });
    }
    alarmData.alarmTime = time;
    saveAlarmData();
    console.log(`Alarm set for: ${alarmData.alarmTime}`);
    res.json({ message: `Alarm set for ${alarmData.alarmTime}` });
});

// Enable/Disable the alarm
app.post("/toggle-alarm", (req, res) => {
    const { enabled } = req.body;
    alarmData.alarmEnabled = enabled;
    saveAlarmData();
    console.log(`Alarm ${alarmData.alarmEnabled ? "enabled" : "disabled"}`);
    res.json({ message: `Alarm ${alarmData.alarmEnabled ? "enabled" : "disabled"}` });
});

// Get current alarm status
app.get("/alarm-status", (req, res) => {
    res.json(alarmData);
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
