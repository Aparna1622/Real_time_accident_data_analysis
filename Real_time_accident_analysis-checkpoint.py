import requests

API_KEY = 'YOUR_API_KEY_HERE'
location = '28.6139,77.2090,100'  # latitude,longitude,radius_km around Delhi

url = f'http://www.mapquestapi.com/traffic/v2/incidents?key={API_KEY}&boundingBox=28.7041,77.1025,28.4089,77.3178&filters=construction,incidents&inFormat=kvp&outFormat=json'

response = requests.get(url)
data = response.json()

for incident in data.get('incidents', []):
    print(f"Type: {incident.get('type')}")
    print(f"Severity: {incident.get('severity')}")
    print(f"Short Desc: {incident.get('shortDesc')}")
    print(f"Location: {incident.get('lat')}, {incident.get('lng')}")
    print("-" * 30)
