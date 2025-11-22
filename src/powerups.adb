--  =================================================================
--  Powerups Package Implementation
--  =================================================================

package body Powerups with
   SPARK_Mode => On
is

   --  Initialize powerup system
   function Create return Powerup_System is
      System : Powerup_System;
   begin
      return System;
   end Create;

   --  Spawn powerup
   procedure Spawn
      (System        : in out Powerup_System;
       Powerup_Type_Val : Powerup_Type;
       X             : Submarine.Coordinate;
       Y             : Submarine.Coordinate)
   is
   begin
      for I in Powerup_Index loop
         if System.Powerups (I).State = Inactive then
            System.Powerups (I).State := Active;
            System.Powerups (I).Powerup_Type := Powerup_Type_Val;
            System.Powerups (I).X := X;
            System.Powerups (I).Y := Y;
            System.Powerups (I).Lifetime := 10000;  --  10 seconds
            exit;
         end if;
      end loop;
   end Spawn;

   --  Update all powerups
   procedure Update_All
      (System  : in out Powerup_System;
       Delta_T : Natural)
   is
   begin
      for I in Powerup_Index loop
         if System.Powerups (I).State = Active then
            --  Update lifetime
            if System.Powerups (I).Lifetime > Delta_T then
               System.Powerups (I).Lifetime := System.Powerups (I).Lifetime - Delta_T;
            else
               System.Powerups (I).State := Inactive;  --  Expired
            end if;
         end if;
      end loop;
   end Update_All;

   --  Get active powerup count
   function Active_Count (System : Powerup_System) return Natural is
      Count : Natural := 0;
   begin
      for I in Powerup_Index loop
         if System.Powerups (I).State = Active then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Active_Count;

end Powerups;
