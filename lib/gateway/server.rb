require_relative 'openstack_cli'
require_relative '../resource/server'

module Gateway

  class Server

    class << self

      attr_accessor :metadata

      def load_data
        @metadata ||= OpenStackCli.server_list
      end

      def servers
        load_data.map do |m|
          Resource::Server.new({
                                   id: m[0],
                                   name: m[1],
                                   status: m[2],
                                   network_names: network_names(m[3]),
                                   image: m[4],
                                   flavor: m[5]
                               })
        end
      end

      def find_all_by_name(name)
        servers.select {|s| s.name == name}
      end

      def destroy(server)
        OpenStackCli.server_delete(server.id)
        @metadata.reject! {|m| m[0] == server.id}
      end

      private

      def network_names(network_string)
        network_string.split(";").map {|x| x.split("=")[0].strip}
      end

    end

  end

end
