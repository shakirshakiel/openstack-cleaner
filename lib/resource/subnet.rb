module Resource

  class Subnet
    attr_accessor :id, :name, :network_id

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @network_id = params[:network_id]
    end

  end

end