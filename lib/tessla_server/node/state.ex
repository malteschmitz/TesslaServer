defmodule TesslaServer.Node.State do
  @moduledoc """
  Struct to represent the state of a `Node`
  """
  alias TesslaServer.Node.History

  defstruct children: [], history: %History{}, stream_name: :none, options: %{}
  @type t :: %__MODULE__{stream_name: String.t, history: History.t, children: [String.t], options: %{}}
end
