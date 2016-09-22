defmodule TesslaServer.Computation.Timing.DelaySignalByTime do
  @moduledoc """
  Implements a `Computation` that delays the values of a signal Stream by the amount specified in
  `options` under the key `amount` in microseconds.
  Only tested for positive values of amount.
  The output signal will hold the value specified under the key `default` in `state.options` as long as the first value
  is delayed.
  """

  alias TesslaServer.{GenComputation, Event}
  alias TesslaServer.Computation.State

  use GenComputation
  use Timex

  # def init(state) do
  #   options = Map.put(state.options, :buffer, [])
  #   super %{state | options: options}
  # end

  # def process_events(timestamp, event_map, state) do
  #   new_event = event_map[hd(state.operands)]
  #   delay = Time.from(state.options[:amount], :microseconds)
  #   delayed_timestamp = Time.add(new_event.timestamp, delay)

  #   new_output = %Event{
  #     stream_id: state.stream_id, timestamp: delayed_timestamp, value: new_event.value
  #   }

  #   buffered = [new_output | state.options[:buffer]]
  #   {later, now} = events_to_add(buffered, timestamp)

  #   updated_history = update_output(now, state.history)
  #   {:ok, updated_history} = History.progress_output(updated_history, timestamp)

  #   options = %{state.options | buffer: later}
  #   %{state | history: updated_history, options: options}
  # end

  # def init_output(state) do
  #   default_value = state.options[:default]
  #   default_event = %Event{stream_id: state.stream_id, value: default_value}
  #   {:ok, stream} = EventStream.add_event(state.history.output, default_event)
  #   %{stream | type: output_stream_type}
  # end

  # def output_stream_type, do: :signal

  # defp events_to_add(events, upto) do
  #   events
  #   |> Enum.split_while(&(&1.timestamp > upto))
  # end

  # defp update_output(events, history) do
  #   events
  #   |> Enum.reverse
  #   |> Enum.reduce(history, fn event, acc ->
  #     {:ok, new_acc} = History.update_output(acc, event)
  #     new_acc
  #   end)
  # end
end