# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3ba2759d4cbdf57831fa493d4e5d764e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :get_info
  
  def get_info
    @info, player = {}, PLAYER.new
    @info[:current_track] = player.current_track
    @info[:player_state] = player.player_state
    @info[:player_position] = [player.player_position, player.track_duration]
    @info[:player_position_percent] = (@info[:player_position][0] / @info[:player_position][1]) * 100
  end
end
