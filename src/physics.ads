--  =================================================================
--  Physics Package Specification
--  =================================================================
--
--  Physics calculations and constants
--
--  Type-Safe: All calculations use strong typing
--  =================================================================

package Physics with
   SPARK_Mode => On
is

   --  Physics constants
   Gravity_Constant : constant := 9.8;  --  m/s^2 (scaled)

   --  Calculate distance fallen under gravity
   function Distance_Fallen
      (Initial_Velocity : Float;
       Time            : Float;
       Gravity         : Float := Gravity_Constant)
      return Float
   with
      Pre => Time >= 0.0 and Gravity >= 0.0;

   --  Apply drag to velocity
   function Apply_Drag
      (Velocity        : Float;
       Drag_Coefficient : Float)
      return Float
   with
      Pre => Drag_Coefficient >= 0.0 and Drag_Coefficient <= 1.0;

end Physics;
