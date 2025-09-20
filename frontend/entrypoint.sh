#!/bin/sh
# Generate runtime config.js in dist
cat <<EOF > /app/dist/config.js
window.RUNTIME_CONFIG = {
  VITE_APP_URL: "${VITE_APP_URL:-http://localhost:5001}"
};
EOF

# Start static server
serve -s dist -l 5173
