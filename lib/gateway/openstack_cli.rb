module Gateway

  class OpenStackCli

    class << self

      def server_list
        p "Fetching server list"
        # | ID | Name | Status | Networks | Image| Flavor|
        cleansed_output(`openstack server list`)
      end

      def server_delete(id)
        p "Deleting server #{id}"
        `openstack server delete #{id}`
      end

      def network_list
        p "Fetching network list"
        # | ID | Name | Subnets |
        cleansed_output(`openstack network list`)
      end

      def network_delete(id)
        p "Deleting network #{id}"
        `openstack network delete #{id}`
      end

      def subnet_list
        p "Fetching subnet list"
        # | ID | Name | Network | Subnet |
        cleansed_output(`openstack subnet list`)
      end

      def subnet_delete(id)
        p "Deleting subnet #{id}"
        `openstack subnet delete #{id}`
      end

      def port_list
        p "Fetching port list"
        # | ID | Name | MAC Address | Fixed IP Addresses | Status |
        cleansed_output(`openstack port list`)
      end

      def port_delete(id)
        p "Deleting port #{id}"
        if id.empty?
          return
        end

        `openstack port set #{id} --device-owner clear`
        `openstack port delete #{id}`
      end

      private

      def cleansed_output(cli_output)
        cleansed = cli_output.split("\n")[3..-2]
        cleansed.map {|a| a.split("|").map(&:strip)}.map {|a| a[1..-1]}
      end

    end

  end

end