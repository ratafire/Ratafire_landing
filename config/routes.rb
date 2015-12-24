Rails.application.routes.draw do

	#Homepage
	root 'home#index'

	get '(*path)' => 'application#blog', :constraints => {subdomain: 'blog'}
	get '/blog' => redirect("https://ratafire.com/blog/")

end
