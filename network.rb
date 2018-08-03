require_relative './subnet_list'

class Network
  attr_accessor :id, :name, :subnet_ids

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @subnet_ids = params[:subnet_ids]
  end

  def destroy
    p "Destroying network #{@id}"
    subnet_list = SubnetList.new
    subnets = subnet_list.find_all_by_network_id(@id)
    subnets.each do |subnet|
      subnet.destroy
    end
    `openstack network delete #{@id}`
  end

end
