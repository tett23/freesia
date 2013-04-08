# coding: utf-8

Freesia::App.controllers :notebooks, map: '/:screen_name' do
  before do
    @page_header = :notebooks
  end

  get :show, map: '/:screen_name/:slug' do |screen_name, slug|
    @notebook = Notebook.first(account_id: current_account.id, slug: slug)
    return error 404 if @notebook.nil?
    return error 403 unless @notebook.account_id == current_account.id
    @datasets = Dataset.list(current_account.id)

    render 'notebooks/show'
  end

  get :new do
    @page_header = :accounts

    render 'notebooks/new'
  end

  post :create do |screen_name|
    params[:notebook][:account_id] = current_account.id
    @notebook = Notebook.new(params[:notebook])
    @page_header = :accounts

    if @notebook.save
      message = "#{@notebook.name}を作成しました"
      flash[:success] = message
      redirect url(:accounts, :index, screen_name: screen_name)
    else
      flash[:error] = set_form_errors(@notebook)
      render 'notebooks/new'
    end
  end

  get :edit, map: '/:screen_name/:slug/edit' do |screen_name, slug|
    @notebook = Notebook.detail(current_account.id, slug)

    render 'notebooks/edit'
  end

  put :update, with: :slug do |screen_name, slug|
    @notebook = Notebook.detail(current_account.id, slug)

    if @notebook.update(params[:notebook])
      message = "#{@notebook.name}を編集しました"
      flash[:success] = message
      redirect url(:notebooks, :show, screen_name: @notebook.account.screen_name, slug: @notebook.slug)
    else
      flash[:error] = set_form_errors(@notebook)
      render 'notebooks/edit'
    end
  end
end
