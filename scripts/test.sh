#!/bin/bash

echo "Testing equality: 12 == 12"
curl -X POST "ec2-34-230-12-231.compute-1.amazonaws.com/webhook" -H "Content-type: application/json" -d '{"exec": "12 == 12"}'
