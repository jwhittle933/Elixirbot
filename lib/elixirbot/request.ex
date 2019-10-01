defmodule Elixirbot.Request do
  @moduledoc """
  Request module for building struct from urlencoded params
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "request" do
    field :token
    field :command
    field :text
    field :response_url
    field :user_id
    field :team_id
    field :channel_id
    field :channel_name
  end

  def new(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, [:token, :command, :text, :response_url, :user_id, :team_id, :channel_name, :channel_id])
    |> apply_changes
  end
end

