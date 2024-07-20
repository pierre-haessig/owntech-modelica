within OwnModel.Examples;

model Buck
  extends Modelica.Icons.Example;
  Components.TWIST twist annotation(
    Placement(transformation(origin = {0, -20}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor load(R = 47)  annotation(
    Placement(transformation(origin = {60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage VSin(V = 20) "DC input source" annotation(
    Placement(transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant const(k = 0.6)  annotation(
    Placement(transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ground.p, twist.gnd) annotation(
    Line(points = {{0, -80}, {0, -40}}, color = {0, 0, 255}));
  connect(load.n, ground.p) annotation(
    Line(points = {{60, -40}, {60, -60}, {0, -60}, {0, -80}}, color = {0, 0, 255}));
  connect(VSin.n, ground.p) annotation(
    Line(points = {{-60, -20}, {-60, -60}, {0, -60}, {0, -80}}, color = {0, 0, 255}));
  connect(twist.low1, load.p) annotation(
    Line(points = {{20, -12}, {32, -12}, {32, -20}, {60, -20}}, color = {0, 0, 255}));
  connect(twist.low1, twist.low2) annotation(
    Line(points = {{20, -12}, {32, -12}, {32, -28}, {20, -28}}, color = {0, 0, 255}));
  connect(VSin.p, twist.high) annotation(
    Line(points = {{-60, 0}, {-60, 20}, {0, 20}, {0, 0}}, color = {0, 0, 255}));
  connect(const.y, twist.duty1) annotation(
    Line(points = {{-78, 50}, {-36, 50}, {-36, -12}, {-24, -12}}, color = {0, 0, 127}));
  connect(twist.duty2, const.y) annotation(
    Line(points = {{-24, -28}, {-36, -28}, {-36, 50}, {-78, 50}}, color = {0, 0, 127}));
end Buck;