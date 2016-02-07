defmodule Backend.Authenticator do

  def authenticate_token(token) do
    case Phoenix.Token.verify(Backend.Endpoint, "user", token, max_age: 86400) do
      {:ok, user_id} ->
        user_id
      {:error, _} ->
        :invalid
    end
  end

  def authenticate_user(username, password) do
    user = get_user(username)
    cond do
      user == nil ->
        :invalid
      Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        user.id
      true ->
        :invalid
    end
  end

  defp get_user(nil) do
    nil
  end

  defp get_user(username) do
    Backend.Repo.get_by(Backend.User, username: username)
  end

end