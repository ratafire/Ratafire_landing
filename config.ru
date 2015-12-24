# This file is used by Rack-based servers to start the application.

require "rack-rewrite"

require ::File.expand_path('../config/environment',  __FILE__)

ENV['RACK_ENV'] ||= 'development'

if ENV['RACK_ENV'] == 'development'
  ENV['SITE_URL'] = 'ratafire.local:3000'
  else
  ENV['SITE_URL'] = 'ratafire.com'
end

use Rack::Rewrite do
	if Proc.new { |rack_env|rack_env['SERVER_NAME'].start_with?('www')} then
		r301 %r{.*}, "http://#{ENV['SITE_URL']}$&"
	else
		use Rack::ReverseProxy do
			reverse_proxy /^\/blog(\/.*)$/, 'http://ratafire.flywheelsites.com$1', :username => 'flywheel', :password => 'skynettie', :timeout => 1000, :preserve_host => true
		end
	end
	r301 %r{^(.+)/$}, '$1'
end


run Rails.application
