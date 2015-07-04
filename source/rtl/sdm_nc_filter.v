// -------------------------------------------------------------
//
// Module: sdm_nc_filter
// Generated by MATLAB(R) 8.1 and the Filter Design HDL Coder 2.9.3.
// Generated on: 2015-06-27 18:59:51
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// OptimizeForHDL: on
// ResetInputPort: rstn
// Name: sdm_nc_filter
// ResetAssertedLevel: Active-low
// TargetLanguage: Verilog
// TestBenchStimulus: step ramp chirp 
// UseVerilogTimescale: off

// Filter Specifications:
//
// Sampling Frequency : N/A (normalized frequency)
// Response           : Lowpass
// Specification      : Fp,Fst,Ap,Ast
// Passband Edge      : 0.046875
// Stopband Edge      : 0.52083
// Passband Ripple    : 1 dB
// Stopband Atten.    : 80 dB
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// Multipliers           : 6
// Folding Factor        : 1
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time IIR Filter (real)
// -------------------------------
// Filter Structure    : Direct-Form II, Second-Order Sections
// Number of Sections  : 2
// Stable              : Yes
// Linear Phase        : No
// Arithmetic          : fixed
// Numerator           : s8,5 -> [-4 4)
// Denominator         : s8,6 -> [-2 2)
// Scale Values        : s8,13 -> [-1.562500e-02 1.562500e-02)
// Input               : s26,0 -> [-33554432 33554432)
// Section Input       : s16,15 -> [-1 1)
// Section Output      : s16,10 -> [-32 32)
// Output              : s26,20 -> [-32 32)
// State               : s16,15 -> [-1 1)
// Numerator Prod      : s24,20 -> [-8 8)
// Denominator Prod    : s24,21 -> [-4 4)
// Numerator Accum     : s40,20 -> [-524288 524288)
// Denominator Accum   : s40,21 -> [-262144 262144)
// Round Mode          : floor
// Overflow Mode       : saturate
// Cast Before Sum     : true
// -------------------------------------------------------------

module sdm_nc_filter
               (
                clk,
                clk_enable,
                rstn,
                filter_in,
                filter_out
                );

  input   clk; 
  input   clk_enable; 
  input   rstn; 
  input   signed [25:0] filter_in; //sfix26
  output  signed [25:0] filter_out; //sfix26_En20

