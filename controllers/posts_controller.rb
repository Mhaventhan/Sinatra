class PostsController < Sinatra::Base
  # sets the root as the parent-directry of the current file
 set :root, File.join(File.dirname(__FILE__),'..')
 # Sets the view directory correctly
 set :views, Proc.new {File.join(root,'views')}

  configure :development do
    register Sinatra::Reloader
  end
  $posts = [{
    id:0,
    title:'Post 0',
    post_body: 'this is the 0 post'
    },
    {
    id:1,
    title:'Post 1',
    post_body: 'this is the 1st post'
    },
    {
    id:2,
    title:'Post 2',
    post_body: 'this is the 2nd post'
  },
    {
    id:3,
    title:'Post 3',
    post_body: 'this is the 3rd post'
    }]

  get "/" do
    @title = "Blog posts"
    @post = $posts
    erb :'posts/index'
  end

  get '/new' do
    @title = "New post"
    @post = {
      id:'',
      title: '',
      post_body: ''
    }
    erb :'posts/new'
  end

  get '/:id' do
    id = params[:id].to_i
    @post = $posts[id]
    erb :'posts/show'

  end
  get '/:id/edit' do
    @title = 'edit'
    id = params[:id].to_i
    @post = $posts[id]

    erb :'posts/edit'

  end

  post '/' do
    new_post = {
      id: $posts.length,
      title: params[:title],
      post_body: params[:post_body]
    }
    $posts.push(new_post)
    redirect '/'
  end

  put "/:id" do
    id = params[:id].to_i
    post = $posts[id]
    post[:title] = params[:title]
    post[:post_body] = params[:post_body]

    $posts[id] = post

    redirect '/'
  end

  delete '/:id' do
    "Delete #{params[:id]}"
  end

end
