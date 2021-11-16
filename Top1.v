`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Names: Ruben Fuentes (35%), Elizabeth Connacher (30%), Rahel Miz (35%)
// 
//////////////////////////////////////////////////////////////////////////////////


module Top1(Clk, Reset, out7, en_out);
    //Clock input and two digit display stuff
    input Clk;
    input Reset;
    wire ClkOut;
    output [6:0] out7; //seg a, b, ... g
    output [7:0] en_out;
    
    //TAS THESE ARE THE HI AND LO REGISTER OUTPUTS/READINGS
   
    //wire [31:0] Hi_DEC; //Value of Hi register in decode stage. Will be concatenated with Lo and form the HiLo input to the ALU
    //wire [31:0] Lo_DEC; //Value of lo register in decode stage. Will be concatenated with Hi and form the HiLo input to the ALU
    
    //The value written to the register (including pc4 when JAL) is
    // wire [31:0] LinkOut;
    
    //this is for testing on Vivado. if testing on board, comment it out
    //assign ClkOut = Clk;

    //Seven segment, uncomment these two lines when doing board
    ClkDiv ClkDiv_1(Clk, Reset, ClkOut);
    Two4DigitDisplay Display_1(Clk, LinkOut[15:0], PC4_WB[15:0], out7, en_out);

    
    //BEGIN STAGE 1
    //This is the Fetch stage.
    //Features instruction memory, PCCounter,
    //A pipeline between stages 1 and 2, and 
    //some wires
    
    //Instruction memory
    wire[31:0] PCInput; //Input to PC, this will come from stage 2 (result of muxes and all that
    wire[31:0] PC4_IF; //Will contain the value of PC + 4 Adder
    (* mark_debug = "true" *) wire[31:0] PCResult; //Output of PC, goes into Instruction Memory
    wire[31:0] Instruction_IF; //Instruction from first stage
    
    //ProgramCounter Instantiation
    //FIXME PC needs a write signal
    //Clkout is the clock used throughout the datapath
    ProgramCounter PCounter(.Address(PCInput), .PCWrite(PC_write), .PCResult(PCResult), .Reset(Rst), .Clk(ClkOut));
    //InstructionMemory
    InstructionMemory Instructions(PCResult, Instruction_IF);
    //PCAdder/ PC + 4
    PCAdder PC4Adder(.PCResult(PCResult), .PCAddResult(PC4_IF));
    
    //Instantiate Pipeline Register between IF and Decode stage
    //First create the wires going out of the pipeline into stage 2
    wire [31:0] Instruction_DEC, PC4_DEC; //Instruction and PC+4 used in DECODE stage
    
    //call the pipeline
    FEDEC_Reg IFDEC(.InstructionIn(Instruction_IF), .PC4In(PC4_IF),
                        .InstructionOut(Instruction_DEC), .PC4Out(PC4_DEC),
                        .Clk(ClkOut), .IFID_write(IFID_write), .IF_flush(IF_flush));
                        
                        
    //STAGE 2
    //Tips: Many of the values needed come from the instruction, represented as Instruction_DEC
    //Example: Rs is the same as Instruction_DEC[25:21] (I think, its around those values).
     
     //HDU 
     //HDU wire declarations
     wire stall_IDEX, stall_EXMEM, stall_MEMWB, IFID_write, PC_write, IF_flush;
     //re-declaring wires used in subsequent stages so vivado does not assume they're all 1-bit wires
     wire [4:0] RegDst_MEM; //this is Rd for R-type, Rt for I-type 
    
    //HazardDetectionUnit
    HazardDetection HazardDetectionUnit(
    .RegDst_EX(RegDst_EX), .RegDst_MEM(RegDst_MEM), .RegDst_WB(RegDst_WB), 
    .Rs_DEC(Instruction_DEC[25:21]), .Rt_DEC(Instruction_DEC[20:16]),
    .RegWrite_EX(RegWrite_EX), .RegWrite_MEM(RegWrite_MEM), .RegWrite_WB(RegWrite_WB),
    .BranchAND(branchANDOut), .Jump(Jump_DEC), .JumpRegister(JrSrc_DEC),
    .stall_IDEX(stall_IDEX), .stall_EXMEM(stall_EXMEM), .stall_MEMWB(stall_MEMWB), //outputs
    .IFID_write(IFID_write), .PC_write(PC_write), .IF_flush(IF_flush) 
    );
    
   
    
    //CALCULATE REG DST USING A MUX
    //This mux chooses between rt, rd, and 31 as the destination register RegDst
    //Its control signal is RegDst_DEC
    //NOTE: In stage 2, regDst stands for the control signal for the mux
    //In latter stages, it stands for the actual register we will write to (5 bits)
    
    //RegDst Mux. wires, this mux decides where the write is done to
    wire [4:0] RegDst_WB; //Used in stage 5
    wire [4:0] RegDstOut; //Input to pipeline register to be carried to future stages
    wire [1:0] RegDst_DEC; //Input control signal to the mux (Might be a good idea to change names)
    
    Mux5bits_3x1 RegDstMux(RegDst_DEC, Instruction_DEC[20:16], Instruction_DEC[15:11], 5'd31, 
                           RegDstOut);
    //Link Mux
    //This allows us to choose between writing the write back value from stage 5 or Pc + 4 from stage 5 (for JAL operations)
    
    wire [31:0] WriteData_WB; //Write data from stage 5
    wire[31:0] PC4_WB; //PC + 4 from wb stage
    wire Link_WB; //Link signal from stage 5, originally created by the controller on stage 2
    wire [31:0] LinkOut; //This is the output of the described mux. Its what gets written into the register
    Mux32bits_2x1 WriteDataMux(Link_WB, WriteData_WB, PC4_WB, LinkOut);
    
    //Ideally, we'd only write PC + 4 when JAL, which features Register 31 ($ra) in the reg dst mux
    
    //Call Register File
    wire RegWrite_WB; // RegWrite signal from write back stage, tells us whether we write or not
    wire [31:0] ReadData1_DEC, ReadData2_DEC; //These guys will hold the outputs of the register, readData1 = GPR[rs], readData2 = GPR[rt]
    RegisterFile Registers(Instruction_DEC[25:21], Instruction_DEC[20:16], RegDst_WB, LinkOut, RegWrite_WB, 
                          ClkOut, ReadData1_DEC, ReadData2_DEC); 
                          
    //HILO REGISTER STUFF
    wire[63:0] ALU64Result_WB; //ALU64 Result from stage 5
    wire HiSrc_WB; //determines the signal for a mux choosing between WriteBack and ALU64Result, from stages 5, to write to hi
    wire LoSrc_WB; //determines the signal for a mux choosing between WriteBack and ALU64Result, from stages 5, to write to lo
    wire HiWrite_WB; //Hi write control signal, much like regWrite
    wire LoWrite_WB;  //Lo write control signal, much like regWrite
    wire [31:0] HiIn; //Input to high, output of HiSrc Mux
    wire [31:0] LoIn; //Input to lo, output of LoSrc Mux 
    wire [31:0] Hi_DEC; //Value of Hi register in decode stage. Will be concatenated with Lo and form the HiLo input to the ALU
    wire [31:0] Lo_DEC; //Value of lo register in decode stage. Will be concatenated with Hi and form the HiLo input to the ALU
    
    //HiSrc
    Mux32bits_2x1 HiSrcMux(HiSrc_WB, WriteData_WB, ALU64Result_WB[63:32], HiIn);
    //LoSrc
    Mux32bits_2x1 LoSrcMux(LoSrc_WB, WriteData_WB, ALU64Result_WB[31:0], LoIn);
    //Instantiate HiLoRegister
    HiLoRegisters HiLoRegister(HiIn, LoIn, HiWrite_WB, LoWrite_WB, ClkOut, Hi_DEC, Lo_DEC);
    
    //IMMEDIATE
    //SignExtend Immediate, this is stored in Immediate_DEC (sign extended one)
    wire [31:0] Immediate_DEC;
    SignExtension SignExtender(Instruction_DEC[15:0], Immediate_DEC, ZeroExtend);
    //Jump Address Calculation, this works by shifting the immediate left twice, and later will get concatenated with top bits of PC + 4
    wire [27:0] shifted_Jump; //Used to calculate jump address, combined with PC4
    TwoShift28Bit JumpShift({2'b00, Instruction_DEC[25:0]}, shifted_Jump);
    
    //CONTROLLER Signal, most of these values are usd in later stages as control signals
    //1 bit signals
    wire Link_DEC, JrSrc_DEC, 
         Jump_DEC, branch_DEC, MemRead_DEC, 
         MemToReg_DEC, MemWrite_DEC, ALUSrc1_DEC, 
         ALUSrc2_DEC, RegWrite_DEC,	
         HiWrite_DEC, LoWrite_DEC, HiSrc_DEC,
         LoSrc_DEC,	ZeroSrc_DEC, Move_DEC,	
         MoveSrc_DEC;
     //Two bit signals
     wire[1:0] bytes2Load_DEC, bytes2Store_DEC;
     
     //NEW Control signals for comparator
     wire CmpSrcCtrl; //Control signal for choosing between GPR[rt] and 0 for comparisons
     wire [1:0] CmpResCtrl; //Chooses between the three comparator results (less than, equal, greater than
     wire ZeroExtend;
     
     //INSTANTIATE CONTROLLER
                                //OPCODE                    //FUNC                  
    Controller ControllerModule(Instruction_DEC[31:26], Instruction_DEC[5:0], Instruction_DEC[16],
                        RegDst_DEC,	Link_DEC, JrSrc_DEC, 
                        Jump_DEC, branch_DEC, MemRead_DEC, 
                        MemToReg_DEC, MemWrite_DEC, ALUSrc1_DEC, 
                        ALUSrc2_DEC, RegWrite_DEC,	
                        HiWrite_DEC, LoWrite_DEC, HiSrc_DEC,
                        LoSrc_DEC,	ZeroSrc_DEC, Move_DEC,	
                        MoveSrc_DEC, bytes2Load_DEC, bytes2Store_DEC,
                        Instruction_DEC[9],
                        CmpSrcCtrl, CmpResCtrl,
                        ZeroExtend);
    //ALU Control
    wire [4:0] ALUOp_DEC; //ALU Op in decode stage
    ALUControl ALUController(Instruction_DEC[31:26], Instruction_DEC[5:0], 
                            Instruction_DEC[21],Instruction_DEC[6], Instruction_DEC[16], ALUOp_DEC,
                            Instruction_DEC[9]
                            );
    
    //BRANCH AND JUMP MUXES
    //Comparator Mux, to choose between GPR[rt] and 0 since we always compare GPR[rs] with one of those two. 0 maps to an input signal of 0 and rt to a signal of 1
    //the output of this mux is the second input to the comparator
    wire [31:0] CmpInput2; //Output of mux, comparator input 2
    Mux32bits_2x1 CompSrcMux(CmpSrcCtrl, 32'b0, ReadData2_DEC, CmpInput2);
    
    //Instantiate Comparator, has a Rs is less than, rs is equal to, and rs is greater than (by rs I mean GPR[rs])
    wire RSlt, RSeq, RSgt; //Rs less than, equal or grater than input 2
    Comparator32Bit BranchComparator(ReadData1_DEC, CmpInput2, RSlt, RSeq, RSgt);
    
    //Choose which result we want from the comparator using a mux. This depends on the instruction, sometimes we test for equality, others for less than, etc
    //0 For less than, 1 for equal, 2 for greater than
    wire BranchConditionResult;
    Mux1bit_3x1 ComparatorOutputSelect(CmpResCtrl, RSlt, RSeq, RSgt, BranchConditionResult);
    
    //the output of this mux holds the condition evualiation. Basically choosing between less tha, greater than or equal to
    
    //Now, to fully be able to every condition, we need some checks
    //For example, we dont have a way to test for greater than or equal to directly
    //But, what we can do is test for less than and, since its the reciprocal of greater than or equal to, we take
    //its inverted value, and that way with Rs less than we can also check rs greater than or equal to if we use its inverse
    
    //these values will be referred to as zero values
    
    //Branch instruction
    wire ZeroMuxOut; //Output of whether we want the normal result for the comparator or its inverse
    //Mux that chooses between normal comparison condition result and its inverse
    Mux1bit_2x1 ZeroMux(ZeroSrc_DEC, BranchConditionResult, ~BranchConditionResult, ZeroMuxOut);
    
    //AND gate with Branch control signal and the output of the zero mux.
    wire branchANDOut; //Holds the output of the and gate. This will be the input control signal for the mux choosing whether we branch
    //this last wire holds the result to whether we branch
    
    //AND gate
    AND1bit branchAnd(ZeroMuxOut, branch_DEC, branchANDOut);
    
    //Set up branch address
    //Shift Immediate by two
    wire [31:0] ShiftedImmediate;
    TwoShift32Bit ImmediateShift(Immediate_DEC, ShiftedImmediate); 
    //ADD wth PC + 4 to get the new instruction address, or PC value
    wire [31:0] branchAddress;
    ALU32Bit BranchADD(5'd2, PC4_DEC, ShiftedImmediate, 64'b0, branchAddress, dummy, dummy2); //An ALU mapped to add only
    
    //Now we have a mux that chooses between the regular PC + 4 or the branch address. The control signal for this mux
    //Is the output of the branch AND gate, as discussed previously
    wire [31:0] branchOutput;
    Mux32bits_2x1 BranchMux(branchANDOut, PC4_IF, branchAddress, branchOutput);
    
    //Now we need to check whether we will be jumping, using a mux and the jump address mentioned before
    //The address is PC + 4 [31:28] concatenated with shifted jump from before
    //its the difference betwee a branch address and a jump address, the branch address is PC + 4 plus an offset, while jump
    //Just jumps to the indicated adress
    wire [31:0] JumpOutput;
    Mux32bits_2x1 JumpMux(Jump_DEC, branchOutput, {PC4_DEC[31:28], shifted_Jump}, JumpOutput); //{PC4_DEC[31:28], shifted_Jump} Is the jump address, calculated by concatenating the top bits of PC4 and shifted jump
    Mux32bits_2x1 JrMux(JrSrc_DEC, JumpOutput, ReadData1_DEC, PCInput); //Connect back to our PC
    //End branch calculation
    
   
    
    //DECODE-EXECUTE PIPELINE
    //Stage 3 wires, will be used on stage 3
    wire [31:0] Shamt_EX, ReadData1_EX, ReadData2_EX, JAddress_EX, Immediate_EX;
    wire [63:0] HiLo_EX;
    wire ALUSrc1_EX, ALUSrc2_EX,MoveSrc_EX,ZeroSrc_EX,JrSrc_EX,
    Move_EX,Branch_EX;
    wire [4:0] ALUOp_EX;
    //Stage 3 + 5
    wire [31:0] PC4_EX;
    wire RegWrite_EX; //This wire comes out of the stage 2-3 pipeline, and goes through some additional logic to turn into TrueRegWrite for the rest of stage 3. See move instructions
    //STAGE 4
    wire[1:0] bytes2Load_EX, bytes2Store_EX;
    wire MemRead_EX, MemWrite_EX;
    //STAGE 5
    wire MemToReg_EX, HiSrc_EX,LoSrc_EX,Link_EX;
    wire[4:0] RegDst_EX;
    wire Jump_EX;
    wire HiWrite_EX, LoWrite_EX;
    
    
    DECEX_Reg DECEX(
    //Stage 3 Requirements (not used in subsequent stages)
    {27'b0, Instruction_DEC[10:6]},ReadData1_DEC,ReadData2_DEC,Immediate_DEC,{PC4_DEC[31:28], shifted_Jump},
    {Hi_DEC, Lo_DEC},
    ALUSrc1_DEC, ALUSrc2_DEC,MoveSrc_DEC,ZeroSrc_DEC,JrSrc_DEC,
    Move_DEC,branch_DEC,
    ALUOp_DEC, Jump_DEC,
    Shamt_EX,ReadData1_EX,ReadData2_EX,Immediate_EX,JAddress_EX,
    HiLo_EX,
    ALUSrc1_EX, ALUSrc2_EX,MoveSrc_EX,ZeroSrc_EX,JrSrc_EX,
    Move_EX,Branch_EX,
    ALUOp_EX,Jump_EX,
    //Stage 3 + 5
    PC4_DEC,
    PC4_EX,
    RegWrite_DEC,
    RegWrite_EX, 
    //Stage 4 Requirements (not used in subsequent stages)
    bytes2Load_DEC, bytes2Store_DEC,
    MemRead_DEC, MemWrite_DEC,
    bytes2Load_EX, bytes2Store_EX,
    MemRead_EX, MemWrite_EX,
    //Stage 5 Requirements that we need to carry through
    MemToReg_DEC,
    HiSrc_DEC,LoSrc_DEC,Link_DEC,RegDstOut,
    MemToReg_EX,
    HiSrc_EX,LoSrc_EX,Link_EX,RegDst_EX,
    HiWrite_DEC, LoWrite_DEC,
    HiWrite_EX, LoWrite_EX,
    //Clock
    ClkOut, stall_IDEX
    );
    
    //STAGE 3 BEGIN
    //ALU Preparation
    wire[31:0] ALUSrc1Output, ALUSrc2Output; //Mux outputs, choosing between either rs and shamt, or rt and immediate
    Mux32bits_2x1 ALUSrc1Mux(ALUSrc1_EX,ReadData1_EX,Shamt_EX,ALUSrc1Output);
    Mux32bits_2x1 ALUSrc2Mux(ALUSrc2_EX,ReadData2_EX,Immediate_EX,ALUSrc2Output);
    
    //ALU Time
    wire [31:0] ALUResult_EX; //Result from ALU
    wire [63:0] ALU64Result_EX; //64 bit output from ALU, used with HiLo things and multiply
    wire Zero;
    ALU32Bit THE_ALU(ALUOp_EX, ALUSrc1Output, ALUSrc2Output, HiLo_EX, ALUResult_EX, Zero, ALU64Result_EX);
    
    //Compute move condition
    //Check if GPR[rt] == 0
    wire XOROutput; //XOR is a quick way to check for equality
    ZeroXOR MoveCheck(ReadData2_EX, XOROutput);
    //Use mux to choose between whether we move on equality or on not equality, similar to the comparison trick on stage 2
    wire MoveMuxOutput;
    Mux1bit_2x1 MoveMux(MoveSrc_EX,XOROutput, ~XOROutput, MoveMuxOutput);
    //ANDgate for move, like with stage 2 comparator/branch
    wire moveANDOutput; //output of the and gate between move control signal and result of the previous mux
    AND1bit moveCheck(Move_EX, MoveMuxOutput, moveANDOutput);
    //Or gate to determine the final REGWRITE value
    wire trueRegWrite; //This will hold the calculated RegWrite value in stage 3, renamed to RegWrite_(Stage) on future stages
    OR1bit WriteOR(moveANDOutput, RegWrite_EX, trueRegWrite); //This is what goes into further stages, called regWrite on stages 4 and 5
    
    //STAGE 4 PIPELINE
    //Prepare values that go into and out of the pipeline
    //Stage 4
    wire [1:0] bytes2Load_MEM, bytes2Store_MEM;
    wire MemRead_MEM, MemWrite_MEM;
    //Stage 4 + 5
    wire [31:0] ALUResult_MEM;
    wire [4:0] RegDst_MEM;
    wire MemToReg_MEM, RegWrite_MEM, HiSrc_MEM, LoSrc_MEM, Link_MEM;
    wire [31:0] PC4_MEM;
    wire [63:0] ALU64Result_MEM;
    wire [31:0] ReadData2_MEM;
    wire HiWrite_MEM, LoWrite_MEM;
    
    EXMEM_Reg EXMEM(
    //Stage 4 Requirements (not used in subsequent stages)
    bytes2Load_EX, bytes2Store_EX,
    MemRead_EX, MemWrite_EX,
    bytes2Load_MEM, bytes2Store_MEM,
    MemRead_MEM, MemWrite_MEM,
    ReadData2_EX, ReadData2_MEM,
    //Stage 4 + 5 (used in both)
    ALUResult_EX,
    ALUResult_MEM,
    //Stage 5 Requirements that we need to carry through
    MemToReg_EX, trueRegWrite,
    ALU64Result_EX,HiSrc_EX,LoSrc_EX,Link_EX,RegDst_EX, PC4_EX,
    MemToReg_MEM, RegWrite_MEM,
    ALU64Result_MEM,HiSrc_MEM,LoSrc_MEM,Link_MEM,RegDst_MEM, PC4_MEM,
    HiWrite_EX, LoWrite_EX,
    HiWrite_MEM, LoWrite_MEM,
    //Clock
    ClkOut, stall_EXMEM
    );
    
    //BEGIN Stage 4
    
    wire [31:0] StoreMaskOutput; //Has the output of the store masking component
    wire [31:0] MemReadData; //Output of memory read, is an input to both storing and loading mask components
    wire [31:0] LoadData_MEM; //output of the load mask component, goes into stage 5 as value retrieved when using lw, lh, lb
    
    DataMemory MemoryUnit(ALUResult_MEM, StoreMaskOutput, ClkOut, MemWrite_MEM, MemRead_MEM, MemReadData);
    MaskStore StoreLogic(ALUResult_MEM[1:0], MemReadData, ReadData2_MEM , bytes2Store_MEM[1:0], StoreMaskOutput);
    MaskLoad LoadLogic(ALUResult_MEM[1:0], MemReadData, bytes2Load_MEM[1:0], LoadData_MEM);
    
    //PIPELINE Stage 4-5
    wire [31:0] ALUResult_WB, LoadData_WB;
    wire MemToReg_WB;
    
    //Declare the pipeline with its values
    MEMWB_Reg MEMWB(
    MemToReg_MEM, LoadData_MEM, ALUResult_MEM, RegWrite_MEM,
    ALU64Result_MEM,HiSrc_MEM,LoSrc_MEM,Link_MEM,RegDst_MEM, PC4_MEM,
    MemToReg_WB, LoadData_WB, ALUResult_WB, RegWrite_WB,
    ALU64Result_WB,HiSrc_WB,LoSrc_WB,Link_WB,RegDst_WB, PC4_WB,
    HiWrite_MEM, LoWrite_MEM,
    HiWrite_WB, LoWrite_WB,
    //ClocK
    ClkOut, stall_MEMWB //MEMWB_stall is an input, but its at the end due to 369 being CRAY 
    );
    
    Mux32bits_2x1 WriteMux(MemToReg_WB, ALUResult_WB, LoadData_WB, WriteData_WB); //Mux xhoosing between Writedata and LoadData 
    
    
endmodule