require_relative './server_list'
require_relative './network_list'

class DanglingNetworkCleaner

  attr_accessor :server_list, :network_list

  def initialize
    ResourceLoader.load
    @server_list = ServerList.new
    @network_list = NetworkList.new
  end

  def all
    attached_network_names = @server_list.servers.map(&:network_names).flatten
    all_network_names = @network_list.networks.map(&:name)

    (all_network_names - attached_network_names)
  end

  def clean_networks
    dangling_network_names = all
    dangling_network_names.each do |dangling_network_name|
      networks = @network_list.find_all_by_name(dangling_network_name)
      networks.map &:destroy
    end
  end

  def clean_servers(exclude_network, server_names)
    servers = server_names.uniq.map {|server_name| @server_list.find_all_by_name(server_name)}.flatten
    network_names = servers.map(&:network_names).flatten.reject {|n| n == exclude_network}
    p "Following networks will be destroyed #{network_names}"
    network_names.each do |network_name|
      networks = @network_list.find_all_by_name(network_name)
      networks.map &:destroy
    end
    servers.each do |server|
      server.destroy
    end
  end

end

cleaner = DanglingNetworkCleaner.new

case ARGV[0]
when "all"
  cleaner.all
when "clean_networks"
  cleaner.clean_networks
when "clean_servers"
  cleaner.clean_servers("ION-VIDEO-VXOA", ARGV[1..-1])
end
