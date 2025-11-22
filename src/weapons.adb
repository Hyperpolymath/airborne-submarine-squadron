--  =================================================================
--  Weapons Package Implementation
--  =================================================================

package body Weapons with
   SPARK_Mode => On
is

   --  Initialize weapons system
   function Create return Weapons_System is
      System : Weapons_System;
   begin
      --  All fields initialized by default values
      return System;
   end Create;

   --  Fire weapon from submarine
   procedure Fire
      (System : in out Weapons_System;
       Sub    : Submarine.Submarine_Type;
       Weapon : Weapon_Type)
   is
      --  Find inactive projectile slot
      Fired : Boolean := False;
   begin
      --  Check cooldown
      if not Is_Ready (System, Weapon) then
         return;  --  Weapon not ready
      end if;

      --  Find first inactive slot
      for I in Projectile_Index loop
         if System.Projectiles (I).State = Inactive then
            --  Activate projectile
            System.Projectiles (I).State := Active;
            System.Projectiles (I).Weapon := Weapon;
            System.Projectiles (I).X := Submarine.Get_X (Sub);
            System.Projectiles (I).Y := Submarine.Get_Y (Sub);

            --  Set velocity based on weapon type
            case Weapon is
               when Torpedo =>
                  System.Projectiles (I).VX := 50;
                  System.Projectiles (I).VY := 0;
                  System.Torpedo_Cooldown_Remaining := Torpedo_Cooldown;

               when Missile =>
                  System.Projectiles (I).VX := 60;
                  System.Projectiles (I).VY := -10;  --  Slight upward arc
                  System.Missile_Cooldown_Remaining := Missile_Cooldown;

               when Depth_Charge =>
                  System.Projectiles (I).VX := 0;
                  System.Projectiles (I).VY := 80;  --  Falls quickly
                  System.Depth_Charge_Cooldown_Remaining := Depth_Charge_Cooldown;

               when Machine_Gun =>
                  System.Projectiles (I).VX := 100;
                  System.Projectiles (I).VY := 0;
                  System.Machine_Gun_Cooldown_Remaining := Machine_Gun_Cooldown;
            end case;

            System.Projectiles (I).Lifetime := 5000;  --  5 seconds max lifetime
            Fired := True;
            exit;
         end if;
      end loop;

      --  If no slot found, oldest projectile is dropped (no error)
   end Fire;

   --  Update all projectiles
   procedure Update_All
      (System  : in out Weapons_System;
       Delta_T : Natural)
   is
   begin
      --  Update cooldowns
      if System.Torpedo_Cooldown_Remaining > Delta_T then
         System.Torpedo_Cooldown_Remaining := System.Torpedo_Cooldown_Remaining - Delta_T;
      else
         System.Torpedo_Cooldown_Remaining := 0;
      end if;

      if System.Missile_Cooldown_Remaining > Delta_T then
         System.Missile_Cooldown_Remaining := System.Missile_Cooldown_Remaining - Delta_T;
      else
         System.Missile_Cooldown_Remaining := 0;
      end if;

      if System.Depth_Charge_Cooldown_Remaining > Delta_T then
         System.Depth_Charge_Cooldown_Remaining := System.Depth_Charge_Cooldown_Remaining - Delta_T;
      else
         System.Depth_Charge_Cooldown_Remaining := 0;
      end if;

      if System.Machine_Gun_Cooldown_Remaining > Delta_T then
         System.Machine_Gun_Cooldown_Remaining := System.Machine_Gun_Cooldown_Remaining - Delta_T;
      else
         System.Machine_Gun_Cooldown_Remaining := 0;
      end if;

      --  Update active projectiles
      for I in Projectile_Index loop
         if System.Projectiles (I).State = Active then
            --  Update position
            declare
               New_X : constant Integer := System.Projectiles (I).X + System.Projectiles (I).VX;
               New_Y : constant Integer := System.Projectiles (I).Y + System.Projectiles (I).VY;
            begin
               --  Check bounds
               if New_X in Submarine.Coordinate'Range then
                  System.Projectiles (I).X := New_X;
               else
                  System.Projectiles (I).State := Inactive;  --  Out of bounds
               end if;

               if New_Y in Submarine.Coordinate'Range then
                  System.Projectiles (I).Y := New_Y;
               else
                  System.Projectiles (I).State := Inactive;  --  Out of bounds
               end if;
            end;

            --  Update lifetime
            if System.Projectiles (I).Lifetime > Delta_T then
               System.Projectiles (I).Lifetime := System.Projectiles (I).Lifetime - Delta_T;
            else
               System.Projectiles (I).State := Inactive;  --  Expired
            end if;
         end if;
      end loop;
   end Update_All;

   --  Get active projectile count
   function Active_Count (System : Weapons_System) return Natural is
      Count : Natural := 0;
   begin
      for I in Projectile_Index loop
         if System.Projectiles (I).State = Active then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Active_Count;

   --  Check if weapon is ready to fire
   function Is_Ready
      (System : Weapons_System;
       Weapon : Weapon_Type)
      return Boolean
   is
   begin
      case Weapon is
         when Torpedo =>
            return System.Torpedo_Cooldown_Remaining = 0;
         when Missile =>
            return System.Missile_Cooldown_Remaining = 0;
         when Depth_Charge =>
            return System.Depth_Charge_Cooldown_Remaining = 0;
         when Machine_Gun =>
            return System.Machine_Gun_Cooldown_Remaining = 0;
      end case;
   end Is_Ready;

end Weapons;
