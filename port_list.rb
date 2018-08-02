require_relative 'resource_loader'
require_relative './port'

class PortList
  attr_accessor :metadata

  def initialize()
    @metadata = ResourceLoader.port_metadata
  end

  def ports
    @metadata.map do |m|
      Port.new({
                   id: m[0],
                   name: m[1],
                   mac_address: m[2],
                   ip_address: ip_address(m[3]),
                   subnet_id: subnet_id(m[3]),
                   status: m[4]
               })
    end
  end

  def find_all_by_subnet_id(subnet_id)
    ports.select {|p| p.subnet_id == subnet_id}
  end

  private

  def ip_address(str)
    str.split(",")[0].split("=")[1].gsub("'", "")
  end

  def subnet_id(str)
    str.split(",")[1].split("=")[1].gsub("'", "")
  end

end
