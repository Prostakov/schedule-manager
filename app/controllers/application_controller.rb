class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def hack_password user counts
  	while counts
  	  k = STDIN.gets.chomp.split(' ')[0]
  	  return "Fuck Yeah! The password is #{k}" if user.authenticate(k)
  	  counts -= 1
  	end
  	"You\'ve lost! Congrats, sucker!"
  end
end
