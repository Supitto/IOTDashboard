defmodule Dashboard.Helper do

    alias Dashboard.Repo
    alias Dashboard.System.User

    
    def user_by_role(role) do
        # Imports only from/2 of Ecto.Query
        import Ecto.Query, only: [from: 2]

        # Create a query
        query = from u in "usuarios",
        where: u.role == ^role,
        select: u.email

        # Send the query to the repository
        Repo.all(query)
    end

end