////////////////////////////////////////////////////////////////
//Module Architecture: sdm_nc_filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [7:0] scaleconst1 = 8'b01010101; //sfix8_En13
  parameter signed [7:0] coeff_b1_section1 = 8'b00100000; //sfix8_En5
  parameter signed [7:0] coeff_b2_section1 = 8'b01000000; //sfix8_En5
  parameter signed [7:0] coeff_b3_section1 = 8'b00100000; //sfix8_En5
  parameter signed [7:0] coeff_a2_section1 = 8'b10001100; //sfix8_En6
  parameter signed [7:0] coeff_a3_section1 = 8'b00110110; //sfix8_En6
  parameter signed [7:0] scaleconst2 = 8'b01001101; //sfix8_En13
  parameter signed [7:0] coeff_b1_section2 = 8'b00100000; //sfix8_En5
  parameter signed [7:0] coeff_b2_section2 = 8'b01000000; //sfix8_En5
  parameter signed [7:0] coeff_b3_section2 = 8'b00100000; //sfix8_En5
  parameter signed [7:0] coeff_a2_section2 = 8'b10010111; //sfix8_En6
  parameter signed [7:0] coeff_a3_section2 = 8'b00101011; //sfix8_En6
  // Signals
  reg  signed [25:0] input_register; // sfix26
  wire signed [43:0] scale1; // sfix44_En23
  wire signed [33:0] mul_temp; // sfix34_En13
  wire signed [15:0] scaletypeconvert1; // sfix16_En15
  // Section 1 Signals 
  wire signed [39:0] a1sum1; // sfix40_En21
  wire signed [39:0] a2sum1; // sfix40_En21
  wire signed [39:0] b1sum1; // sfix40_En20
  wire signed [39:0] b2sum1; // sfix40_En20
  wire signed [15:0] typeconvert1; // sfix16_En15
  reg  signed [15:0] delay_section1 [0:1] ; // sfix16_En15
  wire signed [15:0] inputconv1; // sfix16_En15
  wire signed [23:0] a2mul1; // sfix24_En21
  wire signed [23:0] a3mul1; // sfix24_En21
  wire signed [23:0] b2mul1; // sfix24_En20
  wire signed [39:0] sub_cast; // sfix40_En21
  wire signed [39:0] sub_cast_1; // sfix40_En21
  wire signed [40:0] sub_temp; // sfix41_En21
  wire signed [39:0] sub_cast_2; // sfix40_En21
  wire signed [39:0] sub_cast_3; // sfix40_En21
  wire signed [40:0] sub_temp_1; // sfix41_En21
  wire signed [39:0] b1multypeconvert1; // sfix40_En20
  wire signed [39:0] add_cast; // sfix40_En20
  wire signed [39:0] add_cast_1; // sfix40_En20
  wire signed [40:0] add_temp; // sfix41_En20
  wire signed [39:0] add_cast_2; // sfix40_En20
  wire signed [39:0] add_cast_3; // sfix40_En20
  wire signed [40:0] add_temp_1; // sfix41_En20
  wire signed [15:0] section_result1; // sfix16_En10
  wire signed [43:0] scale2; // sfix44_En23
  wire signed [23:0] mul_temp_1; // sfix24_En23
  wire signed [15:0] scaletypeconvert2; // sfix16_En15
  // Section 2 Signals 
  wire signed [39:0] a1sum2; // sfix40_En21
  wire signed [39:0] a2sum2; // sfix40_En21
  wire signed [39:0] b1sum2; // sfix40_En20
  wire signed [39:0] b2sum2; // sfix40_En20
  wire signed [15:0] typeconvert2; // sfix16_En15
  reg  signed [15:0] delay_section2 [0:1] ; // sfix16_En15
  wire signed [15:0] inputconv2; // sfix16_En15
  wire signed [23:0] a2mul2; // sfix24_En21
  wire signed [23:0] a3mul2; // sfix24_En21
  wire signed [23:0] b2mul2; // sfix24_En20
  wire signed [39:0] sub_cast_4; // sfix40_En21
  wire signed [39:0] sub_cast_5; // sfix40_En21
  wire signed [40:0] sub_temp_2; // sfix41_En21
  wire signed [39:0] sub_cast_6; // sfix40_En21
  wire signed [39:0] sub_cast_7; // sfix40_En21
  wire signed [40:0] sub_temp_3; // sfix41_En21
  wire signed [39:0] b1multypeconvert2; // sfix40_En20
  wire signed [39:0] add_cast_4; // sfix40_En20
  wire signed [39:0] add_cast_5; // sfix40_En20
  wire signed [40:0] add_temp_2; // sfix41_En20
  wire signed [39:0] add_cast_6; // sfix40_En20
  wire signed [39:0] add_cast_7; // sfix40_En20
  wire signed [40:0] add_temp_3; // sfix41_En20
  wire signed [25:0] output_typeconvert; // sfix26_En20
  reg  signed [25:0] output_register; // sfix26_En20

  // Block Statements
  always @ (posedge clk or negedge rstn)
    begin: input_reg_process
      if (rstn == 1'b0) begin
        input_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          input_register <= filter_in;
        end
      end
    end // input_reg_process

  assign mul_temp = input_register * scaleconst1;
  assign scale1 = $signed({mul_temp, 10'b0000000000});

  assign scaletypeconvert1 = (scale1[43] == 1'b0 & scale1[42:23] != 20'b00000000000000000000) ? 16'b0111111111111111 : 
      (scale1[43] == 1'b1 && scale1[42:23] != 20'b11111111111111111111) ? 16'b1000000000000000 : scale1[23:8];

  //   ------------------ Section 1 ------------------

  assign typeconvert1 = (a1sum1[39] == 1'b0 & a1sum1[38:21] != 18'b000000000000000000) ? 16'b0111111111111111 : 
      (a1sum1[39] == 1'b1 && a1sum1[38:21] != 18'b111111111111111111) ? 16'b1000000000000000 : a1sum1[21:6];

  always @ (posedge clk or negedge rstn)
    begin: delay_process_section1
      if (rstn == 1'b0) begin
        delay_section1[0] <= 16'b0000000000000000;
        delay_section1[1] <= 16'b0000000000000000;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_section1[1] <= delay_section1[0];
          delay_section1[0] <= typeconvert1;
        end
      end
    end // delay_process_section1

  assign inputconv1 = scaletypeconvert1;

  assign a2mul1 = delay_section1[0] * coeff_a2_section1;

  assign a3mul1 = delay_section1[1] * coeff_a3_section1;

  assign b2mul1 = $signed({delay_section1[0], 6'b000000});

  assign sub_cast = $signed({inputconv1, 6'b000000});
  assign sub_cast_1 = $signed({{16{a2mul1[23]}}, a2mul1});
  assign sub_temp = sub_cast - sub_cast_1;
  assign a2sum1 = (sub_temp[40] == 1'b0 & sub_temp[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (sub_temp[40] == 1'b1 && sub_temp[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : sub_temp[39:0];

  assign sub_cast_2 = a2sum1;
  assign sub_cast_3 = $signed({{16{a3mul1[23]}}, a3mul1});
  assign sub_temp_1 = sub_cast_2 - sub_cast_3;
  assign a1sum1 = (sub_temp_1[40] == 1'b0 & sub_temp_1[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (sub_temp_1[40] == 1'b1 && sub_temp_1[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : sub_temp_1[39:0];

  assign b1multypeconvert1 = $signed({typeconvert1, 5'b00000});

  assign add_cast = b1multypeconvert1;
  assign add_cast_1 = $signed({{16{b2mul1[23]}}, b2mul1});
  assign add_temp = add_cast + add_cast_1;
  assign b2sum1 = (add_temp[40] == 1'b0 & add_temp[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (add_temp[40] == 1'b1 && add_temp[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : add_temp[39:0];

  assign add_cast_2 = b2sum1;
  assign add_cast_3 = $signed({delay_section1[1], 5'b00000});
  assign add_temp_1 = add_cast_2 + add_cast_3;
  assign b1sum1 = (add_temp_1[40] == 1'b0 & add_temp_1[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (add_temp_1[40] == 1'b1 && add_temp_1[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : add_temp_1[39:0];

  assign section_result1 = (b1sum1[39] == 1'b0 & b1sum1[38:25] != 14'b00000000000000) ? 16'b0111111111111111 : 
      (b1sum1[39] == 1'b1 && b1sum1[38:25] != 14'b11111111111111) ? 16'b1000000000000000 : b1sum1[25:10];

  assign mul_temp_1 = section_result1 * scaleconst2;
  assign scale2 = $signed({{20{mul_temp_1[23]}}, mul_temp_1});

  assign scaletypeconvert2 = (scale2[43] == 1'b0 & scale2[42:23] != 20'b00000000000000000000) ? 16'b0111111111111111 : 
      (scale2[43] == 1'b1 && scale2[42:23] != 20'b11111111111111111111) ? 16'b1000000000000000 : scale2[23:8];

  //   ------------------ Section 2 ------------------

  assign typeconvert2 = (a1sum2[39] == 1'b0 & a1sum2[38:21] != 18'b000000000000000000) ? 16'b0111111111111111 : 
      (a1sum2[39] == 1'b1 && a1sum2[38:21] != 18'b111111111111111111) ? 16'b1000000000000000 : a1sum2[21:6];

  always @ (posedge clk or negedge rstn)
    begin: delay_process_section2
      if (rstn == 1'b0) begin
        delay_section2[0] <= 16'b0000000000000000;
        delay_section2[1] <= 16'b0000000000000000;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_section2[1] <= delay_section2[0];
          delay_section2[0] <= typeconvert2;
        end
      end
    end // delay_process_section2

  assign inputconv2 = scaletypeconvert2;

  assign a2mul2 = delay_section2[0] * coeff_a2_section2;

  assign a3mul2 = delay_section2[1] * coeff_a3_section2;

  assign b2mul2 = $signed({delay_section2[0], 6'b000000});

  assign sub_cast_4 = $signed({inputconv2, 6'b000000});
  assign sub_cast_5 = $signed({{16{a2mul2[23]}}, a2mul2});
  assign sub_temp_2 = sub_cast_4 - sub_cast_5;
  assign a2sum2 = (sub_temp_2[40] == 1'b0 & sub_temp_2[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (sub_temp_2[40] == 1'b1 && sub_temp_2[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : sub_temp_2[39:0];

  assign sub_cast_6 = a2sum2;
  assign sub_cast_7 = $signed({{16{a3mul2[23]}}, a3mul2});
  assign sub_temp_3 = sub_cast_6 - sub_cast_7;
  assign a1sum2 = (sub_temp_3[40] == 1'b0 & sub_temp_3[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (sub_temp_3[40] == 1'b1 && sub_temp_3[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : sub_temp_3[39:0];

  assign b1multypeconvert2 = $signed({typeconvert2, 5'b00000});

  assign add_cast_4 = b1multypeconvert2;
  assign add_cast_5 = $signed({{16{b2mul2[23]}}, b2mul2});
  assign add_temp_2 = add_cast_4 + add_cast_5;
  assign b2sum2 = (add_temp_2[40] == 1'b0 & add_temp_2[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (add_temp_2[40] == 1'b1 && add_temp_2[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : add_temp_2[39:0];

  assign add_cast_6 = b2sum2;
  assign add_cast_7 = $signed({delay_section2[1], 5'b00000});
  assign add_temp_3 = add_cast_6 + add_cast_7;
  assign b1sum2 = (add_temp_3[40] == 1'b0 & add_temp_3[39] != 1'b0) ? 40'b0111111111111111111111111111111111111111 : 
      (add_temp_3[40] == 1'b1 && add_temp_3[39] != 1'b1) ? 40'b1000000000000000000000000000000000000000 : add_temp_3[39:0];

  assign output_typeconvert = (b1sum2[39] == 1'b0 & b1sum2[38:25] != 14'b00000000000000) ? 26'b01111111111111111111111111 : 
      (b1sum2[39] == 1'b1 && b1sum2[38:25] != 14'b11111111111111) ? 26'b10000000000000000000000000 : b1sum2[25:0];

  always @ (posedge clk or negedge rstn)
    begin: Output_Register_process
      if (rstn == 1'b0) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // sdm_nc_filter