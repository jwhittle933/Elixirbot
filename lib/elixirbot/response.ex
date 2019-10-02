defmodule Elixirbot.Response do
  @moduledoc """
  Reponse pattern for slack
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "response" do
    field :response_type
    field :text
    field :attachments
  end

  def new(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, [:response_type, :text, :attachments])
    |> apply_changes
  end
end
