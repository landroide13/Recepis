class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def index
    @chefs = Chef.all
  end

  def create
    @chef = Chef.new get_params
    if @chef.save
      flash[:success] = "Chef Successfully created"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def show
    set_params
  end

  private

  def get_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_params
    @chef = Chef.find params[:id]
  end

end