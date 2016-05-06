defmodule TesslaServer.Node.Aggregation.Minimum do
  @moduledoc """
  Implements a `Node` that emits the minimum value ever occured on an Event Stream
  or a default value if it's smaller than all values occured to that point.

  To do so the `state.operands` list has to be initialized with one integer representing the id of
  the stream that should be aggregated over and the `options` map has to have a key `default`
  which should hold the default value.
  """

  alias TesslaServer.{Node, Event, EventStream}
  alias TesslaServer.Node.{History, State}

  use Node
  use Timex

  def process_events(timestamp, event_map, state) do
    op1 = hd(state.operands)
    new_event = event_map[op1]
    current_event = EventStream.event_at(state.history.output, timestamp)
    if new_event.value < current_event.value do
      output_event = %Event{
        stream_id: state.stream_id, timestamp: new_event.timestamp, value: new_event.value
      }
      {:ok, updated_history} = History.update_output(state.history, output_event)
      %{state |
        history: updated_history
      }
    else
      {:ok, updated_history} = History.progress_output(state.history, timestamp)
      %{state | history: updated_history}
    end
  end

  def init_output(state) do
    default_value = state.options[:default]
    default_event = %Event{stream_id: state.stream_id, value: default_value}

    {:ok, history} = History.update_output(state.history, default_event)
    history.output
  end
end
