# sunrise-alarm
various scripts to run a home made sunrise alarm using an rpi zero, and a tapo smart bulb 

very low effort project, most of this is AI generated.

1. install dependencies 
    - `pip install tapo dotenv asyncio`
    - `npm i`
    - jq
    - amixer
    - play
2. create .env and alarm.json file.
3. run server for controls
4. add cron job `* * * * * /project/root/scripts/check-alarm.sh`
