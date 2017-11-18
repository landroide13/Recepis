class PagesController < ApplicationController

  def home
    redirect_to recipes_path if if_logged?
  end

end 

