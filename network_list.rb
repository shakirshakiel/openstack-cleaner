require_relative 'resource_loader'
require_relative './network'

class NetworkList
  attr_accessor :metadata

  def initialize()
    @metadata = ResourceLoader.network_metadata
  end

  def networks
    @metadata.map do |m|
      Network.new({
                      id: m[0],
                      name: m[1],
                      subnet_ids: subnet_ids(m[2])
                  })
    end
  end

  def find_all_by_name(name)
    networks.select {|n| n.name == name}
  end

  private

  def subnet_ids(subnet_string)
    subnet_string.split(",").map(&:strip)
  end

end
