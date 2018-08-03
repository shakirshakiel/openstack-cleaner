require_relative './gateway/server'
require_relative './gateway/network'

class OpenstackCleaner

  def dangling_networks
    attached_network_names = Gateway::Server.servers.map(&:network_names).flatten
    all_network_names = Gateway::Network.networks.map(&:name)

    (all_network_names - attached_network_names)
  end

  def clean_dangling_networks
    dangling_networks.each do |dangling_network|
      networks = Gateway::Network.find_all_by_name(dangling_network)
      networks.map {|n| Gateway::Network.destroy(n)}
    end
  end

  def clean_servers(exclude_networks, server_names)
    servers = server_names.uniq.map {|server_name| Gateway::Server.find_all_by_name(server_name)}.flatten
    network_names = servers.map(&:network_names).flatten.reject {|n| exclude_networks.include?(n)}
    network_names.each do |network_name|
      networks = Gateway::Network.find_all_by_name(network_name)
      networks.map {|n| Gateway::Network.destroy(n)}
    end
    servers.each do |server|
      Gateway::Server.destroy(server)
    end
  end

end