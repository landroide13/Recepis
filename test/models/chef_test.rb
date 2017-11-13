require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new chefname:"Fofo", email:"chota@vn.com", password:"12345", password_confirmation:"12345"
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname shouldn't be more 35 char" do
    @chef.chefname = "a" * 36
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email shouldn't be more 350 char" do
    @chef.chefname = "a" * 351
    assert_not @chef.valid?
  end

  test "email should be correct format" do
    valid_emails = %w[user@example.com LUIS@gmail.com L.first@yahoo.com lu+is@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end  
  end 

  test "email should be reject invalid formats" do
    invalid_emails = %w[user@example LUIS@gmail,com L.first@yahoo. lu+is@co+uk.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be valid"
    end  
  end 

  test "email should be unique and case incensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lowercase" do
    mix_email = "JhON@ExAmplE.cOm"
    @chef.email = mix_email
    @chef.save
    assert_equal mix_email.downcase, @chef.reload.email
  end

  test "passwoord should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "chefname should be atleast 5 char" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

end