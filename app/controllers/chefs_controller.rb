class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def index
    @chefs = Chef.all
  end

  

end