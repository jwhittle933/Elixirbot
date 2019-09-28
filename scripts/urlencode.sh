#!/bin/bash

curl -X POST --data-urlencode 'text=12 == 12' "localhost:4000/webhook"
