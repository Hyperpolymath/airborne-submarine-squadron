--  =================================================================
--  Missions Package Implementation
--  =================================================================

package body Missions with
   SPARK_Mode => On
is

   --  Create new mission
   function Create_Mission
      (Mission_Type_Val : Mission_Type;
       Target_Count     : Natural := 10;
       Time_Limit       : Natural := 300000)
      return Mission_Data
   is
      Mission : Mission_Data;
   begin
      Mission.Mission_Type := Mission_Type_Val;
      Mission.Status := In_Progress;
      Mission.Target_Count := Target_Count;
      Mission.Time_Limit := Time_Limit;
      Mission.Current_Count := 0;
      Mission.Time_Elapsed := 0;
      return Mission;
   end Create_Mission;

   --  Get status
   function Get_Status (Mission : Mission_Data) return Mission_Status is
      (Mission.Status);

   --  Get type
   function Get_Type (Mission : Mission_Data) return Mission_Type is
      (Mission.Mission_Type);

   --  Get progress percentage
   function Get_Progress (Mission : Mission_Data) return Natural is
   begin
      if Mission.Target_Count = 0 then
         return 100;
      end if;

      declare
         Progress : constant Natural :=
            (Mission.Current_Count * 100) / Mission.Target_Count;
      begin
         if Progress > 100 then
            return 100;
         else
            return Progress;
         end if;
      end;
   end Get_Progress;

   --  Update progress
   procedure Update_Progress
      (Mission       : in out Mission_Data;
       Enemies_Destroyed : Natural := 0;
       Time_Elapsed  : Natural := 0)
   is
   begin
      --  Update counts
      Mission.Current_Count := Mission.Current_Count + Enemies_Destroyed;
      Mission.Time_Elapsed := Mission.Time_Elapsed + Time_Elapsed;

      --  Check completion
      case Mission.Mission_Type is
         when Destroy_Targets =>
            if Mission.Current_Count >= Mission.Target_Count then
               Mission.Status := Completed;
            end if;

         when Patrol =>
            if Mission.Time_Elapsed >= Mission.Time_Limit then
               Mission.Status := Completed;
            end if;

         when others =>
            null;  --  Other mission types: TODO
      end case;

      --  Check failure (time limit exceeded for non-patrol)
      if Mission.Mission_Type /= Patrol and
         Mission.Time_Elapsed >= Mission.Time_Limit
      then
         Mission.Status := Failed;
      end if;
   end Update_Progress;

end Missions;
