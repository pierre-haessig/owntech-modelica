within OwnModel.Components;

model OwnVerter "OwnVerter three-phase power converter board, with PWM control"
    parameter Boolean averaged = false "averaged model if true, else switched model";

Modelica.Electrical.Analog.Interfaces.NegativePin gnd "ground (DC bus -)" annotation(
    Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}})));
   Modelica.Electrical.Analog.Interfaces.PositivePin high "high side of leg (DC bus +)" annotation(
    Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin low1 "low side of leg 1 (mid point)" annotation(
    Placement(transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin low2 "low side of leg 2 (mid point)" annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin low3 "low side of leg 3 (mid point)" annotation(
    Placement(transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}})));
    
  Modelica.Blocks.Interfaces.RealInput duty_abc[3] "three-phase duty cycles" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));

  Components.PWMorAvgLeg leg1(averaged = averaged) "power leg, phase 1" annotation(
    Placement(transformation(origin = {-30, 40}, extent = {{-10, -20}, {10, 20}})));
  Components.PWMorAvgLeg leg2(averaged = averaged) "power leg, phase 2" annotation(
    Placement(transformation(extent = {{-10, -20}, {10, 20}})));
  Components.PWMorAvgLeg leg3(averaged = averaged) "power leg, phase 3" annotation(
    Placement(transformation(origin = {30, -40}, extent = {{-10, -20}, {10, 20}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_duty annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i1 "current phase 1" annotation(
    Placement(transformation(origin = {70, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i2 "current phase 2" annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i3 "current phase 3" annotation(
    Placement(transformation(origin = {70, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex3 mux_im "mux three-phase current measurements" annotation(
    Placement(transformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput i_abc[3](each final unit="A") "three-phase current measurements" annotation(
    Placement(transformation(origin = {150, -90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(leg1.gnd, gnd) annotation(
    Line(points = {{-30, 20}, {-30, -80}, {0, -80}, {0, -100}}, color = {0, 0, 255}));
  connect(leg2.gnd, gnd) annotation(
    Line(points = {{0, -20}, {0, -100}}, color = {0, 0, 255}));
  connect(leg3.gnd, gnd) annotation(
    Line(points = {{30, -60}, {30, -80}, {0, -80}, {0, -100}}, color = {0, 0, 255}));
  connect(high, leg1.high) annotation(
    Line(points = {{0, 100}, {0, 80}, {-30, 80}, {-30, 60}}, color = {0, 0, 255}));
  connect(high, leg2.high) annotation(
    Line(points = {{0, 100}, {0, 20}}, color = {0, 0, 255}));
  connect(high, leg3.high) annotation(
    Line(points = {{0, 100}, {0, 80}, {30, 80}, {30, -20}}, color = {0, 0, 255}));
  connect(duty_abc, demux_duty.u) annotation(
    Line(points = {{-120, 0}, {-82, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demux_duty.y1[1], leg1.duty) annotation(
    Line(points = {{-58, 8}, {-50, 8}, {-50, 40}, {-42, 40}}, color = {0, 0, 127}));
  connect(demux_duty.y2[1], leg2.duty) annotation(
    Line(points = {{-58, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(demux_duty.y3[1], leg3.duty) annotation(
    Line(points = {{-58, -6}, {-50, -6}, {-50, -40}, {18, -40}}, color = {0, 0, 127}));
  connect(leg1.low, i1.p) annotation(
    Line(points = {{-20, 40}, {60, 40}}, color = {0, 0, 255}));
  connect(i1.n, low1) annotation(
    Line(points = {{80, 40}, {100, 40}}, color = {0, 0, 255}));
  connect(leg2.low, i2.p) annotation(
    Line(points = {{10, 0}, {60, 0}}, color = {0, 0, 255}));
  connect(i2.n, low2) annotation(
    Line(points = {{80, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(leg3.low, i3.p) annotation(
    Line(points = {{40, -40}, {60, -40}}, color = {0, 0, 255}));
  connect(i3.n, low3) annotation(
    Line(points = {{80, -40}, {100, -40}}, color = {0, 0, 255}));
  connect(i1.i, mux_im.u1[1]) annotation(
    Line(points = {{70, 30}, {70, 20}, {86, 20}, {86, -82}, {98, -82}}, color = {0, 0, 127}));
  connect(i2.i, mux_im.u2[1]) annotation(
    Line(points = {{70, -10}, {70, -20}, {84, -20}, {84, -90}, {98, -90}}, color = {0, 0, 127}));
  connect(i3.i, mux_im.u3[1]) annotation(
    Line(points = {{70, -50}, {70, -60}, {82, -60}, {82, -96}, {98, -96}}, color = {0, 0, 127}));
  connect(mux_im.y, i_abc) annotation(
    Line(points = {{122, -90}, {150, -90}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 40}, extent = {{-80, 40}, {80, -40}}, textString = "OwnVerter"), Text(origin = {0, -60}, extent = {{-90, 20}, {90, -20}}, textString = "averaged: %averaged")}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end OwnVerter;