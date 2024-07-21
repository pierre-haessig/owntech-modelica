within OwnModel.Components;

model PWMLeg "Power converter leg, with its PWM modulator"
  extends Interfaces.ModulatedLeg;
  LegSwitches legSwitches annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -20}, {10, 20}})));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(useConstantDutyCycle = false, f= f_pwm)  annotation(
    Placement(transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(high, legSwitches.high) annotation(
    Line(points = {{0, 100}, {0, 40}, {40, 40}, {40, 20}}, color = {0, 0, 255}));
  connect(legSwitches.gnd, gnd) annotation(
    Line(points = {{40, -20}, {40, -40}, {0, -40}, {0, -100}}, color = {0, 0, 255}));
  connect(legSwitches.low, low) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(pwm.fire, legSwitches.pwm_high) annotation(
    Line(points = {{-36, -18}, {-36, 4}, {28, 4}}, color = {255, 0, 255}));
  connect(pwm.notFire, legSwitches.pwm_low) annotation(
    Line(points = {{-24, -18}, {-24, -8}, {16, -8}}, color = {255, 0, 255}));
  connect(duty, pwm.dutyCycle) annotation(
    Line(points = {{-120, 0}, {-60, 0}, {-60, -30}, {-42, -30}}, color = {0, 0, 127}));
  
  annotation(
    Diagram,
  Icon(graphics = {Text(origin = {-50, 180}, extent = {{-50, 20}, {50, -20}}, textString = "switched")}));
end PWMLeg;