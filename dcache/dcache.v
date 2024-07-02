
/*

Encabezado

*/


module dcache (
		//Puertos de entrada
		input		[5:0]	 addr_i,
		input		[31:0] dato_i,
		input		       memwrite_i,
		input		       memread_i,
		//Puertos de salida
		output	[31:0] dato_o

);
		
		//Data cache
		reg 		[31:0] memoria [0:63];
		
		//Puerto de escritura
		always @(posedge clk_i) //lleva reloj porque escritura es sincrono
		begin
			if (memwrite_i)
				memoria [addr_i] <= dato_i;
		end
		
		
		//Puerto de lectura
		assign	dato_o = (memread_i) ? memoria [addr_i] : 32'b0;
		
		
endmodule 