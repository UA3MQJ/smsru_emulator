defmodule SmsKVS do
  # модуль хранилище смс
  use GenServer
  require Logger

  def add_sms(sms),
    do: GenServer.call(__MODULE__, {:add_sms, sms})

  def get_sms_index(),
    do: GenServer.call(__MODULE__, :get_sms_index)

  def get_sms_list(to),
    do: GenServer.call(__MODULE__, {:get_sms_list, to})

  def start_link(),
    do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok) do
    Logger.info ">> SmsKVS init"
    {:ok, %{}}
  end

  def handle_call({:add_sms, sms}, _from, state),
    do: {:reply, :ok, Map.update(state, sms.to, [sms], &([sms] ++ &1))}
  
  def handle_call(:get_sms_index, _from, state),
    do: {:reply, Map.keys(state), state}
  
  def handle_call({:get_sms_list, to}, _from, state),
    do: {:reply, state[to], state}

end
