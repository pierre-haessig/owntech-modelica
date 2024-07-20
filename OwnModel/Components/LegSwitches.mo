within OwnModel.Components;

model LegSwitches "Power converter leg, modeled with switches"
extends Interfaces.Leg;


Modelica.Electrical.Analog.Ideal.IdealClosingSwitch s_high "high side switch" annotation(
    Placement(transformation(origin = {0, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch s_low "low side switch" annotation(
    Placement(transformation(origin = {0, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanInput pwm_high annotation(
    Placement(transformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.BooleanInput pwm_low annotation(
    Placement(transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));
equation
  connect(high, s_high.p) annotation(
    Line(points = {{0, 100}, {0, 60}}, color = {0, 0, 255}));
  connect(s_high.n, s_low.p) annotation(
    Line(points = {{0, 40}, {0, -40}}, color = {0, 0, 255}));
  connect(s_low.n, gnd) annotation(
    Line(points = {{0, -60}, {0, -100}}, color = {0, 0, 255}));
  connect(low, s_high.n) annotation(
    Line(points = {{100, 0}, {0, 0}, {0, 40}}, color = {0, 0, 255}));
  connect(pwm_high, s_high.control) annotation(
    Line(points = {{-100, 50}, {-12, 50}}, color = {255, 0, 255}));
  connect(pwm_low, s_low.control) annotation(
    Line(points = {{-100, -50}, {-12, -50}}, color = {255, 0, 255}));

end LegSwitches;