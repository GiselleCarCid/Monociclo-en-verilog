
/* 

	Proyecto: ALU
	Archivo: memoria_a
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo de la primer memoria

*/


module memoria_a (
	input				[2:0] addr_i,
	output			[31:0]dato_o
);
	//definicion de la memoria
	reg				[31:0] memory_a [0:7];
	
	//inicializar memoria
	initial
	begin
		memory_a[0]	=	32'b00000000000000000000000000000111;	//B 7
		memory_a[1]	=	32'b00000000000000000000000000001010;	//A 10
		memory_a[3]	=	32'b00000000000000000000000000001111;	//15
		memory_a[4]	=	32'b00000000000000000000000000011111;	//21
		memory_a[5]	=	32'b11111111111111111111111111111011;	// -5
		
	end
	
	assign	dato_o = memory_a[addr_i];	
endmodule 