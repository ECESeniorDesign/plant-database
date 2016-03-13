defmodule Backend.Session do
  alias Backend.User
  alias Backend.Repo

  def login(params, repo) do
    user = repo.get_by(User, username: String.downcase(params["username"]))
    case authenticate(user, params["password"]) do
      true  -> {:ok, user}
      _     -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end

  def logged_in?(conn) do
    !!current_user(conn)
  end

  def admin?(conn) do
    logged_in?(conn) and current_user(conn).admin
  end

end
