// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain.
// SPDX-FileCopyrightText: 2026 Jonas Kaufmann
// SPDX-License-Identifier: CC0-1.0

module t (
    input logic clk
);
  // This signal occupies enough trace codes to fill the first parallel trace
  // partition before the packed struct below is assigned a trace callback.
  logic [2047:0] padding;

  typedef struct packed {
    logic [63:0] high;
    logic [63:0] low;
  } payload_t;
  payload_t payload;

  int cycle = 0;

  always @(posedge clk) begin
    cycle <= cycle + 1;
    padding <= {padding[2046:0], cycle[0]};
    payload <= {64'(cycle), 64'(~cycle)};
    if (cycle == 4) begin
      $write("*-* All Finished *-*\n");
      $finish;
    end
  end
endmodule
