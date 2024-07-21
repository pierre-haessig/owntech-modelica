within OwnModel.Components;

model TWIST "TWIST Power converter board, with PWM control"
    parameter Boolean averaged = false "averaged model if true, else switched model";

Modelica.Electrical.Analog.Interfaces.NegativePin gnd "ground (DC bus -)" annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}})));
   Modelica.Electrical.Analog.Interfaces.PositivePin high "high side of leg (DC bus +)" annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin low1 "low side of leg 1 (mid point)" annotation(
    Placement(transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin low2 "low side of leg 2 (mid point)" annotation(
    Placement(transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput duty1 "duty cycle of leg 1" annotation(
    Placement(transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}})));
Modelica.Blocks.Interfaces.RealInput duty2 "duty cycle of leg 2" annotation(
    Placement(transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));

  
  Components.PWMorAvgLeg leg1(averaged = averaged)  "power leg 1" annotation(
    Placement(transformation(origin = {-20, 40}, extent = {{-10, -20}, {10, 20}})));
  Components.PWMorAvgLeg leg2(averaged = averaged)  "power leg 2" annotation(
    Placement(transformation(origin = {40, -40}, extent = {{-10, -20}, {10, 20}})));
  LCFilter filter1(final rC = 0)  "output LC filter of leg 1" annotation(
    Placement(transformation(origin = {70, 40}, extent = {{-10, -10}, {10, 10}})));
  LCFilter filter2(final rC = 0)  "output LC filter of leg 2" annotation(
    Placement(transformation(origin = {70, -40}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(leg1.gnd, gnd) annotation(
    Line(points = {{-20, 20}, {-20, -80}, {0, -80}, {0, -100}}, color = {0, 0, 255}));
  connect(leg2.gnd, gnd) annotation(
    Line(points = {{40, -60}, {40, -80}, {0, -80}, {0, -100}}, color = {0, 0, 255}));
  connect(high, leg1.high) annotation(
    Line(points = {{0, 100}, {0, 80}, {-20, 80}, {-20, 60}}, color = {0, 0, 255}));
  connect(high, leg2.high) annotation(
    Line(points = {{0, 100}, {0, 80}, {40, 80}, {40, -20}}, color = {0, 0, 255}));
  connect(leg1.low, filter1.hf) annotation(
    Line(points = {{-10, 40}, {60, 40}}, color = {0, 0, 255}));
  connect(leg2.low, filter2.hf) annotation(
    Line(points = {{50, -40}, {60, -40}}, color = {0, 0, 255}));
  connect(filter1.lf, low1) annotation(
    Line(points = {{80, 40}, {100, 40}}, color = {0, 0, 255}));
  connect(filter2.lf, low2) annotation(
    Line(points = {{80, -40}, {100, -40}}, color = {0, 0, 255}));
  connect(filter1.gnd, leg1.gnd) annotation(
    Line(points = {{70, 30}, {70, 20}, {-20, 20}}, color = {0, 0, 255}));
  connect(filter2.gnd, leg2.gnd) annotation(
    Line(points = {{70, -50}, {70, -60}, {40, -60}}, color = {0, 0, 255}));
  connect(duty1, leg1.duty) annotation(
    Line(points = {{-120, 40}, {-32, 40}}, color = {0, 0, 127}));
  connect(duty2, leg2.duty) annotation(
    Line(points = {{-120, -40}, {28, -40}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 40}, extent = {{-80, 40}, {80, -40}}, textString = "TWIST"), Text(origin = {0, -60}, extent = {{-90, 20}, {90, -20}}, textString = "averaged: %averaged")}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end TWIST;