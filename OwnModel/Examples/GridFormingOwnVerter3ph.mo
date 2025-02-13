within OwnModel.Examples;

model GridFormingOwnVerter3ph "OwnVerter board used as three-phase inverter, with grid forming current control"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vdc = 50 "DC bus voltage, should be > 2Vg";
  parameter SI.Voltage Vg = 20 "Grid voltage amplitude";
  parameter SI.Frequency f0 = 50 "grid frequency";
  parameter SI.Inductance Lf(displayUnit = "uH") = 630e-6 "filter inductance";
  parameter SI.Inductance Lg(displayUnit = "uH") = 100e-6 "grid inductance";
  parameter SI.Resistance Rg = 1 "grid resistance";
  /*Controller parameters */
  parameter SI.Duration Tci(displayUnit = "ms") = 2e-3 "closed loop current control time constant (Skogestad-IMC PI tuning)";
  parameter SI.Resistance kp_current = Lf/Tci "PI proportional gain (unit: Ohms)";
  parameter SI.Duration Ti_current(displayUnit = "ms") = min(Lf/Rg, 4*Tci) "PI integrator time constant";
  /*PLL control tuning by pole placement*/
  parameter SI.Duration rise_time = 0.10;
  parameter SI.AngularFrequency wn = 3.0/rise_time;
  parameter Real xsi = 0.7;
  parameter Real kp_pll = 2*wn*xsi/Vg;
  parameter Real ki_pll = (wn*wn)/Vg;
  parameter SI.Duration Ti_pll = kp_pll/ki_pll;
  /*Set point parameters */
  parameter SI.Duration Tstep(displayUnit = "ms") = 20e-3 "Id,Iq set point step instant";
  parameter SI.Current Id_sp = 1 "Id set point after Tstep";
  parameter SI.Current Iq_sp = 0 "Iq set point after Tstep";
  Components.OwnVerter ownVerter(averaged = true) annotation(
    Placement(transformation(origin = {-4, 0}, extent = {{-20, -20}, {20, 20}})));
  OwnControl.Controllers.CurrentControlDQ3ph currentControl(Vmax = Vdc/2, Vg = Vg, f0 = f0, L = Lf, kp = kp_current, Ti = Ti_current) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  OwnControl.Filters.SRFPLL3ph pll(f0 = f0, kp = kp_pll, Ti = Ti_pll) annotation(
    Placement(transformation(origin = {-110, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage VSin(V = Vdc) annotation(
    Placement(transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-40, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfa(i(fixed = true), L = Lf) "filter inductance" annotation(
    Placement(transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfb(i(fixed = true), L = Lf) "filter inductance" annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfc(i(fixed = false), L = Lf) "filter inductance" annotation(
    Placement(transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rga(R = Rg) "grid resistance" annotation(
    Placement(transformation(origin = {130, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rgb(R = Rg) "grid resistance" annotation(
    Placement(transformation(origin = {130, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rgc(R = Rg) "grid resistance" annotation(
    Placement(transformation(origin = {130, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lga(i(fixed = true), L = Lg) "grid inductance" annotation(
    Placement(transformation(origin = {90, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lgb(i(fixed = true), L = Lg) "grid inductance" annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lgc(i(fixed = false), L = Lg) "grid inductance" annotation(
    Placement(transformation(origin = {90, -20}, extent = {{-10, -10}, {10, 10}})));
  Utilities.VoltageSensor3ph vPCC annotation(
    Placement(transformation(origin = {50, -60}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vga annotation(
    Placement(transformation(origin = {170, 30}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vgb annotation(
    Placement(transformation(origin = {170, 0}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vgc annotation(
    Placement(transformation(origin = {170, -30}, extent = {{-10, 10}, {10, -10}})));
  OwnControl.Utilities.CosinePerturbed3ph vgrid(amplitude_a = Vg, f = f0) annotation(
    Placement(transformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_vg annotation(
    Placement(transformation(origin = {150, -70}, extent = {{-10, -10}, {10, 10}})));
  OwnControl.Controllers.VoltDuty3ph voltDuty3ph(vdc_const = Vdc) annotation(
    Placement(transformation(origin = {-56, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex2 mux_isp(y(each unit = "A")) annotation(
    Placement(transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Id_step(height = Id_sp, startTime = Tstep, y(unit = "A")) annotation(
    Placement(transformation(origin = {-170, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Iq_step(height = Iq_sp, startTime = Tstep, y(unit = "A")) annotation(
    Placement(transformation(origin = {-170, 10}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(pll.ph, currentControl.ph) annotation(
    Line(points = {{-99, -44}, {-90, -44}, {-90, -12}}, color = {0, 0, 127}));
  connect(VSin.p, ownVerter.high) annotation(
    Line(points = {{-40, -20}, {-40, 26}, {-4, 26}, {-4, 20}}, color = {0, 0, 255}));
  connect(VSin.n, ownVerter.gnd) annotation(
    Line(points = {{-40, -40}, {-40, -60}, {-4, -60}, {-4, -20}}, color = {0, 0, 255}));
  connect(ground.p, VSin.n) annotation(
    Line(points = {{-40, -80}, {-40, -40}}, color = {0, 0, 255}));
  connect(Lga.n, Rga.p) annotation(
    Line(points = {{100, 20}, {120, 20}}, color = {0, 0, 255}));
  connect(Lgb.n, Rgb.p) annotation(
    Line(points = {{100, 0}, {120, 0}}, color = {0, 0, 255}));
  connect(Lgc.n, Rgc.p) annotation(
    Line(points = {{100, -20}, {120, -20}}, color = {0, 0, 255}));
  connect(Lfa.n, Lga.p) annotation(
    Line(points = {{60, 20}, {80, 20}}, color = {0, 0, 255}));
  connect(Lfb.n, Lgb.p) annotation(
    Line(points = {{60, 0}, {80, 0}}, color = {0, 0, 255}));
  connect(Lfc.n, Lgc.p) annotation(
    Line(points = {{60, -20}, {80, -20}}, color = {0, 0, 255}));
  connect(ownVerter.low1, Lfa.p) annotation(
    Line(points = {{16, 8}, {30, 8}, {30, 20}, {40, 20}}, color = {0, 0, 255}));
  connect(ownVerter.low2, Lfb.p) annotation(
    Line(points = {{16, 0}, {40, 0}}, color = {0, 0, 255}));
  connect(ownVerter.low3, Lfc.p) annotation(
    Line(points = {{16, -8}, {30, -8}, {30, -20}, {40, -20}}, color = {0, 0, 255}));
  connect(ownVerter.i_abc, currentControl.iabc_m) annotation(
    Line(points = {{18, -16}, {26, -16}, {26, -100}, {-134, -100}, {-134, -4}, {-102, -4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(vPCC.a, Lga.p) annotation(
    Line(points = {{60, -56}, {68, -56}, {68, 20}, {80, 20}}, color = {0, 0, 255}));
  connect(vPCC.b, Lgb.p) annotation(
    Line(points = {{60, -60}, {70, -60}, {70, 0}, {80, 0}}, color = {0, 0, 255}));
  connect(vPCC.c, Lgc.p) annotation(
    Line(points = {{60, -64}, {72, -64}, {72, -20}, {80, -20}}, color = {0, 0, 255}));
  connect(vPCC.n, ground.p) annotation(
    Line(points = {{40, -60}, {30, -60}, {30, -72}, {-20, -72}, {-20, -80}, {-40, -80}}, color = {0, 0, 255}));
  connect(vPCC.vabc, pll.abc) annotation(
    Line(points = {{50, -71}, {50, -93}, {-128, -93}, {-128, -39}, {-124, -39}, {-124, -40}, {-122, -40}, {-122, -39}}, color = {0, 0, 127}, thickness = 0.5));
  connect(Rga.n, Vga.p) annotation(
    Line(points = {{140, 20}, {150, 20}, {150, 30}, {160, 30}}, color = {0, 0, 255}));
  connect(Rgb.n, Vgb.p) annotation(
    Line(points = {{140, 0}, {160, 0}}, color = {0, 0, 255}));
  connect(Rgc.n, Vgc.p) annotation(
    Line(points = {{140, -20}, {150, -20}, {150, -30}, {160, -30}}, color = {0, 0, 255}));
  connect(Vga.n, Vgb.n) annotation(
    Line(points = {{180, 30}, {200, 30}, {200, 0}, {180, 0}}, color = {0, 0, 255}));
  connect(Vgb.n, Vgc.n) annotation(
    Line(points = {{180, 0}, {200, 0}, {200, -30}, {180, -30}}, color = {0, 0, 255}));
  connect(vgrid.abc, demux_vg.u) annotation(
    Line(points = {{121, -70}, {137, -70}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demux_vg.y1[1], Vga.v) annotation(
    Line(points = {{161, -63}, {161, 11}, {169, 11}, {169, 17}}, color = {0, 0, 127}));
  connect(demux_vg.y2[1], Vgb.v) annotation(
    Line(points = {{161, -70}, {163, -70}, {163, -18}, {169, -18}, {169, -12}}, color = {0, 0, 127}));
  connect(demux_vg.y3[1], Vgc.v) annotation(
    Line(points = {{161, -77}, {169, -77}, {169, -43}}, color = {0, 0, 127}));
  connect(voltDuty3ph.duty_abc, ownVerter.duty_abc) annotation(
    Line(points = {{-45, 0}, {-28, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(currentControl.vabc, voltDuty3ph.vabc) annotation(
    Line(points = {{-79, 4}, {-75, 4}, {-75, 0}, {-69, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(Id_step.y, mux_isp.u1[1]) annotation(
    Line(points = {{-159, 50}, {-151, 50}, {-151, 36}, {-143, 36}}, color = {0, 0, 127}));
  connect(Iq_step.y, mux_isp.u2[1]) annotation(
    Line(points = {{-159, 10}, {-151, 10}, {-151, 24}, {-143, 24}}, color = {0, 0, 127}));
  connect(mux_isp.y, currentControl.idq_sp) annotation(
    Line(points = {{-119, 30}, {-113, 30}, {-113, 4}, {-103, 4}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(graphics = {Text(origin = {-20, 80}, extent = {{-100, 20}, {100, -20}}, textString = "Three-phase grid forming inverter with current control"), Text(origin = {-25, 31}, textColor = {38, 162, 105}, extent = {{-15, 3}, {15, -3}}, textString = "DC bus")}, coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 5.0025e-05));
end GridFormingOwnVerter3ph;