#
# Cookbook Name:: passenger_mon
# Attributes:: passenger_mon
#
# Copyright 2013, NREL
#
# All rights reserved - Do Not Redistribute
#

node.default[:passenger_mon][:version] = "0.3.0"
node.default[:passenger_mon][:interval] = 30
node.default[:passenger_mon][:memory] = 400
node.default[:passenger_mon][:log] = "/var/log/passenger_mon.log"
node.default[:passenger_mon][:pid] = "/tmp/passenger_mon.pid"
