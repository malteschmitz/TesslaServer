defmodule TesslaServer.Stream do
  @moduledoc """
  Represents a Stream, generated either from external Events or by computation through
  a `Node`
  Note that `progressed_to` can be bigger than the `timestamp` of the latest `Event`:
  If all Inputs of the `Node` generating this `Stream` have advanced to at least `t` but
  no new Event is generated (e.g. because the `Node` is a delay with a higher value)
  the `Stream` will be progressed to `t` but no Event with a timestamp `t` is present.
  """
  use Timex
  alias TesslaServer.Event

  @type t :: %__MODULE__{progressed_to: Timex.Types.timestamp, name: atom, events: [Event.t]}
  defstruct progressed_to: Time.zero, name: :none, events: []

  @doc """
  Progresses the `Stream` to the given `timestamp`.

      iex> timestamp = {1234, 123456, 123456}
      iex> stream = %Stream{}
      iex> Stream.progress(stream, timestamp)
      {:ok, %Stream{progressed_to: {1234, 123456, 123456}}}

  The `timestamp` has to be bigger than the `stream`s `progressed_to`
  or else an error will be returned.

      iex> timestamp = {1, 0, 0}
      iex> stream = %Stream{progressed_to: {2, 0, 0}}
      iex> Stream.progress(stream, timestamp)
      {:error, "Timestamp smaller than progress of Stream"}
  """
  @spec progress(Stream.t, Timex.Types.timestamp) :: {:ok, Stream.t} | {:error, String.t}
  def progress(%{progressed_to: progressed_to}, timestamp)
  when progressed_to > timestamp, do: {:error, "Timestamp smaller than progress of Stream"}
  def progress(stream, timestamp) when is_tuple(timestamp) do
    {:ok, %{stream | progressed_to: timestamp}}
  end

  @doc """
  Adds the `Event` to the `Stream`.

      iex> event = %Event{stream_name: :test, timestamp: {1000, 123456, 123456}, value: 1}
      iex> stream = %Stream{name: :test}
      iex> {:ok, updated_stream} = Stream.add_event(stream, event)
      iex> hd(updated_stream.events)
      %TesslaServer.Event{stream_name: :test, timestamp: {1000, 123456, 123456}, value: 1}

  If the stream is nil it will create a new `Stream` with the name of the `event` and
  `progressed_to` equal to the `timestamp` of the `event`

      iex> event = %Event{stream_name: :test, timestamp: {1000, 123456, 123456}, value: 1}
      iex> stream = nil
      iex> {:ok, updated_stream} = Stream.add_event(stream, event)
      iex> updated_stream
      %TesslaServer.Stream{
        events: [%TesslaServer.Event{stream_name: :test, timestamp: {1000, 123456, 123456}, value: 1}],
        name: :test,
        progressed_to: {1000, 123456, 123456}
      }

  The `timestamp` of the `Event` has to be greater or equal to the `progressed_to` value
  of the `Stream` and it's `stream_name` the same as the `name` of the stream or else an
  error will be returned.

      iex> event = %Event{stream_name: :wrong_name, timestamp: {1000, 123456, 123456}, value: 1}
      iex> stream = %Stream{name: :test}
      iex> {:error, reason} = Stream.add_event(stream, event)
      iex> reason
      "Event has different stream_name than stream"

      iex> event = %Event{stream_name: :wrong_name, timestamp: {1000, 123456, 123456}, value: 1}
      iex> stream = %Stream{name: :test}
      iex> {:error, reason} = Stream.add_event(stream, event)
      iex> reason
      "Event has different stream_name than stream"


  This method will advance the `progressed_to` field to the `timestamp` of the `Event`.
  """
  @spec add_event(nil | Stream.t, Event.t) ::  {:ok, Stream.t} | {:error, String.t}
  def add_event(nil, event) do
    {:ok, %__MODULE__{name: event.stream_name, progressed_to: event.timestamp, events: [event]}}
  end
  def add_event(%{name: name}, %{stream_name: stream_name})
  when name != stream_name, do: {:error, "Event has different stream_name than stream"}
  def add_event(%{progressed_to: progressed_to}, %{timestamp: timestamp})
  when progressed_to > timestamp, do: {:error, "Event's timestamp smaller than stream progress"}
  def add_event(stream, event) do
    {:ok, %{stream | events: [event | stream.events], progressed_to: event.timestamp}}
  end
end
