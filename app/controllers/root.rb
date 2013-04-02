Freesia::App.controllers :root, map: '/' do
  get :index do
    render 'root/index'
  end
end
