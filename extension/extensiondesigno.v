/* 
	Proyecto: monociclo
	Archivo: extensiondesigno.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo de la extension de signo
*/


module extensiondesigno (
	input [31:0] instruccion_i, // La entrada es la salida de la caché de instrucciones (fetch)
	output reg [31:0] inmediato_o
);
	parameter IMM = 20;
	wire [6:0] opcode_w;
	assign opcode_w = instruccion_i[6:0];
	
	always @(*)
	begin
		case (opcode_w)
			7'b0010011: // Tipo I
				inmediato_o = {{(IMM-12){instruccion_i[31]}}, instruccion_i[31:20]}; // Extensión de signo desde bit 31
			default: 
				inmediato_o = 32'b0;
		endcase
	end
endmodule
