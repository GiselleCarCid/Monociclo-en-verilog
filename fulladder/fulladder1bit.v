/* Todos los archivos rotulados así:
	Proyecto: 		fulladder1bit
	Archivo:			fulladder1bit.v
	Equipo:			4
	Integrantes:	Candia Navarro Iván
						Flores Estopier Rodrigo
						Martínez Saúl
						Nava Izquierdo César
			
	Descripcion:	Sumador Completo

*/


module fulladder1bit(
	input		a_i,
	input		b_i,
	input		c_i,
	output	c_o,
	output	s_o
);	
	//seccion de declaracion de señales
	wire		axorb_w;
	wire		aandc_w;
	wire		candb_w;
	wire		aandb_w;
	
	//la XOR Gate
	assign	axorb_w	=	a_i ^ b_i;
	//2a XOR Gate
	assign	s_o		=	axorb_w ^ c_i;
	
	//1a AND Gate
	assign	aandc_w	=	a_i & c_i;
	//2a AND Gate
	assign	candb_w	=	c_i & b_i;	
	//3a AND Gate
	assign	aandb_w	=	a_i & b_i;
	
	//OR Gate
	assign	c_o		=	aandc_w | candb_w	| aandb_w;
endmodule 