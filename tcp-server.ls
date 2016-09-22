require! {
  'fs'
  'path'
  'ip'
  'net'
}

HOST = ip.address!
PORT = 5000

server = net.create-server (socket) ->
  console.log 'CONNECTED!!!!'
  socket.write 'Hello! -- from the server'

  date = new Date!
  file-name = path.join 'sensordir', "#{date.get-full-year!}-#{pad date.get-month!, 2}.csv"
  file-exists = no
  file = fs.open file-name, 'ax', (err, fd) ->
    if err
      console.log 'FILE EXISTS'
      fs.open-sync file-name, 'a'
      file-exists = yes
    else
      console.log 'FILE CREATED'

  socket.on 'data', (data) ->
    data .= to-string!
    console.log 'got data!'
    console.log data
    data-obj = {}
    data.replace(/^{\[/, '').replace(/\]}$/, '').split('][').for-each (part) ->
      sp-part = part.split ':'
      sp-part && (data-obj[sp-part[0]] = sp-part[1])
    #save header and compare every time for dynamic logging.
    header = Object.keys data-obj
    if not file-exists
      fs.write-file-sync file-name, header.join '\t'

  socket.on 'close', (data) ->
    console.log 'CLOSED: ' + socket.remote-address + ' ' + socket.remote-port

pad = (number, width, fill) ->
  fill = fill or '0'
  number .= to-string!
  if number.length >= width
    then number
    else new Array(width - number.length + 1).join(fill) + number


server.listen PORT, HOST
console.log "listening on #{HOST}:#{PORT}"
