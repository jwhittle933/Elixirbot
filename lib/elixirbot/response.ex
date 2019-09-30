defmodule Elixirbot.Response do
  @moduledoc """
  Reponse pattern for slack
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "response" do
    field :response_type
    field :text
    embeds_many :attachments, Attachment do
      field :text
    end
  end

  def new(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, [:response_type, :text])
    |> cast_embed(:attachments, with: &new_embed/2)
    |> apply_changes
  end

  defp new_embed(schema, params) do
    schema
    |> cast(params, [:text])
  end

  def evaluate(%__MODULE__{} = response, text) do
    %__MODULE__{response | text: text, response_type: "ephemeral"}
  end
end
