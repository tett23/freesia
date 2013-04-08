# coding: utf-8

Freesia::App.controllers :accounts, map: '/' do
  before do
    @page_header = :accounts
  end

  get :index, with: :screen_name do |screen_name|
    @account = Account.first(screen_name: screen_name.to_sym)

    render 'accounts/index'
  end
end
