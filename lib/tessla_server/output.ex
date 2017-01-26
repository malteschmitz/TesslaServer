defmodule TesslaServer.Output do
  @moduledoc """
  Used to log outputs.
  Has to be initialized at startup to hold the ids and names of streams that should be logged.
  """

  require Logger

  alias TesslaServer.{GenComputation, Event}

  @spec start(%{GenComputation.id => String.t}) :: {:ok, pid}
  def start(map \\ %{}) do
    Agent.start(fn -> map end, name: __MODULE__)
  end

  @spec stop :: {:ok, pid}
  def stop do
    Agent.stop __MODULE__
  end

  @spec log_new_event(GenComputation.id, Event.t) :: :ok
  def log_new_event(id, event = %Event{type: :progress}) do
    Agent.cast __MODULE__, fn state ->
      name = Map.get(state, id)
      if name do
        Logger.warn("#{name} progressed to: #{inspect event.timestamp}")
      end
      state
    end
  end

  def log_new_event(id, event) do
    Agent.cast __MODULE__, fn state ->
      name = Map.get(state, id)
      if name do
        seconds = Timex.Duration.to_seconds(event.timestamp)
        IO.puts "#{name}@#{seconds}:#{event.value}"
      end
      state
    end
  end
end
