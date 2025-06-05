
module tb_sequence_detector;

    reg clk, reset, x;
    wire y;

    sequence_detector uut (
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y)
    );

    // Clock generator
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    initial begin
        $dumpfile("sequence.vcd");
        $dumpvars(0, tb_sequence_detector);

        // Reset
        reset = 1; x = 0; #10;
        reset = 0;

        // Sequence: 1 0 1 1 → detects 1011
        x = 1; #10;
        x = 0; #10;
        x = 1; #10;
        x = 1; #10;

        $finish;
    end

endmodule
