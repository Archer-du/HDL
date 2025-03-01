module CTRL(
    input [31:0]        inst,

    output reg          rf_re0,
    output reg          rf_re1,
    output reg          wb_en,
    output reg [1:0]    wb_sel,
    output reg          alu_op1_sel, alu_op2_sel,
    output reg [3:0]    alu_ctrl,
    output reg          jal, jalr,
    output reg [2:0]    br_type,
    //output [2:0] imm_type,
    output reg          mem_we
);
    //inst_type signals
    localparam R_type       = 7'b0110011;
    localparam I_type       = 7'b0010011;
        localparam ADD = 4'b0000;
        localparam SLL = 4'b1001;
        localparam SRL = 4'b1000;
        localparam SUB = 4'b0001;
        localparam OR  = 4'b0110;
        localparam AND = 4'b0101;
        localparam XOR = 4'b0111;
        localparam SLT = 4'b1010;
    localparam S_type       = 7'b0100011;
    localparam B_type       = 7'b1100011;
    localparam class_load   = 7'b0000011;
    localparam U_type_auipc = 7'b0010111;
    localparam U_type_lui   = 7'b0110111;
    localparam J_type       = 7'b1101111;
    localparam JALR         = 7'b1100111;

    //regfile write back signals
    localparam ALU_RES      = 2'b00;
    localparam PC_ADD4      = 2'b01;
    localparam MEM_RD       = 2'b10;
    localparam IMM          = 2'b11;

    //ALU MUXs signals
    localparam RS1          = 1'b0;
    localparam PC_CUR       = 1'b1;
    localparam RS2          = 1'b0;
    localparam IMMGEN       = 1'b1;

    //branch signals
    localparam NONE_BR      = 3'b000;
    localparam BEQ          = 3'b001;
    localparam BLT          = 3'b010;
    localparam BNE          = 3'b011;
    localparam BGE          = 3'b100;
    localparam BLTU         = 3'b101;

    always@(*) begin
        case(inst[6:0])
            R_type: begin
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = ALU_RES;
                alu_op1_sel = RS1;
                alu_op2_sel = RS2;
                mem_we      = 0;
                rf_re0      = 1;
                rf_re1      = 1;
                case(inst[14:12])
                    3'b000: begin
                        if(inst[30]) begin
                            alu_ctrl    = SUB;
                        end
                        else begin
                            alu_ctrl    = ADD;
                        end
                    end
                    3'b001: alu_ctrl    = SLL;
                    3'b101: alu_ctrl    = SRL;
                    3'b110: alu_ctrl    = OR;
                    3'b111: alu_ctrl    = AND;
                    3'b100: alu_ctrl    = XOR;
                    3'b010: alu_ctrl    = SLT;
                    default: alu_ctrl   = 4'b1111;
                endcase
            end
            I_type: begin
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = ALU_RES;
                alu_op1_sel = RS1;
                alu_op2_sel = IMMGEN;
                mem_we      = 0;
                rf_re0      = 1;
                rf_re1      = 0;
                case(inst[14:12])
                    3'b000: alu_ctrl    = ADD;
                    3'b001: alu_ctrl    = SLL;
                    3'b101: alu_ctrl    = SRL;
                    3'b110: alu_ctrl    = OR;
                    3'b111: alu_ctrl    = AND;
                    3'b100: alu_ctrl    = XOR;
                    3'b010: alu_ctrl    = SLT;
                    default: alu_ctrl   = 4'b1111;
                endcase
            end
            S_type: begin
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 0;
                wb_sel      = 2'b00;
                alu_op1_sel = RS1;
                alu_op2_sel = IMMGEN;
                alu_ctrl    = 4'b0000;
                mem_we      = 1;
                rf_re0      = 1;
                rf_re1      = 1;
            end
            B_type: begin
                jal         = 0;
                jalr        = 0;
                wb_en       = 0;
                wb_sel      = 2'b00;
                alu_op1_sel = PC_CUR;
                alu_op2_sel = IMMGEN;
                alu_ctrl    = 4'b0000;
                mem_we      = 0;
                rf_re0      = 1;
                rf_re1      = 1;
                case(inst[14:12])
                    3'b000: br_type     = BEQ;
                    3'b001: br_type     = BNE;
                    3'b100: br_type     = BLT;
                    3'b101: br_type     = BGE;
                    3'b110: br_type     = BLTU;
                    default: br_type    = NONE_BR;
                endcase
            end
            class_load: begin
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = MEM_RD;
                alu_op1_sel = RS1;
                alu_op2_sel = IMMGEN;
                alu_ctrl    = 4'b0000;
                mem_we      = 0;
                rf_re0      = 1;
                rf_re1      = 0;
            end
            U_type_auipc: begin
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = ALU_RES;
                alu_op1_sel = PC_CUR;
                alu_op2_sel = IMMGEN;
                alu_ctrl    = 4'b0000;
                mem_we      = 0;
                rf_re0      = 0;
                rf_re1      = 0;
            end
            U_type_lui: begin
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = IMM;
                alu_op1_sel = 1'b0;
                alu_op2_sel = 1'b0;
                alu_ctrl    = 4'b1111;
                mem_we      = 0;
                rf_re0      = 0;
                rf_re1      = 0;
            end
            J_type: begin
                jal         = 1;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = PC_ADD4;
                alu_op1_sel = PC_CUR;
                alu_op2_sel = IMMGEN;
                alu_ctrl    = 4'b0000;
                mem_we      = 0;
                rf_re0      = 0;
                rf_re1      = 0;
            end
            JALR: begin
                jal         = 0;
                jalr        = 1;
                br_type     = NONE_BR;
                wb_en       = 1;
                wb_sel      = PC_ADD4;
                alu_op1_sel = RS1;
                alu_op2_sel = IMMGEN;
                alu_ctrl    = 4'b0000;
                mem_we      = 0;
                rf_re0      = 1;
                rf_re1      = 0;
            end
            default: begin//nop
                jal         = 0;
                jalr        = 0;
                br_type     = NONE_BR;
                wb_en       = 0;
                wb_sel      = 2'b00;
                alu_op1_sel = RS1;
                alu_op2_sel = RS2;
                alu_ctrl    = 4'b1111;
                mem_we      = 0;
                rf_re0      = 0;
                rf_re1      = 0;
            end
        endcase
    end
endmodule