defmodule Elixirbot.TemplateParser do
  @moduledoc """
  Module for parsing templates

  Only exposes one method, :exec, bound to template.eex
  """
  require EEx
  EEx.function_from_file(:def, :exec, "lib/templates/string_or_number.eex", [:result])
end
