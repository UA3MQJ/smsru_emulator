defmodule SmsruEmulator do
  use Application
  require Logger

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # запускаем только cowboy'ский веб сервер, чтобы проверять работоспособность
    port = Application.get_env(:smsru_emulator, :cowboy_port, 8080)
    Logger.info ">>>> cowboy_port=#{inspect port}"

    children = [
      worker(SmsKVS, []),
      Plug.Adapters.Cowboy.child_spec(:http, SmsruEmulator.Router, [], port: port)
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
