--  =================================================================
--  Missions Package Specification
--  =================================================================
--
--  Mission system: objectives, progression, scoring
--
--  Type-Safe: Enumeration-based mission types
--  =================================================================

package Missions with
   SPARK_Mode => On
is

   --  Mission types
   type Mission_Type is (
      Patrol,           --  Survive for time duration
      Destroy_Targets,  --  Destroy N enemies
      Rescue,           --  Collect survivors
      Escort,           --  Protect friendly unit
      Reconnaissance    --  Reach waypoints
   );

   --  Mission status
   type Mission_Status is (Not_Started, In_Progress, Completed, Failed);

   --  Mission data (private)
   type Mission_Data is private;

   --  Create new mission
   function Create_Mission
      (Mission_Type_Val : Mission_Type;
       Target_Count     : Natural := 10;
       Time_Limit       : Natural := 300000)  --  5 minutes default
      return Mission_Data;

   --  Check mission status
   function Get_Status (Mission : Mission_Data) return Mission_Status;

   --  Get mission type
   function Get_Type (Mission : Mission_Data) return Mission_Type;

   --  Get progress (0-100%)
   function Get_Progress (Mission : Mission_Data) return Natural
   with
      Post => Get_Progress'Result in 0 .. 100;

   --  Update mission progress
   procedure Update_Progress
      (Mission       : in out Mission_Data;
       Enemies_Destroyed : Natural := 0;
       Time_Elapsed  : Natural := 0);

private

   --  Mission implementation
   type Mission_Data is record
      Mission_Type  : Mission_Type := Patrol;
      Status        : Mission_Status := Not_Started;
      Target_Count  : Natural := 10;
      Current_Count : Natural := 0;
      Time_Limit    : Natural := 300000;  --  Milliseconds
      Time_Elapsed  : Natural := 0;
   end record;

end Missions;
