defmodule Elixirbot.Request do
  @moduledoc """
  Request module for building struct from urlencoded params
  """
  defstruct [:command, :text, :response_url, :trigger_id, :user_id, :team_id, :enterprise_id, :channel_id]

  def new do
    %__MODULE__{}
  end
end

