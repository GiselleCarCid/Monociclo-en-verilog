
/* 

	Proyecto: ALU
	Archivo: ALU_FPGA.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo de implementación FPGA de la ALU que puede realizar 
	operaciones con numeros de hasta 32 bits y mostrar los resultados en displays de 7 segmentos

*/


module ALU_FPGA(

	//seleccionan datos de dos bloques de memoria
	input			[2:0] addra_i,  
	input			[2:0] addrb_i,
	
	input					c_i,
	input					invert_i,
	input			[3:0]	operacion_i,
	
	output				c_o,
	
	//mostrar el resultado
	output		[6:0] disp0_o,
	output		[6:0] disp1_o,
	output		[6:0] disp2_o,
	output		[6:0] disp3_o,
	output		[6:0] disp4_o,
	output		[6:0] disp5_o,
	output		[6:0] disp6_o,
	output		[6:0] disp7_o
	
);


wire			[31:0] operadora_w;
wire			[31:0] operadorb_w;
wire			[31:0] resultado_w;



	//Seccion de declaracion de señales
   //Declaracion de las memorias
	memoria_a memory_a (
		.addr_i		(addra_i), 			//direccion de entrada
		.dato_o		(operadora_w)		//salida de datos
	);
	
		memoria_b memory_b (
		.addr_i		(addrb_i),			//direccion de entrada
		.dato_o		(operadorb_w)		//salida de datos
	);
	
	
	//versión parametrizable del módulo ALUNBits
	
	ALUNBits #(
		.N			(32)
	)
	VALUNBits(
	.a_i				(operadora_w),
	.b_i				(operadorb_w),
	.operacion_i			(operacion_i),
	.c_i				(c_i),
	.invert_i		(invert_i),
	.c_o				(c_o),
	.salida_o			(resultado_w)
);


	// Instancia de los display
	// Cada una toma una porción de 4 bits de resultado_w, del menos al mas significativo
	

	display7 display_0(
		.hex_i		(resultado_w[3:0]),
		.display_o	(disp0_o)
	);
	display7 display_1(
		.hex_i		(resultado_w[7:4]),
		.display_o	(disp1_o)
	);
	display7 display_2(
		.hex_i		(resultado_w[11:8]),
		.display_o	(disp2_o)
	);
	display7 display_3(
		.hex_i		(resultado_w[15:12]),
		.display_o	(disp3_o)
	);
	display7 display_4(
		.hex_i		(resultado_w[19:16]),
		.display_o	(disp4_o)
	);
	display7 display_5(
		.hex_i		(resultado_w[23:20]),
		.display_o	(disp5_o)
	);
	display7 display_6(
		.hex_i		(resultado_w[27:24]),
		.display_o	(disp6_o)
	);
	display7 display_7(
		.hex_i		(resultado_w[31:28]),
		.display_o	(disp7_o)
	);
	

endmodule 