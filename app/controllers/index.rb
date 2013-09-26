get '/' do
  # render home page
  @users = User.all

  erb :index
end



#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end


#----------Skills----------

get '/skills/new' do
  erb :skill_new
end

post '/skills/new' do 
  @skill = Skill.create(name: params[:name], context: params[:context])
  redirect ('/')
end


#---------Proficiencies--------

get '/proficiency/new' do
  erb :proficiency_new
end

post '/proficiency/new' do
  @profic = Proficiency.create(years: params[:years], formal: params[:formal], user_id: session[:user_id])
  redirect to ('/')
end




