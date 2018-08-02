class ResourceLoader
  class << self
    attr_accessor :server_metadata, :network_metadata, :subnet_metadata, :port_metadata

    def load
      p "Fetching server list"
      @server_metadata = cleansed_output(`openstack server list`)
      # | ID | Name | Status | Networks | Image| Flavor|

      p "Fetching network list"
      @network_metadata = cleansed_output(`openstack network list`)
      # | ID | Name | Subnets |

      p "Fetching subnet list"
      @subnet_metadata = cleansed_output(`openstack subnet list`)
      # | ID | Name | Network | Subnet |

      p "Fetching port list"
      @port_metadata = cleansed_output(`openstack port list`)
      # | ID | Name | MAC Address | Fixed IP Addresses | Status |
    end

    def cleansed_output(cli_output)
      cleansed = cli_output.split("\n")[3..-2]
      cleansed.map {|a| a.split("|").map(&:strip)}.map {|a| a[1..-1]}
    end

  end
end
