#!/bin/bash
APP=websocket-server
mkdir $APP
cd $APP
npm init -y
npm install ws

cat <<'EOF' > server.js

const WebSocket = require('ws');

const WSS_PORT = process.env.WSS_PORT || 4000;

const wss = new WebSocket.Server({ port: WSS_PORT });

wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
  });

  ws.send('Hello! Message from server...');
});

console.log(`WebSocket Server running on port ${WSS_PORT}`);


EOF

cat <<'EOF' > wss.sh

#!/bin/bash

# Default configuration
WSS_IP=localhost
WSS_PORT=4000

function wss_create() {
  echo "Creating WebSocket server..."
  # Assumes server.js and package.json are set up
  npm install
}

function wss_start() {
  echo "Starting WebSocket server on ${WSS_IP}:${WSS_PORT}..."
  WSS_PORT=$WSS_PORT node server.js
}

EOF
