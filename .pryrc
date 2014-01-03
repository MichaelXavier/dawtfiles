# # Load plugins (only those I whitelist)
# Pry.config.should_load_plugins = false
# Pry.plugins["doc"].activate!

# # Launch Pry with access to the entire Rails stack.
# # If you have Pry in your Gemfile, you can pass: ./script/console --irb=pry instead.
# # If you don't, you can load it through the lines below :)
# rails = File.join Dir.getwd, 'config', 'environment.rb'

# if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
#   require rails
  
#   if Rails.version[0..0] == "2"
#     require 'console_app'
#     require 'console_with_helpers'

#     if defined?(Hijacker)
#       Pry.config.prompt = proc do |target_self, nest_level, pry|
#         current_client = "\033[1m#{Hijacker.current_client}\033[0m"
#         if nest_level == 0
#           "(#{current_client}) pry(#{Pry.view_clip(target_self)})> "
#         else
#           "(#{current_client}) pry(#{Pry.view_clip(target_self)}):#{nest_level}> "
#         end
#       end
#     end
#   elsif Rails.version[0..0] == "3"
#     require 'rails/console/app'
#     require 'rails/console/helpers'
#   else
#     warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
#   end
# end
