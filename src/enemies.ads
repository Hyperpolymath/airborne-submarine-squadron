--  =================================================================
--  Enemies Package Specification
--  =================================================================
--
--  Manages enemy entities: aircraft, submarines, ships, creatures
--
--  Type-Safe: Enumeration-based enemy types
--  Memory-Safe: Bounded arrays, SPARK-verified
--  =================================================================

with Submarine;

package Enemies with
   SPARK_Mode => On
is

   --  Maximum concurrent enemies
   Max_Enemies : constant := 50;

   --  Enemy types
   type Enemy_Type is (
      Fighter_Plane,    --  Air enemy
      Enemy_Sub,        --  Underwater enemy
      Surface_Ship,     --  Surface vessel
      Sea_Creature,     --  Underwater creature
      Bomber            --  Heavy air enemy
   );

   --  Enemy state
   type Enemy_State is (Inactive, Patrolling, Attacking, Fleeing, Destroyed);

   --  Enemy entity (private)
   type Enemy_Entity is private;

   --  Enemy array
   type Enemy_Index is range 1 .. Max_Enemies;
   type Enemy_Array is array (Enemy_Index) of Enemy_Entity;

   --  Enemy management system
   type Enemy_System is private;

   --  Initialize enemy system
   function Create return Enemy_System;

   --  Spawn enemy at position
   procedure Spawn
      (System       : in out Enemy_System;
       Enemy_Type_Val : Enemy_Type;
       X            : Submarine.Coordinate;
       Y            : Submarine.Coordinate);

   --  Update all enemies
   procedure Update_All
      (System  : in out Enemy_System;
       Delta_T : Natural)
   with
      Pre => Delta_T > 0 and Delta_T <= 1000;

   --  Get active enemy count
   function Active_Count (System : Enemy_System) return Natural;

   --  Destroy enemy at index
   procedure Destroy
      (System : in out Enemy_System;
       Index  : Enemy_Index);

private

   --  Enemy health by type
   Fighter_Health   : constant := 25;
   Sub_Health       : constant := 50;
   Ship_Health      : constant := 75;
   Creature_Health  : constant := 30;
   Bomber_Health    : constant := 60;

   --  Enemy implementation
   type Enemy_Entity is record
      State       : Enemy_State := Inactive;
      Enemy_Type  : Enemy_Type := Fighter_Plane;
      X           : Submarine.Coordinate := 0;
      Y           : Submarine.Coordinate := 0;
      VX          : Submarine.Velocity := 0;
      VY          : Submarine.Velocity := 0;
      Health      : Submarine.Health_Points := 100;
      AI_Timer    : Natural := 0;  --  AI decision timer
   end record;

   --  Enemy system implementation
   type Enemy_System is record
      Enemies : Enemy_Array;
   end record;

end Enemies;
