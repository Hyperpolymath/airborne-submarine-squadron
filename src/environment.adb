--  =================================================================
--  Environment Package Implementation
--  =================================================================

package body Environment with
   SPARK_Mode => On
is

   --  Convert environment to string
   function To_String (Env : Environment_Type) return String is
   begin
      case Env is
         when Air        => return "AIR";
         when Water      => return "WATER";
         when Transition => return "TRANSITION";
      end case;
   end To_String;

   --  Gravity multiplier by environment
   function Gravity_Multiplier (Env : Environment_Type) return Float is
   begin
      case Env is
         when Air        => return 1.0;    --  Full gravity
         when Water      => return 0.3;    --  Reduced gravity (buoyancy)
         when Transition => return 0.65;   --  Mid-point
      end case;
   end Gravity_Multiplier;

   --  Drag multiplier by environment
   function Drag_Multiplier (Env : Environment_Type) return Float is
   begin
      case Env is
         when Air        => return 0.98;   --  Low air drag
         when Water      => return 0.85;   --  High water drag
         when Transition => return 0.91;   --  Mid-point
      end case;
   end Drag_Multiplier;

end Environment;
