class RecipesController < ApplicationController

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

  def show
    @recipe = Recipe.find params[:id]
  end  


  private 

  def recipe_params
    @recipe = Recipe.find(params[:id])
  end

  def get_params
    params.require(:recipe).permit(:name, :description)
  end  

end