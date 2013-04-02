# coding: utf-8

Freesia::App.controllers :notebook_journals, parent: :notebooks do
  before do
    @notebook = Notebook.get(params[:notebook_id])
    return error 404 if @notebook.nil?
    return error 403 unless @notebook.account_id == current_account.id
  end

  get :new , with: :dataset_id do |notebook_id, dataset_id|
    @dataset = Dataset.get(dataset_id)
    return error 404 if @dataset.nil?
    return error 403 unless @dataset.account_id == current_account.id

    render 'notebooks/journals/new'
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
