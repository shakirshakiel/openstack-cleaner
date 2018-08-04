require_relative 'openstack_cli'
require_relative 'port'
require_relative '../resource/subnet'
require_relative '../gateway/router'

module Gateway

  class Subnet

    class << self

      attr_accessor :metadata

      def load_data
        @metadata ||= OpenStackCli.subnet_list
      end

      def subnets
        load_data.map do |m|
          Resource::Subnet.new({
                                   id: m[0],
                                   name: m[1],
                                   network_id: m[2]
                               })
        end
      end

      def find_all_by_network_id(network_id)
        subnets.select {|s| s.network_id == network_id}
      end

      def destroy_all_by_network_id(network_id)
        subnets_to_be_deleted = find_all_by_network_id(network_id)
        subnets_to_be_deleted.each do |s|
          Gateway::Port.destroy_all_by_subnet_id(s.id)
          OpenStackCli.subnet_delete(s.id)
          Gateway::Router.destroy_all_by_subnet_id(s.id)
          @metadata.reject! {|m| m[0] == s.id}
        end
      end

    end

  end

end
