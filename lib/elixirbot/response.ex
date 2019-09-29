defmodule Elixirbot.Response do
  @moduledoc """
  Reponse pattern for slack
  """
  defstruct [
    :response_type,
    :text,
    :attachments
  ]

  def new(msg), do: %__MODULE__{response_type: "ephemeral", text: msg}

end
