class Port
  attr_accessor :id, :name, :mac_address, :ip_address, :subnet_id, :status

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @mac_address = params[:mac_address]
    @ip_address = params[:ip_address]
    @subnet_id = params[:subnet_id]
    @status = params[:status]
  end

  def destroy
    `openstack port set #{@id} --device-owner clear`
    `openstack port delete #{@id}`
  end

end