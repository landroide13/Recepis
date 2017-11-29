class ComentsController < ApplicationController
  before_action :require_user

  def create
    @recipe = Recipe.find params[:recipe_id]
    @coment = @recipe.coments.build coment_params
    @coment.chef = current_chef
    if @coment.save
      flash[:success] = "Comment Successfully created.."
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Commnet was not created.."
      redirect_back(fallback_location: root_path)
    end
  end

  private 

  def coment_params
    params.require(:coment).permit(:description)
  end

end