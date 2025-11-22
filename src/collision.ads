--  =================================================================
--  Collision Package Specification
--  =================================================================
--
--  Collision detection between game entities
--
--  Type-Safe: All operations use strong typing
--  =================================================================

with Submarine;

package Collision with
   SPARK_Mode => On
is

   --  Bounding box for collision
   type Bounding_Box is record
      X      : Submarine.Coordinate;
      Y      : Submarine.Coordinate;
      Width  : Positive := 32;
      Height : Positive := 32;
   end record;

   --  Check collision between two bounding boxes (AABB)
   function Check_Collision
      (Box1 : Bounding_Box;
       Box2 : Bounding_Box)
      return Boolean;

   --  Check point-box collision
   function Point_In_Box
      (X   : Submarine.Coordinate;
       Y   : Submarine.Coordinate;
       Box : Bounding_Box)
      return Boolean;

   --  Get distance between two points
   function Distance
      (X1, Y1 : Submarine.Coordinate;
       X2, Y2 : Submarine.Coordinate)
      return Natural;

end Collision;
