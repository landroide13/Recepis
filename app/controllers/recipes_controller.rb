class RecipesController < ApplicationController
  before_action :recipe_params, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only:[:edit, :update, :destroy]

  def index
    @recipes = Recipe.paginate(:page => params[:page], :per_page => 3)
  end

  def new
    @recipe = Recipe.new 
  end

  def create
    @recipe = Recipe.new get_params
    @recipe.chef = current_chef
    if @recipe.save
      flash[:success] = "Recipe created successfully.."
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def edit 
  end

  def update
    if @recipe.update(get_params)
      flash[:success] = "Recipe successfully updated"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Upps, something come up , try again"
      render 'edit'
    end
  end

  def show
  end  

  def destroy
    @recipe.destroy
    flash[:danger] = "Recipe successfully deleted.."
    redirect_to recipes_path  
  end


  private 

  def recipe_params
    @recipe = Recipe.find(params[:id])
  end

  def get_params
    params.require(:recipe).permit(:name, :description, ingredient_ids:[])
  end  

  def require_same_user
    if current_chef != @recipe.chef && !current_chef.admin?
      flash[:danger] = "You can only edit and delete your own recipes.."
      redirect_to recipes_path
    end
  end

end