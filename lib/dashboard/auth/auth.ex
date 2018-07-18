defmodule Dashboard.Auth do

    import Ecto.Query
    alias Comeonin.Bcrypt
    alias Dashboard.Repo
    alias Dashboard.System.User

    def get_user!(id) do
        Repo.get!(Dashboard.System.User,id)
    end

    def authenticate_user(email, plain_text_password) do
        query = from u in User, where: u.email == ^email
        Repo.one(query)
        |> check_password(plain_text_password)
    end

    defp check_password(nil, _), do: {:error, "ERRO: Usuario invalido ou senha incorreta"}

    defp check_password(user, plain_text_password) do
        case Bcrypt.checkpw(plain_text_password, user.password) do
            true -> {:ok, user}
            false -> {:error, "ERRO: Usuario invalido ou senha incorreta"}
        end
    end
end