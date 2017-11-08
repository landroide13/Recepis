require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
 
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com"
    @recipe = Recipe.create name:"pato pure", description:"Toxic", chef:@chef
    @recipe2 = @chef.recipes.build name:"Italian Veggies", description:"stir frieds veggies with tomato saurce"
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should see recipes listing to" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select 'a[href=?]', recipe_path(@recipe),text: @recipe.name
    assert_select 'a[href=?]', recipe_path(@recipe2),text: @recipe.name
  end

  test "should recipes show" do 
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end

end
