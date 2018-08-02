require_relative './resource_loader'
require_relative './subnet'
require_relative './port_list'

class SubnetList
  attr_accessor :metadata

  def initialize()
    @metadata = ResourceLoader.subnet_metadata
  end

  def subnets
    @metadata.map do |m|
      Subnet.new({
                     id: m[0],
                     name: m[1],
                     network_id: m[2]
                 })
    end
  end

  def find_all_by_network_id(network_id)
    subnets.select {|s| s.network_id == network_id}
  end

end
