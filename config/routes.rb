Rails.application.routes.draw do

	#Homepage
	root 'home#index'

	constraints Constraints::CustomSubdomain do
	  get '(*path)' => 'application#blog', :constraints => {subdomain: 'blog'}
	end

	get '/blog' => redirect("https://ratafire.com/blog/")

end
