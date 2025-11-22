--  =================================================================
--  Physics Package Implementation
--  =================================================================

package body Physics with
   SPARK_Mode => On
is

   --  Calculate distance fallen under gravity
   --  d = v0*t + (1/2)*g*t^2
   function Distance_Fallen
      (Initial_Velocity : Float;
       Time            : Float;
       Gravity         : Float := Gravity_Constant)
      return Float
   is
   begin
      return Initial_Velocity * Time + 0.5 * Gravity * Time * Time;
   end Distance_Fallen;

   --  Apply drag to velocity
   --  v_new = v_old * drag_coefficient
   function Apply_Drag
      (Velocity        : Float;
       Drag_Coefficient : Float)
      return Float
   is
   begin
      return Velocity * Drag_Coefficient;
   end Apply_Drag;

end Physics;
