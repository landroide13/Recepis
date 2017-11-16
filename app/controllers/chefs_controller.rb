class ChefsController < ApplicationController

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
 
  def new
    @chef = Chef.new
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

  def edit
    @chef = set_params
  end

  def update
    @chef = set_params
    if @chef.update get_params
      flash[:success] = "Chef successfully updated"
      redirect_to chef_path(@chef)
    else
      flash[:danger] = "Upss, something come up, try again.."
      render 'edit'
    end
  end  

  def show
    @chef = set_params
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
  end

  private

  def get_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_params
    Chef.find params[:id]
  end

end