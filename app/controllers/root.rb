Freesia::App.controllers :root, map: '/' do
  get :index do
    @notebooks = Notebook.list(current_account.id)

    render 'root/index'
  end
end
