#!/bin/bash


curl -X POST "localhost:4000/webhook" \
     --data-urlencode 'text=12 == 12' \
     --data-urlencode 'user_id=jon' \
     --data-urlencode "response_url=https://hooks.slack.com/services/tglfxgm6x/bnvc02t53/tkrdochbywsnkb6elwcvfeac" \
     # "ec2-34-230-12-231.compute-1.amazonaws.com/webhook"
