# coding: utf-8

Freesia::App.controllers :notebooks, map: '/:screen_name' do
  get :show, with: :slug do |screen_name, slug|
    @notebook = Notebook.first(account_id: current_account.id, slug: slug)
    return error 404 if @notebook.nil?
    return error 403 unless @notebook.account_id == current_account.id
    @datasets = Dataset.list(current_account.id)

    render 'notebooks/show'
  end

  get :new do
    render 'notebooks/new'
  end

  post :create do |screen_name|
    params[:notebook][:account_id] = current_account.id
    @notebook = Notebook.new(params[:notebook])

    if @notebook.save
      message = "#{@notebook.name}を作成しました"
      flash[:success] = message
      redirect url(:accounts, :index, screen_name: screen_name)
    else
      flash[:error] = set_form_errors(@notebook)
      render 'notebooks/new'
    end
  end
end
