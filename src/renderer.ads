--  =================================================================
--  Renderer Package Specification
--  =================================================================
--
--  Text-based rendering for terminal output
--  (In full game, this would be graphics rendering)
--
--  Type-Safe: All rendering operations type-checked
--  =================================================================

with Submarine;
with Environment;

package Renderer with
   SPARK_Mode => On
is

   --  Render submarine status
   procedure Render_Status
      (Sub     : Submarine.Submarine_Type;
       Env     : Environment.Environment_Type;
       Seconds : Natural);

end Renderer;
