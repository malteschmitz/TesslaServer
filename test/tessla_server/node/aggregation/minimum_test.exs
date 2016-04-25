defmodule TesslaServer.Node.Aggregation.MinimumTest do
  use ExUnit.Case, async: true
  use Timex

  alias TesslaServer.Node.Aggregation.Minimum
  alias TesslaServer.{Event, Node}

  import TesslaServer.Registry
  import DateTime, only: [now: 0, shift: 2, to_timestamp: 1]

  doctest Minimum

  @default_value 5

  setup do
    :gproc.reg(gproc_tuple(:minimum_test))
    state = %{stream_name: :minimum, options: %{operand1: :number, default: @default_value}}
    {:ok, state: state}
  end

  test "Should take value of new event if it is smaller than previous maximum" , %{state: state} do
    processor = Minimum.start state
    name = :minimum_test
    Node.add_child(processor, name)
    assert_receive({_, {:process, event}})
    assert(event.value == @default_value)
    timestamp = DateTime.now
    event1 = %Event{timestamp: to_timestamp(timestamp), value: 4, stream_name: :number}
    event2 = %Event{timestamp: to_timestamp(shift(timestamp, seconds: 2)), value: 3, stream_name: :number}

    Node.send_event(processor, event1)

    assert_receive({_, {:process, event}})

    assert(event.value == event1.value)

    Node.send_event(processor, event2)

    assert_receive({_, {:process, event}})

    assert(event.value == event2.value)

    :ok = Node.stop(processor)
  end

  test "Should keep previous value if new value is bigger" , %{state: state} do
    processor = Minimum.start state
    name = :minimum_test
    Node.add_child(processor, name)
    assert_receive({_, {:process, event}})
    assert(event.value == @default_value)
    timestamp = DateTime.now
    event1 = %Event{timestamp: to_timestamp(timestamp), value: 4, stream_name: :number}
    event2 = %Event{timestamp: to_timestamp(shift(timestamp, seconds: 2)), value: 5, stream_name: :number}

    Node.send_event(processor, event1)

    assert_receive({_, {:process, event}})

    assert(event.value == event1.value)

    Node.send_event(processor, event2)

    refute_receive({_, {:process, event}})

    :ok = Node.stop(processor)
  end

  test "Should keep default value until smaller value occurs" , %{state: state} do
    processor = Minimum.start state
    name = :minimum_test
    Node.add_child(processor, name)
    assert_receive({_, {:process, event}})
    assert(event.value == @default_value)
    timestamp = DateTime.now
    event1 = %Event{timestamp: to_timestamp(timestamp), value: 6, stream_name: :number}
    event2 = %Event{timestamp: to_timestamp(shift(timestamp, seconds: 2)), value: 5, stream_name: :number}
    event3 = %Event{timestamp: to_timestamp(shift(timestamp, seconds: 3)), value: 3, stream_name: :number}

    Node.send_event(processor, event1)
    refute_receive({_, {:process, event}})

    Node.send_event(processor, event2)
    refute_receive({_, {:process, event}})

    Node.send_event(processor, event3)
    assert_receive({_, {:process, event}})
    assert(event.value == event3.value)

    :ok = Node.stop(processor)
  end
end