require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
 
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com"
    @recipe = Recipe.create name:"tiramisu", description:"Mixed creams with chocolate", chef:@chef_id
    @recipe2 = @chef.recipes.build name:"Musaka", description:"Egg plants with cheese and tomato saurce"
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should see recipes listed" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

end
