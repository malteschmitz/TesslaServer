define num_events: Signal<Int> := literal(10000)

define add_calls: Events<Unit> := function_calls("add")

define add_call_sum: Signal<Int> := eventCount(add_calls)

define a_0: Signal<Int> := signalAbs(add_call_sum)
define a_1: Signal<Int> := signalAbs(add_call_sum)
define b_0: Signal<Int> := signalAbs(a_0)
define b_1: Signal<Int> := signalAbs(a_0)
define b_2: Signal<Int> := signalAbs(a_1)
define b_3: Signal<Int> := signalAbs(a_1)
define c_0: Signal<Int> := signalAbs(b_0)
define c_1: Signal<Int> := signalAbs(b_0)
define c_2: Signal<Int> := signalAbs(b_1)
define c_3: Signal<Int> := signalAbs(b_1)
define c_4: Signal<Int> := signalAbs(b_2)
define c_5: Signal<Int> := signalAbs(b_2)
define c_6: Signal<Int> := signalAbs(b_3)
define c_7: Signal<Int> := signalAbs(b_3)
define m_0: Signal<Int> := signalAbs(c_0)
define m_1: Signal<Int> := signalAbs(c_0)
define m_2: Signal<Int> := signalAbs(c_1)
define m_3: Signal<Int> := signalAbs(c_1)
define m_4: Signal<Int> := signalAbs(c_2)
define m_5: Signal<Int> := signalAbs(c_2)
define m_6: Signal<Int> := signalAbs(c_3)
define m_7: Signal<Int> := signalAbs(c_3)
define m_8: Signal<Int> := signalAbs(c_4)
define m_9: Signal<Int> := signalAbs(c_4)
define m_10: Signal<Int> := signalAbs(c_5)
define m_11: Signal<Int> := signalAbs(c_5)
define m_12: Signal<Int> := signalAbs(c_6)
define m_13: Signal<Int> := signalAbs(c_6)
define m_14: Signal<Int> := signalAbs(c_7)
define m_15: Signal<Int> := signalAbs(c_7)
define l_0: Signal<Int> := signalAbs(m_0)
define l_1: Signal<Int> := signalAbs(m_0)
define l_2: Signal<Int> := signalAbs(m_1)
define l_3: Signal<Int> := signalAbs(m_1)
define l_4: Signal<Int> := signalAbs(m_2)
define l_5: Signal<Int> := signalAbs(m_2)
define l_6: Signal<Int> := signalAbs(m_3)
define l_7: Signal<Int> := signalAbs(m_3)
define l_8: Signal<Int> := signalAbs(m_4)
define l_9: Signal<Int> := signalAbs(m_4)
define l_10: Signal<Int> := signalAbs(m_5)
define l_11: Signal<Int> := signalAbs(m_5)
define l_12: Signal<Int> := signalAbs(m_6)
define l_13: Signal<Int> := signalAbs(m_6)
define l_14: Signal<Int> := signalAbs(m_7)
define l_15: Signal<Int> := signalAbs(m_7)
define l_16: Signal<Int> := signalAbs(m_8)
define l_17: Signal<Int> := signalAbs(m_8)
define l_18: Signal<Int> := signalAbs(m_9)
define l_19: Signal<Int> := signalAbs(m_9)
define l_20: Signal<Int> := signalAbs(m_10)
define l_21: Signal<Int> := signalAbs(m_10)
define l_22: Signal<Int> := signalAbs(m_11)
define l_23: Signal<Int> := signalAbs(m_11)
define l_24: Signal<Int> := signalAbs(m_12)
define l_25: Signal<Int> := signalAbs(m_12)
define l_26: Signal<Int> := signalAbs(m_13)
define l_27: Signal<Int> := signalAbs(m_13)
define l_28: Signal<Int> := signalAbs(m_14)
define l_29: Signal<Int> := signalAbs(m_14)
define l_30: Signal<Int> := signalAbs(m_15)
define l_31: Signal<Int> := signalAbs(m_15)
define g_0: Signal<Boolean> := eq(l_0, l_1)
define g_1: Signal<Boolean> := eq(l_2, l_3)
define g_2: Signal<Boolean> := eq(l_4, l_5)
define g_3: Signal<Boolean> := eq(l_6, l_7)
define g_4: Signal<Boolean> := eq(l_8, l_9)
define g_5: Signal<Boolean> := eq(l_10, l_11)
define g_6: Signal<Boolean> := eq(l_12, l_13)
define g_7: Signal<Boolean> := eq(l_14, l_15)
define g_8: Signal<Boolean> := eq(l_16, l_17)
define g_9: Signal<Boolean> := eq(l_18, l_19)
define g_10: Signal<Boolean> := eq(l_20, l_21)
define g_11: Signal<Boolean> := eq(l_22, l_23)
define g_12: Signal<Boolean> := eq(l_24, l_25)
define g_13: Signal<Boolean> := eq(l_26, l_27)
define g_14: Signal<Boolean> := eq(l_28, l_29)
define g_15: Signal<Boolean> := eq(l_30, l_31)
define g_16: Signal<Boolean> := eq(l_0, l_1)
define g_17: Signal<Boolean> := eq(l_2, l_3)
define g_18: Signal<Boolean> := eq(l_4, l_5)
define g_19: Signal<Boolean> := eq(l_6, l_7)
define g_20: Signal<Boolean> := eq(l_8, l_9)
define g_21: Signal<Boolean> := eq(l_10, l_11)
define g_22: Signal<Boolean> := eq(l_12, l_13)
define g_23: Signal<Boolean> := eq(l_14, l_15)
define g_24: Signal<Boolean> := eq(l_16, l_17)
define g_25: Signal<Boolean> := eq(l_18, l_19)
define g_26: Signal<Boolean> := eq(l_20, l_21)
define g_27: Signal<Boolean> := eq(l_22, l_23)
define g_28: Signal<Boolean> := eq(l_24, l_25)
define g_29: Signal<Boolean> := eq(l_26, l_27)
define g_30: Signal<Boolean> := eq(l_28, l_29)
define g_31: Signal<Boolean> := eq(l_30, l_31)
define k_0: Signal<Boolean> := eq(g_0, g_1)
define k_1: Signal<Boolean> := eq(g_2, g_3)
define k_2: Signal<Boolean> := eq(g_4, g_5)
define k_3: Signal<Boolean> := eq(g_6, g_7)
define k_4: Signal<Boolean> := eq(g_8, g_9)
define k_5: Signal<Boolean> := eq(g_10, g_11)
define k_6: Signal<Boolean> := eq(g_12, g_13)
define k_7: Signal<Boolean> := eq(g_14, g_15)
define k_8: Signal<Boolean> := eq(g_16, g_17)
define k_9: Signal<Boolean> := eq(g_18, g_19)
define k_10: Signal<Boolean> := eq(g_20, g_21)
define k_11: Signal<Boolean> := eq(g_22, g_23)
define k_12: Signal<Boolean> := eq(g_24, g_25)
define k_13: Signal<Boolean> := eq(g_26, g_27)
define k_14: Signal<Boolean> := eq(g_28, g_29)
define k_15: Signal<Boolean> := eq(g_30, g_31)
define o_0: Signal<Boolean> := eq(k_0, k_1)
define o_1: Signal<Boolean> := eq(k_2, k_3)
define o_2: Signal<Boolean> := eq(k_4, k_5)
define o_3: Signal<Boolean> := eq(k_6, k_7)
define o_4: Signal<Boolean> := eq(k_8, k_9)
define o_5: Signal<Boolean> := eq(k_10, k_11)
define o_6: Signal<Boolean> := eq(k_12, k_13)
define o_7: Signal<Boolean> := eq(k_14, k_15)
define s_0: Signal<Boolean> := eq(o_0, o_1)
define s_1: Signal<Boolean> := eq(o_2, o_3)
define s_2: Signal<Boolean> := eq(o_4, o_5)
define s_3: Signal<Boolean> := eq(o_6, o_7)
define t_0: Signal<Boolean> := eq(s_0, s_1)
define t_1: Signal<Boolean> := eq(s_2, s_3)
define z: Signal<Boolean> := eq(t_0, t_1)

define finished: Signal<Boolean> := and(z, eq(add_call_sum, num_events))