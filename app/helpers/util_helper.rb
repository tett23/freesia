# coding: utf-8

Freesia::App.helpers do
  # sinatraデフォルトのpassはインスタンス変数をそのままにし、beforeなどを2度実行するため、インスタンス変数削除を含むpassを再定義する
  def freesia_pass
    if instance_variable_defined?(:@instance_variables_snapshot)
      instance_variables.each do |var_name|
        remove_instance_variable(var_name) unless var_name == :@instance_variables_snapshot
      end

      @instance_variables_snapshot.each do |key, value|
        instance_variable_set(key, value)
      end

      remove_instance_variable(:@instance_variables_snapshot)
    end

    sinatra_pass
  end
  unless method_defined?(:sinatra_pass)
    alias_method :sinatra_pass, :pass
    alias_method :pass, :freesia_pass
  end

  # freesia_passのために変数を記録する
  def take_snapshot_instance_variables
    unless instance_variable_defined?(:@instance_variables_snapshot)
      @instance_variables_snapshot = instance_variables.inject({}) do |hash, var_name|
        hash[var_name] = instance_variable_get(var_name); hash
      end
    end
  end
end
