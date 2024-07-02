
/* 

	Proyecto: ALU
	Archivo: ALU.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo principal ALU

*/



module ALU(
	//Entradas
	input					a_i,				 //valor de entrada en A
	input					b_i,				 //valor de entrada en B
	input			[2:0]	operacion_i,	 //selector para la operacion 
	input					c_i,				 //acarreo de entrada del sumador
	input					invert_i,       //Bandera para invertir el operando b_i
	input					less_i,         //Bandera de entrada para la operación de configuración
	//Salidas
	output				c_o,				 //acarreo de salida de la suma 
	output reg			set_o,          //resultado de la operacion
	output reg			salida_o        //resultado de la operacion
);



	//seccion de declaracion de señales
	wire		aband_w;	         //salida de AND
	wire		abor_w;	         //salida de OR
	wire		nob_w;	         //salida de ~b
	wire		selb_w;        	//valor de b_i despues de pasar por un multiplexor
	wire		salidasum_w;      //salida del sumador hacia el selector
	wire		abxor_w;	         //salida de XOR
	
	assign	abxor_w	=	a_i ^ selb_w;     //Calcula el XOR de a_i con selb_w
	assign 	aband_w	=	a_i & selb_w;     //Calcula el AND de a_i con selb_w
	assign 	abor_w	=	a_i | selb_w;     //Calcula el OR de a_i con selb_w
	
	assign	nob_w	=	~b_i;      // Calcula la negación de b_i.
	assign 	selb_w		=	(invert_i) ? nob_w : b_i;     //Selecciona entre nob_w y b_i dependiendo de invert_i.
	
	
	
	//instancia del sumador
	//fulladder1bit es un componente que suma a_i y selb_w
	fulladder1bit sumador(
	   
		.a_i 		(a_i),
		.b_i		(selb_w),
		.c_i		(c_i),			//acarreo de entrada
		.c_o		(c_o),  			//acarreo de salida
		.s_o		(salidasum_w)  //resultado de la suma
);	
	
	
	
	//selector
   //Gestiona las operaciones basadas en el selector operacion_i
	always @(*)
	begin
	
		//asignación de la señal set_o
		case(operacion_i)
			3'b101:
					set_o = ~c_o;
			default
					set_o = salidasum_w;
		endcase
		
		//asignación de la señal salida_o
		case(operacion_i)
			3'b000:
					salida_o	=	aband_w;
			3'b001:
					salida_o	=	abor_w;
			3'b010:
					salida_o	=	salidasum_w;
			3'b011:
					salida_o	=	abxor_w;
			3'b100:
					salida_o	=	less_i;
			default:
					salida_o	=	1'b0;
		endcase
			
	end

endmodule

