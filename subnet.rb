class Subnet
  attr_accessor :id, :name, :network_id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @network_id = params[:network_id]
  end

  def destroy
    p "Destroying Subnet #{@id}"
    port_list = PortList.new
    port_list = port_list.find_all_by_subnet_id(@id)
    port_list.each do |port|
      port.destroy
    end
    `openstack subnet delete #{@id}`
  end

end