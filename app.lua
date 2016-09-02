-- Desert Research Institute
-- Water sprinklers monitor
port = 4545
print("========================================")
print("Starting server")
print("========================================")
server = net.createServer(net.UDP)
print(server)
server:on("receive", function(server, msg)
  print("Message Reveived")
  print(msg)
  server:send("echo: "..msg)
end)
server:listen(port)
