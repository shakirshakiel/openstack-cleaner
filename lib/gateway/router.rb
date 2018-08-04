require_relative 'openstack_cli'
require_relative '../resource/router'

module Gateway

  class Router

    class << self

      attr_accessor :metadata

      def load_data
        return @metadata unless @metadata.nil?
        router_list = OpenStackCli.router_list
        @metadata = router_list.map {|rl| [rl[0], rl[1], OpenStackCli.router_show(rl[0])]}
      end

      def routers
        load_data.map do |m|
          Resource::Router.new({
                                   id: m[0],
                                   name: m[1],
                                   interfaces: m[2]
                               })
        end
      end

      def destroy_all_by_subnet_id(subnet_id)
        routers.each do |r|
          r.interfaces = r.interfaces.reject {|i| i["subnet_id"] == subnet_id}
          destroy(r) if r.interfaces.empty?
        end

        @metadata = @metadata.map do |m|
          interfaces = m[2].reject {|i| i["subnet_id"] == subnet_id}
          [m[0], m[1], interfaces]
        end
      end


      def destroy(router)
        OpenStackCli.router_delete(router.id)
        @metadata.reject! {|m| m[0] == router.id}
      end

    end

  end

end
