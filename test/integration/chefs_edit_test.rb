require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create! chefname:"tata", email:"tufo@vn.com", password:"12345", password_confirmation:"12345"

    @chef2 = Chef.create!(chefname: "john", email: "john@example.com",
                                        password: "password", password_confirmation: "password")

    @admin_user = Chef.create!(chefname: "john1", email: "john1@example.com",
                                        password: "password", password_confirmation: "password", admin: true)
  end

  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{chefname: " ", email: "tufo@vn.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{chefname: "tata1 ", email: "tufo1@vn.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "tata1", @chef.chefname
    assert_match "tufo1@vn.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{chefname: "tata2", email: "tufo2@vn.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "tata2", @chef.chefname
    assert_match "tufo2@vn.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params:{chef:{chefname: updated_name, email: updated_email}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "tata", @chef.chefname
    assert_match "tufo@vn.com", @chef.email
  end

end
