module sequence_detector (
    input clk,
    input reset,
    input x,
    output reg y
);

    // FSM State Encoding
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] state, next_state;

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (x == 1'b1) ? S1 : S0;
            S1: next_state = (x == 1'b0) ? S2 : S1;
            S2: next_state = (x == 1'b1) ? S3 : S0;
            S3: next_state = (x == 1'b1) ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    // Output logic (Moore FSM)
    always @(*) begin
        if (state == S3 && x == 1)
            y = 1;
        else
            y = 0;
    end

endmodule
