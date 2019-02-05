defmodule SmsruEmulator.Router do

  import Plug.Conn
  use Plug.Router
  use Plug.Debugger

  plug Plug.Parsers, parsers: [:erlencoded, :multipart]
  plug :match
  plug :dispatch

  get "/favicon.ico" do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(404, "")
  end

  get "/" do
    li = SmsKVS.get_sms_index()
    |> Enum.map(fn(it) -> "<a href='#{it}'>" <> it <> "</a><br>" end)
    |> Enum.into("")

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "SMSru service emulator<br><br>Phone list:<br>" <> li)
  end

  get "/sms/send" do
    to   = String.trim(conn.params["to"])
    from = conn.params["from"]
    msg  = conn.params["msg"]
    dt   = DateTime.utc_now()
    IO.puts ">>> #{DateTime.to_iso8601(dt)} #{inspect to} #{inspect from} #{inspect msg}"
    SmsKVS.add_sms(%{dt: dt, to: to, from: from, msg: msg})
    
    resp = '''
    {
      "status": "OK",
      "status_code": 100,
      "sms": {
          "#{to}": {
              "status": "OK",
              "status_code": 100,
              "sms_id": "000000-10000000"
          }
      } ,
      "balance": 1000000.00
    }
    '''
    send_resp(conn, 200, to_string(resp))
  end

  get "/:num" do
    li = SmsKVS.get_sms_list(num)
    |> Enum.map(fn(it) -> 
                  "#{DateTime.to_iso8601(it.dt)} #{inspect it.to} #{inspect it.from} #{inspect it.msg}<br>"
                end)
    |> Enum.into("")

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "SMS list for #{num}:<br><a href='/'>back</a><br><br>#{li}</br><a href='/'>back</a>")
  end
end
