# iex
# c "log_level.ex"

defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 && legacy? == false -> :trace
      level == 1 && legacy? == true -> :debug
      level == 1 && legacy? == false -> :debug
      level == 2 && legacy? == true -> :info
      level == 2 && legacy? == false -> :info
      level == 3 && legacy? == true -> :warning
      level == 3 && legacy? == false -> :warning
      level == 4 && legacy? == true -> :error
      level == 4 && legacy? == false -> :error
      level == 5 && legacy? == false -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = LogLevel.to_label(level, legacy?)
    cond do
      label == :error -> :ops
      label == :fatal -> :ops
      label == :unknown && level > 5 && legacy? != true -> :dev2
      label == :unknown -> :dev1
      true -> :dev2
      false
    end
  end
end
