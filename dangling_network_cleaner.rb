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

  def clean
    dangling_network_names = all
    dangling_network_names.each do |dangling_network_name|
      networks = @network_list.find_all_by_name(dangling_network_name)
      networks[0].destroy
    end
  end

end

DanglingNetworkCleaner.new.clean