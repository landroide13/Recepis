class RecipesController < ApplicationController
  before_action :recipe_params, only: [:edit, :update, :show, :destroy]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new 
  end

  def create
    @recipe = Recipe.new get_params
    @recipe.chef = Chef.first
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
    params.require(:recipe).permit(:name, :description)
  end  

end