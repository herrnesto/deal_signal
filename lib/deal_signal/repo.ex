defmodule DealSignal.Repo do
  use Ecto.Repo,
    otp_app: :deal_signal,
    adapter: Ecto.Adapters.Postgres
end
