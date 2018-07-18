defmodule Dashboard.Auth.ErrorHandler do
  import Plug.Conn
  use DashboardWeb, :controller

  def auth_error(conn, {type, reason}, _opts) do
    body = to_string(reason)
    conn
    |> redirect(to: "/")
  end
end