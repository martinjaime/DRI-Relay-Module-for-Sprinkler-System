#DRI Relay Module for Sprinkler System

These set of scripts read sensor data from a monitor device, and posts them to
a web server

###app.lua
App instructions for reading and posting data.

###credentials.lua
Hidden in this repository, must contain information about the network that the
ESP8266 must connect to. Rename `credentials.example.lua` to `credentials.lua`

###init.lua
Contain initiation instructions to set up the device by connecting the device to
the network. This file reads `credentials.lua`, so make sure it exists.

###udp-client.py
Is a PC side client for demonstration purposes.
