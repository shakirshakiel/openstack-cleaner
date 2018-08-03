module Resource

  class Network
    attr_accessor :id, :name, :subnet_ids

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @subnet_ids = params[:subnet_ids]
    end

  end

end