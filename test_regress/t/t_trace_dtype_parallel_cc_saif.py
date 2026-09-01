#!/usr/bin/env python3
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# This file ONLY is placed under the Creative Commons Public Domain.
# SPDX-FileCopyrightText: 2026 Jonas Kaufmann
# SPDX-License-Identifier: CC0-1.0

import vltest_bootstrap

test.scenarios('vltmt')
test.top_filename = 't/t_trace_dtype_parallel.v'

test.compile(verilator_flags2=['--cc', '--trace-saif', '--trace-structs'])

# The packed struct must be traced using a dtype helper.  The preceding wide
# signal makes this helper belong to a nonzero parallel trace partition.
trace_cpp = test.obj_dir + '/' + test.vm_prefix + '__Trace__0.cpp'
test.file_grep(trace_cpp, r'^ *Vt_.*trace_chg_dtype.*payload')

test.execute()

test.passes()
