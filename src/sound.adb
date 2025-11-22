--  =================================================================
--  Sound Package Implementation
--  =================================================================
--
--  Stub implementation - future work: SDL_Mixer or similar
--  =================================================================

with Ada.Text_IO;

package body Sound with
   SPARK_Mode => On
is

   --  Initialize sound system
   function Create return Sound_System is
      System : Sound_System;
   begin
      return System;
   end Create;

   --  Play music with crossfade
   procedure Play_Music
      (System : in out Sound_System;
       Track  : Music_Type;
       Fade_Time : Natural := 1000)
   is
      use Ada.Text_IO;
   begin
      if not System.Muted then
         Put_Line ("[SOUND] Crossfading to: " & Track'Image);
      end if;

      System.Target_Music := Track;
      System.Crossfade_Remaining := Fade_Time;
   end Play_Music;

   --  Play sound effect
   procedure Play_Sound
      (System : in out Sound_System;
       Effect : Sound_Effect_Type)
   is
      use Ada.Text_IO;
   begin
      if not System.Muted then
         Put_Line ("[SOUND] Playing SFX: " & Effect'Image);
      end if;
   end Play_Sound;

   --  Update sound system
   procedure Update
      (System  : in out Sound_System;
       Delta_T : Natural)
   is
   begin
      --  Update crossfade
      if System.Crossfade_Remaining > 0 then
         if System.Crossfade_Remaining > Delta_T then
            System.Crossfade_Remaining := System.Crossfade_Remaining - Delta_T;
         else
            System.Crossfade_Remaining := 0;
            System.Current_Music := System.Target_Music;
         end if;
      end if;
   end Update;

   --  Set muted
   procedure Set_Muted
      (System : in out Sound_System;
       Muted  : Boolean)
   is
   begin
      System.Muted := Muted;
   end Set_Muted;

   --  Check muted
   function Is_Muted (System : Sound_System) return Boolean is
      (System.Muted);

end Sound;
