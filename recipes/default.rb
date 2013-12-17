#
# Cookbook Name:: passenger_mon
# Recipe:: default
#
# Copyright 2013, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "logrotate"
include_recipe "rbenv::system"
include_recipe "supervisor"

rbenv_gem "passenger_mon" do
  version node[:passenger_mon][:version]
  notifies :restart, "supervisor_service[passenger_mon]"
end

supervisor_service "passenger_mon" do
  command "#{node[:rbenv][:root_path]}/shims/passenger_mon --interval=#{node[:passenger_mon][:interval]} --memory=#{node[:passenger_mon][:memory]} --log=#{node[:passenger_mon][:log]} --pid=#{node[:passenger_mon][:pid]}"
  environment({
    "PATH" => "#{node[:rbenv][:root_path]}/shims:#{node[:rbenv][:root_path]}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  })
  action :enable
  autostart true
  autorestart true
  startretries 25
  startsecs 3
  stopsignal "INT"
  user "root"
end

logrotate_app "passenger_mon" do
  path node[:passenger_mon][:log]
  frequency "daily"
  rotate node[:supervisor][:logrotate][:rotate]
  create "644 root root"
  options %w(missingok compress delaycompress copytruncate notifempty)
end
