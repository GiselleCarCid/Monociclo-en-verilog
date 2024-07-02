
/* 

	Proyecto: ALU
	Archivo: memoria_b.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo de la segunda memoria

*/


module memoria_b (
	input				[2:0] addr_i,
	output			[31:0]dato_o
);
	//definicion de la memoria
	reg				[31:0] memory_b [0:7];
	
	//inicializar memoria
	initial
	begin
		memory_b[0]	=	32'b00000000000000000000000000000010;	//B 7
		memory_b[1]	=	32'b00000000000000000000000000001010;	//A 10
		memory_b[2]	=	32'b00000000000000000000000000000011;	//3 
		memory_b[3]	=	32'b00000000000000000000000000001111;	//15
		memory_b[4]	=	32'b00000000000000000000000000011111;	//21
		memory_b[5]	=	32'b11111111111111111111111111111011;	// -5
	end
	
	assign	dato_o = memory_b[addr_i];	
endmodule 