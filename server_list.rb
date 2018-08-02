require_relative 'resource_loader'
require_relative './server'

class ServerList
  attr_accessor :metadata

  def initialize()
    @metadata = ResourceLoader.server_metadata
  end

  def servers
    @metadata.map do |m|
      Server.new({
                     id: m[0],
                     name: m[1],
                     status: m[2],
                     network_names: network_names(m[3]),
                     image: m[4],
                     flavor: m[5]
                 })
    end
  end

  private

  def network_names(network_string)
    network_string.split(";").map {|x| x.split("=")[0].strip}
  end

end
