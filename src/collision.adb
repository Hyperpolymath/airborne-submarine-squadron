--  =================================================================
--  Collision Package Implementation
--  =================================================================

package body Collision with
   SPARK_Mode => On
is

   --  AABB collision detection
   function Check_Collision
      (Box1 : Bounding_Box;
       Box2 : Bounding_Box)
      return Boolean
   is
   begin
      return Box1.X < Box2.X + Box2.Width and
             Box1.X + Box1.Width > Box2.X and
             Box1.Y < Box2.Y + Box2.Height and
             Box1.Y + Box1.Height > Box2.Y;
   end Check_Collision;

   --  Point-in-box test
   function Point_In_Box
      (X   : Submarine.Coordinate;
       Y   : Submarine.Coordinate;
       Box : Bounding_Box)
      return Boolean
   is
   begin
      return X >= Box.X and
             X <= Box.X + Box.Width and
             Y >= Box.Y and
             Y <= Box.Y + Box.Height;
   end Point_In_Box;

   --  Manhattan distance (approximation)
   function Distance
      (X1, Y1 : Submarine.Coordinate;
       X2, Y2 : Submarine.Coordinate)
      return Natural
   is
      DX : constant Natural := abs (X1 - X2);
      DY : constant Natural := abs (Y1 - Y2);
   begin
      return DX + DY;
   end Distance;

end Collision;
