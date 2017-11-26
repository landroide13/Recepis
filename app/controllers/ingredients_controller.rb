class IngredientsController < ApplicationController
  before_action :set_ingredient, only:[:edit, :update, :show]
  before_action :require_admin, except:[:show, :index]


  def show
    @ingredient_recipes = @ingredient.recipes.paginate page: params[:page], per_page: 3
  end

  def index
    @ingredients = Ingredient.paginate page: params[:page], per_page: 3
  end

  def new
    @ingredient = Ingredient.new
  end 

  def create
    @ingredient = Ingredient.new ingredient_params
    if @ingredient.save
      flash[:success] = "Ingredient Succesfully Created.."
      redirect_to ingredient_path(@ingredient)
    else
      flash[:danger] = "Ups, something comming up, try again.."
      render 'new'
    end    
  end

  def edit
  end

  def update
    if @ingredient.update ingredient_params
      flash[:success] = "Ingredient successfully updated.."
      redirect_to ingredient_path(@ingredient)
    else
      flash[:danger] = "Upss.."
      render 'edit'
    end
  end

  def destroy
  end

  private 

  def set_ingredient
    @ingredient = Ingredient.find params[:id]
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def require_admin
    if if_logged? && !current_chef.admin?
      flash[:danger] = "Only admin Users can perfome that action.."
      redirect_to ingredients_path
    end
  end

end