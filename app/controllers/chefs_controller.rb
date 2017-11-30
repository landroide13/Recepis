class ChefsController < ApplicationController
  before_action :set_params, only:[:show, :destroy, :edit, :update]
  before_action :require_same_user, only:[:edit, :update, :destroy]
  before_action :require_admin, only:[:destroy]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
 
  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new get_params
    if @chef.save
      session[:chef_id] = @chef.id
      cookies.signed[:chef_id] = @chef.id
      flash[:success] = "Chef Successfully created.."
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger] = "Chef successfully deleted.."
      redirect_to chefs_path
    end
  end

  def edit
    
  end

  def update
    if @chef.update get_params
      flash[:success] = "Chef successfully updated"
      redirect_to chef_path(@chef)
    else
      flash[:danger] = "Upss, something come up, try again.."
      render 'edit'
    end
  end  

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
  end

  private

  def get_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_params
    @chef = Chef.find params[:id]
  end

  def require_same_user
    if current_chef != @chef && !current_chef.admin?
      flash[:danger] = "You can only edit and delete your own account.."
      redirect_to chefs_path
    end
  end

  def require_admin
    if if_logged? && !current_chef.admin?
      flash[:danger] = "Only admins can perfome that.."
      redirect_to root_path
    end
  end

end