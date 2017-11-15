require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com", password:"12345", password_confirmation:"12345"
    @recipe = Recipe.create name:"Italian Veggies", description:"stir frieds veggies with tomato saurce", chef:@chef
    @recipe2 = @chef.recipes.build name:"Italian Veggies", description:"stir frieds veggies with tomato saurce"
    @recipe2.save
  end

  test "should get chef path" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select 'a[href=?]', recipe_path(@recipe),text: @recipe.name
    assert_select 'a[href=?]', recipe_path(@recipe2),text: @recipe.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
end
