within OwnModel.Components;

model AvgLeg "Averaged model of Power converter leg with its PWM modulator"
  extends Interfaces.ModulatedLeg;
  Real duty_eff "effective duty cycle (limited & lagged)";
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0)  annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.FirstOrder lag(T = 0.5/f_pwm)  "PWM lag modeled as first order low pass filter T=1/f_pwm" annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  duty_eff = lag.y;
  /*Ideal transformer equations*/
  v_low = v_high*duty_eff;
  i_high = i_low*duty_eff;
  high.i + low.i + gnd.i = 0;
  connect(duty, limiter.u) annotation(
    Line(points = {{-120, 0}, {-82, 0}}, color = {0, 0, 127}));
  connect(limiter.y, lag.u) annotation(
    Line(points = {{-58, 0}, {-42, 0}}, color = {0, 0, 127}));
annotation(
    Diagram(graphics = {Text(origin = {5, 0}, extent = {{-15, 6}, {15, -6}}, textString = "duty_eff")}),
  Icon(graphics = {Text(origin = {-50, 180}, extent = {{-50, 20}, {50, -20}}, textString = "avg")}));
end AvgLeg;