# coding: utf-8

Freesia::App.controllers :notebooks do
  get :index do
    @notebooks = Notebook.list(current_account.id)
    render 'notebooks/index'
  end

  get :new do
    render 'notebooks/new'
  end

  post :create do
    params[:notebook][:account_id] = current_account.id
    @notebook = Notebook.new(params[:notebook])

    if @notebook.save
      message = "#{@notebook.name}を作成しました"
      flash[:success] = message
      redirect url(:notebooks, :index)
    else
      render 'notebooks/new'
    end
  end
end
