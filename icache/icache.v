
/* 

	Proyecto: monociclo
	Archivo: icache.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo del icache

*/

module icache (
    input            clk_i,
	 //puerto de lectura
	 input    [5:0]   rdaddr_i,
	 output   [31:0]  inst_o
);
    //definir la memoria 
	 reg      [31:0]  memoria[0:63];
	 
	 initial
	 begin
	    memoria[0] = 32'b000000000000000000000000000000;																			
		 memoria[1] = 32'b000000000000000000000000000000;
		 memoria[2] = 32'b000000000000000000000000000000;
	 
	 //Definir la lectura de la memoria
	 end
	 assign  inst_o = memoria[rdaddr_i];

endmodule 