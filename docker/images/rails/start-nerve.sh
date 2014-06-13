#!/bin/bash
sed -i "s/3000/$SERVICE_PORT/g" /nerve_config.conf.json
nerve -c /nerve_config.conf.json