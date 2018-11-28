define num_events: Signal<Int> := literal(10000)

define add_calls: Events<Unit> := function_calls("add")

define add_call_sum: Signal<Int> := eventCount(add_calls)

define a_0: Signal<Int> := signalAbs(add_call_sum)
define a_1: Signal<Int> := signalAbs(add_call_sum)
define t_0: Signal<Boolean> := eq(a_0, a_1)
define t_1: Signal<Boolean> := eq(a_0, a_1)
define z: Signal<Boolean> := eq(t_0, t_1)

define finished: Signal<Boolean> := and(z, eq(add_call_sum, num_events))
