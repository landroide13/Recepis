require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
 
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com", password:"12345", password_confirmation:"12345"
    @recipe = Recipe.create name:"Italian Veggies", description:"stir frieds veggies with tomato saurce", chef:@chef
  end

  test "successfully delete recipe" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text:'Recipe successfully deleted..'
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirect_to recipes_path
    assert_not flash.empty?
  end


end
