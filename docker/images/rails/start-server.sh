#!/bin/bash
cd /app
bundle install
bundle exec unicorn -p $SERVICE_PORT