defmodule TesslaServer.Computation.Aggregation.MrvTest do
  use ExUnit.Case, async: true
  use Timex

  alias TesslaServer.Computation.Aggregation.Mrv
  alias TesslaServer.{Event, GenComputation, Registry}

  import DateTime, only: [now: 0, shift: 2, to_timestamp: 1]
  import System, only: [unique_integer: 0]

  doctest Mrv

  @op1 unique_integer
  @default 1
  @test unique_integer
  @processor unique_integer

  setup do
    Registry.register @test
    Mrv.start @processor, [@op1], %{default: @default}
    :ok
  end

  test "Should change value of signal on every event with new value" do
    GenComputation.add_child(@processor, @test)
    assert_receive({_, {:update_input_stream, %{type: :signal, events: [out0]}}})
    assert(out0.value == @default)

    timestamp = DateTime.now
    event1 = %Event{value: 3, timestamp: to_timestamp(timestamp), stream_id: @op1}
    event2 = %Event{
      value: 3, timestamp: to_timestamp(shift(timestamp, seconds: 2)), stream_id: @op1
    }
    event3 = %Event{
      value: 5, timestamp: to_timestamp(shift(timestamp, seconds: 3)), stream_id: @op1
    }

    GenComputation.send_event(@processor, event1)

    assert_receive {_,
      {:update_input_stream, %{progressed_to: progressed_to, events: [out1, ^out0]}}
    }
    assert progressed_to == event1.timestamp
    assert out1.timestamp == event1.timestamp
    assert out1.value == event1.value

    GenComputation.send_event(@processor, event2)
    assert_receive {_,
      {:update_input_stream, %{progressed_to: progressed_to, events: [^out1, ^out0]}}
    }
    assert progressed_to == event2.timestamp

    GenComputation.send_event(@processor, event3)
    assert_receive({_, {:update_input_stream, %{events: [out2, ^out1, ^out0]}}})
    assert out2.value == event3.value
    assert out2.timestamp == event3.timestamp

    :ok = GenComputation.stop(@processor)
  end
end
