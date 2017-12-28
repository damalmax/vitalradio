defmodule SkypeListener.Mixfile do
  use Mix.Project

  def project do
    [
      app: :skype_listener,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      rustler_crates: rustler_crates(), # Define Rust crates
      compilers: [:rustler] ++ Mix.compilers  # Add compiler for the native Rust code
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end


  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      # dependency for https://docs.rs/rustler/
      {:rustler, "~> 0.10.1"}
    ]
  end

  defp rustler_crates do
    [
      crypter: [
        path: "native/crypter",
        mode: (if Mix.env == :prod, do: :release, else: :debug),
      ]
    ]
  end
end