module vending_machine (
    input clk,
    input reset,
    input coin5,
    input coin10,
    input select_A,
    input select_B,

    output reg dispense_A,
    output reg dispense_B,
    output reg change_5,
    output reg change_10
);

    reg [4:0] amount;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            amount <= 0;
            dispense_A <= 0;
            dispense_B <= 0;
            change_5 <= 0;
            change_10 <= 0;
        end
        else begin
            // Default outputs
            dispense_A <= 0;
            dispense_B <= 0;
            change_5 <= 0;
            change_10 <= 0;

            // Accept coins
            if (coin5)
                amount <= amount + 5;

            else if (coin10)
                amount <= amount + 10;

            // Product A - ₹10
            if (select_A && (amount >= 10)) begin
                dispense_A <= 1;

                if (amount - 10 == 5)
                    change_5 <= 1;

                else if (amount - 10 >= 10)
                    change_10 <= 1;

                amount <= 0;
            end

            // Product B - ₹15
            else if (select_B && (amount >= 15)) begin
                dispense_B <= 1;

                if (amount - 15 == 5)
                    change_5 <= 1;

                else if (amount - 15 >= 10)
                    change_10 <= 1;

                amount <= 0;
            end
        end
    end

endmodule