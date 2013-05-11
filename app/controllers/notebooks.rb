# coding: utf-8

Freesia::App.controllers :notebooks, map: '/:screen_name', priority: :low do
  before do
    @page_header = :notebooks
  end

  get :new, map: '/:screen_name/new' do |screen_name|
    @page_header = :accounts
    @account = Account.detail(screen_name)
    add_breadcrumbs(@account.name, url(:accounts, :index, screen_name: @account.screen_name))

    render 'notebooks/new'
  end

  post :create do |screen_name|
    params[:notebook][:account_id] = current_account.id
    @notebook = Notebook.new(params[:notebook])
    @page_header = :accounts
    @account = Account.detail(screen_name)
    add_breadcrumbs(@account.name, url(:accounts, :index, screen_name: @account.screen_name))

    if @notebook.save
      message = "#{@notebook.name}を作成しました"
      flash[:success] = message
      redirect url(:accounts, :index, screen_name: screen_name)
    else
      flash[:error] = set_form_errors(@notebook)
      render 'notebooks/new'
    end
  end

  get :show, map: '/:screen_name/:slug', priority: :low do |screen_name, slug|
    @notebook = Notebook.first(account_id: current_account.id, slug: slug)
    return error 404 if @notebook.nil?
    return error 403 unless @notebook.account_id == current_account.id
    @datasets = Dataset.list(current_account.id)
    add_breadcrumbs(@notebook.account.name, url(:accounts, :index, screen_name: @notebook.account.screen_name))
    add_breadcrumbs(@notebook.name, url(:notebooks, :show, screen_name: screen_name, slug: slug))

    render 'notebooks/show'
  end

  get :edit, map: '/:screen_name/:slug/edit' do |screen_name, slug|
    @notebook = Notebook.detail(current_account.id, slug)
    add_breadcrumbs(@notebook.account.name, url(:accounts, :index, screen_name: @notebook.account.screen_name))
    add_breadcrumbs(@notebook.name, url(:notebooks, :show, screen_name: @notebook.account.screen_name, slug: @notebook.slug))

    render 'notebooks/edit'
  end

  put :update, with: :slug do |screen_name, slug|
    @notebook = Notebook.detail(current_account.id, slug)
    add_breadcrumbs(@notebook.account.name, url(:accounts, :index, screen_name: @notebook.account.screen_name))
    add_breadcrumbs(@notebook.name, url(:notebooks, :show, screen_name: @notebook.account.screen_name, slug: @notebook.slug))

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
