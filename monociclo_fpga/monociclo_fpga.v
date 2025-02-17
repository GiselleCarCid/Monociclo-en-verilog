/* 
	Proyecto: ALU
	Archivo: monocicloFPGA.v
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

module monociclo_fpga(

	//seleccionan datos de dos bloques de memoria
   input               clk_i, 
  	input               rst_ni,
	
	//mostrar el resultado
	output		[6:0]   disp0_o,
	output		[6:0]   disp1_o,
	output		[6:0]   disp2_o,
	output		[6:0]   disp3_o,
	output		[6:0]   disp4_o,
	output		[6:0]   disp5_o,
	output		[6:0]   disp6_o,
	output		[6:0]   disp7_o
	
);
   wire			[31:0]  salida_o;



	//Seccion de declaracion de señales
  
	
	
	//versión parametrizable del módulo ALUNBits
	
	monociclo mono(
		.clk_i     (clk_o), 
		.rst_ni    (rst_ni),
		.salida_o  (salida_o [31:0])
);


	//versión parametrizable del módulo ALUNBits
	
	divisor div(
		.clk_i     (clk_i), 
		.clk_o     (clk_o),
);

	// Instancia de los display
	// Cada una toma una porción de 4 bits de salida_o, del menos al mas significativo
	

	display7 display_0(
		.entrada_i		(salida_o[3:0]),
		.display_o	   (disp0_o)
	);
	display7 display_1(
		.entrada_i		(salida_o[7:4]),
		.display_o	   (disp1_o)
	);
	display7 display_2(
		.entrada_i		(salida_o[11:8]),
		.display_o	   (disp2_o)
	);
	display7 display_3(
		.entrada_i		(salida_o[15:12]),
		.display_o	   (disp3_o)
	);
	display7 display_4(
		.entrada_i		(salida_o[19:16]),
		.display_o	   (disp4_o)
	);
	display7 display_5(
		.entrada_i		(salida_o[23:20]),
		.display_o	   (disp5_o)
	);
	display7 display_6(
		.entrada_i		(salida_o[27:24]),
		.display_o	   (disp6_o)
	);
	display7 display_7(
		.entrada_i		(salida_o[31:28]),
		.display_o	   (disp7_o)
	);
	

endmodule 