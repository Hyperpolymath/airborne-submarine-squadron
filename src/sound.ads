--  =================================================================
--  Sound Package Specification
--  =================================================================
--
--  Sound system: music, sound effects, crossfading
--  (Stub implementation - real audio integration future work)
--
--  Type-Safe: Enumeration-based sound types
--  =================================================================

package Sound with
   SPARK_Mode => On
is

   --  Music tracks
   type Music_Type is (
      Air_Theme,
      Water_Theme,
      Menu_Theme,
      Victory_Theme,
      Game_Over_Theme
   );

   --  Sound effects
   type Sound_Effect_Type is (
      Torpedo_Fire,
      Missile_Launch,
      Explosion,
      Splash,
      Engine,
      Sonar_Ping,
      Alarm
   );

   --  Sound system state
   type Sound_System is private;

   --  Initialize sound system
   function Create return Sound_System;

   --  Play music with crossfade
   procedure Play_Music
      (System : in out Sound_System;
       Track  : Music_Type;
       Fade_Time : Natural := 1000)  --  Milliseconds
   with
      Pre => Fade_Time <= 10000;

   --  Play sound effect
   procedure Play_Sound
      (System : in out Sound_System;
       Effect : Sound_Effect_Type);

   --  Update sound system (for crossfading)
   procedure Update
      (System  : in out Sound_System;
       Delta_T : Natural)
   with
      Pre => Delta_T > 0 and Delta_T <= 1000;

   --  Mute/unmute
   procedure Set_Muted
      (System : in out Sound_System;
       Muted  : Boolean);

   --  Check if muted
   function Is_Muted (System : Sound_System) return Boolean;

private

   --  Sound system implementation (stub)
   type Sound_System is record
      Current_Music : Music_Type := Menu_Theme;
      Target_Music  : Music_Type := Menu_Theme;
      Crossfade_Remaining : Natural := 0;
      Muted : Boolean := False;
   end record;

end Sound;
