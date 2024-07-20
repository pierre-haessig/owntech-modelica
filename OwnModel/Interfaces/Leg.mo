within OwnModel.Interfaces;

partial model Leg "Interface for Power converter leg"
  Modelica.Electrical.Analog.Interfaces.PositivePin high "high side of leg (DC bus +)" annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 200}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin low "low side of the leg (mid point)" annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin gnd "ground (DC bus -)" annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -200}, extent = {{-10, -10}, {10, 10}})));
  
annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 200}, {100, -200}}), Line(origin = {10.1708, 128.829}, points = {{-10.1708, 69.1708}, {-10.1708, -8.8292}, {9.82918, -68.8292}}), Line(origin = {10.3653, -31.1326}, points = {{-10.1708, 91.1708}, {-10.1708, -28.8292}, {9.82918, -88.8292}}), Line(origin = {0, -130}, points = {{0, 10}, {0, -70}}), Line(origin = {50, 36.06}, points = {{-49.9952, -36.064}, {50.0048, -36.064}})}, coordinateSystem(extent = {{-100, -200}, {100, 200}})),
  Diagram(coordinateSystem(extent = {{-100, -200}, {100, 200}})));
end Leg;