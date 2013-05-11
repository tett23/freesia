# coding: utf-8

Freesia::App.controllers :journals, map: '/:screen_name/:slug' do
  before do
    @notebook = Notebook.detail(params[:screen_name], params[:slug])
    return error 404 if @notebook.nil?
    return error 403 unless @notebook.account_id == current_account.id
  end

  get :new, map: '/:screen_name/:slug/:dataset_id/new'do |screen_name, slug, dataset_id|
    @dataset = Dataset.get(dataset_id)
    return error 404 if @dataset.nil?
    return error 403 unless @dataset.account_id == current_account.id

    render 'notebooks/journals/new'
  end

  get :show, map: '/:screen_name/:slug/:journal_id'do |screen_name, slug, journal_id|
    @journal = Journal.get(journal_id)
    return error 404 if @journal.nil?
    return error 403 unless @journal.account_id == current_account.id
    @datasets = Dataset.list(current_account.id)

    render 'notebooks/journals/show'
  end

  post :create, with: :dataset_id do |notebook_id, dataset_id|
    @dataset = Dataset.get(dataset_id)
    return error 404 if @dataset.nil?
    return error 403 unless @dataset.account_id == current_account.id

    journal = Journal.create(
      account_id: current_account.id,
    )
    @notebook.journals << journal
    @notebook.save()
    DatasetJournal.create(
      journal_id: journal.id,
      dataset_id: @dataset.id
    )

    params[:journal].each do |column_id, value|
      journal_datum = {
        value: value,
        journal_id: journal.id,
        dataset_id: @dataset.id,
        data_column_id: column_id
      }
      journal_datum = JournalDatum.create(journal_datum)
    end

    message = "#{@notebook.name}に#{@dataset.name}を追加しました"
    flash[:success] = message
    redirect url(:notebooks, :show, id: notebook_id)
  end
end
