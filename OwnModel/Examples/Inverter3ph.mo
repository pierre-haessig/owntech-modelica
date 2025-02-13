within OwnModel.Examples;

model Inverter3ph "OwnVerter board used as a three-phase inverter feeding an RL load in open loop"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vdc = 50 "DC bus voltage, should be > 2Vg";
  parameter SI.Voltage Vi = 20 "Desired inverter voltage amplitude";
  parameter SI.Frequency f0 = 50 "Inverter voltage frequency";
  parameter SI.Inductance Lf(displayUnit = "uH") = 630e-6 "filter inductance";
  parameter SI.Inductance L(displayUnit = "uH") = 100e-6 "load inductance";
  parameter SI.Resistance R = 10 "load resistance";
  Components.OwnVerter ownVerter(averaged = false, f_pwm = 1e4) annotation(
    Placement(transformation(origin = {-40, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage VSin(V = Vdc) annotation(
    Placement(transformation(origin = {-80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-60, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfa(i(fixed = true), L = Lf) "filter inductance" annotation(
    Placement(transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfb(i(fixed = true), L = Lf) "filter inductance" annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfc(i(fixed = true), L = Lf) "filter inductance" annotation(
    Placement(transformation(origin = {10, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Ra(R = R) "load resistance" annotation(
    Placement(transformation(origin = {90, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rb(R = R) "load resistance" annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rc(R = R) "load resistance" annotation(
    Placement(transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor La(i(fixed = true), L = L) "load inductance" annotation(
    Placement(transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lb(i(fixed = true), L = L) "load inductance" annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lc(i(fixed = true), L = L) "load inductance" annotation(
    Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  Utilities.VoltageSensor3ph vload_dclow "load voltage with respect to DC low side" annotation(
    Placement(transformation(origin = {10, -60}, extent = {{10, -10}, {-10, 10}})));
  OwnControl.Controllers.VoltDuty3ph voltDuty3ph(vdc_const = Vdc) annotation(
    Placement(transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}})));
  OwnControl.Utilities.CosinePerturbed3ph v_inv(amplitude_a = Vi, f = f0) "desired three-phase inverter voltages" annotation(
    Placement(transformation(origin = {-140, 30}, extent = {{-10, -10}, {10, 10}})));
  Utilities.VoltageSensor3ph vload_n "load voltage with respect to neutral" annotation(
    Placement(transformation(origin = {50, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vn_dclow "neutral point voltage with respect to DC low side" annotation(
    Placement(transformation(origin = {90, -80}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(VSin.p, ownVerter.high) annotation(
    Line(points = {{-80, -20}, {-80, 26}, {-40, 26}, {-40, 20}}, color = {0, 0, 255}));
  connect(VSin.n, ownVerter.gnd) annotation(
    Line(points = {{-80, -40}, {-80, -72}, {-40, -72}, {-40, -20}}, color = {0, 0, 255}));
  connect(ground.p, VSin.n) annotation(
    Line(points = {{-60, -80}, {-60, -72}, {-80, -72}, {-80, -40}}, color = {0, 0, 255}));
  connect(La.n, Ra.p) annotation(
    Line(points = {{60, 20}, {80, 20}}, color = {0, 0, 255}));
  connect(Lb.n, Rb.p) annotation(
    Line(points = {{60, 0}, {80, 0}}, color = {0, 0, 255}));
  connect(Lc.n, Rc.p) annotation(
    Line(points = {{60, -20}, {80, -20}}, color = {0, 0, 255}));
  connect(Lfa.n, La.p) annotation(
    Line(points = {{20, 20}, {40, 20}}, color = {0, 0, 255}));
  connect(Lfb.n, Lb.p) annotation(
    Line(points = {{20, 0}, {40, 0}}, color = {0, 0, 255}));
  connect(Lfc.n, Lc.p) annotation(
    Line(points = {{20, -20}, {40, -20}}, color = {0, 0, 255}));
  connect(ownVerter.low1, Lfa.p) annotation(
    Line(points = {{-20, 8}, {-10, 8}, {-10, 20}, {0, 20}}, color = {0, 0, 255}));
  connect(ownVerter.low2, Lfb.p) annotation(
    Line(points = {{-20, 0}, {0, 0}}, color = {0, 0, 255}));
  connect(ownVerter.low3, Lfc.p) annotation(
    Line(points = {{-20, -8}, {-10, -8}, {-10, -20}, {0, -20}}, color = {0, 0, 255}));
  connect(vload_dclow.a, La.p) annotation(
    Line(points = {{20, -56}, {28, -56}, {28, 20}, {40, 20}}, color = {0, 0, 255}));
  connect(vload_dclow.b, Lb.p) annotation(
    Line(points = {{20, -60}, {30, -60}, {30, 0}, {40, 0}}, color = {0, 0, 255}));
  connect(vload_dclow.c, Lc.p) annotation(
    Line(points = {{20, -64}, {32, -64}, {32, -20}, {40, -20}}, color = {0, 0, 255}));
  connect(vload_dclow.n, ground.p) annotation(
    Line(points = {{0, -60}, {-10, -60}, {-10, -72}, {-60, -72}, {-60, -80}}, color = {0, 0, 255}));
  connect(voltDuty3ph.duty_abc, ownVerter.duty_abc) annotation(
    Line(points = {{-99, 30}, {-90.5, 30}, {-90.5, 0}, {-64, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(Ra.n, Rb.n) annotation(
    Line(points = {{100, 20}, {120, 20}, {120, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(Rb.n, Rc.n) annotation(
    Line(points = {{100, 0}, {120, 0}, {120, -20}, {100, -20}}, color = {0, 0, 255}));
  connect(vload_n.a, vload_dclow.a) annotation(
    Line(points = {{40, -56}, {20, -56}}, color = {0, 0, 255}));
  connect(vload_n.b, vload_dclow.b) annotation(
    Line(points = {{40, -60}, {20, -60}}, color = {0, 0, 255}));
  connect(vload_n.c, vload_dclow.c) annotation(
    Line(points = {{40, -64}, {20, -64}}, color = {0, 0, 255}));
  connect(vload_n.n, Rb.n) annotation(
    Line(points = {{60, -60}, {120, -60}, {120, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(vn_dclow.n, ground.p) annotation(
    Line(points = {{80, -80}, {-10, -80}, {-10, -72}, {-60, -72}, {-60, -80}}, color = {0, 0, 255}));
  connect(vn_dclow.p, Rc.n) annotation(
    Line(points = {{100, -80}, {120, -80}, {120, -20}, {100, -20}}, color = {0, 0, 255}));
  connect(v_inv.abc, voltDuty3ph.vabc) annotation(
    Line(points = {{-129, 30}, {-122, 30}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(graphics = {Text(origin = {0, 85}, extent = {{-100, 15}, {100, -15}}, textString = "Three-phase inverter in open loop"), Text(origin = {-62, 31}, textColor = {38, 162, 105}, extent = {{-16, 3}, {16, -3}}, textString = "DC bus"), Text(origin = {0, -110}, extent = {{-100, 10}, {100, -10}}, textString = "For simulation speed and plot clarity, the PWM frequency is reduced to 10 kHz.
To increase it to 200 kHz, the solver timestep should be reduced proportionally
(to maintain at least about 10 pts/switching period)", horizontalAlignment = TextAlignment.Left), Text(origin = {-116, 52}, textColor = {38, 162, 105}, extent = {{-32, 4}, {32, -4}}, textString = "desired voltages → duty cycles"), Text(origin = {70, 37}, textColor = {38, 162, 105}, extent = {{-16, 3}, {16, -3}}, textString = "RL load")}, coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    experiment(StartTime = 0, StopTime = 0.02, Tolerance = 1e-06, Interval = 1e-05));
end Inverter3ph;