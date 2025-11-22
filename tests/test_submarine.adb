--  =================================================================
--  Test Suite - Submarine Package
--  =================================================================
--
--  Unit tests for Submarine package
--  Uses simple assertions (AUnit would be used in production)
--  =================================================================

with Ada.Text_IO;
with Submarine;

procedure Test_Submarine is
   use Ada.Text_IO;
   use Submarine;

   Test_Count : Natural := 0;
   Pass_Count : Natural := 0;

   procedure Assert (Condition : Boolean; Message : String) is
   begin
      Test_Count := Test_Count + 1;
      if Condition then
         Pass_Count := Pass_Count + 1;
         Put_Line ("  ✅ PASS: " & Message);
      else
         Put_Line ("  ❌ FAIL: " & Message);
      end if;
   end Assert;

   Sub : Submarine_Type;

begin
   Put_Line ("=================================================");
   Put_Line ("  Submarine Package - Unit Tests");
   Put_Line ("=================================================");
   New_Line;

   --  Test 1: Submarine creation
   Put_Line ("[Test 1] Submarine Creation");
   Sub := Create (X => 100, Y => 100, Name => "TestSub");
   Assert (Get_X (Sub) = 100, "Initial X position correct");
   Assert (Get_Y (Sub) = 100, "Initial Y position correct");
   Assert (Get_Health (Sub) = 100, "Initial health is 100");
   Assert (Get_Name (Sub) = "TestSub", "Name stored correctly");
   New_Line;

   --  Test 2: Submarine movement
   Put_Line ("[Test 2] Submarine Movement");
   Sub := Create (X => 100, Y => 100, Name => "MoveSub");
   Update (Sub, Delta_T => 16);  --  One frame at 60 FPS
   Assert (Get_Y (Sub) > 100, "Submarine falls due to gravity");
   New_Line;

   --  Test 3: Health and damage
   Put_Line ("[Test 3] Health and Damage");
   Sub := Create (X => 100, Y => 100, Name => "DamageSub");
   Take_Damage (Sub, Amount => 25);
   Assert (Get_Health (Sub) = 75, "Submarine takes 25 damage correctly");
   Take_Damage (Sub, Amount => 100);  --  Overkill
   Assert (Get_Health (Sub) = 0, "Health doesn't go below 0");
   New_Line;

   --  Test 4: Buoyancy effect
   Put_Line ("[Test 4] Buoyancy Effect");
   Sub := Create (X => 100, Y => 100, Name => "BuoySub");
   Update (Sub, Delta_T => 16);
   declare
      Y_Before_Buoyancy : constant Coordinate := Get_Y (Sub);
   begin
      Apply_Buoyancy (Sub);
      Assert (Get_VY (Sub) < 10, "Buoyancy reduces vertical velocity");
   end;
   New_Line;

   --  Test 5: Position bounds
   Put_Line ("[Test 5] Position Bounds");
   Sub := Create (X => 9999, Y => 9999, Name => "BoundsSub");
   Assert (Get_X (Sub) in Coordinate'Range, "X position within valid range");
   Assert (Get_Y (Sub) in Coordinate'Range, "Y position within valid range");
   New_Line;

   --  Summary
   Put_Line ("=================================================");
   Put_Line ("  Test Summary");
   Put_Line ("=================================================");
   Put_Line ("  Total Tests: " & Natural'Image (Test_Count));
   Put_Line ("  Passed:      " & Natural'Image (Pass_Count));
   Put_Line ("  Failed:      " & Natural'Image (Test_Count - Pass_Count));
   New_Line;

   if Pass_Count = Test_Count then
      Put_Line ("  ✅ ALL TESTS PASSED!");
   else
      Put_Line ("  ❌ SOME TESTS FAILED");
   end if;

   Put_Line ("=================================================");

end Test_Submarine;
