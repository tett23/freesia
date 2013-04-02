# coding: utf-8

Freesia::App.controllers :setting_columns, map: '/settings' do
  get :new do
    render 'settings/columns/new'
  end

  post :create do
    params[:data_column][:account_id] = current_account.id
    @data_column = DataColumn.new(params[:data_column])

    if @data_column.save
      message = "#{@data_column.name}:#{@data_column.type} を作成しました"
      flash[:success] = message
      redirect url(:settings, :index)
    else
      render 'settings/columns/new'
    end
  end
end
