module Resource
  class Router
    attr_accessor :id, :name, :interfaces

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @interfaces = params[:interfaces]
    end

  end
end