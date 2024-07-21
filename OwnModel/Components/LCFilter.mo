within OwnModel.Components;

model LCFilter "LC filter of TWIST board"
  /*Inductance*/
  parameter SI.Inductance L(displayUnit="uH")=33e-6 "filter inductance";
  parameter SI.Resistance rL=0 "series resistance of inductor";
  parameter SI.Current iL_start=0 "initial current";
  /*Capacitor*/
  parameter SI.Capacitance C_electro(displayUnit="uF")=47e-6 "electrolytic capacitance (can be disconnected)";
  parameter SI.Capacitance C_ceramic(displayUnit="uF")=3*4.7e-6 "ceramic capacitance";
  final parameter SI.Capacitance C(displayUnit="uF")=if electrolytic then C_electro+C_ceramic else C_ceramic "total capacitance";
  parameter SI.Resistance rC=0 "series resistance of capacitor";
  parameter Boolean electrolytic=true "connection of electrolytic capacitor in // with the ceramic one";
  parameter SI.Voltage vC_start=0 "initial voltage";

 Modelica.Electrical.Analog.Interfaces.NegativePin gnd "ground (DC bus -)" annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Electrical.Analog.Interfaces.PositivePin hf "high frequency voltage side" annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Electrical.Analog.Interfaces.PositivePin lf "filtered voltage side" annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));

 
  Modelica.Electrical.Analog.Basic.Inductor LL(final L = L, i(start = iL_start, fixed = true))  annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor CC(final C = C, v(start = vC_start, fixed = true))  annotation(
    Placement(transformation(origin = {40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor Cr(final R = rC)  annotation(
    Placement(transformation(origin = {40, -70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
 Modelica.Electrical.Analog.Basic.Resistor Lr(final R = rL)  annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(CC.n, Cr.p) annotation(
    Line(points = {{40, -40}, {40, -60}}, color = {0, 0, 255}));
  connect(Cr.n, gnd) annotation(
    Line(points = {{40, -80}, {0, -80}, {0, -100}}, color = {0, 0, 255}));
  connect(hf, LL.p) annotation(
    Line(points = {{-100, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(CC.p, lf) annotation(
    Line(points = {{40, -20}, {40, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(LL.n, Lr.p) annotation(
    Line(points = {{-40, 0}, {-20, 0}}, color = {0, 0, 255}));
  connect(Lr.n, lf) annotation(
    Line(points = {{-40, 0}, {-20, 0}}, color = {255, 0, 0}));
  annotation(
    Icon(graphics = {Line(origin = {40.0598, -90.0395}, rotation = -90,points = {{-90, 0}, {-56, 0}}, color = {0, 0, 255}), Line(points = {{-60, 0}, {-59, 6}, {-52, 14}, {-38, 14}, {-31, 6}, {-30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{-30, 0}, {-29, 6}, {-22, 14}, {-8, 14}, {-1, 6}, {0, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{0, 0}, {1, 6}, {8, 14}, {22, 14}, {29, 6}, {30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(origin = {38.976, -40.32}, rotation = -90,points = {{-6, 28}, {-6, -28}}, color = {0, 0, 255}), Line(origin = {38.976, -40.32}, rotation = -90,points = {{6, 28}, {6, -28}}, color = {0, 0, 255}), Line(origin = {120.046, 0.0549898},points = {{-90, 0}, {-18, -1}}, color = {0, 0, 255}), Line(origin = {39.9996, -136.438}, rotation = -90, points = {{-90, 0}, {-57, 0}, {-56.5, -40}, {-36, -40}}, color = {0, 0, 255}), Line(points = {{-90, 0}, {-60, 0}}, color = {0, 0, 255}), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {2, 120}, textColor = {0, 0, 255}, extent = {{-102, 20}, {102, -20}}, textString = "%name")}));
end LCFilter;