defmodule TesslaServer.Computation.Filter.Sample do
  @moduledoc """
  Implements a `Computation` that emits Events with the value of a Signal whenever an input Event is
  received.

  To do so the `state.operands` list has to be initialized with two integers, the first specifying
  the Signal which values should be taken and the second specifying the EventStream acting as the
  sampler.
  This is the same as `TesslaServer.Computation.Filter.IfThen` with swapped operands.
  """

  alias TesslaServer.{GenComputation, Event}
  alias TesslaServer.Computation.State

  use GenComputation

  # def perform_computation(timestamp, event_map, state) do
  #   [op1, op2] = state.operands
  #   sampler = event_map[op2]
  #   signal = event_map[op1]
  #   cond do
  #     !sampler ->
  #       :wait
  #     !signal ->
  #       :wait
  #     !(sampler.timestamp == timestamp) ->
  #       :wait
  #     true ->
  #       {:ok, %Event{
  #         stream_id: state.stream_id, timestamp: timestamp, value: signal.value
  #       }}
  #   end
  # end
end
