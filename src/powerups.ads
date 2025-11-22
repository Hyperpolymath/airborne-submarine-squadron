--  =================================================================
--  Powerups Package Specification
--  =================================================================
--
--  Manages collectible powerups: health, weapons, speed, shields
--
--  Type-Safe: Enumeration-based powerup types
--  Memory-Safe: Bounded arrays
--  =================================================================

with Submarine;

package Powerups with
   SPARK_Mode => On
is

   --  Maximum active powerups
   Max_Powerups : constant := 20;

   --  Powerup types
   type Powerup_Type is (
      Health_Pack,      --  Restore health
      Weapon_Upgrade,   --  Improved weapons
      Speed_Boost,      --  Temporary speed increase
      Shield,           --  Temporary invulnerability
      Ammo_Refill       --  Reload ammunition
   );

   --  Powerup state
   type Powerup_State is (Inactive, Active, Collected);

   --  Powerup entity (private)
   type Powerup_Entity is private;

   --  Powerup array
   type Powerup_Index is range 1 .. Max_Powerups;
   type Powerup_Array is array (Powerup_Index) of Powerup_Entity;

   --  Powerup system
   type Powerup_System is private;

   --  Initialize powerup system
   function Create return Powerup_System;

   --  Spawn powerup
   procedure Spawn
      (System        : in out Powerup_System;
       Powerup_Type_Val : Powerup_Type;
       X             : Submarine.Coordinate;
       Y             : Submarine.Coordinate);

   --  Update all powerups
   procedure Update_All
      (System  : in out Powerup_System;
       Delta_T : Natural)
   with
      Pre => Delta_T > 0 and Delta_T <= 1000;

   --  Get active powerup count
   function Active_Count (System : Powerup_System) return Natural;

private

   --  Powerup implementation
   type Powerup_Entity is record
      State        : Powerup_State := Inactive;
      Powerup_Type : Powerup_Type := Health_Pack;
      X            : Submarine.Coordinate := 0;
      Y            : Submarine.Coordinate := 0;
      Lifetime     : Natural := 10000;  --  10 seconds default
   end record;

   --  System implementation
   type Powerup_System is record
      Powerups : Powerup_Array;
   end record;

end Powerups;
