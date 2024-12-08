#!/usr/bin/env bash

light() {
  local brightness=$(brightnessctl get)
  local threshold=${1:-15}
  local unit

  if [[ -z "$brightness" ]]; then
    echo "Erro ao obter o brilho da tela."
    return 1
  fi

  if [[ $brightness -lt $threshold ]]; then
    unit=""
  else
    unit="%"
    brightness=$((brightness / threshold))
  fi

  echo "󰌵 $brightness$unit"
}

light
