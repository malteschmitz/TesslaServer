define num_events: Signal<Int> := literal(10000)

define add_calls: Events<Unit> := function_calls("add")

define add_call_sum: Signal<Int> := eventCount(add_calls)

define a_0: Signal<Int> := signalAbs(add_call_sum)
define a_1: Signal<Int> := signalAbs(add_call_sum)
define b_0: Signal<Int> := signalAbs(a_0)
define b_1: Signal<Int> := signalAbs(a_0)
define b_2: Signal<Int> := signalAbs(a_1)
define b_3: Signal<Int> := signalAbs(a_1)
define s_0: Signal<Boolean> := eq(b_0, b_1)
define s_1: Signal<Boolean> := eq(b_2, b_3)
define s_2: Signal<Boolean> := eq(b_0, b_1)
define s_3: Signal<Boolean> := eq(b_2, b_3)
define t_0: Signal<Boolean> := eq(s_0, s_1)
define t_1: Signal<Boolean> := eq(s_2, s_3)
define z: Signal<Boolean> := eq(t_0, t_1)

define finished: Signal<Boolean> := and(z, eq(add_call_sum, num_events))
