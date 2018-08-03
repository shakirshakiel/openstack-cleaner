require_relative 'openstack_cli'
require_relative 'subnet'
require_relative '../resource/network'

module Gateway

  class Network

    class << self

      attr_accessor :metadata

      def load_data
        @metadata ||= OpenStackCli.network_list
      end

      def networks
        load_data.map do |m|
          Resource::Network.new({
                                    id: m[0],
                                    name: m[1],
                                    subnet_ids: subnet_ids(m[2])
                                })
        end
      end

      def find_all_by_name(name)
        networks.select {|n| n.name == name}
      end

      def destroy(network)
        Gateway::Subnet.destroy_all_by_network_id(network.id)
        OpenStackCli.network_delete(network.id)
        @metadata.reject! {|m| m[0] == network.id}
      end

      private

      def subnet_ids(subnet_string)
        subnet_string.split(",").map(&:strip)
      end

    end

  end

end
