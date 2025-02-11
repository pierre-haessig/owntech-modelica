within OwnModel.Examples;

model Buck "TWIST board used as a buck (step down) DC/DC converter supplying a resistive load"
  extends Modelica.Icons.Example;
  parameter Boolean closed_loop = true "closed loop voltage control if true, else open loop (constant duty cycle)";
  Components.TWIST twist(averaged = true) annotation(
    Placement(transformation(origin = {40, -20}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {40, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor load(R = 47) annotation(
    Placement(transformation(origin = {80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage VSin(V = 20) "DC input source" annotation(
    Placement(transformation(origin = {-20, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant constDuty(k = 0.75) "constant duty cycle reference" annotation(
    Placement(transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID ctrl(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.000215, Ti = 7.5175e-5, yMax = 1, yMin = 0, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.6) "voltage control" annotation(
    Placement(transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.Switch switch annotation(
    Placement(transformation(origin = {-48, 16}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Sources.BooleanExpression switchSelect(y = closed_loop) annotation(
    Placement(transformation(origin = {-90, 16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vLoad annotation(
    Placement(transformation(origin = {100, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Step stepVolt(height = 0.5, offset = 12, startTime = 0.2) annotation(
    Placement(transformation(origin = {-144, -10}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ground.p, twist.gnd) annotation(
    Line(points = {{40, -80}, {40, -40}}, color = {0, 0, 255}));
  connect(load.n, ground.p) annotation(
    Line(points = {{80, -40}, {80, -60}, {40, -60}, {40, -80}}, color = {0, 0, 255}));
  connect(VSin.n, ground.p) annotation(
    Line(points = {{-20, -20}, {-20, -60}, {40, -60}, {40, -80}}, color = {0, 0, 255}));
  connect(twist.low1, load.p) annotation(
    Line(points = {{60, -12}, {72, -12}, {72, -20}, {80, -20}}, color = {0, 0, 255}));
  connect(twist.low1, twist.low2) annotation(
    Line(points = {{60, -12}, {72, -12}, {72, -28}, {60, -28}}, color = {0, 0, 255}));
  connect(VSin.p, twist.high) annotation(
    Line(points = {{-20, 0}, {-20, 20}, {40, 20}, {40, 0}}, color = {0, 0, 255}));
  connect(switchSelect.y, switch.u2) annotation(
    Line(points = {{-79, 16}, {-60, 16}}, color = {255, 0, 255}));
  connect(ctrl.y, switch.u1) annotation(
    Line(points = {{-79, -10}, {-68, -10}, {-68, 8}, {-60, 8}}, color = {0, 0, 127}));
  connect(switch.y, twist.duty2) annotation(
    Line(points = {{-37, 16}, {-3, 16}, {-3, -28}, {15, -28}}, color = {0, 0, 127}));
  connect(twist.duty1, switch.y) annotation(
    Line(points = {{16, -12}, {0, -12}, {0, 16}, {-36, 16}}, color = {0, 0, 127}));
  connect(constDuty.y, switch.u3) annotation(
    Line(points = {{-79, 50}, {-69, 50}, {-69, 24}, {-61, 24}}, color = {0, 0, 127}));
  connect(vLoad.p, load.p) annotation(
    Line(points = {{100, -20}, {80, -20}}, color = {0, 0, 255}));
  connect(vLoad.n, load.n) annotation(
    Line(points = {{100, -40}, {80, -40}}, color = {0, 0, 255}));
  connect(vLoad.v, ctrl.u_m) annotation(
    Line(points = {{112, -30}, {128, -30}, {128, -100}, {-90, -100}, {-90, -22}}, color = {0, 0, 127}));
  connect(stepVolt.y, ctrl.u_s) annotation(
    Line(points = {{-133, -10}, {-102, -10}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 0.01, Tolerance = 1e-06, Interval = 1e-06));
end Buck;