defmodule Elixirbot.Request do
  @moduledoc """
  Request module for building struct from urlencoded params
  """
  defstruct [
    :token,
    :command,
    :text,
    :response_url,
    :user_id,
    :team_id,
    :channel_id,
    :channel_name
  ]

  def new(%{
        "token" => token,
        "team_id" => team_id,
        "channel_id" => channel_id,
        "channel_name" => channel_name,
        "command" => command,
        "text" => text,
        "response_url" => response_url,
        "user_id" => user_id
          }) do
    %__MODULE__{
      token: token,
      command: command,
      text: text,
      response_url: response_url,
      user_id: user_id,
      team_id: team_id,
      channel_id: channel_id,
      channel_name: channel_name,
    }
  end

end

