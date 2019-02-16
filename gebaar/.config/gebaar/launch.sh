#!/usr/bin/env sh

# Terminate already running gebaar instances
killall -q gebaard

# Wait until the processes have been shut down
while pgrep -x gebaard >/dev/null; do sleep 1; done

# Launch gebaar
gebaard -b

echo "Gebaar launched..."
