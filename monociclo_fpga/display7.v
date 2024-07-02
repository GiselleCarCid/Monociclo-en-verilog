/* 
	Proyecto: ALU
	Archivo: display7.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo para el display de siete segmentos
*/


module display7(
	input			[3:0] entrada_i,
	output reg	[6:0] display_o
);


	always @(*)
	begin
		case (entrada_i)
			4'h0:				//	   gfedcba
					display_o = 7'b1000000;
			4'h1:				//	   gfedcba
					display_o = 7'b1111001;
			4'h2:				//	   gfedcba
					display_o = 7'b0100100;
			4'h3:				//	   gfedcba
					display_o = 7'b0110000;
			4'h4:				//	   gfedcba
					display_o = 7'b0011001;
			4'h5:				//	   gfedcba
					display_o = 7'b0010010;
			4'h6:				//	   gfedcba
					display_o = 7'b0000010;
			4'h7:				//	   gfedcba
					display_o = 7'b1111000;
			4'h8:				//	   gfedcba
					display_o = 7'b0000000;
			4'h9:				//	   gfedcba
					display_o = 7'b0011000;
			4'ha:				//	   gfedcba
					display_o = 7'b0001000;
			4'hb:				//	   gfedcba
					display_o = 7'b0000011;
			4'hc:				//	   gfedcba
					display_o = 7'b1000110;
			4'hd:				//	   gfedcba
					display_o = 7'b0100001;
			4'he:				//	   gfedcba
					display_o = 7'b0000110;
			4'hf:				//	   gfedcba
					display_o = 7'b0001110;
			default:
					display_o = 7'b1111111;
		endcase
	end

endmodule 