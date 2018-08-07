require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/pizza_order' )
also_reload ( '.models/*' )

# index root
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb (:index)
end

# new root: must be above other roots using same path for variables!
get '/pizza-orders/new' do
  erb(:new)
end
# create root
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

# show root
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb (:show)
end

# delete root
post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  redirect "http://localhost:4567/pizza-orders"
end

# edit root
get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end
#
post '/pizza-orders/:id/update' do
  @order = PizzaOrder.new(params)
  @order.update()
  redirect "http://localhost:4567/pizza-orders"
end
