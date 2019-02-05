defmodule SmsruEmulator.Mixfile do
  use Mix.Project

  def project do
    [app: :smsru_emulator,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :plug, :cowboy],
     mod: {SmsruEmulator, []}]
  end

  defp deps do
    [
     {:plug_cowboy, "~>1.0"},
     {:cowboy, "~>1.0"},
    ]
  end
end
