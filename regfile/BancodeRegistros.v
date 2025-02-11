
/* 

	Proyecto: monociclo
	Archivo: BancodeRegistros.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo del banco de registros

*/

module BancodeRegistros(
  //Puerto de escritura (Sincronos)
  input              clk_i,  //reloj
  input     [4:0]    rd_i,   //escritura
  input     [31:0]   datard_i, //dato
  input              wren_i, //write enable
  //Puerto de lectura
  input     [4:0]    rs1_i, //rs2 lectura
  output    [31:0]   datars1_o,
  input     [4:0]    rs2_i, //rs2 lectura
  output    [31:0]   datars2_o
);

  //definir una memoria de 32*32
  reg       [31:0] Registros [0:31];
  
  //Puerto de escritura
  always @(posedge clk_i) //Cada que haya un pulso positivo de reloj...
  begin
     if (wren_i) //Si se puede escribir...
	     Registros[rd_i] = datard_i; //escribir en rd_i el datard_i
  end
  
  assign   datars1_o = Registros[rs1_i];
  assign   datars2_o = Registros[rs2_i];
endmodule
