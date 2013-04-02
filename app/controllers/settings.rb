Freesia::App.controllers :settings do
  get :index do
    @data_columns = DataColumn.list(current_account.id)

    render 'settings/index'
  end

  get :new do

  end
end
