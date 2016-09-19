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
  uart.on("data", "\r",
    function(data)
      --x, y, z = data:match("(-*%d+),(-*%d+),(-*%d+)")
      if (string.match(data, "quit")) then
        print("Quitting app...")
        uart.on("data") -- quit this listener
      end
      sck:send(data)
    end,
    0)
end)
client:on("receive", function(sck, c) print(c) end)
