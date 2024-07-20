within OwnModel.Interfaces;

partial model ModulatedLeg "Interface for Power converter leg with its PWM modulator"
  extends Leg;
  parameter SI.Frequency f_pwm(displayUnit="kHz")=200e3 "PWM switching frequency";
  Modelica.Blocks.Interfaces.RealInput duty "duty cycle of high switch" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
equation

end ModulatedLeg;