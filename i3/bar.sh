#!/usr/bin/env bash

# Info light
light(){
    if [ $(brightnessctl get) -lt 15 ]; then
        light_value=$(brightnessctl get)
        else
        light_value=$[$(brightnessctl get)/15]%
    fi
}

# Info CapsLock and NumLock
caps_and_num_lock(){
    capslock_status=$(xset q | grep "Caps" | awk -F' ' '{ print $4 }')
    if [ $capslock_status = "on" ]; then
        caps="󰘲"
        else
        caps=""
    fi

    numlock_status=$(xset q | grep "Caps" | awk -F' ' '{ print $8 }')
    if [ $numlock_status = "on" ]; then
        num="󰌿"
        else
        num=""
    fi

    if [ $capslock_status = $numlock_status ]; then
    locks_value="$caps  $num"
    else
    locks_value="$caps$num"
    fi
}

separator_num_and_caps(){
    if [ $capslock_status = "on" -o $numlock_status = "on" ]; then
        separator_lock="  "
        else
        separator_lock=""
    fi
}

# Info Swap
swap(){
    swap_used=$(swapon --show=USED | tail -n 1 | cut -c3-)
}

i3status | (swap && caps_and_num_lock && read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && light && read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
    read line
    light
    caps_and_num_lock
    separator_num_and_caps
    swap
    #echo ",[{\"full_text\":\"󱠂 ${brightnessctl_value}(${brightnessctl_percentage}) ⌇ ${capslock_icon} ${capslock_status} ⌇ ${numlock_icon} ${numlock_status} ⌇  ${swap_used}\" },${line#,\[}" || exit 1
    echo ",[{\"full_text\":\"${locks_value}${separator_lock}󱠂 ${light_value}    ${swap_used}\" },${line#,\[}" || exit 1
done)
