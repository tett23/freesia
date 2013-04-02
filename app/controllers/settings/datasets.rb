# coding: utf-8

Freesia::App.controllers :setting_datasets, map: '/settings/datasets' do
  get :new do
    @columns = DataColumn.list(current_account.id)

    render 'settings/datasets/new'
  end

  post :create do
    columns = params[:dataset][:columns]
    params[:dataset].delete(:columns.to_s)
    params[:dataset][:account_id] = current_account.id

    @dataset = Dataset.new(params[:dataset])

    if @dataset.save
      columns.each do |column_id, is_use|
        unless is_use.to_i.zero?
          DataColumnDataset.create(dataset_id: @dataset.id, column_id: column_id)
        end
      end

      message = "データセット「#{@dataset.name} 」を作成しました"
      flash[:success] = message
      redirect url(:settings, :index)
    else
      render 'settings/datasets/new'
    end
  end

  get :edit, with: :id do |id|
    @dataset = Dataset.get(id)
    return error 404 if @dataset.nil?
    return error 403 unless @dataset.account_id == current_account.id
    @columns = DataColumn.list(current_account.id)

    @use_columns = @dataset.columns.map do |column|
      column.id
    end

    render 'settings/datasets/edit'
  end

  put :update, with: :id do |id|
    columns = params[:dataset][:columns]
    params[:dataset].delete(:columns.to_s)
    params[:dataset][:account_id] = current_account.id

    @dataset = Dataset.get(id)
    return error 404 if @dataset.nil?
    return error 403 unless @dataset.account_id == current_account.id

    if @dataset.update(params[:dataset])
      DataColumnDataset.all(dataset_id: @dataset.id).destroy
      columns.each do |column_id, is_use|
        unless is_use.to_i.zero?
          DataColumnDataset.create(dataset_id: @dataset.id, column_id: column_id.to_i)
        end
      end

      message = "データセット「#{@dataset.name} 」を編集しました"
      flash[:success] = message
      redirect url(:settings, :index)
    else
      render 'settings/datasets/new'
    end
  end
end
