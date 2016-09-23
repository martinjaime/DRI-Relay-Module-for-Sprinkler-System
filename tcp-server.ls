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
  file = 0 # file descriptor
  fs.open file-name, 'ax', (err, fd) ->
    if err
      console.log "#{file-name} EXISTS"
      file = fs.open-sync file-name, 'a'
      file-exists := yes
    else
      file = fd
      console.log 'FILE CREATED'

  socket.on 'data', (data) ->
    data .= to-string!.trim!
    data-obj = {}
    data .= replace /^{\[/, ''
    data .= replace /\]}$/, ''
    data.split('][').for-each (part) ->
      sp-part = part.split ':'
      sp-part && (data-obj[sp-part[0]] = sp-part[1])
    #TODO:save header and compare every time for dynamic logging.
    header = Object.keys data-obj
    data-values = header.map((key) -> data-obj[key])
    data-values.unshift Date.now!
    header.unshift 'timestamp'
    if not file-exists
      fs.append-file-sync file-name, header.join(',') + '\n'
      file-exists := yes
    if data-values.length is not 1
      fs.append-file-sync file-name, data-values.join(',') + '\n'

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
