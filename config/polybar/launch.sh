#!/usr/bin/env bash

killall -9 polybar

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload base & disown
done

echo "Launched polybar(s)..."

