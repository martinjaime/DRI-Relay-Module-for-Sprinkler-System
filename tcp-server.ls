require! {
  'net'
  'ip'
}

HOST = ip.address!
PORT = 5000

server = net.create-server (socket) ->
  console.log 'CONNECTED!!!!'
  socket.on 'data', (data) ->
    console.log 'outputting data'
    console.log data.to-string!
  socket.on 'close', (data) ->
    console.log 'CLOSED: ' + socket.remote-address + ' ' + socket.remote-port
  socket.write 'Hello! -- from the server'

server.listen PORT, HOST
console.log "listening on #{HOST}:#{PORT}"
