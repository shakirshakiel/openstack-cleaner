require_relative 'lib/openstack_cleaner'

desc "Show all dangling networks"
task :dangling_networks do
  cleaner = OpenstackCleaner.new
  p cleaner.dangling_networks
end

desc "Clean all dangling networks"
task :clean_dangling_networks do
  cleaner = OpenstackCleaner.new
  cleaner.clean_dangling_networks
end

desc "Clean all servers and its associated networks Usage: rake clean_servers exclude_networks='' servers=''"
task :clean_servers do
  exclude_networks = ENV["exclude_networks"].split(",").map(&:strip)
  servers = ENV["servers"].split(",").map(&:strip)

  cleaner = OpenstackCleaner.new
  cleaner.clean_servers(exclude_networks, servers)
end