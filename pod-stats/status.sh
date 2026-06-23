#!/bin/bash

while true; do
  {
    echo "# TYPE container_status gauge"

    podman ps --format '{{.Names}} {{.Status}}' | while read name status; do
      if [[ "$status" == *Up* ]]; then
        echo "container_status{name=\"$name\"} 1"
      else
        echo "container_status{name=\"$name\"} 0"
      fi
    done

  } > ~/container_apps/pod-stats/metrics.txt

  sleep 900
done
