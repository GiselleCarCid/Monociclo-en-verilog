/* 
	Proyecto: ALU
	Archivo: ALUNBits.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion: 

*/


module ALUNBits #(
	parameter			N	=	4
)
(
	input			   [N-1:0]	a_i,
	input			   [N-1:0]	b_i,
	input			   [3:0]		operacion_i,
	input			   			c_i,
	input			   			invert_i,
	output		   			c_o,
	output 	reg	[N-1:0]	salida_o,
	output                  zeroflag_o
);
	wire			   [N-2:0]	carryint_w; //3 porque va de 0 a 2
	wire 			   [N-1:0]	resAux_o;
	
	genvar i;
	wire set_o;
	
	wire 			   [N-1:0] izquierdaLogico_w;
	wire 			   [N-1:0] derechaLogico_w;
	wire 			   [N-1:0] derechaAritmetico_w;
	
	assign izquierdaLogico_w = a_i << b_i;
	assign derechaLogico_w = a_i >> b_i;
	assign derechaAritmetico_w = a_i >>> b_i;
	
	
	//Generación de la bandera de zero
	
   assign       zeroflag = ~(|(salida_o));
	
	
	generate
		for (i=0; i<N; i = i + 1)
			begin : alu 
				case(i)
				0:
				
					ALU ALU_N0(
						.a_i			(a_i[i]),
						.b_i			(b_i[i]),
						.operacion_i		(operacion_i[2:0]),
						.c_i			(c_i),
						.invert_i	(invert_i),
						.less_i		(set_o),
						.c_o			(carryint_w[i]),
						.salida_o		(resAux_o[i]),
						.set_o		()
						);
				N-1:
					ALU ALU_N1(
						.a_i			(a_i[i]),
						.b_i			(b_i[i]),
						.operacion_i		(operacion_i[2:0]),
						.c_i			(carryint_w[i-1]),
						.invert_i	(invert_i),
						.less_i		(1'b0),
						.c_o			(c_o),
						.salida_o		(resAux_o[i]),
						.set_o		(set_o)
					);
				default:
					ALU ALU_N(
						.a_i			(a_i[i]),
						.b_i			(b_i[i]),
						.operacion_i		(operacion_i[2:0]),
						.c_i			(carryint_w[i-1]),
						.invert_i	(invert_i),
						.less_i		(1'b0),
						.c_o			(carryint_w[i]),
						.salida_o		(resAux_o[i]),
						.set_o		()
						);
				
				endcase 
			end
	endgenerate
	
	always@(*)
		begin
			case(operacion_i[3])
				1'b0:
						salida_o = resAux_o;
					 
				1'b1:
					begin
						case (operacion_i[2:0])
							3'b001:
							  salida_o = izquierdaLogico_w;
							3'b010:
								salida_o = derechaLogico_w;
							3'b011:
								salida_o = derechaAritmetico_w;
								
						default:
							  salida_o = 32'b00000000000000000000000000000000;
							
						endcase
						
					end
			endcase
		
		end

endmodule 