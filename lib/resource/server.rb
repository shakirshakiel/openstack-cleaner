module Resource

  class Server
    attr_accessor :id, :name, :status, :network_names, :image, :flavor

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @status = params[:status]
      @network_names = params[:network_names]
      @image = params[:image]
      @flavor = params[:flavor]
    end

  end

end
