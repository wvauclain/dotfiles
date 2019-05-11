#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch the correct bars for the given computer
case $(hostname) in
    goldenarches)
        polybar goldenarches &
        ;;
    shadowboxpc)
        polybar shadowboxpc-main &
        polybar shadowboxpc-side &
        ;;
esac

echo "Bars launched..."
