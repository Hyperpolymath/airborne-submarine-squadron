--  =================================================================
--  Environment Package Specification
--  =================================================================
--
--  Manages game environment: air, water, transitions
--
--  Type-Safe: Enumeration-based environment states
--  =================================================================

package Environment with
   SPARK_Mode => On
is

   --  Environment types
   type Environment_Type is (Air, Water, Transition);

   --  Get environment name
   function To_String (Env : Environment_Type) return String;

   --  Get physics multipliers for environment
   function Gravity_Multiplier (Env : Environment_Type) return Float;
   function Drag_Multiplier (Env : Environment_Type) return Float;

end Environment;
