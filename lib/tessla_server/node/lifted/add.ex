defmodule TesslaServer.Node.Lifted.Add do
  @moduledoc """
  Implements a `Node` that adds two event streams

  To do so the `state.options` object has to be initialized with the keys `:operand1`
  and `:operand2`, which must be atoms representing the names of the event streams 
  that should be summed.
  """

  alias TesslaServer.{Node, Event}
  alias TesslaServer.Node.{History, State}

  use Node

  def prepare_values(state) do
    {:ok, get_operands(state)}
  end

  def process_values(state, events) when length(events) < 2, do: {:ok, :wait}
  def process_values(state, events) do
    [op1 | [op2]] = events
    value = op1.value + op2.value
    latest_event = Enum.max_by(events, &(&1.timestamp))
    processed_event = %{latest_event | value: value, stream_name: state.stream_name}
    {:ok, processed_event}
  end


  @spec get_operands(State.t) :: [Event.t]
  defp get_operands(state) do
    [History.get_latest_input_of_stream(state.history, state.options.operand1),
     History.get_latest_input_of_stream(state.history, state.options.operand2)]
    |> Enum.filter(&(!is_nil(&1)))
  end
end