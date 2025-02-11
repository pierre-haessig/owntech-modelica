within OwnModel.Utilities;

model VoltageSensor3ph
extends Modelica.Icons.RoundSensor;

  Modelica.Electrical.Analog.Interfaces.PositivePin a "phase a" annotation (Placement(
        transformation(origin = {0, 40}, extent = {{-110, -10}, {-90, 10}}), iconTransformation(origin = {0, 40}, extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin b annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin c annotation(
    Placement(transformation(origin = {0, -40}, extent = {{-110, -10}, {-90, 10}}), iconTransformation(origin = {0, -40}, extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "neutral" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput vabc[3](each unit="V")
    "Voltages between pins a/b/c and n"
     annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  equation
  a.i = 0;
  b.i = 0;
  c.i = 0;
  n.i = 0;
  vabc[1] = a.v - n.v;
  vabc[2] = b.v - n.v;
  vabc[3] = c.v - n.v;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-70, 0}, {-90, 0}}, color = {0, 0, 255}), Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Text(textColor = {64, 64, 64}, extent = {{-30, -10}, {30, -70}}, textString = "V3φ"), Line(origin = {0, -40}, points = {{-60, 0}, {-90, 0}}, color = {0, 0, 255}), Line(origin = {0, 40}, points = {{-60, 0}, {-90, 0}}, color = {0, 0, 255})}));
end VoltageSensor3ph;