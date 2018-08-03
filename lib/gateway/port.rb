require_relative 'openstack_cli'
require_relative '../resource/port'

module Gateway

  class Port

    class << self

      attr_accessor :metadata

      def load_data
        @metadata ||= OpenStackCli.port_list
      end

      def ports
        load_data.map do |m|
          Resource::Port.new({
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

      def destroy_all_by_subnet_id(subnet_id)
        ports_to_be_deleted = find_all_by_subnet_id(subnet_id)
        ports_to_be_deleted.each do |p|
          OpenStackCli.port_delete(p.id)
          @metadata.reject! {|m| m[0] == p.id}
        end
      end

      private

      def ip_address(str)
        str.split(",")[0].split("=")[1].gsub("'", "")
      end

      def subnet_id(str)
        str.split(",")[1].split("=")[1].gsub("'", "")
      end

    end

  end

end
