-- Desert Research Institute
-- Water sprinklers monitor
PORT = 5000
HOST = "192.168.43.178"
print("========================================")
print("Starting client")
print("========================================")
client = net.createConnection(net.TCP, 0)
print(client)
client:connect(PORT, HOST)
client:on("connection", function(sck, msg)
  print("Connected!!!!")
  uart.on("data", "\n",
    function(data)
      --x, y, z, dir = data:match("(-*%d+)\t(-*%d+)\t(-*%d+)\t(-*%d+)")
      if (string.match(data, "quit")) then
        print("Quitting...")
        uart.on("data") -- quit this listener
      --[[
      elseif (x ~= nil and y ~= nil and z ~= nil and dir ~= nil) then
        print(x .. " " .. " " .. y .. " " .. z .. " " .. dir)
        x = tonumber(x)
        y = tonumber(y)
        z = tonumber(z)
        dir = tonumber(dir)
      end
      --]]
      sck:send(data)
    end,
    0)
end)
client:on("receive", function(sck, c) print(c) end)
