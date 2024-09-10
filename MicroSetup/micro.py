# Assuming you have Flask and Requests installed.
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

# Here's the weather API endpoint
@app.route('/weather', methods=['GET'])
def get_weather():
    # Here's where we're getting the weather data
    weather_url = f"https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
    response = requests.get(weather_url)
    data = response.json()
    
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
