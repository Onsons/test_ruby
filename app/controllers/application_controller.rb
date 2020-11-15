# For the documentation check http://sinatrarb.com/intro.html
class ApplicationController < Sinatra::Base
	configure do
	  set :views, "app/views"
	  set :public_dir, "public"
	end
	get '/' do
	  erb(:index, :locals => {:result => -1,:amount =>0,:from_To => ""})
  end
  get '/history' do
	  history = History.all
	  erb(:history, locals: { history: history })
  end
  get '/delete-history' do
	  history = History.all
	  history.destroy 
	  redirect('/history')
  end
  post '/' do
	  new_history = History.new
	  new_history.fromTo = params[:from_To] #getting the value of the input of type radio
	  new_history.created_at = Time.now.strftime("%d/%m/%Y")
	  new_history.amount = params[:amount] #getting the amount
	  getResultValue = GetResultValue.new(new_history.fromTo,new_history.amount)
	  new_history.result = getResultValue.getResult #calculating the result
	  new_history.save 
	  erb(:index, locals: { result:new_history.result ,amount:new_history.amount,from_To:new_history.fromTo}) 
	end

end