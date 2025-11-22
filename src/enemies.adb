--  =================================================================
--  Enemies Package Implementation
--  =================================================================

package body Enemies with
   SPARK_Mode => On
is

   --  Initialize enemy system
   function Create return Enemy_System is
      System : Enemy_System;
   begin
      return System;
   end Create;

   --  Spawn enemy at position
   procedure Spawn
      (System       : in out Enemy_System;
       Enemy_Type_Val : Enemy_Type;
       X            : Submarine.Coordinate;
       Y            : Submarine.Coordinate)
   is
   begin
      --  Find inactive slot
      for I in Enemy_Index loop
         if System.Enemies (I).State = Inactive then
            System.Enemies (I).State := Patrolling;
            System.Enemies (I).Enemy_Type := Enemy_Type_Val;
            System.Enemies (I).X := X;
            System.Enemies (I).Y := Y;

            --  Set initial velocity and health based on type
            case Enemy_Type_Val is
               when Fighter_Plane =>
                  System.Enemies (I).VX := -30;
                  System.Enemies (I).VY := 0;
                  System.Enemies (I).Health := Fighter_Health;

               when Enemy_Sub =>
                  System.Enemies (I).VX := -20;
                  System.Enemies (I).VY := 5;
                  System.Enemies (I).Health := Sub_Health;

               when Surface_Ship =>
                  System.Enemies (I).VX := -15;
                  System.Enemies (I).VY := 0;
                  System.Enemies (I).Health := Ship_Health;

               when Sea_Creature =>
                  System.Enemies (I).VX := -25;
                  System.Enemies (I).VY := 10;
                  System.Enemies (I).Health := Creature_Health;

               when Bomber =>
                  System.Enemies (I).VX := -20;
                  System.Enemies (I).VY := 0;
                  System.Enemies (I).Health := Bomber_Health;
            end case;

            System.Enemies (I).AI_Timer := 0;
            exit;  --  Spawned, done
         end if;
      end loop;
   end Spawn;

   --  Update all enemies
   procedure Update_All
      (System  : in out Enemy_System;
       Delta_T : Natural)
   is
   begin
      for I in Enemy_Index loop
         if System.Enemies (I).State /= Inactive and
            System.Enemies (I).State /= Destroyed
         then
            --  Update position
            declare
               New_X : constant Integer := System.Enemies (I).X + System.Enemies (I).VX;
               New_Y : constant Integer := System.Enemies (I).Y + System.Enemies (I).VY;
            begin
               --  Check bounds
               if New_X in Submarine.Coordinate'Range then
                  System.Enemies (I).X := New_X;
               else
                  --  Enemy left screen, deactivate
                  System.Enemies (I).State := Inactive;
               end if;

               if New_Y in Submarine.Coordinate'Range then
                  System.Enemies (I).Y := New_Y;
               else
                  System.Enemies (I).State := Inactive;
               end if;
            end;

            --  Simple AI: Change direction occasionally
            if System.Enemies (I).AI_Timer > 2000 then
               System.Enemies (I).VY := -System.Enemies (I).VY;
               System.Enemies (I).AI_Timer := 0;
            else
               System.Enemies (I).AI_Timer := System.Enemies (I).AI_Timer + Delta_T;
            end if;
         end if;
      end loop;
   end Update_All;

   --  Get active enemy count
   function Active_Count (System : Enemy_System) return Natural is
      Count : Natural := 0;
   begin
      for I in Enemy_Index loop
         if System.Enemies (I).State /= Inactive and
            System.Enemies (I).State /= Destroyed
         then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Active_Count;

   --  Destroy enemy
   procedure Destroy
      (System : in out Enemy_System;
       Index  : Enemy_Index)
   is
   begin
      System.Enemies (Index).State := Destroyed;
      System.Enemies (Index).Health := 0;
      --  Future: Trigger explosion animation
   end Destroy;

end Enemies;
