defmodule Crypter do
  use Rustler, otp_app: :skype_listener, crate: "crypter"

  # When NIF is loaded, Rustler will override this functions.
  def ms_sha256(_arg1, _arg2), do: exit(:nif_not_loaded)
end
