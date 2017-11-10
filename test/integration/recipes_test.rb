require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
 
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com"
    @recipe = Recipe.create name:"Italian Veggies", description:"stir frieds veggies with tomato saurce", chef:@chef
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
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text:"Edit this recipe"
    assert_select 'a[href=?]', delete_recipe_path(@recipe), text:"Delete this recipe"
  end

  test "create a new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_recipe = "Italian Veggies"
    description_of_recipe = "stir frieds veggies with tomato saurce"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { name: name_recipe, description: description_of_recipe} 
    end
    follow_redirect!
    assert_match name_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name:" ", description:" "}}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end


end
