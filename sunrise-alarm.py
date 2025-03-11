"""L530, L535 and L630 Example"""   

from tapo import ApiClient
from tapo.requests import Color
import asyncio
from dotenv import load_dotenv
import os

async def connect(): 
    # Read the username and password
    username = os.getenv("SUNRISE_USERNAME")
    password = os.getenv("SUNRISE_PASSWORD")
    ip_address = os.getenv("SUNRISE_IP_ADDRESS")

    client = ApiClient(username, password)
    return await client.l530(ip_address)

async def init():
    load_dotenv()
    duration = int(os.getenv("SUNRISE_DURATION"))
    color = Color.WarmWhite
    start_brightness = 0
    end_brightness = 30
    full_duration = 60 * duration
    wait_time = full_duration/(end_brightness-start_brightness)
    
    device = await connect() 
    await device.on()
    await device.set_color(Color.WarmWhite)
    
    brightness = start_brightness
    while brightness < end_brightness:
        brightness += 1
        await device.set_brightness(brightness)
        await asyncio.sleep(wait_time)

asyncio.run(init())