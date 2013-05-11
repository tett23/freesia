# coding: utf-8

Freesia::App.controllers :accounts, map: '/' do
  before do
    @page_header = :accounts
  end

  get :index, map: '/:screen_name', priority: :low do |screen_name|
    pass if screen_name == 'settings'
    @account = Account.first(screen_name: screen_name.to_sym)
    add_breadcrumbs(@account.name, url(:accounts, :index, screen_name: @account.screen_name))

    render 'accounts/index'
  end
end
