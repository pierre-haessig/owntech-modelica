within OwnModel.Examples;

model GridFormingOwnVerter3ph
  extends Modelica.Icons.Example;
  
  parameter SI.Voltage Vdc = 50 "DC bus voltage, should be > 2Vg";
  parameter SI.Voltage Vg = 20 "Grid voltage amplitude";
  parameter SI.Frequency f0 = 50 "grid frequency";
  parameter SI.Inductance Lf(displayUnit="uH")=630e-6 "filter inductance";
  parameter SI.Inductance Lg(displayUnit="uH")=100e-6 "grid inductance";
  parameter SI.Resistance Rg=1 "grid resistance";
  /*Controller parameters */
  parameter SI.Duration Tci(displayUnit = "ms") = 2e-3 "closed loop current control time constant (Skogestad-IMC PI tuning)";
  parameter Real kp_current = Lf/Tci "PI proportional gain (unit: Ohms)";
  parameter SI.Duration Ti_current(displayUnit = "ms") = 4*Tci "PI integrator time constant";
  /*PLL control tuning by pole placement*/
  parameter SI.Duration rise_time = 0.10;
  parameter SI.AngularFrequency wn = 3.0 / rise_time;
  parameter Real xsi = 0.7;
  parameter Real kp_pll = 2 * wn * xsi / Vg;
  parameter Real ki_pll = (wn * wn) /Vg;
  parameter SI.Duration Ti_pll = kp_pll/ki_pll;
  /*Set point parameters */
  parameter SI.Duration Tstep(displayUnit = "ms") = 20e-3 "Id,Iq set point step instant";
  parameter SI.Current Id_sp = 1 "Id set point after Tstep";
  parameter SI.Current Iq_sp = 0 "Iq set point after Tstep";
  
  Components.OwnVerter ownVerter(averaged = true)  annotation(
  Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  OwnControl.Controllers.CurrentControlDQ3ph currentControl(Vmax = Vdc/2, Vg = Vg, f0 = f0, L = Lf, kp = kp_current, Ti = Ti_current)  annotation(
  Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  OwnControl.Filters.SRFPLL3ph pll(f0 = f0, kp = kp_pll, Ti = Ti_pll)  annotation(
  Placement(transformation(origin = {-70, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage VSin(V = 40) annotation(
  Placement(transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
  Placement(transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfa(i(fixed = true), L = Lf)  "filter inductance" annotation(
  Placement(transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfb(i(fixed = true), L = Lf)  "filter inductance" annotation(
  Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lfc(i(fixed = true), L = Lf)  "filter inductance" annotation(
  Placement(transformation(origin = {70, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rga(R = Rg)  "grid resistance" annotation(
  Placement(transformation(origin = {150, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rgb(R = Rg)  "grid resistance" annotation(
  Placement(transformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor Rgc(R = Rg) "grid resistance" annotation(
  Placement(transformation(origin = {150, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lga(i(fixed = true), L = Lg)  "grid inductance" annotation(
  Placement(transformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lgb(i(fixed = true), L = Lg)  "grid inductance" annotation(
  Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor Lgc(i(fixed = true), L = Lg)  "grid inductance" annotation(
  Placement(transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}})));
  Utilities.VoltageSensor3ph vPCC annotation(
  Placement(transformation(origin = {70, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vga annotation(
  Placement(transformation(origin = {190, 30}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vgb annotation(
  Placement(transformation(origin = {190, 0}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vgc annotation(
  Placement(transformation(origin = {190, -30}, extent = {{-10, 10}, {10, -10}})));
  OwnControl.Utilities.CosinePerturbed3ph vgrid(amplitude_a = Vg, f = f0)  annotation(
  Placement(transformation(origin = {130, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_vg annotation(
  Placement(transformation(origin = {170, -70}, extent = {{-10, -10}, {10, 10}})));
  OwnControl.Controllers.VoltDuty3ph voltDuty3ph(vdc_const = Vdc)  annotation(
    Placement(transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex2 mux_isp(y(each unit = "A")) annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Id_step(height = Id_sp, startTime = Tstep, y(unit = "A")) annotation(
    Placement(transformation(origin = {-130, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Iq_step(height = Iq_sp, startTime = Tstep, y(unit = "A")) annotation(
    Placement(transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(pll.ph, currentControl.ph) annotation(
    Line(points = {{-59, -44}, {-50, -44}, {-50, -12}}, color = {0, 0, 127}));
  connect(VSin.p, ownVerter.high) annotation(
    Line(points = {{0, -20}, {0, 20}, {30, 20}, {30, 10}}, color = {0, 0, 255}));
  connect(VSin.n, ownVerter.gnd) annotation(
    Line(points = {{0, -40}, {0, -60}, {30, -60}, {30, -10}}, color = {0, 0, 255}));
  connect(ground.p, VSin.n) annotation(
    Line(points = {{0, -80}, {0, -40}}, color = {0, 0, 255}));
  connect(Lga.n, Rga.p) annotation(
    Line(points = {{120, 20}, {140, 20}}, color = {0, 0, 255}));
  connect(Lgb.n, Rgb.p) annotation(
    Line(points = {{120, 0}, {140, 0}}, color = {0, 0, 255}));
  connect(Lgc.n, Rgc.p) annotation(
    Line(points = {{120, -20}, {140, -20}}, color = {0, 0, 255}));
  connect(Lfa.n, Lga.p) annotation(
    Line(points = {{80, 20}, {100, 20}}, color = {0, 0, 255}));
  connect(Lfb.n, Lgb.p) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(Lfc.n, Lgc.p) annotation(
    Line(points = {{80, -20}, {100, -20}}, color = {0, 0, 255}));
  connect(ownVerter.low1, Lfa.p) annotation(
    Line(points = {{40, 4}, {50, 4}, {50, 20}, {60, 20}}, color = {0, 0, 255}));
  connect(ownVerter.low2, Lfb.p) annotation(
    Line(points = {{40, 0}, {60, 0}}, color = {0, 0, 255}));
  connect(ownVerter.low3, Lfc.p) annotation(
    Line(points = {{40, -4}, {50, -4}, {50, -20}, {60, -20}}, color = {0, 0, 255}));
  connect(ownVerter.i_abc, currentControl.iabc_m) annotation(
    Line(points = {{42, -8}, {46, -8}, {46, -100}, {-100, -100}, {-100, -4}, {-62, -4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(vPCC.a, Lga.p) annotation(
    Line(points = {{80, -56}, {88, -56}, {88, 20}, {100, 20}}, color = {0, 0, 255}));
  connect(vPCC.b, Lgb.p) annotation(
    Line(points = {{80, -60}, {90, -60}, {90, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(vPCC.c, Lgc.p) annotation(
    Line(points = {{80, -64}, {92, -64}, {92, -20}, {100, -20}}, color = {0, 0, 255}));
  connect(vPCC.n, ground.p) annotation(
    Line(points = {{60, -60}, {50, -60}, {50, -72}, {0, -72}, {0, -80}}, color = {0, 0, 255}));
  connect(vPCC.vabc, pll.abc) annotation(
    Line(points = {{70, -70}, {70, -94}, {-90, -94}, {-90, -38}, {-82, -38}}, color = {0, 0, 127}, thickness = 0.5));
  connect(Rga.n, Vga.p) annotation(
    Line(points = {{160, 20}, {170, 20}, {170, 30}, {180, 30}}, color = {0, 0, 255}));
  connect(Rgb.n, Vgb.p) annotation(
    Line(points = {{160, 0}, {180, 0}}, color = {0, 0, 255}));
  connect(Rgc.n, Vgc.p) annotation(
    Line(points = {{160, -20}, {170, -20}, {170, -30}, {180, -30}}, color = {0, 0, 255}));
  connect(Vga.n, Vgb.n) annotation(
    Line(points = {{200, 30}, {220, 30}, {220, 0}, {200, 0}}, color = {0, 0, 255}));
  connect(Vgb.n, Vgc.n) annotation(
    Line(points = {{200, 0}, {220, 0}, {220, -30}, {200, -30}}, color = {0, 0, 255}));
  connect(vgrid.abc, demux_vg.u) annotation(
    Line(points = {{142, -70}, {158, -70}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demux_vg.y1[1], Vga.v) annotation(
    Line(points = {{182, -62}, {182, 12}, {190, 12}, {190, 18}}, color = {0, 0, 127}));
  connect(demux_vg.y2[1], Vgb.v) annotation(
    Line(points = {{182, -70}, {184, -70}, {184, -18}, {190, -18}, {190, -12}}, color = {0, 0, 127}));
  connect(demux_vg.y3[1], Vgc.v) annotation(
    Line(points = {{182, -76}, {190, -76}, {190, -42}}, color = {0, 0, 127}));
  connect(voltDuty3ph.duty_abc, ownVerter.duty_abc) annotation(
    Line(points = {{-4, 0}, {18, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(currentControl.vabc, voltDuty3ph.vabc) annotation(
    Line(points = {{-38, 4}, {-34, 4}, {-34, 0}, {-28, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(Id_step.y, mux_isp.u1[1]) annotation(
    Line(points = {{-119, 50}, {-111, 50}, {-111, 36}, {-103, 36}}, color = {0, 0, 127}));
  connect(Iq_step.y, mux_isp.u2[1]) annotation(
    Line(points = {{-119, 10}, {-111, 10}, {-111, 24}, {-103, 24}}, color = {0, 0, 127}));
  connect(mux_isp.y, currentControl.idq_sp) annotation(
    Line(points = {{-78, 30}, {-72, 30}, {-72, 4}, {-62, 4}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "Three-phase grid forming inverter with current control")}),
  experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 5e-05));
end GridFormingOwnVerter3ph;