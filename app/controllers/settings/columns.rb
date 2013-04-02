# coding: utf-8

Freesia::App.controllers :setting_columns, map: '/settings/columns' do
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

  get :edit, with: :id do |id|
    @data_column = DataColumn.get(id)
    return error 404 if @data_column.nil?
    return error 403 unless @data_column.account_id == current_account.id

    render 'settings/columns/edit'
  end

  put :update, with: :id do |id|
    @data_column = DataColumn.get(id)
    return error 404 if @data_column.nil?
    return error 403 unless @data_column.account_id == current_account.id

    if @data_column.update(params[:data_column])
      message = "#{@data_column.name}:#{@data_column.type} を編集しました"
      flash[:success] = message
      redirect url(:settings, :index)
    else
      render 'settings/columns/new'
    end
  end

end
