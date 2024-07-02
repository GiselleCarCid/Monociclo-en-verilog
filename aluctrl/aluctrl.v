/* 

	Proyecto: monociclo
	Archivo: aluctrl.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo de ALU control

*/


module aluctrl (

	input 					f7_i,
	input				[2:0]	f3_i,
	input				[3:0]	aluopr_i,
	output	reg	[3:0]	aluopr_o
	
);



always @(*)
	begin
		case (aluopr_i)
		
			//INSTRUCCIONES TIPO R
			5'b01100:	
				begin
					case ({f7_i, f3_i})
						4'b0_000:
							aluopr_o = 4'b0_0_00; // SUMA
						4'b1_000:
							aluopr_o = 4'b0_1_00; // RESTA
						4'b0_001:
							aluopr_o = 4'b0_0_01; // AND
					   4'b0_010:
							aluopr_o = 4'b0_0_10; // OR
						4'b0_011:
							aluopr_o = 4'b0_0_11; // XOR
						4'b0_100:
							aluopr_o = 4'b0_1_01; // SLT
						4'b0_101:
							aluopr_o = 4'b0_1_10; // SLTU
						4'b0_110:
							aluopr_o = 4'b1_0_00; // <<
						4'b0_111:
							aluopr_o = 4'b1_0_00; // >>
						4'b1_111:
							aluopr_o = 4'b1_0_10; // >>>
					endcase
            end
			
			// INSTRUCCIONES TIPO I
			5'b00100:	
				begin
					case (f3_i)
						3'b000:
							aluopr_o= 4'b0_0_00; // Suma inmediata
						3'b001:
							aluopr_o= 4'b1_0_01; // SLLI
						3'b010:
							aluopr_o= 4'b0_1_10; // SLTI
						3'b011:
							aluopr_o= 4'b0_1_00; // SLTIU
						3'b100:
							aluopr_o= 4'b0_0_11; // XORI
						3'b101:
							if (f7_i)					//-----------si f7 es 1 es a y si es 0 es b----------
								aluopr_o= 4'b1_0_11; // SRAI
							else
								aluopr_o= 4'b1_0_10; // SRLI
						3'b110:
							aluopr_o= 4'b0_0_10; // ORI
						3'b111:
							aluopr_o= 4'b0_0_01; // ANDI
					endcase
				end
				
				
			// INSTRUCCIONES TIPO S
			5'b01000:	
				begin
					aluopr_o= 4'b0_0_00;
				end
				
				
			// INSTRUCCIONES TIPO L
			5'b00000:	
				begin
					aluopr_o= 4'b0_0_00;
				end
				
				
			// INSTRUCIONES TIPO B
			5'b11000:	
				begin		// BEQ, BNE, BLT, BGT
					case (f3_i)
						3'b000:
							aluopr_o= 4'b0_1_01; // BEQ
						3'b001:
							aluopr_o= 4'b0_1_01; // BNE
						3'b100:
							aluopr_o= 4'b0_1_10; // BLT
						3'b101:
							aluopr_o= 4'b0_1_10; // BGE
						/*3'b110:
							aluopr_o= 4'b0_1_00; // BLTU
						3'b111:
							aluopr_o= 4'b0_1_10; // BGEU*/
					endcase
				end
			default:
				aluopr_o= 4'b1_1_11;
			endcase
		end
endmodule 

