# coding: utf-8

Freesia::App.controllers :accounts, map: '/' do
  get :index, with: :screen_name do |screen_name|
    @account = Account.first(screen_name: screen_name.to_sym)

    render 'accounts/index'
  end
end
