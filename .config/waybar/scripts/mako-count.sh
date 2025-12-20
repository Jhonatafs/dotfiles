#!/bin/bash
COUNT=$(makoctl list | jq '.data[0] | length')

if [ "$COUNT" != "0" ]; then
    echo "{\"text\": \"$COUNT\", \"tooltip\": \"Notificações pendentes\", \"class\": \"active\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"Sem notificações\", \"class\": \"\"}"
fi
