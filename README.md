#DRI Relay Module for Sprinkler System

These set of scripts read sensor data from a monitor device, and posts them to
a web server

###app-client.lua
App instructions for reading and posting data to tcp server.

###server-settings.lua
Contains server and serial interface information such as `IP`, `BAUD` rate, and
`PORT` number. Read by app-client.lua

###credentials.lua
Ignored in this repository, must contain information about the network that
the ESP8266 must connect to. Rename `credentials.example.lua` to `credentials.lua`. Read by init.lua.

###init.lua
Contain initiation instructions to set up the device by connecting the device to
the network. This file reads `credentials.lua`, so make sure it exists.

###tcp-server.ls
TCP server.

##Instructions
1. Clone this repository.
2. cd into it, and run `npm install`
3. Use ESPTool to put init.lua, app-client.lua, credentials.lua, and server-settings.lua into the HUZZAH 8266 module (tested on Ubuntu 14.04 machine).
4. Run the server with `npm start`.
5. Reset the Wifi module, and watch for the server to log "CONNECTED!!!" to the console.
