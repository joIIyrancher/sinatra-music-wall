# Homepage (Root path)
get '/' do
  erb :index
end


get '/songs' do
  # session["value"] ||= "Hello world!"
  # puts "The cookie contains #{session["value"]}"
  # @likes = Like.all
  @songs = Song.all.to_a.sort! { |a,b| b.likes.count <=> a.likes.count }
  erb :'songs/index'
end

get '/songs/new' do
  # if session["user"]
  #   @song = Song.new
  #   erb :'songs/new'
  # else
  #   redirect '/login'
  # end

  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  @songs = Song.where(author: @song.author)
  erb :'songs/show'
end

get '/profile' do
  if session["user"]
    @songs = Song.where(user_id: session["user"].id)
    erb :'users/profile'
  end
end

get '/login' do
  erb :'users/login'
end

get '/register' do
  erb :'users/register'
end


get '/logout' do
  session["user"] = nil
  redirect '/songs'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    created_at: params[:created_at],
    updated_at: params[:updated_at]
  )
  @song.user = session["user"]
  if @song.save
    redirect '/songs'
  else 
    erb :'songs/new'
  end
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user and @user.password == params[:password]
    puts "FOUND!"
    session["user"] = @user
    redirect '/songs'
  else
    puts "NOT FOUND"
    erb :'users/login'
  end
end

post '/register' do
  @user = User.new(email: params[:email], password: params[:password])
  if @user.save
    redirect '/login'
  else
    erb :'users/register'
  end
end


post '/songs/:id' do
  like = Like.new
  like.user = session["user"]
  like.song = Song.find(params[:id])
  like.save
  redirect '/songs'
end

