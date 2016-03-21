# Homepage (Root path)
get '/' do
  erb :index
end


get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  @songs = Song.where(author: @song.author)
  erb :'songs/show'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    created_at: params[:created_at],
    updated_at: params[:updated_at]
  )
  if @song.save
    redirect '/songs'
  else 
    erb :'songs/new'
  end
end