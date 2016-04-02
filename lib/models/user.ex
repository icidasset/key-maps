defmodule KeyMaps.Models.User do
  use Ecto.Schema

  alias KeyMaps.{Repo, Models}

  import Comeonin.Bcrypt
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :maps, Models.Map

    timestamps
  end


  def changeset(user, params \\ :empty) do
    user
    |> cast(params, ~w(email password_hash)a)
    |> validate_required(~w(email password_hash)a)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> unique_constraint(:email)
  end


  #
  # Queries
  #
  def get_by_email(email), do: Repo.get_by(Models.User, email: email)
  def create(attr), do: Repo.insert format(attr)


  #
  # Private
  #
  defp format(attr) do
    changeset(
      %Models.User{},
      %{
        email: attr.email,
        password: attr.password,
        password_hash: hashpwsalt(attr.password)
      }
    )
  end

end
