--  =================================================================
--  Weapons Package Specification
--  =================================================================
--
--  Manages weapons: torpedoes, missiles, depth charges, bullets
--
--  Type-Safe: Strong typing for weapon types and projectiles
--  Memory-Safe: SPARK-verified, bounded arrays
--  =================================================================

with Submarine;

package Weapons with
   SPARK_Mode => On
is

   --  Maximum active projectiles
   Max_Projectiles : constant := 100;

   --  Weapon types
   type Weapon_Type is (
      Torpedo,        --  Underwater homing weapon
      Missile,        --  Air-to-air/surface missile
      Depth_Charge,   --  Drops vertically underwater
      Machine_Gun     --  Rapid-fire bullets
   );

   --  Projectile state
   type Projectile_State is (Inactive, Active, Exploding);

   --  Projectile type (private)
   type Projectile_Type is private;

   --  Projectile array
   type Projectile_Index is range 1 .. Max_Projectiles;
   type Projectile_Array is array (Projectile_Index) of Projectile_Type;

   --  Weapons system state
   type Weapons_System is private;

   --  Initialize weapons system
   function Create return Weapons_System;

   --  Fire weapon from submarine
   procedure Fire
      (System : in out Weapons_System;
       Sub    : Submarine.Submarine_Type;
       Weapon : Weapon_Type);

   --  Update all projectiles
   procedure Update_All
      (System  : in out Weapons_System;
       Delta_T : Natural)
   with
      Pre => Delta_T > 0 and Delta_T <= 1000;

   --  Get active projectile count
   function Active_Count (System : Weapons_System) return Natural;

   --  Check if weapon is ready to fire (cooldown)
   function Is_Ready
      (System : Weapons_System;
       Weapon : Weapon_Type)
      return Boolean;

private

   --  Projectile damage values
   Torpedo_Damage       : constant := 50;
   Missile_Damage       : constant := 40;
   Depth_Charge_Damage  : constant := 60;
   Machine_Gun_Damage   : constant := 5;

   --  Weapon cooldowns (milliseconds)
   Torpedo_Cooldown      : constant := 2000;  --  2 seconds
   Missile_Cooldown      : constant := 1500;  --  1.5 seconds
   Depth_Charge_Cooldown : constant := 3000;  --  3 seconds
   Machine_Gun_Cooldown  : constant := 100;   --  0.1 seconds

   --  Projectile implementation
   type Projectile_Type is record
      State    : Projectile_State := Inactive;
      Weapon   : Weapon_Type := Torpedo;
      X        : Submarine.Coordinate := 0;
      Y        : Submarine.Coordinate := 0;
      VX       : Submarine.Velocity := 0;
      VY       : Submarine.Velocity := 0;
      Lifetime : Natural := 0;  --  Milliseconds
   end record;

   --  Weapons system implementation
   type Weapons_System is record
      Projectiles       : Projectile_Array;
      Torpedo_Cooldown_Remaining      : Natural := 0;
      Missile_Cooldown_Remaining      : Natural := 0;
      Depth_Charge_Cooldown_Remaining : Natural := 0;
      Machine_Gun_Cooldown_Remaining  : Natural := 0;
   end record;

end Weapons;
