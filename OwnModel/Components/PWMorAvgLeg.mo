within OwnModel.Components;

model PWMorAvgLeg "Power converter leg with its PWM modulator that can be selected between averaged or switched model"
  extends Interfaces.ModulatedLeg;
  parameter Boolean averaged = false "averaged model if true, else switched model";
  /*The two alternative models*/
  PWMLeg pwm_leg if not averaged annotation(
    Placement(transformation(origin = {0, 40}, extent = {{-10, -20}, {10, 20}})));
  AvgLeg avg_leg if averaged annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-10, -20}, {10, 20}})));
equation
  if averaged then
    connect(duty, avg_leg.duty);
    connect(high, avg_leg.high);
    connect(low,  avg_leg.low);
    connect(gnd,  avg_leg.gnd);
  else
    connect(duty, pwm_leg.duty);
    connect(high, pwm_leg.high);
    connect(low,  pwm_leg.low);
    connect(gnd,  pwm_leg.gnd);
  end if;
annotation(
    Icon(graphics = {Text(origin = {-50, 160}, extent = {{-50, 40}, {50, -40}}, textString = "avg:
%averaged")}));
end PWMorAvgLeg;