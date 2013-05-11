# coding: utf-8

Freesia::App.controllers :settings do
  get :index, map: '/settings', priority: :high do
    @data_columns = DataColumn.list(current_account.id)
    @datasets = Dataset.list(current_account.id)
    add_breadcrumbs('設定', url(:settings, :index))

    render 'settings/index'
  end
end
