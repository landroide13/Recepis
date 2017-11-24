require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com", password:"12345", password_confirmation:"12345"
    @recipe = Recipe.create name:"Italian Veggies", description:"stir frieds veggies with tomato saurce", chef:@chef
  end

  test "reject update recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: {name: " ", description: "Some description"}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully edit recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = 'updated name'
    updated_description = 'updated description'
    patch recipe_path(@recipe), params: {recipe: {name: updated_name, description: updated_description}}
    assert_redirected_to @recipe 
    # follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

end 
