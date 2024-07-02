/* 
	Proyecto: monociclo
	Archivo: monociclo.v
	Grupo: 5CV3
	Equipo: 5
	Integrantes:
	
		Carmona Cid Giselle 
		Fuentes Godinez Alondra 
		Marin Nostroza Luis Enrique 
		Reyes Vivar Fernando 
		Sanchez Martinez Brian Omar 
	
	Descripcion:  Codigo del monociclo
*/

module monociclo(
   input           clk_i,
	input           rst_ni,
	output  [31:0]  salida_o
);

   //SECCIÓN DE DECLARACIÓN DE SEÑALES
	reg     [31:0]  pc_r;
	wire    [31:0]  pcnext_w;
	wire    [31:0]  if_inst_o;
	wire    [31:0]  ex_resultado_o;
	wire    [31:0]  wb_resultado_o;
	wire            c_o;
	wire    [31:0]  es_dato_o;
	wire    [31:0]  muxalu_dato_o;
	wire            id_regwrite_o;
	wire            id_alusrc_o;
	wire            id_branch_o;
	wire            id_memread_o;
	wire            id_memwrite_o;
   wire            id_memtoreg_o;
	wire    [31:0]  dators1;
	wire    [31:0]  dators2;
	wire    [31:0]  sll_dato_o;
	wire    [31:0]  branch_pc_w;
	wire            ex_zeroflag_o;
	wire    [31:0]  pcsrc_w;
	wire    [31:0]  pcbranchnext_w;
	wire            aluopr_i;
	wire    [3:0]	  aluctrl_aluop_o;
	
	

	
	//Seccion de asignacion de señales para monitoreo en FPGA
	assign salida_o = if_inst_o;
	
	
	//Calculo de PC
   always @(posedge clk_i, negedge rst_ni)
	begin 
	   if(!rst_ni)
		  pc_r  <= 32'b0;
		else
	   pc_r <= pcbranchnext_w; //La salida toma el valor d ela entrada
	end 
	
	assign pcnext_w = pc_r + 32'h4;
	
	//Instancia de la memoria de instrucciones
	
	icache icache_u0(
	  .rdaddr_i  (pc_r[7:2]),
	  .inst_o    (if_inst_o)
	);
	
	//Etapa de decodificacion
	
   decodificador decode_u0(
      .opcode_i          (if_inst_o[6:0]),
		.regwrite_o        (id_regwrite_o),
		.alusrc_o          (id_alusrc_o),
		.branch_o          (id_branch_o),
		.memread_o         (id_memread_o),
		.memwrite_o        (id_memwrite_o),
		.memtoreg_o        (id_memtoreg_o),
		.aluopr_o          (id_aluop)
	);

	
	//ALU Control
	aluctrl aluctrl_comp(
       .f7_i       (if_inst_o[30]),
       .f3_i       (if_inst_o[14:12]),
       .aluopr_i   (id_aluop),
       .aluopr_o   (aluctrl_aluop_o)
	  );
	
	
	//Tarea - Conectar el banco de registros
		BancodeRegistros regfile(
	
	  .clk_i      (clk_i),//reloj
     .rd_i      (if_inst_o[11:7]),//lectura
     .datard_i  (wb_resultado_o),//dato
     .wren_i    (id_regwrite_o),//write enableW
     .rs1_i     (if_inst_o[19:15]),//rs2 lectura
     .datars1_o (dators1[31:0]), //lectura
     .rs2_i     (if_inst_o[24:20]),//rs2 lectura
     .datars2_o (dators2[31:0]) //lectura
	);


	

	
	//Extension de signo
	
	extensiondesigno extend_u3 (
	   .instruccion_i     (if_inst_o),
		.inmediato_o       (es_dato_o)
	);
	
	
	//Desplazamiento logico de 1 bit hacia la izquierda
	
	sll1bit sll1bit_0(
		.entrada_i (es_dato_o),
		.salida_o  (sll_dato_o)

   );

	
	//Multiplexor para el segundo operando de la ALU
	assign muxalu_dato_o = (id_alusrc_o) ? es_dato_o : dators2;
	
	
	//Conexion a la ALU
	ALUNBits #(
	    .N   (32)
	)
	(
	    .a_i         (dators1[31:0]),
		 .b_i         (muxalu_dato_o),
		 .c_i         (aluctrl_aluop_o[2]),
		 .invert_i    (if_inst_o[30]),
		 .less_i      (),
		 .operacion_i (aluctrl_aluop_o),
		 .salida_o    (ex_resultado_o),
		 .c_o         (c_o),
		 .zeroflag_o  (ex_zeroflag_o)

	);
		 
	
	
	//Sumador para calcular el PC de salto
	
	assign	branch_pc_w  = sll_dato_o + pc_r;
	assign   pcsrc_w = id_branch_o & ex_zeroflag_o;
	
	   //selector
	assign   pcbranchnext_w = (pcsrc_w) ? branch_pc_w : pcnext_w;
	
	
	//Conectar wb_resultado
	assign wb_resultado_o = ex_resultado_o;
	

endmodule 