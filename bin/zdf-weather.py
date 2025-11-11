#!/usr/bin/env python3

import json
import os
from datetime import datetime

import requests


def load_dotenv(path="$HOME/dotfiles/.env"):
    path = os.path.expandvars(path)
    if not os.path.exists(path):
        return
    with open(path) as f:
        for line in f:
            if line.strip() == "" or line.startswith("#"):
                continue
            key, _, value = line.strip().partition("=")
            os.environ[key] = value.strip('"').strip("'")


load_dotenv()

API_KEY = os.getenv("WEATHER_API_KEY")
LOCATION = "Kathmandu"
# LOCATION = "Biratnagar"
DAYS = 2

WEATHER_CODES = {
    1000: "☀️",
    1003: "⛅️",
    1006: "☁️",
    1009: "☁️",
    1030: "🌫",
    1063: "🌦",
    1066: "🌨",
    1069: "🌧",
    1072: "🌧",
    1087: "⛈",
    1114: "❄️",
    1117: "❄️",
    1135: "🌫",
    1147: "🌫",
    1150: "🌦",
    1153: "🌦",
    1168: "🌧",
    1171: "🌧",
    1180: "🌧",
    1183: "🌧",
    1186: "🌧",
    1189: "🌧",
    1192: "🌧",
    1195: "🌧",
    1198: "🌧",
    1201: "🌧",
    1204: "🌧",
    1207: "🌧",
    1210: "🌨",
    1213: "🌨",
    1216: "🌨",
    1219: "🌨",
    1222: "🌨",
    1225: "🌨",
    1237: "❄️",
    1240: "🌦",
    1243: "🌧",
    1246: "🌧",
    1249: "🌧",
    1252: "🌧",
    1255: "🌨",
    1258: "🌨",
    1261: "❄️",
    1264: "❄️",
    1273: "⛈",
    1276: "⛈",
    1279: "⛈",
    1282: "⛈",
}

BLOCKS = [
    ("🌅 Morning", 6, 12),
    ("🌤 Afternoon", 12, 18),
    ("🌆 Evening", 18, 22),
    ("🌙 Night", 22, 24),  # plus next-day 0–6
]


def format_temp(t):
    return f"{t}°".ljust(4)


def get_hours_in_range(hours, start, end):
    return [h for h in hours if start <= int(h["time"].split(" ")[1][:2]) < end]


def summarize_block(hours):
    if not hours:
        return None

    avg_temp = round(sum(h.get("feelslike_c", 0) for h in hours) / len(hours))

    def severity(h):
        return h.get("condition", {}).get("code", 9999)

    worst = min(hours, key=severity)
    code = worst.get("condition", {}).get("code", "")
    emoji = WEATHER_CODES.get(code, "❓")
    desc = worst.get("condition", {}).get("text", "?")

    # Check for notable chances
    alerts = []
    rain = max((h.get("chance_of_rain", 0) for h in hours), default=0)
    snow = max((h.get("chance_of_snow", 0) for h in hours), default=0)
    wind = max((h.get("wind_kph", 0) for h in hours), default=0)

    if rain >= 50:
        alerts.append(f"Rain {rain}%")
    if snow >= 50:
        alerts.append(f"Snow {snow}%")
    if wind >= 30:
        alerts.append(f"Wind {wind:.0f} Km/h")

    extra = f", {', '.join(alerts)}" if alerts else ""
    return f"{emoji} {format_temp(avg_temp)} {desc}{extra}"


try:
    resp = requests.get(
        f"http://api.weatherapi.com/v1/forecast.json?key={API_KEY}&q={LOCATION}&days={DAYS}&aqi=no&alerts=no",
        timeout=5,
    )
    weather = resp.json()
except Exception as e:
    print(json.dumps({"text": "⚠️", "tooltip": f"Weather fetch failed: {e}"}))
    exit(1)

current = weather.get("current", {})
forecast = weather.get("forecast", {}).get("forecastday", [])
condition = current.get("condition", {})
emoji = WEATHER_CODES.get(condition.get("code", ""), "❓")

data = {"text": f"{emoji} {current.get('feelslike_c', '?')}°", "tooltip": ""}

desc = condition.get("text", "?")
temp = current.get("temp_c", "?")
feels = current.get("feelslike_c", "?")
wind = current.get("wind_kph", "?")
humidity = current.get("humidity", "?")

data["tooltip"] += f"<b>{desc} {temp}°</b>\n"
data["tooltip"] += f"Feels like: {feels}°\n"
data["tooltip"] += f"Wind: {wind} Km/h\n"
data["tooltip"] += f"Humidity: {humidity}%\n"

for i, day in enumerate(forecast[:2]):
    date = day.get("date", "????-??-??")
    astro = day.get("astro", {})
    sunrise = astro.get("sunrise", "??:??")
    sunset = astro.get("sunset", "??:??")

    max_temp = day.get("day", {}).get("maxtemp_c", "?")
    min_temp = day.get("day", {}).get("mintemp_c", "?")

    label = "Today" if i == 0 else "Tomorrow" if i == 1 else date
    data["tooltip"] += f"\n<b>{label}</b>\n"
    data["tooltip"] += f"🌅 {sunrise} 🌇 {sunset}\n"

    hours = day.get("hour", [])
    next_day_hours = forecast[i + 1]["hour"] if i + 1 < len(forecast) else []

    for block_label, start, end in BLOCKS:
        block_hours = get_hours_in_range(hours, start, end)

        # Add 0–6 of next day for "Night" block on Tomorrow
        if i == 1 and block_label == "🌙 Night":
            block_hours += get_hours_in_range(next_day_hours, 0, 6)

        summary = summarize_block(block_hours)
        if summary:
            data["tooltip"] += f"{block_label}: {summary}\n"

print(json.dumps(data))
