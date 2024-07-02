/* 
	Proyecto: monociclo
	Archivo: decodificador.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo del monociclo
*/


module decodificador (
		input				[6:0] opcode_i,
		output reg		      regwrite_o,
		output reg		      alusrc_o,
		output reg           branch_o,
		output reg           memread_o,
		output reg           memwrite_o,
		output reg           memtoreg_o, 
	   output reg     [4:0] aluopr_o
);

	
	always @(*)
	begin
		case (opcode_i)
			7'b0010011:			//tipo I
				begin
					regwrite_o = 1'b1;
					alusrc_o   = 1'b1;
					branch_o   = 1'b0;
					memread_o  = 1'b0;
					memwrite_o = 1'b0;
					memtoreg_o = 1'b0;
					aluopr_o    = 5'b00100;
					
				end
			7'b0110011:			//tipo R
				begin
					regwrite_o = 1'b1;
					alusrc_o   = 1'b0;
					branch_o   = 1'b0;
					memread_o  = 1'b0;
					memwrite_o = 1'b0;
					memtoreg_o = 1'b0;
					aluopr_o    = 5'b01100;
				end
			7'b0100011:			//tipo S
				begin
					regwrite_o = 1'b0;
					alusrc_o   = 1'b1;
					branch_o   = 1'b0;
					memread_o  = 1'b0;
					memwrite_o = 1'b1;
					memtoreg_o = 1'b0;
					aluopr_o    = 5'b01000;
				end
			7'b0000011:			//tipo L
				begin
					regwrite_o = 1'b1;
					alusrc_o   = 1'b1;
					branch_o   = 1'b0;
					memread_o  = 1'b1;
					memwrite_o = 1'b0;
					memtoreg_o = 1'b1;
					aluopr_o    = 5'b00000;
				end
		   7'b1100011:			//tipo B
				begin
					regwrite_o = 1'b0;
					alusrc_o   = 1'b1;
					branch_o   = 1'b1;
					memread_o  = 1'b0;
					memwrite_o = 1'b0;
					memtoreg_o = 1'b0;
					aluopr_o    = 5'b11000;
				end
			7'b1101111: // Tipo J (JAL)
				begin
					regwrite_o = 1'b1;
					alusrc_o   = 1'b0;
					memread_o  = 1'b0;
					memwrite_o = 1'b0;
					memtoreg_o = 1'b0;
					branch_o   = 1'b1; 
					aluopr_o    = 5'b11100;
				end
			default
				begin
					regwrite_o = 1'b0;
					alusrc_o   = 1'b0;
					branch_o   = 1'b0;
					memread_o  = 1'b0;
					memwrite_o = 1'b0;
					memtoreg_o = 1'b0;
					aluopr_o    = 5'b00000;
				end
			//Faltan casos incondicionales
		endcase
	end
endmodule
