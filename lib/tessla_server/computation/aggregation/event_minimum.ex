defmodule TesslaServer.Computation.Aggregation.EventMinimum do
  @moduledoc """
  Implements a `Computation` that emits the minimum value ever occured on an Event Stream
  or a default value if it's smaller than all values occured to that point.

  To do so the `state.operands` list has to be initialized with one integer representing the id of
  the stream that should be aggregated over and the `options` map has to have a key `default`
  which should hold the default value.
  """

  alias TesslaServer.{GenComputation, Event, Registry}
  alias TesslaServer.Computation.State

  use GenComputation

  def init(state) do
    Registry.subscribe_to :source
    super state
  end

  def handle_cast(:start_evaluation, state) do
    first_event = %Event{
      stream_id: state.stream_id, value: state.cache[:minimum], type: output_event_type
    }

    Enum.each state.children, fn child ->
      GenComputation.send_event child, first_event
    end
    {:noreply, state}
  end

  def process_event_map(event_map, timestamp, state) do
    new_event = event_map[hd(state.operands)]

    case new_event.type do
      :event ->
        old_min = Map.get state.cache, :minimum
        new_min = Enum.min [new_event.value, old_min]

        if new_min < old_min do
          {:ok, %Event{
            stream_id: state.stream_id, timestamp: timestamp, value: new_min, type: output_event_type
          }, %{minimum: new_min}}
        else
          {:progress, state.cache}
        end
      :progress -> {:progress, state.cache}
    end
  end

  def init_cache(state) do
    %{minimum: state.options[:default]}
  end

  def output_event_type, do: :change
end