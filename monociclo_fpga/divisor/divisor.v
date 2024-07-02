module divisor (
   input clk_i,          // Señal de reloj de entrada
   input rst_ni,         // Señal de reset
   output reg clk_o      // Señal de reloj de salida
);

reg [31:0] cuenta;       // 'cuenta' ahora es un registro de 32 bits

always @(posedge clk_i or negedge rst_ni)  // Corregido para usar 'or' en lugar de ','
   begin 
       if (!rst_ni)                        // Si reset está activo (activo bajo)
          begin 
            clk_o <= 1'b1;                  // Inicializa clk_o a 1
            cuenta <= 32'b0;                // Resetea 'cuenta' a 0
          end 
       else 
          begin 
            if (cuenta == 32'd50_000_000)  // Uso de 'd' para especificar decimal
               begin 
                  cuenta <= 32'b0;          // Resetea 'cuenta' a 0
                  clk_o <= ~clk_o;          // Invierte el estado de clk_o
               end 
            else
               cuenta <= cuenta + 32'b1;   // Incrementa 'cuenta'
          end
    end
    
endmodule 