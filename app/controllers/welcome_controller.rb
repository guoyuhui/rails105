class WelcomeController < ApplicationController

  def index
    flash[:warning] = "hello world!"
  end

end
