package WaterWatt
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  model System
    extends ThermoPower.System(allowFlowReversal = false, T_amb = 288.15);
    annotation(
      defaultComponentName = "system",
      defaultComponentPrefixes = "inner",
      missingInnerMessage = "The System object is missing, please drag it on the top layer of your model");
  end System;

  model KPI "Calculation of Energy Consumption, Cost of Energy Consumption and Key Performance Indicators"
    // Input Variables
    Modelica.Blocks.Interfaces.RealInput Q(unit = "m3/h") = 0.0 "Circuit Total Flow" annotation(
      Dialog(group = "Circuit Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput P(unit = "kW") = 0.0 "Circuit Total Power" annotation(
      Dialog(group = "Circuit Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput NQ1(unit = "m3/h") = 0.0 "Normalized Pump Group 1 Flow" annotation(
      Dialog(group = "Pumps Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput NQ2(unit = "m3/h") = 0.0 "Normalized Pump Group 2 Flow" annotation(
      Dialog(group = "Pumps Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput NQ3(unit = "m3/h") = 0.0 "Normalized Pump Group 3 Flow" annotation(
      Dialog(group = "Pumps Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput NPP1(unit = "kW") = 0.0 "Normalized Pump Group 1 Total Power" annotation(
      Dialog(group = "Pumps Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput NPP2(unit = "kW") = 0.0 "Normalized Pump Group 2 Total Power" annotation(
      Dialog(group = "Pumps Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput NPP3(unit = "kW") = 0.0 "Normalized Pump Group 3 Total Power" annotation(
      Dialog(group = "Pumps Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTQ1(unit = "m3/h") = 0.0 "Cooling Tower 1 Flow" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTQ2(unit = "m3/h") = 0.0 "Cooling Tower 2 Flow" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTQ3(unit = "m3/h") = 0.0 "Cooling Tower 3 Flow" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTQ4(unit = "m3/h") = 0.0 "Cooling Tower 4 Flow" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTP1(unit = "kW") = 0.0 "Pump Group 1 Total Power" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTP2(unit = "kW") = 0.0 "Pump Group 2 Total Power" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTP3(unit = "kW") = 0.0 "Pump Group 3 Total Power" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput CTP4(unit = "kW") = 0.0 "Pump Group 4 Total Power" annotation(
      Dialog(group = "Cooling Towers Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput IP(unit = "kW") = 0.0 "Initial Total Power Consumption" annotation(
      Dialog(group = "Circuit Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput DT11(unit = "degC") = 0.0 "Cooling Tower Temperature Difference" annotation(
      Dialog(group = "Cooling Towers Thermal Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput DT21(unit = "degC") = 0.0 "Cooling Tower Temperature Difference Between Inlet and Wet-Bulb" annotation(
      Dialog(group = "Cooling Towers Thermal Parameters"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    // Techno-Economic Evaluation
    Modelica.Blocks.Interfaces.RealInput ELC(unit = "kWh/hour") = 0.0 "Circuit Energy Consumption" annotation(
      Dialog(group = "Techno-Economic Evaluation"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput C(unit = "€/hour") = 0.0 "Circuit Total Electricity Cost" annotation(
      Dialog(group = "Techno-Economic Evaluation"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    // Circuit SEC
    final WaterWatt.Units.SEC_kWh_per_m3 SEC = if Q <= 0 then 0 else P / Q "Specific Energy Consumption" annotation(
      Dialog(group = "KPI"));
    //Pumps SEC
    final WaterWatt.Units.SEC_kWh_per_m3 NSECP1 = if NQ1 <= 0 then 0 else NPP1 / NQ1 "Normalized Specific Energy Consumption for Pump Group 1" annotation(
      Dialog(group = "KPI"));
    final WaterWatt.Units.SEC_kWh_per_m3 NSECP2 = if NQ2 <= 0 then 0 else NPP2 / NQ2 "Normalized Specific Energy Consumption for Pump Group 2" annotation(
      Dialog(group = "KPI"));
    final WaterWatt.Units.SEC_kWh_per_m3 NSECP3 = if NQ3 <= 0 then 0 else NPP3 / NQ3 "Normalized Specific Energy Consumption for Pump Group 3" annotation(
      Dialog(group = "KPI"));
    //Cooling Towers SEC
    final WaterWatt.Units.SEC_kWh_per_m3 SECCT1 = if CTQ1 <= 0 then 0 else CTP1 / CTQ1 "Specific Energy Consumption for Cooling Tower 1" annotation(
      Dialog(group = "KPI"));
    final WaterWatt.Units.SEC_kWh_per_m3 SECCT2 = if CTQ2 <= 0 then 0 else CTP2 / CTQ2 "Specific Energy Consumption for Cooling Tower 2" annotation(
      Dialog(group = "KPI"));
    final WaterWatt.Units.SEC_kWh_per_m3 SECCT3 = if CTQ3 <= 0 then 0 else CTP3 / CTQ3 "Specific Energy Consumption for Cooling Tower 3" annotation(
      Dialog(group = "KPI"));
    final WaterWatt.Units.SEC_kWh_per_m3 SECCT4 = if CTQ4 <= 0 then 0 else CTP4 / CTQ4 "Specific Energy Consumption for Cooling Tower 3" annotation(
      Dialog(group = "KPI"));
    //Reduction of Energy Consumption for a Specific Measure
    Modelica.Blocks.Interfaces.RealInput P1(unit = "kW") = 0.0 "Component Power" annotation(
      Dialog(group = "Reduction of Energy Consumption for a Specific Measure"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput IP1(unit = "kW") = 0.0 "Initial Component Power" annotation(
      Dialog(group = "Reduction of Energy Consumption for a Specific Measure"),
      Placement(visible = false, transformation(extent = {{100, -10}, {120, 10}})));
    //Energy Savings
    final WaterWatt.Units.Power_kW RELC = if IP <= P then 0 else IP - P "Reduction in Electric Energy Consumption" annotation(
      Dialog(group = "KPI"));

    final WaterWatt.Units.Percentage SRELC = if IP <= 0 then 0 else RELC * 100 / IP "Share of Energy Savings" annotation(
      Dialog(group = "KPI"));
    //Energy Savings for a Specific Measure
    final WaterWatt.Units.Power_kW RELC1 = if IP1 <= P1 then 0 else IP1 - P1 "Reduction in Electric Energy Consumption for a Specific Measure" annotation(
      Dialog(group = "KPI"));
    final WaterWatt.Units.Percentage SRELC1 = if IP1 <= 0 then 0 else RELC1 * 100 / IP1 "Share of Energy Savings for a Specific Measure" annotation(
      Dialog(group = "KPI"));
    //Cooling Tower Thermal Efficiency
    final WaterWatt.Units.Percentage CTEfficiency = if DT21 <= 0 then 0 else DT11 * 100 / DT21 "Cooling Tower Efficiency" annotation(
      Dialog(group = "KPI"));
  
    annotation(
      defaultComponentName = "KPI",
      defaultComponentPrefixes = "inner",
      missingInnerMessage = "The KPI object is missing, please drag it on the top layer of your model",
      Icon(graphics = {Polygon(lineColor = {0, 170, 0}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, points = {{-100, 60}, {-60, 100}, {60, 100}, {100, 60}, {100, -60}, {60, -100}, {-60, -100}, {-100, -60}, {-100, 60}}), Text(extent = {{-80, 40}, {80, -20}}, textString = "KPI")}, coordinateSystem(initialScale = 0.1)),
      Documentation(info="<html>
  <p>Created and developed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
  </html>"));
  end KPI;






























  package Examples "Package containing several IWC examples"
    extends Modelica.Icons.Package;

    package CS2
      extends Modelica.Icons.ExamplesPackage;

      model CircuitBase
        extends WaterWatt.Icons.BaseExample;
        WaterWatt.Components.WaterSteam.Pipe pipe_InductiveFurnace_to_HybridCoolingTower(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 220, dpnom = 110000, hstartin = 146.64e3, hstartout = 146.64e3, noInitialPressure = false, omega = 3.1416 * 0.04 * 2, pstart = 5.8e5, wnom = 30 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {0, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CS2.Components.HeatEx HeatEx(ColdFluid_Flow_hstartin = 125.75e3, ColdFluid_Flow_hstartout = 126.45e3, ColdFluid_Flow_noInitialPressure = true, D = 0.08, HotFluid_Flow_hstartin = 138.29e3, HotFluid_Flow_hstartout = 134.11e3, L = 2, N = 5, Nt = 73, dpcold_nom = 50000, dphot_nom = 50000, e = 0.002, pcold_start = 3.1e5, phot_start = 3.7e5, wcold_nom = 30 * 999 / 3600, whot_nom = 35 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-1, -5}, extent = {{-11, 11}, {11, -11}}, rotation = 0)));
        CS2.Components.Pump1 Pump1(motorEfficiency = 0.924, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-80, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_HybridCoolingTower_to_HeatEx(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 220, dpnom = 80000, hstartin = 125.75e3, hstartout = 125.75e3, noInitialPressure = false, omega = 3.1416 * 0.04 * 2, pstart = 3.9e5, wnom = 30 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {38, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_HeatEx_to_pump1(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 220, dpnom = 160000, hstartin = 132.37e3, hstartout = 132.37e3, noInitialPressure = false, omega = 3.1416 * 0.04 * 2, pstart = 2.6e5, wnom = 30 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-50, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump1_to_InductiveFurnace(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 220, dpnom = 147000, hstartin = 132.37e3, hstartout = 132.37e3, noInitialPressure = false, omega = 3.1416 * 0.04 * 2, pstart = 7.37e5, wnom = 30 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-130, 6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS2.Components.Pump2 Pump2(hstart = 129.93e3, motorEfficiency = 0.924, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {40, -88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_HeatEx_to_Pump2(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 50, dpnom = 220000, hstartin = 134.11e3, hstartout = 134.11e3, noInitialPressure = false, omega = 3.1416 * 0.04 * 2, pstart = 3.2e5, wnom = 35 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {92, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump2_to_controlcabinet(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 10, dpnom = 197000, hstartin = 134.11e3, hstartout = 134.11e3, omega = 3.1416 * 0.04 * 2, pstart = 7.27e5, wnom = 35 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-10, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_controlcabinet_to_HeatEx(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 50, dpnom = 150000, hstartin = 138.29e3, hstartout = 138.29e3, omega = 3.1416 * 0.04 * 2, pstart = 5.2e5, wnom = 35 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-68, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        CS2.Components.InductiveFurnace1 Ind_Furnace(CoilWall_Tstart = 608.15, CrucibleWall_Tstart = 1907.15, D = 0.08, L = 220, dpnom = 10000, hstartin = 132e3, hstartout = 146.64e3, noInitialPressure = false, pstart = 5.9e5, wnom = 30 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-147, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        CS2.Components.ControlCabinet1 Cont_Cabinet(D = 0.08, L = 50, dpnom = 10000, hstartin = 138.29e3, hstartout = 134.11e3, pstart = 5.3e5, wnom = 35 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-144.6, -55}, extent = {{-12.6, -9}, {12.6, 9}}, rotation = 0)));
        CS2.Components.HTC CoolingTower(Ht = 10, Mt = 20, N = 6, Nt = 1, UAnom = 29040, Vt = 0.05, Wnom = 4100, ct = 500, dpctnom = 80000, k_wa_tot = 2000, noInitialPressure = false, nu_a = 1, nu_l = 0, qanom = 7.3, rhoanom(displayUnit = "kg/m3") = 1.2, rhownom(displayUnit = "kg/m3") = 999, rpm_nom = 1500, use_in_tax = true, wctnom = 30 * 999 / 3600, wcwnom = 66.5 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {142, 28}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        inner WaterWatt.System system(T_amb = 284.15, T_wb = 281.15, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
          Placement(visible = true, transformation(origin = {-190, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.ExpansionTankIdeal pmp1expTank(pf = 737000) annotation(
          Placement(visible = true, transformation(origin = {-100, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.ExpansionTankIdeal pmp2expTank(pf = 727000) annotation(
          Placement(visible = true, transformation(origin = {16, -74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS2.Components.Pump3 pump3(hstart = 46.28e3, initOpt = ThermoPower.Choices.Init.Options.fixedState, use_in_n = true) annotation(
          Placement(visible = true, transformation(origin = {180, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump3_to_HybridCoolingTower(A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 220, dpnom = 390000, hstartin = 46.28e3, hstartout = 46.28e3, noInitialPressure = true, omega = 3.1416 * 0.04 * 2, pstart = 4.9e5, wnom = 66.5 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {164, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Tank StorageTank(A = 2000, V0 = 1000, hstart = 46.28e3, initOpt = ThermoPower.Choices.Init.Options.fixedState, y0 = 0.1, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {142, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(Cont_Cabinet.WaterInlet, pipe_pump2_to_controlcabinet.outfl) annotation(
          Line(points = {{-158, -54}, {-158, -54}, {-158, -82}, {-20, -82}, {-20, -80}}, color = {0, 0, 255}));
        connect(Cont_Cabinet.WaterOutlet, pipe_controlcabinet_to_HeatEx.infl) annotation(
          Line(points = {{-132, -54}, {-68, -54}, {-68, -48}, {-68, -48}}, color = {0, 0, 255}));
        connect(Ind_Furnace.WaterInlet, pipe_pump1_to_InductiveFurnace.outfl) annotation(
          Line(points = {{-158, 38}, {-158, 38}, {-158, 6}, {-140, 6}, {-140, 6}}, color = {0, 0, 255}));
        connect(Ind_Furnace.WaterOutlet, pipe_InductiveFurnace_to_HybridCoolingTower.infl) annotation(
          Line(points = {{-136, 38}, {-120, 38}, {-120, 82}, {-10, 82}, {-10, 82}}, color = {0, 0, 255}));
        connect(pipe_pump3_to_HybridCoolingTower.infl, pump3.outfl) annotation(
          Line(points = {{174, 56}, {174, 56}, {174, 16}, {174, 16}}, color = {0, 0, 255}));
        connect(CoolingTower.coolingWaterOutlet, StorageTank.inletTop) annotation(
          Line(points = {{142, 14}, {142, 14}, {142, -2}, {142, -2}}, color = {0, 0, 255}));
        connect(StorageTank.outlet, pump3.infl) annotation(
          Line(points = {{150, -16}, {178, -16}, {178, 2}}, color = {0, 0, 255}));
        connect(CoolingTower.coolingWaterInlet, pipe_pump3_to_HybridCoolingTower.outfl) annotation(
          Line(points = {{142, 42}, {142, 56}, {154, 56}}, color = {0, 0, 255}));
        connect(pipe_HybridCoolingTower_to_HeatEx.infl, CoolingTower.waterOutlet) annotation(
          Line(points = {{48, 0}, {76, 0}, {76, 20}, {128, 20}}, color = {0, 0, 255}));
        connect(pipe_InductiveFurnace_to_HybridCoolingTower.outfl, CoolingTower.waterInlet) annotation(
          Line(points = {{10, 82}, {76, 82}, {76, 28}, {128, 28}}, color = {0, 0, 255}));
        connect(pipe_controlcabinet_to_HeatEx.outfl, HeatEx.HotFluid_inlet) annotation(
          Line(points = {{-68, -28}, {-68, -10}, {-12, -10}}, color = {0, 0, 255}));
        connect(Pump2.infl, pipe_HeatEx_to_Pump2.outfl) annotation(
          Line(points = {{48, -86}, {92, -86}, {92, -48}}, color = {0, 0, 255}));
        connect(HeatEx.HotFluid_outlet, pipe_HeatEx_to_Pump2.infl) annotation(
          Line(points = {{10, -10}, {92, -10}, {92, -28}}, color = {0, 0, 255}));
        connect(pmp2expTank.WaterInfl, Pump2.outfl) annotation(
          Line(points = {{20, -80}, {34, -80}, {34, -80}, {34, -80}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_controlcabinet.infl, pmp2expTank.WaterOutfl) annotation(
          Line(points = {{0, -80}, {12, -80}, {12, -80}, {12, -80}}, color = {0, 0, 255}));
        connect(pipe_pump1_to_InductiveFurnace.infl, pmp1expTank.WaterOutfl) annotation(
          Line(points = {{-120, 6}, {-104, 6}}, color = {0, 0, 255}));
        connect(pmp1expTank.WaterInfl, Pump1.outfl) annotation(
          Line(points = {{-96, 6}, {-86, 6}, {-86, 6}, {-86, 6}}, color = {0, 0, 255}));
        connect(pipe_HeatEx_to_pump1.infl, HeatEx.ColdFluid_outlet) annotation(
          Line(points = {{-40, 0}, {-10, 0}, {-10, 0}, {-12, 0}}, color = {0, 0, 255}));
        connect(HeatEx.ColdFluid_inlet, pipe_HybridCoolingTower_to_HeatEx.outfl) annotation(
          Line(points = {{10, 0}, {28, 0}}, color = {0, 0, 255}));
        connect(Pump1.infl, pipe_HeatEx_to_pump1.outfl) annotation(
          Line(points = {{-72, 0}, {-60, 0}}, color = {0, 0, 255}));
      protected
        annotation(
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          __OpenModelica_commandLineOptions = "");
      end CircuitBase;

      model CircuitTable
        extends CS2.CircuitBase;
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.TimeTable Heat_InductiveFurnace(table = [0, 133.585725; 3600, 133.585725]) annotation(
          Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable Heat_ControlCabinet(table = [0, 40.656525; 3600, 40.656525]) annotation(
          Placement(visible = true, transformation(origin = {-180, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable pump1_rpm(table = [0, 2770.68; 3600, 2770.68]) annotation(
          Placement(visible = true, transformation(origin = {-57, 21}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable pump2_rpm(table = [0, 3000; 3600, 3000]) annotation(
          Placement(visible = true, transformation(origin = {65, -59}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax1(table = [0, 0.1534; 3600, 0.1534]) annotation(
          Placement(visible = true, transformation(origin = {-57, 45}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax2(table = [0, 0.1534; 3600, 0.1534]) annotation(
          Placement(visible = true, transformation(origin = {65, -37}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable fan_speed(table = [0, 1500; 0.5e6, 1500]) annotation(
          Placement(visible = true, transformation(origin = {101, 63}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax_fan(table = [0, 0.1534; 3600, 0.1534]) annotation(
          Placement(visible = true, transformation(origin = {101, 86}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable pump3_rpm(table = [0, 2950; 3600, 2950]) annotation(
          Placement(visible = true, transformation(origin = {157, 5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
        inner WaterWatt.KPI KPI_CS2(CTP1 = CoolingTower.EP, CTQ1 = CoolingTower.VFR, DT11 = CoolingTower.Tlin - CoolingTower.Tlout, DT21 = CoolingTower.Tlin - CoolingTower.Tdb, NPP1 = Pump1.NEP, NPP2 = Pump1.NEP, NQ1 = Pump1.NVFR, NQ2 = Pump2.NVFR, P = Pump1.EP + Pump2.EP + CoolingTower.EP, Q = Pump1.VFR + Pump2.VFR) annotation(
          Placement(visible = true, transformation(origin = {190, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(Heat_ControlCabinet.y, Cont_Cabinet.ThermalPower) annotation(
          Line(points = {{-168, -34}, {-164, -34}, {-164, -48}, {-158, -48}, {-158, -48}}, color = {0, 0, 127}));
        connect(Heat_InductiveFurnace.y, Ind_Furnace.ThermalPower) annotation(
          Line(points = {{-168, 60}, {-160, 60}, {-160, 60}, {-158, 60}}, color = {0, 0, 127}));
        connect(pump3_rpm.y, pump3.in_n) annotation(
          Line(points = {{162, 6}, {172, 6}, {172, 8}, {172, 8}}, color = {0, 0, 127}));
        connect(tax_fan.y, CoolingTower.tax) annotation(
          Line(points = {{108, 86}, {130, 86}, {130, 42}, {130, 42}}, color = {0, 0, 127}));
        connect(fan_speed.y, CoolingTower.fanRpm) annotation(
          Line(points = {{108, 64}, {120, 64}, {120, 34}, {130, 34}, {130, 34}}, color = {0, 0, 127}));
        connect(Pump2.tax, tax2.y) annotation(
          Line(points = {{40, -80}, {40, -80}, {40, -36}, {58, -36}, {58, -36}}, color = {0, 0, 127}));
        connect(Pump2.in_n, pump2_rpm.y) annotation(
          Line(points = {{42, -80}, {44, -80}, {44, -60}, {58, -60}, {58, -58}}, color = {0, 0, 127}));
        connect(Pump1.tax, tax1.y) annotation(
          Line(points = {{-80, 6}, {-80, 6}, {-80, 46}, {-64, 46}, {-64, 46}}, color = {0, 0, 127}));
        connect(Pump1.in_n, pump1_rpm.y) annotation(
          Line(points = {{-78, 6}, {-78, 6}, {-78, 20}, {-64, 20}, {-64, 22}}, color = {0, 0, 127}));
        annotation(
          experiment(StartTime = 0, StopTime = 1e+06, Tolerance = 1e-06, Interval = 2000),
          Diagram);
      end CircuitTable;

      package Components
        extends Modelica.Icons.Package;

        model Pump1
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {4, 12, 16} * (1 / 1000), head_nom = {65.5, 61.1, 51.9}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {4, 12, 16} * (1 / 1000), eta_nom = {0.298, 0.547, 0.548}), w0 = 30 * 999 / 3600, dp0 = 65 * 9.81 * 999, n0 = 3000, V = 0.05, rho0 = 999, motorEfficiency = 0.893);
        end Pump1;

        model Pump2
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {4, 12, 16} * (1 / 1000), head_nom = {65.5, 61.1, 51.9}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {4, 12, 16} * (1 / 1000), eta_nom = {0.298, 0.547, 0.548}), w0 = 35 * 999 / 3600, dp0 = 64 * 9.81 * 999, n0 = 3000, V = 0.05, rho0 = 999, motorEfficiency = 0.893);
        end Pump2;

        model HeatEx
          extends WaterWatt.Components.WaterSteam.Special.TubularHeatExchangerWater;
        end HeatEx;


        model InductiveFurnace1
          extends WaterWatt.Components.WaterSteam.Special.InductiveFurnace;
        end InductiveFurnace1;

        model ControlCabinet1
          extends WaterWatt.Components.WaterSteam.Special.ThermalPowerInput(pipe.L = 50, pipe.noInitialPressure = false);
        end ControlCabinet1;

        model HTC
          extends WaterWatt.Components.WaterSteam.Special.CoolingTowerClosed(cooledFlow.pstart = 4.7e5);
        end HTC;

        model Pump3
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {60, 66.5, 70} * (1 / 3600), head_nom = {50, 45, 40}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {60, 66.5, 70} * (1 / 3600), eta_nom = {0.90, 0.95, 0.99}), w0 = 66.5 * 999 / 3600, dp0 = 45 * 9.81 * 999, n0 = 3000, V = 0.05, rho0 = 999);
        end Pump3;
      end Components;
      annotation(
        uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
        Documentation(info="<html>
    <p>Closed Cooling Circuit of an Inductive Furnace.
    <p>Developed by ISQ, for the WaterWatt project</p>
    <p>To simulate the IWC operation, run the simulation for the CircuitTable model</p>
    </html>"));
    end CS2;








    package CS4
      extends Modelica.Icons.ExamplesPackage;

      model CircuitBase
        extends WaterWatt.Icons.BaseExample;
        WaterWatt.Components.WaterSteam.Pipe pipe_pump2_to_filter1(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Downstream, L = 20, dpnom(displayUnit = "bar") = 310000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = true, omega = 3.1416 * 0.3 * 2, pstart = 11.9e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-76, -24}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.PressDrop filter1(dpnom = 0.5 * 10 ^ 5, wnom = 900 * (1 / 3) * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-166, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.PressDrop filter2(dpnom = 0.5 * 10 ^ 5, wnom = 900 * (1 / 3) * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-166, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.PressDrop filter3(dpnom = 0.5 * 10 ^ 5, wnom = 900 * (1 / 3) * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-166, -66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_filter_to_scrubber(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 0.001, dpnom(displayUnit = "bar") = 9000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 5.2e5, wnom = 900 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-192, 14}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
        inner WaterWatt.System system annotation(
          Placement(visible = true, transformation(origin = {-190, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CS4.Components.Pump_group2 pump_group21(motorEfficiency = 0.958, hstart = 63.04e3, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-46, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS4.Components.Pump_group2 pump_group22(motorEfficiency = 0.958, hstart = 63.04e3, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-46, -34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS4.Components.Pump_group2 pump_group23(motorEfficiency = 0.958, hstart = 63.04e3, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-46, -64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS4.Components.Pump_group2 pump_group24(motorEfficiency = 0.958, hstart = 63.04e3, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-46, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS4.Components.Pump_group1 pump_group12(motorEfficiency = 0.96, hstart = 63.04e3, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {64, -78}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS4.Components.Pump_group1 pump_group11(motorEfficiency = 0.96, hstart = 63.04e3, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {64, -24}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_storagetank_to_pump1_1(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 5, dpnom = 44450, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 1e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {90, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_storagetank_to_pump1_2(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 5, dpnom = 44450, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 1e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {90, -76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump1_to_pump2_2(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 30, dpnom(displayUnit = "bar") = 520000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 10.5e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {40, -72}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump1_to_pump2_1(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 30, dpnom(displayUnit = "bar") = 520000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 10.5e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {40, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_filter_to_scrubber2(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 70, dpnom(displayUnit = "bar") = 90000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = true, omega = 3.1416 * 0.3 * 2, pstart = 5.1e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-42, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_filter_to_scrubber1(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 70, dpnom(displayUnit = "bar") = 90000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 5.1e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-42, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_scrubber_to_sedimentationtank1(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -62, L = 80, dpnom(displayUnit = "bar") = 100, hstartin = 77.01e3, hstartout = 77.01e3, noInitialPressure = true, omega = 3.1416 * 0.3 * 2, pstart = 4.1e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {48, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_scrubber_to_sedimentationtank2(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -62, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Downstream, L = 80, dpnom(displayUnit = "bar") = 100, hstartin = 77.01e3, hstartout = 77.01e3, noInitialPressure = true, omega = 3.1416 * 0.3 * 2, pstart = 4.1e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {48, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump2_to_filter2(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Downstream, L = 20, dpnom(displayUnit = "bar") = 310000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.3 * 2, pstart = 11.9e5, wnom = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-76, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_pump2_to_filter(A = 3.1416 * 0.4 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = 20, dpnom(displayUnit = "bar") = 310000, hstartin = 63.04e3, hstartout = 63.04e3, noInitialPressure = false, omega = 3.1416 * 0.4 * 2, pstart = 8.6e5, wnom = 900 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-114, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Tank storagetank(A = 400, V0 = 400 * 5.5, hstart = 63.04e3, noInitialPressure = true, y(fixed = true), y0 = 5.5, ymax = 5.5, ymin = -5.5, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {156, -82}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_scrubber_to_sedimentationtank(A = 3.1416 * 0.3 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 20, dpnom(displayUnit = "bar") = 820000, hstartin = 77.01e3, hstartout = 77.01e3, noInitialPressure = true, omega = 3.1416 * 0.3 * 2, pstart = 10.2e5, wnom = 900 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {192, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        WaterWatt.Components.WaterSteam.Pipe pipe_sedimentationtank_to_coolingtower1(A = 3.1416 * 0.5 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -1, L = 10, dpnom(displayUnit = "bar") = 110000, hstartin = 67.22e3, hstartout = 67.22e3, noInitialPressure = true, omega = 3.1416 * 0.5 * 2, pstart = 2.0e5, wnom = 300 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {128, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        WaterWatt.Components.WaterSteam.Pipe pipe_sedimentationtank_to_coolingtower3(A = 3.1416 * 0.5 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -1, L = 10, dpnom(displayUnit = "bar") = 110000, hstartin = 67.22e3, hstartout = 67.22e3, noInitialPressure = true, omega = 3.1416 * 0.5 * 2, pstart = 2.0e5, wnom = 300 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {184, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        WaterWatt.Components.WaterSteam.CoolingTower CoolingTower1(S = 1000, Wnom = 30e3, gamma_wp_nom = 350, k_wa_tot = 0.11, nu_a = 0, nu_l = 0, qanom = 78.1, rhoanom(displayUnit = "kg/m3") = 1.225, rpm_nom = 2900, wlnom = 300 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {128, -56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.CoolingTower CoolingTower2(S = 1000, Wnom = 30e3, gamma_wp_nom = 350, k_wa_tot = 0.11, nu_a = 0, nu_l = 0, qanom = 78.1, rhoanom(displayUnit = "kg/m3") = 1.225, rpm_nom = 2900, wlnom = 300 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {156, -56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.CoolingTower CoolingTower3(S = 1000, Wnom = 30e3, gamma_wp_nom = 350, k_wa_tot = 0.11, nu_a = 0, nu_l = 0, qanom = 78.1, rhoanom(displayUnit = "kg/m3") = 1.225, rpm_nom = 2900, wlnom = 300 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {184, -56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.WaterSteam.Pipe pipe_sedimentationtank_to_coolingtower2(A = 3.1416 * 0.5 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -1, L = 10, dpnom(displayUnit = "bar") = 110000, hstartin = 67.22e3, hstartout = 67.22e3, noInitialPressure = true, omega = 3.1416 * 0.5 * 2, pstart = 2.0e5, wnom = 300 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {156, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        WaterWatt.Components.WaterSteam.Tank sedimentationtank(A = 1200, V0 = 1200 * 10.23, hstart = 67.22e3, noInitialPressure = true, y(fixed = true), y0 = 10.23, ymax = 10.23, ymin = -10.23, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {184, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        CS4.Components.GasScrubber1 gasScrubber1(noInitialPressure = true, w_water = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {2, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        CS4.Components.GasScrubber2 gasScrubber2(noInitialPressure = true, w_water = 450 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {3, 47}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
        inner WaterWatt.KPI KPI_CS4(CTP1 = CoolingTower1.EP, CTP2 = CoolingTower2.EP, CTP3 = CoolingTower3.EP, CTQ1 = CoolingTower1.VFR, CTQ2 = CoolingTower2.VFR, CTQ3 = CoolingTower3.VFR, DT11 = CoolingTower1.Tlin - CoolingTower1.Tlout, DT21 = CoolingTower1.Tlin - CoolingTower1.Twb[CoolingTower1.N], NPP1 = pump_group11.NEP + pump_group12.NEP, NPP2 = pump_group21.NEP + pump_group22.NEP + pump_group23.NEP + pump_group24.NEP, NQ1 = pump_group11.NVFR + pump_group12.NVFR, NQ2 = pump_group21.NVFR + pump_group22.NVFR + pump_group23.NVFR + pump_group24.NVFR, P = pump_group11.EP + pump_group12.EP + pump_group21.EP + pump_group22.EP + pump_group23.EP + pump_group24.EP + CoolingTower1.EP + CoolingTower2.EP + CoolingTower3.EP, Q = pump_group11.VFR + pump_group12.VFR) annotation(
          Placement(visible = true, transformation(origin = {190, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(gasScrubber2.flangeB1, pipe_scrubber_to_sedimentationtank2.infl) annotation(
          Line(points = {{14, 38}, {38, 38}, {38, 40}, {38, 40}}, color = {0, 0, 255}));
        connect(pipe_filter_to_scrubber2.outfl, gasScrubber2.flangeA1) annotation(
          Line(points = {{-32, 40}, {-8, 40}, {-8, 38}, {-8, 38}}, color = {0, 0, 255}));
        connect(gasScrubber1.flangeB1, pipe_scrubber_to_sedimentationtank1.infl) annotation(
          Line(points = {{12, 72}, {36, 72}, {36, 72}, {38, 72}}, color = {0, 0, 255}));
        connect(pipe_filter_to_scrubber1.outfl, gasScrubber1.flangeA1) annotation(
          Line(points = {{-32, 72}, {-10, 72}, {-10, 72}, {-8, 72}}, color = {0, 0, 255}));
        connect(pipe_sedimentationtank_to_coolingtower3.infl, sedimentationtank.outlet) annotation(
          Line(points = {{184, -18}, {184, -18}, {184, -12}, {156, -12}, {156, -6}, {176, -6}, {176, -6}}, color = {0, 0, 255}));
        connect(pipe_sedimentationtank_to_coolingtower2.infl, sedimentationtank.outlet) annotation(
          Line(points = {{156, -18}, {156, -18}, {156, -6}, {176, -6}, {176, -6}}, color = {0, 0, 255}));
        connect(pipe_sedimentationtank_to_coolingtower1.infl, sedimentationtank.outlet) annotation(
          Line(points = {{128, -18}, {128, -18}, {128, -12}, {156, -12}, {156, -6}, {176, -6}, {176, -6}}, color = {0, 0, 255}));
        connect(pump_group21.infl, pipe_pump1_to_pump2_1.outfl) annotation(
          Line(points = {{-38, -6}, {0, -6}, {0, -18}, {30, -18}, {30, -18}}, color = {0, 0, 255}));
        connect(pump_group22.infl, pipe_pump1_to_pump2_1.outfl) annotation(
          Line(points = {{-38, -32}, {0, -32}, {0, -18}, {30, -18}, {30, -18}, {30, -18}}, color = {0, 0, 255}));
        connect(pump_group23.infl, pipe_pump1_to_pump2_2.outfl) annotation(
          Line(points = {{-38, -62}, {0, -62}, {0, -72}, {30, -72}, {30, -72}}, color = {0, 0, 255}));
        connect(pump_group24.infl, pipe_pump1_to_pump2_2.outfl) annotation(
          Line(points = {{-38, -88}, {0, -88}, {0, -72}, {30, -72}}, color = {0, 0, 255}));
        connect(pipe_storagetank_to_pump1_1.infl, storagetank.outlet) annotation(
          Line(points = {{100, -22}, {110, -22}, {110, -76}, {124, -76}, {124, -88}, {148, -88}}, color = {0, 0, 255}));
        connect(pipe_scrubber_to_sedimentationtank.outfl, sedimentationtank.inlet) annotation(
          Line(points = {{192, 12}, {192, -6}}, color = {0, 0, 255}));
        connect(pipe_sedimentationtank_to_coolingtower2.outfl, CoolingTower2.waterInlet) annotation(
          Line(points = {{156, -38}, {156, -38}, {156, -46}, {156, -46}}, color = {0, 0, 255}));
        connect(pipe_pump1_to_pump2_2.infl, pump_group12.outfl) annotation(
          Line(points = {{50, -72}, {48, -72}, {48, -72}, {54, -72}, {54, -72}, {58, -72}, {58, -71.5}, {58, -71.5}, {58, -71.25}, {58, -71.25}, {58, -71.125}, {58, -71.125}, {58, -71.0625}, {58, -71.0625}, {58, -71.0312}, {58, -71.0312}, {58, -71}}, color = {0, 0, 255}));
        connect(pump_group12.infl, pipe_storagetank_to_pump1_2.outfl) annotation(
          Line(points = {{72, -76}, {80, -76}}, color = {0, 0, 255}));
        connect(pipe_storagetank_to_pump1_2.infl, storagetank.outlet) annotation(
          Line(points = {{100, -76}, {124, -76}, {124, -88}, {148, -88}}, color = {0, 0, 255}));
        connect(pipe_pump1_to_pump2_1.infl, pump_group11.outfl) annotation(
          Line(points = {{50, -18}, {53, -18}, {53, -18}, {56, -18}, {56, -17.5}, {56, -17.5}, {56, -17.25}, {60, -17.25}, {60, -17.125}, {60, -17.125}, {60, -16.0625}, {58, -16.0625}, {58, -17}}, color = {0, 0, 255}));
        connect(pump_group11.infl, pipe_storagetank_to_pump1_1.outfl) annotation(
          Line(points = {{72, -22}, {80, -22}}, color = {0, 0, 255}));
        connect(pipe_sedimentationtank_to_coolingtower3.outfl, CoolingTower3.waterInlet) annotation(
          Line(points = {{184, -38}, {184, -38}, {184, -46}, {184, -46}}, color = {0, 0, 255}));
        connect(CoolingTower3.waterOutlet, storagetank.inletTop) annotation(
          Line(points = {{184, -64}, {184, -64}, {184, -68}, {156, -68}, {156, -74}, {156, -74}}, color = {0, 0, 255}));
        connect(CoolingTower2.waterOutlet, storagetank.inletTop) annotation(
          Line(points = {{156, -65}, {156, -74}}, color = {0, 0, 255}));
        connect(pipe_sedimentationtank_to_coolingtower1.outfl, CoolingTower1.waterInlet) annotation(
          Line(points = {{128, -38}, {128, -46}}, color = {0, 0, 255}));
        connect(CoolingTower1.waterOutlet, storagetank.inletTop) annotation(
          Line(points = {{128, -66}, {128, -68}, {156, -68}, {156, -74}}, color = {0, 0, 255}));
        connect(pipe_scrubber_to_sedimentationtank1.outfl, pipe_scrubber_to_sedimentationtank.infl) annotation(
          Line(points = {{58, 72}, {192, 72}, {192, 32}, {192, 32}}, color = {0, 0, 255}));
        connect(pipe_scrubber_to_sedimentationtank2.outfl, pipe_scrubber_to_sedimentationtank.infl) annotation(
          Line(points = {{58, 40}, {192, 40}, {192, 32}, {192, 32}}, color = {0, 0, 255}));
        connect(filter3.inlet, pipe_pump2_to_filter.outfl) annotation(
          Line(points = {{-156, -66}, {-134, -66}, {-134, -44}, {-124, -44}}, color = {0, 0, 255}));
        connect(filter1.inlet, pipe_pump2_to_filter.outfl) annotation(
          Line(points = {{-156, -20}, {-134, -20}, {-134, -44}, {-124, -44}}, color = {0, 0, 255}));
        connect(filter2.inlet, pipe_pump2_to_filter.outfl) annotation(
          Line(points = {{-156, -44}, {-124, -44}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_filter.infl, pipe_pump2_to_filter2.outfl) annotation(
          Line(points = {{-104, -44}, {-92, -44}, {-92, -70}, {-86, -70}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_filter.infl, pipe_pump2_to_filter1.outfl) annotation(
          Line(points = {{-104, -44}, {-92, -44}, {-92, -24}, {-86, -24}}, color = {0, 0, 255}));
        connect(pipe_filter_to_scrubber.infl, filter3.outlet) annotation(
          Line(points = {{-192, 4}, {-192, -66}, {-176, -66}}, color = {0, 0, 255}));
        connect(pipe_filter_to_scrubber.infl, filter2.outlet) annotation(
          Line(points = {{-192, 4}, {-192, -44}, {-176, -44}}, color = {0, 0, 255}));
        connect(filter1.outlet, pipe_filter_to_scrubber.infl) annotation(
          Line(points = {{-176, -20}, {-192, -20}, {-192, 4}}, color = {0, 0, 255}));
        connect(pipe_filter_to_scrubber2.infl, pipe_filter_to_scrubber.outfl) annotation(
          Line(points = {{-52, 40}, {-192, 40}, {-192, 24}}, color = {0, 0, 255}));
        connect(pipe_filter_to_scrubber.outfl, pipe_filter_to_scrubber1.infl) annotation(
          Line(points = {{-192, 24}, {-192, 72}, {-52, 72}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_filter1.infl, pump_group22.outfl) annotation(
          Line(points = {{-66, -24}, {-58, -24}, {-58, -28}, {-52, -28}, {-52, -26}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_filter1.infl, pump_group21.outfl) annotation(
          Line(points = {{-66, -24}, {-58, -24}, {-58, -1}, {-52, -1}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_filter2.infl, pump_group23.outfl) annotation(
          Line(points = {{-66, -70}, {-58, -70}, {-58, -58}, {-52, -58}, {-52, -57}, {-52, -57}, {-52, -56.5}, {-52, -56.5}, {-52, -56}}, color = {0, 0, 255}));
        connect(pipe_pump2_to_filter2.infl, pump_group24.outfl) annotation(
          Line(points = {{-66, -70}, {-58, -70}, {-58, -84}, {-52, -84}, {-52, -83}, {-52, -83}, {-52, -82.5}, {-52, -82.5}, {-52, -82.25}, {-52, -82.25}, {-52, -82}}, color = {0, 0, 255}));
        annotation(
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          __OpenModelica_commandLineOptions = "");
      end CircuitBase;

      model CircuitTable
        extends CS4.CircuitBase;
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.TimeTable PG2_rpm(table = [0, 1480; 3600, 1480]) annotation(
          Placement(visible = true, transformation(origin = {14, 4}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable PG1_rpm(table = [0, 1480; 3600, 1480]) annotation(
          Placement(visible = true, transformation(origin = {102, 4}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax2(table = [0, 0.1514; 3600, 0.1514]) annotation(
          Placement(visible = true, transformation(origin = {14, 22}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax1(table = [0, 0.1514; 3600, 0.1514]) annotation(
          Placement(visible = true, transformation(origin = {102, 22}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable fan_rpm2(table = [0, 2900; 3600, 2900]) annotation(
          Placement(visible = true, transformation(origin = {171, -43}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable fan_rpm1(table = [0, 2900; 3600, 2900]) annotation(
          Placement(visible = true, transformation(origin = {143, -43}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable fan_rpm3(table = [0, 2900; 3600, 2900]) annotation(
          Placement(visible = true, transformation(origin = {199, -43}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax_fan(table = [0, 0.1514; 3600, 0.1514]) annotation(
          Placement(visible = true, transformation(origin = {212, -26}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
      equation
        connect(pump_group12.in_n, PG1_rpm.y) annotation(
          Line(points = {{66, -70}, {66, -70}, {66, 4}, {96, 4}, {96, 4}, {96, 4}}, color = {0, 0, 127}));
        connect(pump_group11.in_n, PG1_rpm.y) annotation(
          Line(points = {{66, -16}, {66, -16}, {66, 4}, {96, 4}, {96, 4}}, color = {0, 0, 127}));
        connect(pump_group24.in_n, PG2_rpm.y) annotation(
          Line(points = {{-44, -82}, {-44, -82}, {-44, 4}, {8, 4}, {8, 4}}, color = {0, 0, 127}));
        connect(pump_group23.in_n, PG2_rpm.y) annotation(
          Line(points = {{-44, -56}, {-44, -56}, {-44, 4}, {8, 4}, {8, 4}}, color = {0, 0, 127}));
        connect(pump_group22.in_n, PG2_rpm.y) annotation(
          Line(points = {{-44, -26}, {-44, -26}, {-44, 4}, {8, 4}, {8, 4}}, color = {0, 0, 127}));
        connect(pump_group21.in_n, PG2_rpm.y) annotation(
          Line(points = {{-44, 0}, {-44, 0}, {-44, 4}, {8, 4}, {8, 4}}, color = {0, 0, 127}));
        connect(CoolingTower3.tax, tax_fan.y) annotation(
          Line(points = {{190, -46}, {190, -46}, {190, -26}, {206, -26}, {206, -26}}, color = {0, 0, 127}));
        connect(CoolingTower2.tax, tax_fan.y) annotation(
          Line(points = {{162, -46}, {162, -46}, {162, -26}, {206, -26}, {206, -26}}, color = {0, 0, 127}));
        connect(CoolingTower1.tax, tax_fan.y) annotation(
          Line(points = {{134, -46}, {134, -46}, {134, -26}, {206, -26}, {206, -26}}, color = {0, 0, 127}));
        connect(pump_group12.tax, tax1.y) annotation(
          Line(points = {{64, -70}, {64, -70}, {64, 22}, {96, 22}, {96, 22}}, color = {0, 0, 127}));
        connect(pump_group11.tax, tax1.y) annotation(
          Line(points = {{64, -16}, {64, -16}, {64, 22}, {96, 22}, {96, 22}}, color = {0, 0, 127}));
        connect(CoolingTower3.fanRpm, fan_rpm3.y) annotation(
          Line(points = {{192, -52}, {192, -52}, {192, -42}, {194, -42}, {194, -42}}, color = {0, 0, 127}));
        connect(CoolingTower2.fanRpm, fan_rpm2.y) annotation(
          Line(points = {{164, -52}, {164, -52}, {164, -42}, {166, -42}, {166, -42}}, color = {0, 0, 127}));
        connect(CoolingTower1.fanRpm, fan_rpm1.y) annotation(
          Line(points = {{136, -52}, {136, -52}, {136, -42}, {138, -42}, {138, -42}}, color = {0, 0, 127}));
        connect(pump_group24.tax, tax2.y) annotation(
          Line(points = {{-46, -82}, {-46, -82}, {-46, 22}, {8, 22}, {8, 22}}, color = {0, 0, 127}));
        connect(pump_group23.tax, tax2.y) annotation(
          Line(points = {{-46, -56}, {-46, -56}, {-46, 22}, {8, 22}, {8, 22}}, color = {0, 0, 127}));
        connect(pump_group22.tax, tax2.y) annotation(
          Line(points = {{-46, -26}, {-46, -26}, {-46, 22}, {8, 22}, {8, 22}}, color = {0, 0, 127}));
        connect(pump_group21.tax, tax2.y) annotation(
          Line(points = {{-46, 0}, {-46, 0}, {-46, 22}, {8, 22}, {8, 22}}, color = {0, 0, 127}));
        annotation(
          experiment(StartTime = 0, StopTime = 1e+06, Tolerance = 1e-06, Interval = 2000),
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
          __OpenModelica_commandLineOptions = "");
      end CircuitTable;

      package Components
        extends Modelica.Icons.Package;

        model Pump_group1
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {450, 1400, 1500} * (1 / 3600), head_nom = {101.5, 91.5, 89.2}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {450, 1400, 1500} * (1 / 3600), eta_nom = {0.438, 0.834, 0.843}), redeclare function flowCharacteristicNPSHr = WaterWatt.Functions.PumpCharacteristics.quadraticNPSHr(q_nom = {450, 1400, 1500} * (1 / 3600), NPSHr_nom = {20, 40, 60}), w0 = 450 * 999 / 3600, dp0 = 101.5 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.940);
        end Pump_group1;

        model Pump_group2
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {225, 800, 1000} * (1 / 3600), head_nom = {66.9, 61.9, 58.5}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {225, 800, 1000} * (1 / 3600), eta_nom = {0.364, 0.795, 0.832}), redeclare function flowCharacteristicNPSHr = WaterWatt.Functions.PumpCharacteristics.quadraticNPSHr(q_nom = {225, 800, 1000} * (1 / 3600), NPSHr_nom = {20, 40, 60}), w0 = 225 * 999 / 3600, dp0 = 66.9 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.935);
        end Pump_group2;

        model GasScrubber1
          extends WaterWatt.Components.WaterSteam.Special.GasScrubber(air_sinkMassFlow.T = 300, air_sourceMassFlow.w0 = 450 * 0.26 * 999 / 3600, air_sinkMassFlow.w0 = 450 * 0.26 * 999 / 3600);
        end GasScrubber1;




        model GasScrubber2
          extends WaterWatt.Components.WaterSteam.Special.GasScrubber(air_sinkMassFlow.T = 300, air_sourceMassFlow.w0 = 450 * 0.26 * 999 / 3600, air_sinkMassFlow.w0 = 450 * 0.26 * 999 / 3600);
        end GasScrubber2;


        model Pump_group1_1
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {450, 1400, 1500} * (1 / 3600), head_nom = {101.5, 91.5, 89.2}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {450, 1400, 1500} * (1 / 3600), eta_nom = {0.438, 0.834, 0.843} * 0.9), w0 = 450 * 999 / 3600, dp0 = 101.5 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.940);
        end Pump_group1_1;

        model Pump_group1_2
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {450, 1400, 1500} * (1 / 3600), head_nom = {101.5, 91.5, 89.2}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {450, 1400, 1500} * (1 / 3600), eta_nom = {0.438, 0.834, 0.843} * 0.85), w0 = 450 * 999 / 3600, dp0 = 101.5 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.940);
        end Pump_group1_2;

        model Pump_group2_1
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {225, 800, 1000} * (1 / 3600), head_nom = {66.9, 61.9, 58.5}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {225, 800, 1000} * (1 / 3600), eta_nom = {0.364, 0.795, 0.832} * 0.86), w0 = 225 * 999 / 3600, dp0 = 66.9 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.938);
        end Pump_group2_1;

        model Pump_group2_2
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {225, 800, 1000} * (1 / 3600), head_nom = {66.9, 61.9, 58.5}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {225, 800, 1000} * (1 / 3600), eta_nom = {0.364, 0.795, 0.832} * 0.87), w0 = 225 * 999 / 3600, dp0 = 66.9 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.938);
        end Pump_group2_2;

        model Pump_group2_3
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {225, 800, 1000} * (1 / 3600), head_nom = {66.9, 61.9, 58.5}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {225, 800, 1000} * (1 / 3600), eta_nom = {0.364, 0.795, 0.832} * 0.87), w0 = 225 * 999 / 3600, dp0 = 66.9 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.938);
        end Pump_group2_3;

        model Pump_group2_4
          extends WaterWatt.Components.WaterSteam.Pump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlowMonotonic(q_nom = {225, 800, 1000} * (1 / 3600), head_nom = {66.9, 61.9, 58.5}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {225, 800, 1000} * (1 / 3600), eta_nom = {0.364, 0.795, 0.832} * 0.88), w0 = 225 * 999 / 3600, dp0 = 66.9 * 9.81 * 999, n0 = 1480, V = 0.05, rho0 = 999, motorEfficiency = 0.938);
        end Pump_group2_4;
      end Components;
      annotation(
        uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
        Documentation(info="<html>
    <p>Gas Washing Circuit of a Basic Oxygen Furnace
    <p>Developed by ISQ, for the WaterWatt project</p>
    <p>To simulate the IWC operation, run the simulation for the CircuitTable model</p>
    </html>"));
    end CS4;



    package CS9
      extends Modelica.Icons.ExamplesPackage;

      partial model CircuitBase
        extends WaterWatt.Icons.BaseExample;
        inner WaterWatt.System system annotation(
          Placement(visible = true, transformation(origin = {-170, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.PulpTank feedTank(A = 400, V0 = feedTank.A * feedTank.y0, y0 = 1, ymax = 1.41, ymin = -1.41, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {-88, 68}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.PulpTank dilutionTank(A = 525, V0 = dilutionTank.A * dilutionTank.y0, y0 = 4, ymax = 0.86, ymin = -0.86, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {-162, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.PulpPipe pipeToDilutionTank(A = 0.002, Cfnom = 0.005, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -7.1, L = 10, dpnom = 83700, omega = 0.141, wnom = 52 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-164, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        CS9.Components.LICAR_TES8_150 giroTKF3(CheckValve = true, motorEfficiency = 0.917, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-98, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CS9.Components.LICAR_TES8_150 giroTKF1(motorEfficiency = 0.917, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-98, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.WaterTank waterwasteF1(A = 100, V0 = waterwasteF1.A * waterwasteF1.y0, y0 = 1.5, ymax = 2, ymin = -2, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {-30, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.BulkTank bulkwasteF1(A = 100, V0 = bulkwasteF1.A * bulkwasteF1.y0, y0 = 0.3, ymax = 0.57, ymin = -0.57, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {10, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.WaterTank waterwasteF3(A = 100, V0 = waterwasteF1.A * waterwasteF1.y0, y0 = waterwasteF1.y0, ymax = 2, ymin = -2, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {52, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.BulkTank bulkwasteF3(A = 100, V0 = bulkwasteF1.A * bulkwasteF1.y0, y0 = bulkwasteF1.y0, ymax = 0.57, ymin = -0.57, ystart = 0) annotation(
          Placement(visible = true, transformation(origin = {92, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.PulpPressDrop feederToMachine(dpnom = 93100, wnom = 514 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-30, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        CS9.Components.LICAR_TW8_150 waterTKF1(motorEfficiency = 0.907, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {-14, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CS9.Components.LICAR_TW8_150 waterTKF3(motorEfficiency = 0.907, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {68, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CS9.Components.LICAR_TW6_80 bulkTKF1(motorEfficiency = 0.887, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {26, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        CS9.Components.LICAR_TW6_80 bulkTKF3(motorEfficiency = 0.887, use_in_n = true, use_in_tax = true) annotation(
          Placement(visible = true, transformation(origin = {108, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        WaterWatt.Components.Slurry.PulpPipe pipeToMachine(A = 0.009, Cfnom = 0.005, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -8, L = 15, dpnom = 100, omega = 0.344, pstart = 1.82e5, wnom = 514 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        WaterWatt.Components.Slurry.BulkPipe pipeBulkTKF1(A = 0.002, Cfnom = 0.005, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = 7.4, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 10, dpnom = 109000, omega = 0.141, pstart = 2.885e5, wnom = 57 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {32, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.Slurry.BulkPipe pipeBulkTKF3(A = 0.002, Cfnom = 0.005, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = 7.4, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 10, dpnom = 109000, omega = 0.141, pstart = 2.885e5, wnom = 57 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {114, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.Slurry.PulpPipe pipeGiroTKF1(A = 0.006, Cfnom = 0.005, DynamicMomentum = false, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = 7.1, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 10, dpnom = 209000, omega = 0.281, pstart = 3.8e5, wnom = 226 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-92, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.Slurry.PulpPipe pipeGiroTKF3(A = 0.006, Cfnom = 0.005, DynamicMomentum = false, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = 7.1, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 10, dpnom = 209000, omega = 0.281, pstart = 3.8e5, wnom = 226 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-74, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.Slurry.WaterPipe pipeWaterTKF1(A = 0.006, Cfnom = 0.005, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = 0, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 10, dpnom = 387000, omega = 0.264, pstart = 5.14e5, wnom = 200 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-160, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.Slurry.WaterPipe pipeWaterTKF3(A = 0.006, Cfnom = 0.005, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = 0, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 10, dpnom = 387000, omega = 0.264, pstart = 4.84e5, wnom = 200 * 999 / 3600) annotation(
          Placement(visible = true, transformation(origin = {-176, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        WaterWatt.Components.Slurry.PressMachine pressMachine(bulkF1_ratio = 57 / 514, bulkF3_ratio = 57 / 514, waterF1_ratio = 200 / 514, waterF3_ratio = 200 / 514) annotation(
          Placement(visible = true, transformation(origin = {-16, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        connect(feedTank.outlet, pipeToMachine.infl) annotation(
          Line(points = {{-96, 62}, {-97, 62}, {-97, 60}, {-96, 60}, {-96, 54}, {-30, 54}, {-30, 50}}, color = {0, 0, 255}));
        connect(pipeToDilutionTank.infl, feedTank.outlet) annotation(
          Line(points = {{-164, 40}, {-164, 40}, {-164, 62}, {-96, 62}, {-96, 62}}, color = {0, 0, 255}));
        connect(pipeToDilutionTank.outfl, dilutionTank.inletTop) annotation(
          Line(points = {{-164, 20}, {-164, 20.25}, {-162, 20.25}, {-162, -18}}, color = {0, 0, 255}));
        connect(pipeWaterTKF1.outfl, dilutionTank.inlet) annotation(
          Line(points = {{-160, -54}, {-160, -48}, {-170, -48}, {-170, -32}}, color = {0, 0, 255}));
        connect(pipeWaterTKF3.outfl, dilutionTank.inlet) annotation(
          Line(points = {{-176, -54}, {-176, -48}, {-170, -48}, {-170, -32}}, color = {0, 0, 255}));
        connect(dilutionTank.outlet, giroTKF3.infl) annotation(
          Line(points = {{-154, -32}, {-140, -32}, {-140, -72}, {-106, -72}}, color = {0, 0, 255}));
        connect(dilutionTank.outlet, giroTKF1.infl) annotation(
          Line(points = {{-154, -32}, {-140, -32}, {-140, -24}, {-106, -24}}, color = {0, 0, 255}));
        connect(pressMachine.outletBulkF3, bulkwasteF3.inletTop) annotation(
          Line(points = {{-2, -16}, {-2, -20}, {94, -20}, {94, -28}}, color = {0, 0, 255}));
        connect(pressMachine.outletBulkF1, bulkwasteF1.inletTop) annotation(
          Line(points = {{-22, -16}, {-20, -16}, {-20, -24}, {10, -24}, {10, -30}}, color = {0, 0, 255}));
        connect(pressMachine.outletWaterF3, waterwasteF3.inletTop) annotation(
          Line(points = {{-10, -16}, {-10, -16}, {-10, -22}, {52, -22}, {52, -26}, {52, -26}}, color = {0, 0, 255}));
        connect(pressMachine.outletWaterF1, waterwasteF1.inletTop) annotation(
          Line(points = {{-30, -16}, {-30, -16}, {-30, -26}, {-30, -26}}, color = {0, 0, 255}));
        connect(feederToMachine.outlet, pressMachine.inletPulp) annotation(
          Line(points = {{-30, 2}, {-30, 2}, {-30, -4}, {-30, -4}}, color = {0, 0, 255}));
        connect(pipeGiroTKF1.outfl, feedTank.inlet) annotation(
          Line(points = {{-92, 40}, {-92, 40}, {-92, 48}, {-80, 48}, {-80, 62}, {-80, 62}}, color = {0, 0, 255}));
        connect(bulkwasteF3.outlet, bulkTKF3.infl) annotation(
          Line(points = {{100, -42}, {100, -42}, {100, -82}, {100, -82}}, color = {0, 0, 255}));
        connect(pipeBulkTKF3.infl, bulkTKF3.outfl) annotation(
          Line(points = {{114, 30}, {114, 30}, {114, -76}, {114, -76}}, color = {0, 0, 255}));
        connect(giroTKF3.outfl, pipeGiroTKF3.infl) annotation(
          Line(points = {{-92, -66}, {-74, -66}, {-74, 20}}, color = {0, 0, 255}));
        connect(pipeGiroTKF3.outfl, feedTank.inlet) annotation(
          Line(points = {{-74, 40}, {-74, 48}, {-80, 48}, {-80, 62}}, color = {0, 0, 255}));
        connect(giroTKF1.outfl, pipeGiroTKF1.infl) annotation(
          Line(points = {{-92, -18}, {-92, 20}}, color = {0, 0, 255}));
        connect(pipeBulkTKF3.outfl, feedTank.inlet) annotation(
          Line(points = {{112, 50}, {112, 62}, {-80, 62}}, color = {0, 0, 255}));
        connect(waterTKF3.outfl, pipeWaterTKF3.infl) annotation(
          Line(points = {{74, -76}, {78, -76}, {78, -98}, {-176, -98}, {-176, -74}}, color = {0, 0, 255}));
        connect(waterTKF1.outfl, pipeWaterTKF1.infl) annotation(
          Line(points = {{-8, -76}, {-4, -76}, {-4, -94}, {-160, -94}, {-160, -74}}, color = {0, 0, 255}));
        connect(bulkwasteF1.outlet, bulkTKF1.infl) annotation(
          Line(points = {{18, -44}, {18, -82}}, color = {0, 0, 255}));
        connect(waterwasteF3.outlet, waterTKF3.infl) annotation(
          Line(points = {{60, -40}, {60, -82}}, color = {0, 0, 255}));
        connect(waterwasteF1.outlet, waterTKF1.infl) annotation(
          Line(points = {{-22, -40}, {-22, -82}}, color = {0, 0, 255}));
        connect(bulkTKF1.outfl, pipeBulkTKF1.infl) annotation(
          Line(points = {{32, -76}, {32, 30}}, color = {0, 0, 255}));
        connect(pipeBulkTKF1.outfl, feedTank.inlet) annotation(
          Line(points = {{32, 50}, {32, 62}, {-80, 62}}, color = {0, 0, 255}));
        connect(pipeToMachine.outfl, feederToMachine.inlet) annotation(
          Line(points = {{-30, 32}, {-30, 22}}, color = {0, 0, 255}));
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1})),
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
      end CircuitBase;

      model CircuitTable
        extends CS9.CircuitBase(giroTKF1.use_in_n = true, bulkTKF1.use_in_n = true, waterTKF1.use_in_n = true, waterTKF3.use_in_n = true, bulkTKF3.use_in_n = true, giroTKF1.use_in_tax = true, giroTKF3.use_in_n = true, giroTKF3.use_in_tax = true, waterTKF1.use_in_tax = true, bulkTKF1.use_in_tax = true, waterTKF3.use_in_tax = true, bulkTKF3.use_in_tax = true, pipeWaterTKF3.HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, pipeWaterTKF1.HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, pipeGiroTKF1.HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, pipeGiroTKF3.HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, pipeBulkTKF1.HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, pipeBulkTKF3.HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, pipeToDilutionTank.noInitialPressure = false, system.initOpt = ThermoPower.Choices.Init.Options.noInit, pipeToMachine.pstart = 2e5, giroTKF1.dp0.displayUnit = "Pa", giroTKF1.motorEfficiency = 0.942, giroTKF3.motorEfficiency = 0.942, waterTKF1.motorEfficiency = 0.936, waterTKF3.motorEfficiency = 0.936, bulkTKF1.motorEfficiency = 0.921, bulkTKF3.motorEfficiency = 0.921);
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.TimeTable giroTKF1_rpm(table = [0, 1450; 3600, 1450]) annotation(
          Placement(visible = true, transformation(origin = {-117, -9}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable giroTKF3_rpm(table = [0, 1450; 3600, 1450]) annotation(
          Placement(visible = true, transformation(origin = {-119, -57}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable waterTKF1_rpm(table = [0, 1450; 3600, 1450]) annotation(
          Placement(visible = true, transformation(origin = {-37, -69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable waterTKF3_rpm(table = [0, 1450; 3600, 1450]) annotation(
          Placement(visible = true, transformation(origin = {47, -69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable bulkTKF3_rpm(table = [0, 1450; 3600, 1450]) annotation(
          Placement(visible = true, transformation(origin = {89, -69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable bulkTKf1_rpm(table = [0, 1450; 3600, 1450]) annotation(
          Placement(visible = true, transformation(origin = {7, -69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        Modelica.Blocks.Sources.TimeTable tax(table = [0, 0.13; 3600, 0.13]) annotation(
          Placement(visible = true, transformation(origin = {-117, 13}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
        inner KPI KPI_9(NPP1 = giroTKF1.NEP + giroTKF3.NEP, NPP2 = waterTKF1.NEP + waterTKF3.NEP, NPP3 = bulkTKF1.NEP + bulkTKF3.NEP, NQ1 = giroTKF1.NVFR + giroTKF3.NVFR, NQ2 = waterTKF1.NVFR + waterTKF3.NVFR, NQ3 = bulkTKF1.NVFR + bulkTKF3.NVFR, P = giroTKF1.EP + giroTKF3.EP + waterTKF1.EP + waterTKF3.EP + bulkTKF1.EP + bulkTKF3.EP, Q = -feedTank.VFR_outlet) annotation(
          Placement(visible = true, transformation(origin = {182, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(waterTKF1_rpm.y, waterTKF1.in_n) annotation(
          Line(points = {{-30, -68}, {-16, -68}, {-16, -76}, {-16, -76}}, color = {0, 0, 127}));
        connect(tax.y, bulkTKF3.tax) annotation(
          Line(points = {{-110, 14}, {-98, 14}, {-98, -52}, {108, -52}, {108, -76}, {108, -76}}, color = {0, 0, 127}));
        connect(tax.y, waterTKF3.tax) annotation(
          Line(points = {{-110, 14}, {-98, 14}, {-98, -52}, {68, -52}, {68, -76}, {68, -76}}, color = {0, 0, 127}));
        connect(tax.y, bulkTKF1.tax) annotation(
          Line(points = {{-110, 14}, {-98, 14}, {-98, -52}, {26, -52}, {26, -76}, {26, -76}}, color = {0, 0, 127}));
        connect(tax.y, waterTKF1.tax) annotation(
          Line(points = {{-110, 14}, {-98, 14}, {-98, -52}, {-14, -52}, {-14, -76}, {-14, -76}}, color = {0, 0, 127}));
        connect(tax.y, giroTKF3.tax) annotation(
          Line(points = {{-110, 14}, {-98, 14}, {-98, -66}, {-98, -66}}, color = {0, 0, 127}));
        connect(tax.y, giroTKF1.tax) annotation(
          Line(points = {{-110, 14}, {-98, 14}, {-98, -18}, {-98, -18}}, color = {0, 0, 127}));
        connect(bulkTKF3_rpm.y, bulkTKF3.in_n) annotation(
          Line(points = {{95, -69}, {105, -69}, {105, -76}}, color = {0, 0, 127}));
        connect(waterTKF3_rpm.y, waterTKF3.in_n) annotation(
          Line(points = {{55, -67}, {66, -67}, {66, -76}}, color = {0, 0, 127}));
        connect(bulkTKf1_rpm.y, bulkTKF1.in_n) annotation(
          Line(points = {{15, -67}, {24, -67}, {24, -76}}, color = {0, 0, 127}));
        connect(giroTKF3_rpm.y, giroTKF3.in_n) annotation(
          Line(points = {{-112, -56}, {-100, -56}, {-100, -66}, {-100, -66}}, color = {0, 0, 127}));
        connect(giroTKF1_rpm.y, giroTKF1.in_n) annotation(
          Line(points = {{-110, -8}, {-100, -8}, {-100, -18}, {-100, -18}}, color = {0, 0, 127}));
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1})),
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, initialScale = 0.1)),
          experiment(StartTime = 0, StopTime = 3e+06, Tolerance = 1e-06, Interval = 6000));
      end CircuitTable;

      model Components
        extends Modelica.Icons.Package;

        model LICAR_TES8_150
          extends WaterWatt.Components.Slurry.PulpPump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(q_nom = {100, 300, 400} * (1 / 3600), head_nom = {32.3, 27, 23.5}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {100, 300, 400} * (1 / 3600), eta_nom = {0.5, 0.72, 0.75}), w0 = 226 * 999 / 3600, dp0 = 28.5 * 9.81 * 999, n0 = 1450, V = 0.01, rho0 = 999);
        end LICAR_TES8_150;

        model LICAR_TW8_150
          extends WaterWatt.Components.Slurry.WaterPump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(q_nom = {50, 350, 400} * (1 / 3600), head_nom = {40.7, 32.9, 30}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {50, 350, 400} * (1 / 3600), eta_nom = {0.3, 0.735, 0.755}), w0 = 200 * 999 / 3600, dp0 = 39.5 * 9.81 * 999, n0 = 1450, V = 0.01, rho0 = 999);
        end LICAR_TW8_150;

        model LICAR_TW6_80
          extends WaterWatt.Components.Slurry.BulkPump(redeclare function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(q_nom = {25, 100, 150} * (1 / 3600), head_nom = {20.2, 15.5, 9.4}), redeclare function efficiencyCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticEfficiency(q_nom = {25, 100, 150} * (1 / 3600), eta_nom = {0.42, 0.66, 0.61}), w0 = 57 * 999 / 3600, dp0 = 18.6 * 9.81 * 999, n0 = 1450, V = 0.01, rho0 = 999);
        end LICAR_TW6_80;

        model Accum
          extends WaterWatt.Components.BaseClasses.Accumulator(redeclare package Medium = WaterWatt.Media.Pulp);
        initial equation
          if initOpt == ThermoPower.Choices.Init.Options.noInit then
          end if;
        end Accum;
      end Components;
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        uses(Modelica(version = "3.2.2"), ThermoPower(version = "3.1")),
        Documentation(info="<html>
    <p>Fiber transportation circuit in a paper & pulp plant
    <p>Developed by ISQ, for the WaterWatt project</p>
    <p>To simulate the IWC operation, run the simulation for the CircuitTable model</p>
    </html>"));
    end CS9;

  annotation(Documentation(info="<html>
    <p>To simulate the IWC operation, run the simulation for the CircuitTable models</p>
    </html>"));

  end Examples;








  package Components
    extends Modelica.Icons.Package;

    package ColdWater
      extends Modelica.Icons.Package;

      model SourcePressure
        extends ThermoPower.Water.SourcePressure(redeclare package Medium = Media.ColdWater, final use_in_h = false, final use_T = true, T = system.T_amb);
      end SourcePressure;

      model SinkPressure
        extends ThermoPower.Water.SinkPressure(redeclare package Medium = Media.ColdWater, final use_in_h = false, final use_T = true, T = system.T_amb);
      end SinkPressure;

      model SourceMassFlow
        extends ThermoPower.Water.SourceMassFlow(redeclare package Medium = Media.ColdWater, final use_in_h = false, final use_T = true, T = system.T_amb);
        WaterWatt.Units.VolumeFlowRate_mch VFR = w * 3600 / 999 "volume flowrate in m3/h (standard density)";
      end SourceMassFlow;

      model SinkMassFlow
        extends ThermoPower.Water.SinkMassFlow(redeclare package Medium = Media.ColdWater, final use_in_h = false, final use_T = true, T = system.T_amb);
        WaterWatt.Units.VolumeFlowRate_mch VFR = w * 3600 / 999 "volume flowrate in m3/h (standard density)";
      end SinkMassFlow;

      model Pump "Centrifugal pump with varying motor rotational speed"
        extends WaterWatt.Components.BaseClasses.Pump(redeclare replaceable package Medium = Media.ColdWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
      end Pump;

      model PressDrop "Pressure drop inducer"
        extends WaterWatt.Components.BaseClasses.PressDrop(redeclare package Medium = Media.ColdWater, rhonom = 999, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint);
      end PressDrop;

      model Tank "Water Tank"
        extends WaterWatt.Components.BaseClasses.Tank(redeclare package Medium = Media.ColdWater);
      end Tank;

      model Pipe "Section of a pipeline system"
        extends WaterWatt.Components.BaseClasses.Pipe(redeclare package Medium = Media.ColdWater, final N = 2, final Nw = 1, Nt = 1, final rhonom = 999, initOpt = ThermoPower.Choices.Init.Options.steadyState);
        annotation(
          experiment(StartTime = 0, StopTime = 3600, Tolerance = 1e-06, Interval = 7.2));
      end Pipe;
      
      annotation(Documentation(info="<html>
    <p>Adaptations to component models existing in ThermoPower performed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
    </html>"));
      
    end ColdWater;






    package WaterSteam
      extends Modelica.Icons.Package;

      model SourcePressure
        extends ThermoPower.Water.SourcePressure(redeclare package Medium = Media.WaterSteam, final use_in_h = false, final use_T = true, T = system.T_amb);
      end SourcePressure;

      model SinkPressure
        extends ThermoPower.Water.SinkPressure(redeclare package Medium = Media.WaterSteam, final use_in_h = false, final use_T = true, T = system.T_amb);
      end SinkPressure;

      model SourceMassFlow
        extends ThermoPower.Water.SourceMassFlow(redeclare package Medium = Media.WaterSteam, final use_in_h = false, final use_T = true, T = system.T_amb);
        WaterWatt.Units.VolumeFlowRate_mch VFR = w * 3600 / 999 "volume flowrate in m3/h (standard density)";
      end SourceMassFlow;

      model SinkMassFlow
        extends ThermoPower.Water.SinkMassFlow(redeclare package Medium = Media.WaterSteam, final use_in_h = false, final use_T = true, T = system.T_amb);
        WaterWatt.Units.VolumeFlowRate_mch VFR = w * 3600 / 999 "volume flowrate in m3/h (standard density)";
      end SinkMassFlow;

      model Pump "Centrifugal pump with varying motor rotational speed"
        extends WaterWatt.Components.BaseClasses.Pump(redeclare replaceable package Medium = Media.WaterSteam constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
      end Pump;

      model PressDrop "Pressure drop inducer"
        extends WaterWatt.Components.BaseClasses.PressDrop(redeclare package Medium = Media.WaterSteam, rhonom = 999, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint);
      end PressDrop;

      model Tank "Water Tank"
        extends WaterWatt.Components.BaseClasses.Tank(redeclare package Medium = Media.WaterSteam);
      end Tank;

      model Pipe "Section of a pipeline system"
        extends WaterWatt.Components.BaseClasses.Pipe(redeclare package Medium = Media.WaterSteam, final Nw = N - 1, Nt = 1, final rhonom = 999);
      end Pipe;

      model BarometricCondenser "Barometric Condenser with inlet of a cold water stream and steam"
        extends ThermoPower.Water.BarometricCondenser(redeclare package Medium = Media.WaterSteam, final Tr = 1, final Tt = 5, final neglectLegDynamics = true);
        WaterWatt.Units.Power_kW TPC = hl * wl * 0.001 - hc * wl * 0.001 "Thermal Power Cosumption by the Water stream";
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Text(origin = {228, 17}, rotation = -90, lineColor = {0, 0, 255}, extent = {{-46, -29}, {46, 29}}, textString = "%name")}));
      end BarometricCondenser;

      model CoolingTower "Open circuit cooling tower"
        extends WaterWatt.Components.BaseClasses.CoolingTower(final k_wa_nom = k_wa_tot);
        parameter Real k_wa_tot "Overall mass and heat transfer coefficient";
        WaterWatt.Units.VolumeFlowRate_mch VFR = wl[N] * 3600 / 999 "volume flowrate in m3/h";
      end CoolingTower;

      model Accumulator
        extends WaterWatt.Components.BaseClasses.Accumulator(redeclare package Medium = Media.WaterSteam);
      end Accumulator;

      model ExpansionTankIdeal
        extends ThermoPower.Water.ExpansionTankIdeal(redeclare package Medium = Media.WaterSteam);
      end ExpansionTankIdeal;

      model TemperatureSensor
        extends ThermoPower.Water.SensT1(redeclare package Medium = Media.WaterSteam);
      end TemperatureSensor;

      package Special "Components for specific cases, developed in the scope of the WaterWatt project"
        extends Modelica.Icons.Package;

        model GasScrubber "Venturi scrubber"
          parameter SI.MassFlowRate w_water = 255 * 999 / 3600 "Mass flow rate of water stream" annotation(
            Dialog(group = "Water Flow Parameters"));
          parameter SI.MassFlowRate w_gas = w_water * 0.26 "Mass flow rate of gas stream" annotation(
            Dialog(group = "Gas Flow Parameters"));
          parameter Modelica.SIunits.Temperature T_inlet_gas = 70 + 273.15 "Inlet Temperature of gas stream" annotation(
            Dialog(group = "Gas Flow Parameters"));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer h_water = 50 "Water Heat Transfer Coefficient" annotation(
            Dialog(group = "Water Flow Parameters"));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer h_gas = 30 "Gas Heat Transfer Coefficient" annotation(
            Dialog(group = "Gas Flow Parameters"));
          parameter Modelica.SIunits.Volume V = 50 "Inner Volume" annotation(
            Dialog(group = "Gas Scrubber Parameters"));
          parameter Modelica.SIunits.Area S = 130 "Inner Area" annotation(
            Dialog(group = "Gas Scrubber Parameters"));
          parameter Modelica.SIunits.Distance H = 4 "Elevation of inlet over outlet" annotation(
            Dialog(group = "Gas Scrubber Parameters"));
          parameter WaterWatt.Media.WaterSteam.AbsolutePressure pstart = 1e5 "Hot fluid Pressure start value" annotation(
            Dialog(tab = "Initialisation"));
          parameter Boolean noInitialPressure = true "Remove initial equation on pressure" annotation(
            Dialog(tab = "Initialisation"),
            choices(checkBox = true));
          Modelica.SIunits.Temperature T_outlet_water = header_water.T "Water Outlet Temperature";
          Modelica.SIunits.Temperature T_outlet_gas = header_gas.gas.T "Gas Outlet Temperature";
          WaterWatt.Units.Power_kW TPC = header_water.thermalPort.Q_flow * 0.001 "Thermal Power Cosumption by the Water stream";
          ThermoPower.Water.Header header_water(Cm = 1000, H = H, S = S, V = V, gamma = h_water, noInitialPressure = noInitialPressure, pstart = pstart) annotation(
            Placement(visible = true, transformation(extent = {{-10, -44}, {10, -24}}, rotation = 0)));
          ThermoPower.Gas.Header header_gas(redeclare package Medium = Modelica.Media.Air.DryAirNasa, Cm = 1000, S = S, Tm(displayUnit = "K"), V = V, gamma = h_gas, initOpt = ThermoPower.Choices.Init.Options.fixedState, noInitialPressure = false, pstart = 101325) annotation(
            Placement(visible = true, transformation(extent = {{-10, 50}, {10, 30}}, rotation = 0)));
          ThermoPower.Gas.SourceMassFlow air_sourceMassFlow(redeclare package Medium = Modelica.Media.Air.DryAirNasa, T = T_inlet_gas, w0 = w_gas) annotation(
            Placement(visible = true, transformation(extent = {{-82, 30}, {-62, 50}}, rotation = 0)));
          ThermoPower.Gas.SinkMassFlow air_sinkMassFlow(redeclare package Medium = Modelica.Media.Air.DryAirNasa, w0 = w_gas) annotation(
            Placement(transformation(extent = {{68, 30}, {88, 50}})));
          inner ThermoPower.System system(initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
            Placement(visible = true, transformation(origin = {-84, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          ThermoPower.Water.FlangeA flangeA1 annotation(
            Placement(visible = true, transformation(origin = {-84, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-52, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          ThermoPower.Water.FlangeB flangeB1 annotation(
            Placement(visible = true, transformation(origin = {82, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {52, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          ThermoPower.Thermal.HT_DHTVolumes Adapter_air annotation(
            Placement(visible = true, transformation(origin = {0, 20}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
          ThermoPower.Thermal.HT_DHTVolumes Adapter_water annotation(
            Placement(visible = true, transformation(origin = {0, -14}, extent = {{6, -6}, {-6, 6}}, rotation = -90)));
        equation
          connect(Adapter_air.DHT_port, Adapter_water.DHT_port) annotation(
            Line(points = {{0, 14}, {0, 14}, {0, -8}, {0, -8}}, color = {255, 127, 0}));
          connect(header_water.outlet, flangeB1) annotation(
            Line(points = {{10, -34}, {84, -34}, {84, -34}, {82, -34}}, color = {0, 0, 255}));
          connect(flangeA1, header_water.inlet) annotation(
            Line(points = {{-84, -34}, {-10, -34}, {-10, -34}, {-10, -34}}, color = {0, 0, 255}));
          connect(Adapter_water.HT_port, header_water.thermalPort) annotation(
            Line(points = {{0, -22}, {0, -22}, {0, -28}, {0, -28}}, color = {191, 0, 0}));
          connect(header_gas.thermalPort, Adapter_air.HT_port) annotation(
            Line(points = {{0, 34}, {0, 34}, {0, 28}, {0, 28}}, color = {191, 0, 0}));
          connect(header_gas.outlet, air_sinkMassFlow.flange) annotation(
            Line(points = {{10, 40}, {68, 40}, {68, 40}, {68, 40}}, color = {159, 159, 223}));
          connect(air_sourceMassFlow.flange, header_gas.inlet) annotation(
            Line(points = {{-62, 40}, {-10, 40}, {-10, 40}, {-10, 40}}, color = {159, 159, 223}));
          annotation(
            Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {80, 60}}), graphics = {Line(origin = {-40, 0}, points = {{0, 40}, {0, -40}}), Line(origin = {40, 0}, points = {{0, 40}, {0, -40}}), Ellipse(origin = {0, 40}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-40, 6}, {40, -6}}, endAngle = 360), Ellipse(origin = {0, -40}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-40, -2}, {40, 2}}, endAngle = 360), Line(origin = {-10, 45}, points = {{0, -5}, {0, 5}}), Line(origin = {10, 45}, points = {{0, -5}, {0, 5}}), Ellipse(origin = {0, 51}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-12, 1}, {12, -1}}, endAngle = 360), Line(origin = {-12, 52}, points = {{0, 0}, {0, 0}}), Ellipse(origin = {0, 55}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-12, -1}, {12, 1}}, endAngle = 360), Ellipse(origin = {0, 53}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-12, 1}, {12, -1}}, endAngle = 360), Rectangle(lineColor = {188, 188, 188}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Line(origin = {-40, 0}, points = {{0, -40}, {0, 40}, {0, 40}, {0, 40}}), Line(origin = {40, 0}, points = {{0, -40}, {0, 40}}), Ellipse(origin = {0, 40}, extent = {{-40, 6}, {40, -6}}, endAngle = 360), Rectangle(origin = {0, 45}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, extent = {{-10, -5}, {10, 5}})}),
            Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {80, 60}})),
            experiment(StartTime = 0, StopTime = 3600, Tolerance = 1e-06, Interval = 7.2),
            __OpenModelica_commandLineOptions = "",
            Documentation(info="<html>
        <p>Created and developed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
        </html>"));
        end GasScrubber;



        model CoolingTowerClosed "Closed circuit cooling tower"
          extends WaterWatt.Components.BaseClasses.CoolingTowerClosed;
          parameter Boolean use_in_tax = false "Use connector tax to compute the total cost, otherwise the total cost is forced to zero" annotation(
            Dialog(group = "External inputs"),
            choices(checkBox = true));
          WaterWatt.Units.Power_kW EP = coolingTower.Wtot * 0.001 "cooling tower accounting motor efficiency in kW";
          WaterWatt.Units.EnergyConsumption_kWh_per_hour ELC = coolingTower.Wtot * 0.001 "pump energy consumption accounting motor efficiency in kWh/hour";
          WaterWatt.Units.Per_hour CP "Cost of electricity consumption per year";
          Modelica.SIunits.Temperature Tlin = cooledFlow.T[1] "Inlet Temperature";
          Modelica.SIunits.Temperature Tlout = cooledFlow.T[N] "Outlet Temperature";
          Modelica.SIunits.Temperature Tdb = system.T_amb "Dry bulb Temperature";
          WaterWatt.Units.VolumeFlowRate_mch VFR = cooledFlow.w * 3600 / 999 "pump volume flowrate in m3/h";
          WaterWatt.Units.Power_kW TPS = cooledFlow.Q * 0.001 "Thermal Power Supply by the process water stream";
          Modelica.Blocks.Interfaces.RealInput tax(unit = "1/(kW.h)") if use_in_tax annotation(
            Placement(visible = true, transformation(origin = {-92, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        protected
          Modelica.Blocks.Interfaces.RealInput tax_int(unit = "1/(kW.h)") "Internal connector for tax";
        equation
          CP = ELC * tax_int "total cost (euro per year)";
// conditional input
          connect(tax, tax_int);
          if not use_in_tax then
            tax_int = 0 "cost is forced to zero";
          end if;
        end CoolingTowerClosed;

        model InductiveFurnace "Inductive Furnace of a Iron & Steel plant encompassing a water cooling system"
          parameter Modelica.SIunits.Distance L = 220 "Cooling Water Tube Length" annotation(
            Dialog(group = "Tube Parameters"));
          parameter Modelica.SIunits.Distance D = 0.08 "Cooling Water Tube Diameter" annotation(
            Dialog(group = "Tube Parameters"));
          parameter SI.MassFlowRate wnom = 30 * 999 / 3600 "Cooling Water Flow rate" annotation(
            Dialog(group = "Fluid Flow Parameters"));
          parameter WaterWatt.Media.WaterSteam.AbsolutePressure pstart = 1e5 "Water Flow Pressure start value" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"));
          parameter SI.PressureDifference dpnom = 1e5 "Tube Nominal pressure drop (friction term only!)" annotation(
            Dialog(group = "Tube Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy hstartin = if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Inlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy hstartout = if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Outlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"));
          parameter Boolean noInitialPressure = false "Remove initial equation on pressure" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"),
            choices(checkBox = true));
          parameter Modelica.SIunits.Temperature CrucibleWall_Tstart = 1907.15 annotation(
            Dialog(tab = "Initialisation", group = "Crucible Wall Parameters"));
          parameter Modelica.SIunits.Temperature CoilWall_Tstart = 608.15 annotation(
            Dialog(tab = "Initialisation", group = "Coil Wall Parameters"));
          Modelica.SIunits.Temperature T_in = pipe.T[1] "Inlet Temperature";
          Modelica.SIunits.Temperature T_out = pipe.T[pipe.N] "Outlet Temperature";
          WaterWatt.Units.VolumeFlowRate_mch VFR = pipe.w * 3600 / 999 "pump volume flowrate in m3/h";
          WaterWatt.Units.Power_kW TPC = ThermalPower "Thermal Power Cosumption by the Water stream";
          WaterWatt.Components.WaterSteam.Pipe pipe(A = 3.1416 * 0.25 * D ^ 2, DynamicMomentum = false, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = L, dpnom = dpnom, hstartin = hstartin, hstartout = hstartout, noInitialPressure = noInitialPressure, omega = 3.1416 * D, pstart = pstart, wnom = wnom) annotation(
            Placement(visible = true, transformation(origin = {1, -79}, extent = {{-31, -31}, {31, 31}}, rotation = 0)));
          ThermoPower.Thermal.HeatSource1DFV heatSource1DFV1 annotation(
            Placement(visible = true, transformation(origin = {-1, 55}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
          ThermoPower.Water.FlangeA WaterInlet annotation(
            Placement(visible = true, transformation(origin = {-162, -78}, extent = {{-22, -22}, {22, 22}}, rotation = 0), iconTransformation(origin = {-68, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          ThermoPower.Water.FlangeB WaterOutlet annotation(
            Placement(visible = true, transformation(origin = {160, -76}, extent = {{-24, -24}, {24, 24}}, rotation = 0), iconTransformation(origin = {68, -68}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput ThermalPower(unit = "kW") annotation(
            Placement(visible = true, transformation(origin = {-150, 70}, extent = {{-32, -32}, {32, 32}}, rotation = 0), iconTransformation(origin = {-80, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          ThermoPower.Thermal.MetalWallFV CoilWall(M = 41.2, UA_ext = 401, WallRes = true, cm = 390, Tstartbar = CoilWall_Tstart) annotation(
            Placement(visible = true, transformation(origin = {1, -31}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
          ThermoPower.Thermal.MetalWallFV CrucibleWall(M = 41.2, UA_ext = 120, WallRes = true, cm = 750, Tstartbar = CrucibleWall_Tstart) annotation(
            Placement(visible = true, transformation(origin = {1, 7}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
          Modelica.Blocks.Math.Product Product annotation(
            Placement(visible = true, transformation(origin = {-50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.RealExpression Thousand(y = 1000) annotation(
            Placement(visible = true, transformation(origin = {-84, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(Product.y, heatSource1DFV1.power) annotation(
            Line(points = {{-38, 80}, {0, 80}, {0, 70}, {0, 70}}, color = {0, 0, 127}));
          connect(Thousand.y, Product.u1) annotation(
            Line(points = {{-72, 86}, {-62, 86}, {-62, 86}, {-62, 86}}, color = {0, 0, 127}));
          connect(ThermalPower, Product.u2) annotation(
            Line(points = {{-150, 70}, {-64, 70}, {-64, 74}, {-62, 74}}, color = {0, 0, 127}));
          connect(CoilWall.int, CrucibleWall.ext) annotation(
            Line(points = {{2, -22}, {0, -22}, {0, -3}, {1, -3}}, color = {255, 127, 0}));
          connect(heatSource1DFV1.wall, CrucibleWall.int) annotation(
            Line(points = {{0, 44}, {0, 28}, {1, 28}, {1, 17}}, color = {255, 127, 0}));
          connect(pipe.outfl, WaterOutlet) annotation(
            Line(points = {{32, -78}, {158, -78}, {158, -76}, {160, -76}}, color = {0, 0, 255}));
          connect(pipe.wall, CoilWall.ext) annotation(
            Line(points = {{2, -64}, {0, -64}, {0, -42}, {2, -42}}, color = {255, 127, 0}));
          connect(WaterInlet, pipe.infl) annotation(
            Line(points = {{-162, -78}, {-26, -78}, {-26, -78}, {-28, -78}, {-28, -78}, {-30, -78}}, color = {0, 0, 255}));
          annotation(
            Diagram,
            Icon(graphics = {Ellipse(origin = {0, 70}, extent = {{-60, 10}, {60, -10}}, endAngle = 360), Line(origin = {-60, 15}, points = {{0, -55}, {0, 55}}), Line(origin = {70, 81}, points = {{-10, -11}, {10, 11}}), Line(origin = {73, 55}, points = {{-13, -15}, {13, 15}}), Line(origin = {0, -59.8292}, points = {{-60, 19.8292}, {-40, -20.1708}, {40, -20.1708}, {60, 19.8292}, {60, 19.8292}}), Line(origin = {60, 0}, points = {{0, -40}, {0, 40}}), Polygon(origin = {0, -30}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-60, 50}, {60, 50}, {60, -10}, {40, -50}, {-40, -50}, {-60, -12}, {-60, -10}, {-60, 50}})}),
            __OpenModelica_commandLineOptions = "",
            experiment(StartTime = 0, StopTime = 3600, Tolerance = 1e-06, Interval = 7.2));
          annotation(
            Dialog(group = "Cooling Water Tube Parameters"));
          annotation(
            Dialog(group = "Cooling Water Tube Parameters"));
          annotation(
            Dialog(group = "Fluid Parameters"),
            Documentation(info="<html>
        <p>Created and developed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
        </html>"));
        end InductiveFurnace;


        /*
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        A = 3.1416 * 0.04 ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = 0.001, dpnom = 10000, hstartin = 134.11e3, hstartout = 134.11e3, noInitialPressure = true, omega = 3.1416 * 0.04 * 2, pstart = 5.3e5, wnom = 35 * 999 / 3600
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        */

        model ThermalPowerInput "Generic Component for the input of a specific thermal power in the circuit"
          parameter Modelica.SIunits.Distance L = 220 "Cooling Water Tube Length" annotation(
            Dialog(group = "Tube Parameters"));
          parameter Modelica.SIunits.Distance D = 0.08 "Cooling Water Tube Diameter" annotation(
            Dialog(group = "Tube Parameters"));
          parameter SI.MassFlowRate wnom = 35 * 999 / 3600 "Cooling Water Flow rate" annotation(
            Dialog(group = "Fluid Flow Parameters"));
          parameter WaterWatt.Media.WaterSteam.AbsolutePressure pstart = 5.3e5 "Water Flow Pressure start value" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"));
          parameter SI.PressureDifference dpnom = 1e5 "Tube Nominal pressure drop (friction term only!)" annotation(
            Dialog(group = "Tube Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy hstartin = if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Inlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy hstartout = if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if pipe.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Outlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"));
          parameter Boolean noInitialPressure = false "Remove initial equation on pressure" annotation(
            Dialog(tab = "Initialisation", group = "Fluid Parameters"),
            choices(checkBox = true));
          Modelica.SIunits.Temperature T_in = pipe.T[1] "Inlet Temperature";
          Modelica.SIunits.Temperature T_out = pipe.T[pipe.N] "Outlet Temperature";
          WaterWatt.Units.VolumeFlowRate_mch VFR = pipe.w * 3600 / 999 "pump volume flowrate in m3/h";
          WaterWatt.Units.Power_kW TPC = ThermalPower "Thermal Power Cosumption by the Water stream";
          WaterWatt.Components.WaterSteam.Pipe pipe(A = 3.1416 * 0.25 * D ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, L = L, dpnom = dpnom, hstartin = hstartin, hstartout = hstartout, noInitialPressure = true, omega = 3.1416 * D, pstart = pstart, wnom = wnom) annotation(
            Placement(visible = true, transformation(origin = {1, -13}, extent = {{35, -35}, {-35, 35}}, rotation = 0)));
          ThermoPower.Thermal.HeatSource1DFV HeatSource annotation(
            Placement(visible = true, transformation(origin = {0, 54}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
          Modelica.Blocks.Interfaces.RealInput ThermalPower(unit = "kW") annotation(
            Placement(visible = true, transformation(origin = {-92, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          ThermoPower.Water.FlangeB WaterOutlet annotation(
            Placement(visible = true, transformation(origin = {-86, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          ThermoPower.Water.FlangeA WaterInlet annotation(
            Placement(visible = true, transformation(origin = {86, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          Modelica.Blocks.Math.Product Product annotation(
            Placement(visible = true, transformation(origin = {-26, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Modelica.Blocks.Sources.RealExpression Thousand(y = 1000) annotation(
            Placement(visible = true, transformation(origin = {-58, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(Product.y, HeatSource.power) annotation(
            Line(points = {{-14, 80}, {0, 80}, {0, 66}, {0, 66}}, color = {0, 0, 127}));
          connect(Thousand.y, Product.u1) annotation(
            Line(points = {{-46, 92}, {-44, 92}, {-44, 86}, {-38, 86}, {-38, 86}}, color = {0, 0, 127}));
          connect(ThermalPower, Product.u2) annotation(
            Line(points = {{-92, 80}, {-48, 80}, {-48, 74}, {-38, 74}, {-38, 74}}, color = {0, 0, 127}));
          connect(pipe.infl, WaterInlet) annotation(
            Line(points = {{36, -12}, {84, -12}, {84, -12}, {86, -12}}, color = {0, 0, 255}));
          connect(WaterOutlet, pipe.outfl) annotation(
            Line(points = {{-86, -12}, {-34, -12}, {-34, -12}, {-34, -12}}, color = {0, 0, 255}));
          connect(HeatSource.wall, pipe.wall) annotation(
            Line(points = {{0, 46}, {0, 46}, {0, 4}, {2, 4}}, color = {255, 127, 0}));
          annotation(
            Icon(graphics = {Rectangle(origin = {0, 60}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-80, 20}, {80, -20}}), Rectangle(fillColor = {0, 0, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 40}, {80, -40}})}, coordinateSystem(extent = {{-120, -40}, {120, 100}})),
            __OpenModelica_commandLineOptions = "",
            Diagram(coordinateSystem(extent = {{-120, -40}, {120, 100}})),
            Documentation(info="<html>
        <p>Created and developed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
        </html>"));
        end ThermalPowerInput;



        model TubularHeatExchangerWater "Shell and Tube Heat Exchanger for the heat transfer between two water streams"
          parameter Integer N = 5 "Number of nodes" annotation(
            Dialog(group = "Heat Exchanger Parameters"));
          parameter Integer Nt = 100 "Number of tubes" annotation(
            Dialog(group = "Heat Exchanger Parameters"));
          parameter Modelica.SIunits.Distance L = 2 "Length of the Heat Exchanger" annotation(
            Dialog(group = "Heat Exchanger Parameters"));
          parameter Modelica.SIunits.Distance D = 0.08 "Internal Diameter of the Heat Exchanger Tubes" annotation(
            Dialog(group = "Heat Exchanger Parameters"));
          parameter Modelica.SIunits.Distance e "Thickness of Tubes" annotation(
            Dialog(group = "Heat Exchanger Parameters"));
          parameter SI.MassFlowRate whot_nom = 35 * 999 / 3600 "Mass flow rate of hot fluid" annotation(
            Dialog(group = "Hot Fluid Parameters"));
          parameter SI.MassFlowRate wcold_nom = 30 * 999 / 3600 "Mass flow rate of cold fluid" annotation(
            Dialog(group = "Cold Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.AbsolutePressure phot_start = 1e5 "Hot fluid Pressure start value" annotation(
            Dialog(tab = "Initialisation", group = "Hot Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.AbsolutePressure pcold_start = 1e5 "Cold fluid Pressure start value" annotation(
            Dialog(tab = "Initialisation", group = "Cold Fluid Parameters"));
          parameter SI.PressureDifference dphot_nom = 0 "Hot Fluid Flow Nominal pressure drop (friction term only!)" annotation(
            Dialog(group = "Hot Fluid Parameters"));
          parameter SI.PressureDifference dpcold_nom = 0 "Cold Fluid Flow Nominal pressure drop (friction term only!)" annotation(
            Dialog(group = "Cold Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy HotFluid_Flow_hstartin = if HotFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if HotFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Hot Fluid Flow Inlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Hot Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy HotFluid_Flow_hstartout = if HotFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if HotFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Hot Fluid Flow Outlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Hot Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy ColdFluid_Flow_hstartin = if ColdFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if ColdFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Cold Fluid Flow Inlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Cold Fluid Parameters"));
          parameter WaterWatt.Media.WaterSteam.SpecificEnthalpy ColdFluid_Flow_hstartout = if ColdFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if ColdFluid_Flow.FluidPhaseStart == ThermoPower.Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Cold Fluid Flow Outlet enthalpy start value" annotation(
            Dialog(tab = "Initialisation", group = "Cold Fluid Parameters"));
          final parameter Modelica.SIunits.Distance Dext = D + e "Enternal Diameter of the Heat Exchanger Tubes" annotation(
            Dialog(group = "Heat Exchanger Parameters"));
          parameter Boolean HotFluid_Flow_noInitialPressure = false "Remove initial equation on pressure" annotation(
            Dialog(tab = "Initialisation", group = "Hot Fluid Parameters"),
            choices(checkBox = true));
          parameter Boolean ColdFluid_Flow_noInitialPressure = false "Remove initial equation on pressure" annotation(
            Dialog(tab = "Initialisation", group = "Cold Fluid Parameters"),
            choices(checkBox = true));
          Modelica.SIunits.Temperature T_hotfluid_in = HotFluid_Flow.T[1] "Inlet Temperature of hot fluid";
          Modelica.SIunits.Temperature T_hotfluid_out = HotFluid_Flow.T[N] "Outlet Temperature of cold fluid";
          Modelica.SIunits.Temperature T_coldfluid_in = ColdFluid_Flow.T[1] "Inlet Temperature of hot fluid";
          Modelica.SIunits.Temperature T_coldfluid_out = ColdFluid_Flow.T[N] "Outlet Temperature of cold fluid";
          WaterWatt.Units.VolumeFlowRate_mch VFR_hotfluid = HotFluid_Flow.w * 3600 / 999 "pump volume flowrate in m3/h";
          WaterWatt.Units.VolumeFlowRate_mch VFR_coldfluid = ColdFluid_Flow.w * 3600 / 999 "pump volume flowrate in m3/h";
          WaterWatt.Units.Power_kW TPC = ColdFluid_Flow.Q * 0.001 "Thermal Power Consumption by the Cold Fluid stream";
          WaterWatt.Units.Power_kW TPS = HotFluid_Flow.Q * 0.001 "Thermal Power Supply by the Hot Fluid stream";
          ThermoPower.Water.FlangeA ColdFluid_inlet(redeclare package Medium = WaterWatt.Media.WaterSteam) annotation(
            Placement(visible = true, transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0), iconTransformation(extent = {{80, -70}, {120, -30}}, rotation = 0)));
          ThermoPower.Water.FlangeB ColdFluid_outlet(redeclare package Medium = WaterWatt.Media.WaterSteam) annotation(
            Placement(visible = true, transformation(extent = {{80, -20}, {120, 20}}, rotation = 0), iconTransformation(extent = {{-120, -70}, {-80, -30}}, rotation = 0)));
          ThermoPower.Water.FlangeA HotFluid_inlet(redeclare package Medium = WaterWatt.Media.WaterSteam) annotation(
            Placement(visible = true, transformation(extent = {{-20, 80}, {20, 120}}, rotation = 0), iconTransformation(extent = {{-120, 30}, {-80, 70}}, rotation = 0)));
          ThermoPower.Water.FlangeB HotFluid_outlet(redeclare package Medium = WaterWatt.Media.WaterSteam) annotation(
            Placement(visible = true, transformation(extent = {{-20, -120}, {20, -80}}, rotation = 0), iconTransformation(extent = {{80, 30}, {120, 70}}, rotation = 0)));
          ThermoPower.Water.Flow1DFV HotFluid_Flow(redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.FlowDependentHeatTransferCoefficient(gamma_nom = 2000, alpha = 0.8), redeclare package Medium = WaterWatt.Media.WaterSteam, A = 3.1416 * 0.25 * D ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Downstream, L = L, N = N, Nt = Nt, dpnom = dphot_nom, hstartin = HotFluid_Flow_hstartin, hstartout = HotFluid_Flow_hstartout, omega = D * 3.1416, pstart = phot_start, rhonom = 999, wnom = whot_nom, noInitialPressure = HotFluid_Flow_noInitialPressure) annotation(
            Placement(transformation(extent = {{-20, -66}, {20, -26}})));
          ThermoPower.Water.Flow1DFV ColdFluid_Flow(redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.FlowDependentHeatTransferCoefficient(alpha = 0.8, gamma_nom = 1000), redeclare package Medium = WaterWatt.Media.WaterSteam, A = 3.1416 * 0.25 * D ^ 2, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Upstream, L = L, N = N, dpnom = dpcold_nom, hstartin = ColdFluid_Flow_hstartin, hstartout = ColdFluid_Flow_hstartout, noInitialPressure = ColdFluid_Flow_noInitialPressure, omega = Nt * Dext * 3.1416, pstart = pcold_start, rhonom = 999, wnom = wcold_nom) annotation(
            Placement(transformation(extent = {{-20, 70}, {20, 30}})));
          ThermoPower.Thermal.MetalTubeFV wall(L = L, Nt = Nt, Nw = N - 1, lambda = 45, rext = Dext * 0.5, rhomcm = 500 * 7800, rint = D * 0.5) annotation(
            Placement(visible = true, transformation(extent = {{-20, 4}, {20, -36}}, rotation = 0)));
          ThermoPower.Thermal.CounterCurrentFV counterCurrentFV(Nw = N - 1) annotation(
            Placement(transformation(extent = {{-20, 0}, {20, 40}})));
        equation
          connect(ColdFluid_Flow.wall, counterCurrentFV.side1) annotation(
            Line(points = {{0, 40}, {0, 40}, {0, 26}, {0, 26}}, color = {255, 127, 0}));
          connect(counterCurrentFV.side2, wall.ext) annotation(
            Line(points = {{0, 14}, {0, 14}, {0, -10}, {0, -10}}, color = {255, 127, 0}));
          connect(HotFluid_Flow.wall, wall.int) annotation(
            Line(points = {{0, -36}, {0, -22}}, color = {255, 127, 0}));
          connect(HotFluid_inlet, HotFluid_Flow.infl) annotation(
            Line(points = {{0, 100}, {0, 74}, {-40, 74}, {-40, -46}, {-20, -46}}, color = {0, 0, 255}));
          connect(HotFluid_Flow.outfl, HotFluid_outlet) annotation(
            Line(points = {{20, -46}, {40, -46}, {40, -74}, {0, -74}, {0, -100}}, color = {0, 0, 255}));
          connect(ColdFluid_inlet, ColdFluid_Flow.infl) annotation(
            Line(points = {{-100, 0}, {-60, 0}, {-60, 50}, {-20, 50}}, color = {0, 0, 255}));
          connect(ColdFluid_Flow.outfl, ColdFluid_outlet) annotation(
            Line(points = {{20, 50}, {60, 50}, {60, 0}, {100, 0}}, color = {0, 0, 255}));
          annotation(
            Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(origin = {0.00026907, 49.7887}, rotation = 90, points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(lineColor = {85, 170, 255}, extent = {{-100, -115}, {100, -145}}, textString = "%name"), Line(origin = {-0.351844, -50.1409}, rotation = 90, points = {{0, -80}, {0, -40}, {40, -20}, {-40, 20}, {0, 40}, {0, 80}}, color = {0, 0, 255}, thickness = 0.5)}, coordinateSystem(initialScale = 0.1)));
        end TubularHeatExchangerWater;

      end Special;
      
      annotation(Documentation(info="<html>
    <p>Adaptations to component models existing in ThermoPower performed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
    </html>"));
      
    end WaterSteam;


    package Slurry
      extends Modelica.Icons.Package;

      model SinkPressure
        extends ThermoPower.Water.SinkPressure(redeclare package Medium = Media.Pulp, final use_in_h = false, final use_T = true, T = system.T_amb);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {4, -74}, lineColor = {170, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 6}, {80, -6}})}));
      end SinkPressure;

      model WaterPump "Centrifugal pump with varying motor rotational speed"
        extends WaterWatt.Components.BaseClasses.Pump(redeclare replaceable package Medium = Media.ColdWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -50}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 2}, {80, -10}})}));
      end WaterPump;

      model BulkPump "Centrifugal pump with varying motor rotational speed"
        extends WaterWatt.Components.BaseClasses.Pump(redeclare replaceable package Medium = Media.Bulk constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -50}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 2}, {80, -10}})}));
      end BulkPump;

      model PulpPump "Centrifugal pump with varying motor rotational speed"
        extends WaterWatt.Components.BaseClasses.Pump(redeclare replaceable package Medium = Media.Pulp constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -50}, lineColor = {170, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 2}, {80, -10}})}));
      end PulpPump;

      model WaterPressDrop "Pressure dtop inducer"
        extends WaterWatt.Components.BaseClasses.PressDrop(redeclare package Medium = Media.ColdWater, rhonom = 999, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -28}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 0}, {80, -10}})}));
      end WaterPressDrop;

      model BulkPressDrop "Pressure drop inducer"
        extends ThermoPower.Water.PressDrop(redeclare package Medium = Media.Bulk, rhonom = 999, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -32}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 6}, {80, -6}})}));
      end BulkPressDrop;

      model PulpPressDrop "Pressure drop inducer"
        extends WaterWatt.Components.BaseClasses.PressDrop(redeclare package Medium = Media.Pulp, rhonom = 999, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -32}, lineColor = {170, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 6}, {80, -6}})}));
      end PulpPressDrop;

      model WaterTank "Water Tank"
        extends WaterWatt.Components.BaseClasses.Tank(redeclare package Medium = Media.ColdWater);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {20, -8}, lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-74, 20}, {34, -66}})}));
      end WaterTank;

      model BulkTank "Tank containing bulk water"
        extends WaterWatt.Components.BaseClasses.Tank(redeclare package Medium = Media.Bulk);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {22, -56}, fillColor = {109, 109, 109}, fillPattern = FillPattern.Solid, extent = {{-76, 68}, {32, -18}})}));
      end BulkTank;

      model PulpTank "Tank containing pulp"
        extends WaterWatt.Components.BaseClasses.Tank(redeclare package Medium = Media.Pulp);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {22, -60}, lineColor = {170, 170, 255}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-76, 72}, {32, -14}})}));
      end PulpTank;

      model WaterPipe "Section of a pipeline system"
        extends WaterWatt.Components.BaseClasses.Pipe(redeclare package Medium = Media.ColdWater, final N = 2, final Nw = 1, Nt = 1, final rhonom = 999);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -28}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 0}, {80, -10}})}));
      end WaterPipe;

      model BulkPipe "Section of a pipeline system"
        extends WaterWatt.Components.BaseClasses.Pipe(redeclare package Medium = Media.Bulk, final N = 2, final Nw = 1, Nt = 1, final rhonom = 999);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -32}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 6}, {80, -6}})}));
      end BulkPipe;

      model PulpPipe "Section of a pipeline system"
        extends WaterWatt.Components.BaseClasses.Pipe(redeclare package Medium = Media.Pulp, final N = 2, final Nw = 1, Nt = 1, final rhonom = 999);
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -32}, lineColor = {170, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 6}, {80, -6}})}));
      end PulpPipe;

      model PressMachine "Paper pressing machine"
        outer System system;
        parameter Modelica.SIunits.PerUnit waterF1_ratio = 0.25 "fraction of inlet pulp which falls in the waterwasteF1 tank";
        parameter Modelica.SIunits.PerUnit bulkF1_ratio = 0.25 "fraction of inlet pulp which falls in the bulkwasteF1 tank";
        parameter Modelica.SIunits.PerUnit waterF3_ratio = 0.25 "fraction of inlet pulp which falls in the waterwasteF3 tank";
        parameter Modelica.SIunits.PerUnit bulkF3_ratio = 0.25 "fraction of inlet pulp which falls in the bulkwasteF3 tank";
        ThermoPower.Water.FlangeA inletPulp(redeclare package Medium = Media.Pulp) annotation(
          Placement(visible = true, transformation(origin = {-68, 28}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-68, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ThermoPower.Water.FlangeB outletWaterF1(redeclare package Medium = Media.ColdWater) annotation(
          Placement(visible = true, transformation(origin = {-68, -28}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-68, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ThermoPower.Water.FlangeB outletBulkF1(redeclare package Medium = Media.Bulk) annotation(
          Placement(visible = true, transformation(origin = {-24, -28}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-26, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ThermoPower.Water.FlangeB outletWaterF3(redeclare package Medium = Media.ColdWater) annotation(
          Placement(visible = true, transformation(origin = {26, -28}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {26, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ThermoPower.Water.FlangeB outletBulkF3(redeclare package Medium = Media.Bulk) annotation(
          Placement(visible = true, transformation(origin = {70, -28}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {68, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput m_flowToOtherProcesses annotation(
          Placement(visible = true, transformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
// outlet flow distribution
        outletWaterF1.m_flow = -inletPulp.m_flow * waterF1_ratio;
        outletBulkF1.m_flow = -inletPulp.m_flow * bulkF1_ratio;
        outletWaterF3.m_flow = -inletPulp.m_flow * waterF3_ratio;
        outletBulkF3.m_flow = -inletPulp.m_flow * bulkF3_ratio;
        m_flowToOtherProcesses = max(0, inletPulp.m_flow + outletWaterF1.m_flow + outletBulkF1.m_flow + outletWaterF3.m_flow + outletBulkF3.m_flow);
// inlet pressure
        inletPulp.p = system.p_amb;
// h_outflow
        outletWaterF1.h_outflow = inStream(inletPulp.h_outflow);
        outletBulkF1.h_outflow = inStream(inletPulp.h_outflow);
        outletWaterF3.h_outflow = inStream(inletPulp.h_outflow);
        outletBulkF3.h_outflow = inStream(inletPulp.h_outflow);
        inletPulp.h_outflow = inStream(outletWaterF1.h_outflow);
//dummy, not used
      initial equation
        assert(waterF1_ratio + bulkF1_ratio + waterF3_ratio + bulkF3_ratio <= 100, "sum of water and bulk ratios shall be <= 100");
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Ellipse(origin = {-68, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Ellipse(origin = {-26, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Ellipse(origin = {26, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Ellipse(origin = {68, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-20, 20}, {20, -20}}, endAngle = 360), Line(origin = {-1, 20}, points = {{-67, 0}, {67, 0}}), Line(origin = {0.508554, -19.9689}, points = {{-67, 0}, {67, 0}}), Text(origin = {-4, 75}, lineColor = {0, 0, 255}, extent = {{-54, 13}, {54, -13}}, textString = "%name")}),
          Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
      end PressMachine;
      
      annotation(Documentation(info="<html>
    <p>Adaptations to component models existing in ThermoPower performed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
    </html>"));
      
    end Slurry;


    package BaseClasses "Base models to be used to each one of the three sections, not set to be used directly on circuit assembling"
      extends Modelica.Icons.BasesPackage;

      model Tank
        extends ThermoPower.Water.Tank;
        parameter Modelica.SIunits.Length ymax = Modelica.Constants.inf "Maximum value of level";
        parameter Modelica.SIunits.Length ymin = -Modelica.Constants.inf "Minimum value of level";
        Modelica.SIunits.Length yT = y + y0 "Level of liquid in tank";
        parameter Modelica.SIunits.Length yTmax = Modelica.Constants.inf "Maximum value of liquid level";
        parameter Modelica.SIunits.Length yTmin = -Modelica.Constants.inf "Minimum value of liquid level";
        WaterWatt.Units.VolumeFlowRate_mch VFR_inlet = inlet.m_flow * 3600 / 999 "inlet volume flowrate in m3/h (standard density)";
        WaterWatt.Units.VolumeFlowRate_mch VFR_inletTop = inletTop.m_flow * 3600 / 999 "inletTop volume flowrate in m3/h (standard density)";
        WaterWatt.Units.VolumeFlowRate_mch VFR_outlet = outlet.m_flow * 3600 / 999 "outlet volume flowrate in m3/h (standard density)";
        WaterWatt.Units.Time_hour tres = -V / VFR_outlet "Tank residence time";
      equation
        assert(y < ymax, "Tank overflow", AssertionLevel.warning);
        assert(y > ymin, "Tank underflow", AssertionLevel.warning);
        assert(yT < yTmax, "Tank overflow", AssertionLevel.warning);
        assert(yT > yTmin, "Tank underflow", AssertionLevel.warning);
      end Tank;


      model Pump
        extends ThermoPower.Water.Pump(CheckValve = true, final use_in_Np = false);
        parameter Boolean use_in_tax = false "Use connector tax to compute the total cost, otherwise the total cost is forced to zero" annotation(
          Dialog(group = "External inputs"),
          choices(checkBox = true));
        parameter Boolean useNPSHrCharacteristic = false "Use NPSHr Characteristic" annotation(
          Dialog(group = "Characteristics"));
        parameter Modelica.SIunits.Energy TotalEnergy_start = 0 "initial value of pump energy accounting motor efficiency in Joule";
        Modelica.SIunits.Energy TotalEnergy "pump energy accounting motor efficiency in Joule";
        WaterWatt.Units.Energy_kWh EE = TotalEnergy / 3.6e6 "pump energy over simulation in kWh";
        WaterWatt.Units.Power_kW EP "pump power accounting motor efficiency in kW";
        WaterWatt.Units.EnergyConsumption_kWh_per_hour ELC "pump energy consumption accounting motor efficiency in kWh/hour";
        WaterWatt.Units.VolumeFlowRate_mch VFR = q_single * 3600 "pump volume flowrate in m3/h";
        Modelica.SIunits.PerUnit C "Cost";
        WaterWatt.Units.Per_hour CP "Cost of electricity consumption per hour";
        WaterWatt.Units.VolumeFlowRate_mch NVFR = q_single * 3600 * 100 ^ 0.5 / head ^ 0.5 "normalized pump volume flowrate in m3/h";
        Modelica.SIunits.Power NEP "normalized pump power accounting motor efficiency in Watt";
        parameter Modelica.SIunits.PerUnit motorEfficiency = 0.90 "Motor Efficiency";
        SI.Height NPSHa "Net Positive Suction Head available";
        SI.Height NPSHr "Net Positive Suction Head required";
        Modelica.SIunits.Temperature T_pump;
        parameter Modelica.SIunits.Temperature Tin_nom = system.T_amb;
        parameter SI.Height NPSHr0 = 10 "Nominal Net positive suction head required";
        replaceable function flowCharacteristicNPSHr = WaterWatt.Functions.PumpCharacteristics.baseFlowNPSHr "NPSHr vs. q_flow characteristic" annotation(
          Dialog(group = "Characteristics"),
          choicesAllMatching = true);
        Medium.AbsolutePressure pv "Saturated liquid pressure";
        Modelica.Blocks.Interfaces.RealInput tax(unit = "1/(kW.h)") if use_in_tax annotation(
          Placement(visible = true, transformation(origin = {-92, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 86}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      protected
        Modelica.Blocks.Interfaces.RealInput tax_int(unit = "1/(kW.h)") "Internal connector for tax";
      equation
        pv = Modelica.Media.Water.WaterIF97_base.saturationPressure(T_pump);
        T_pump = if Tin < system.T_amb then Tin_nom else Tin;
        NPSHa = (infl.p - pv) / (rho * g);
        if useNPSHrCharacteristic then
          NPSHr = homotopy(flowCharacteristicNPSHr(q_single), NPSHr0);
        else
          NPSHr = 0;
        end if;
        der(TotalEnergy) = W_single / motorEfficiency;
        EP = W_single * 0.001 / motorEfficiency;
        ELC = der(TotalEnergy) * 3600 / 3.6e6;
        NEP = EP * 100 ^ 1.5 / head ^ 1.5;
        C = EE * tax_int "total cost (tax is expressed in euro per kWh)";
        CP = ELC * tax_int "total cost (euro per hour)";
// conditional input
        connect(tax, tax_int);
        if not use_in_tax then
          tax_int = 0 "cost is forced to zero";
        end if;
      initial equation
        TotalEnergy = TotalEnergy_start;
        annotation(
          Documentation(info = "<html>The net positive suction head available is computed. Requires a two-phase medium model to compute the saturation properties.
      </html>", revisions = "<html>
      <ul>
      <li><i>30 Jul 2007</i>
          by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
             Added (removed NPSH from Pump model).</li>
      </ul>
      </html>"));
      end Pump;

      model CoolingTower
        extends ThermoPower.Water.CoolingTower(final M0 = 1, final Mnom = 1.1, final Mp = 1, S = 1, final cp = 1, staticModel = true);
        parameter Boolean use_in_tax = false "Use connector tax to compute the total cost, otherwise the total cost is forced to zero" annotation(
          Dialog(group = "External inputs"),
          choices(checkBox = true));
        WaterWatt.Units.Power_kW EP = Wtot * 0.001 "cooling tower accounting motor efficiency in kW";
        WaterWatt.Units.EnergyConsumption_kWh_per_hour ELC = Wtot * 0.001 "pump energy consumption accounting motor efficiency in kWh/hour";
        WaterWatt.Units.Per_hour CP "Cost of electricity consumption per year";
        WaterWatt.Units.Power_kW TPS = -Q[N - 1] * 0.001 "Thermal Power Supply by the water stream";
        Modelica.Blocks.Interfaces.RealInput tax(unit = "1/(kW.h)") if use_in_tax annotation(
          Placement(visible = true, transformation(origin = {-92, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      protected
        Modelica.Blocks.Interfaces.RealInput tax_int(unit = "1/(kW.h)") "Internal connector for tax";
      equation
        CP = ELC * tax_int "total cost (euro per year)";
// conditional input
        connect(tax, tax_int);
        if not use_in_tax then
          tax_int = 0 "cost is forced to zero";
        end if;
        annotation(
          Icon(coordinateSystem(grid = {0.1, 0.1}), graphics = {Text(origin = {-137, 7}, rotation = -90, lineColor = {0, 0, 255}, extent = {{65, 43}, {-15, -7}}, textString = "%name", horizontalAlignment = TextAlignment.Left)}));
      end CoolingTower;

      model CoolingTowerClosed
        import SI = Modelica.SIunits;
        outer WaterWatt.System system "System object";
        ThermoPower.Water.FlangeA coolingWaterInlet annotation(
          Placement(visible = true, transformation(extent = {{18, 48}, {38, 68}}, rotation = 0), iconTransformation(extent = {{-10, 80}, {10, 100}}, rotation = 0)));
        ThermoPower.Water.FlangeB coolingWaterOutlet annotation(
          Placement(visible = true, transformation(extent = {{18, -68}, {38, -48}}, rotation = 0), iconTransformation(extent = {{-10, -100}, {10, -80}}, rotation = 0)));
        ThermoPower.Water.FlangeA waterInlet annotation(
          Placement(visible = true, transformation(extent = {{-86, 30}, {-66, 50}}, rotation = 0), iconTransformation(extent = {{-100, -10}, {-80, 10}}, rotation = 0)));
        ThermoPower.Water.FlangeB waterOutlet annotation(
          Placement(visible = true, transformation(extent = {{-86, -66}, {-66, -46}}, rotation = 0), iconTransformation(extent = {{-100, -60}, {-80, -40}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput fanRpm "Fan rotational speed in rpm" annotation(
          Placement(visible = true, transformation(extent = {{-80, 52}, {-40, 92}}, rotation = 0), iconTransformation(extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput powerConsumption "Total fan power consumption" annotation(
          Placement(transformation(extent = {{74, -10}, {94, 10}}), iconTransformation(extent = {{70, -10}, {90, 10}})));
        ThermoPower.Water.CoolingTower coolingTower(N = N, Nt = Nt, S = St, Wnom = Wnom, hlstart = hcstart, initOpt = initOpt, gamma_wp_nom = UAenom / St, k_wa_nom = k_wa_tot / St, nu_a = nu_a, nu_l = nu_l, qanom = qanom, rhoanom = rhoanom, rpm_nom = rpm_nom, staticModel = true, closedCircuit = true, wlnom = wcwnom) annotation(
          Placement(visible = true, transformation(origin = {28, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
        ThermoPower.Water.Flow1DFV cooledFlow(redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.FlowDependentThermalConductance(UAnom = UAinom, alpha = 0.8), A = At, FFtype = ThermoPower.Choices.Flow1D.FFtypes.OpPoint, H = -Ht, L = Lt, N = N, Nt = Nt, dpnom = dpctnom, hstart = htstart, initOpt = initOpt, omega = omegact, rhonom = rhownom, wnf = 0.1, wnom = wctnom, noInitialPressure = noInitialPressure) annotation(
          Placement(visible = true, transformation(origin = {-76, -6}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        parameter ThermoPower.Choices.Init.Options initOpt = system.initOpt "Initialization option" annotation(
          Dialog(tab = "Initialisation", enable = not staticModel));
        parameter Integer Nt = 1 "Number of towers in parallel";
        parameter Integer N(min = 2) = 6 "Number of nodes in the tower and cooling water models";
        final parameter Integer Nw = N - 1 "Number of volumes on the pipe wall";
        parameter SI.Volume Vt "Total internal volume of cooling tubes (single tower)";
        parameter SI.Density rhownom = 1000 "Cooling water nominal density";
        parameter SI.Mass Mt "Total mass of the tubes (single tower)";
        parameter SI.SpecificHeatCapacity ct = 500 "Specific heat capacity of the tubes";
        final parameter SI.Length Lt = 1 "Fictitious length of the cooling water tubes";
        final parameter SI.Area At = Vt / Lt "Fictitious cross-section of cooling water tubes";
        final parameter SI.Area St = 1 "Fictitious heat transfer area of cooling water tubes";
        final parameter SI.Length omegact = St / Lt "Fictitious wet perimeter of cooling water tubes";
        parameter SI.Length Ht = 0 "Height difference betewen cooling water inlet and outlet";
        parameter SI.MassFlowRate wctnom "Nominal water mass flow rate in the cooling tubes (single tower)";
        parameter SI.PressureDifference dpctnom "Nominal cooling tubes pressure drop (friction term only!)";
        parameter SI.MassFlowRate wcwnom "Nominal mass flow rate of cooling water (single tower)";
        parameter SI.VolumeFlowRate qanom "Nominal air volume flow rate (single tower)";
        parameter SI.Density rhoanom = 1.2 "Nominal air density";
        parameter SI.PerUnit nu_a = 0.9 "Exponent of air flow rate in mass & heat transfer coefficients";
        parameter SI.PerUnit nu_l = 0 "Exponent of liquid flow rate in mass & heat transfer coefficients";
        parameter SI.ThermalConductance UAnom "Overall nominal UA value of the cooling tubes (single tower)";
        parameter SI.PerUnit UArnom = 6 "Ratio internal/external UA values of the cooling tubes, nominal conditions";
        parameter SI.ThermalConductance UAinom = UAnom * (UArnom + 1) "Internal nominal UA value of the cooling tubes (single tower)" annotation(
          Dialog(group = "Advanced (override UAnom, UArnom)"));
        parameter SI.ThermalConductance UAenom = UAnom * (UArnom + 1) / UArnom "Exteral nominal UA value of the cooling tubes (single tower)" annotation(
          Dialog(group = "Advanced (override UAnom, UArnom)"));
        parameter Real k_wa_tot(final unit = "kg.K/s") "Overall nominal mass and heat transfer coefficient of the cooling tower";
        parameter Real rpm_nom "Nominal fan rotational speed [rpm]";
        parameter SI.Power Wnom "Nominal power consumption (single tower)";
        parameter SI.SpecificEnthalpy hcstart[N] = fill(120e3, N) "Start values of cooling water enthalpy at volume boundaries" annotation(
          Dialog(tab = "Initialisation"));
        parameter SI.SpecificEnthalpy htstart[N] = fill(120e3, N) "Start values of tube water enthalpy at volume boundaries" annotation(
          Dialog(tab = "Initialisation"));
        parameter SI.Temperature Twbstart = system.T_wb "Start value of average wet bulb temperature" annotation(
          Dialog(tab = "Initialisation"));
        ThermoPower.Thermal.MetalWallFV tubeWalls(M = Mt, Nw = Nw, cm = ct, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
          Placement(visible = true, transformation(origin = {-37, -7}, extent = {{-21, -21}, {21, 21}}, rotation = 90)));
        parameter Boolean noInitialPressure = false "Remove initial equation on pressure for the water tubes" annotation(
          Dialog(tab = "Initialisation"),
          choices(checkBox = true));
      equation
        connect(waterInlet, cooledFlow.infl) annotation(
          Line(points = {{-76, 40}, {-76, 14}}, color = {0, 0, 255}));
        connect(tubeWalls.int, cooledFlow.wall) annotation(
          Line(points = {{-44, -6}, {-66, -6}}, color = {255, 127, 0}));
        connect(cooledFlow.outfl, waterOutlet) annotation(
          Line(points = {{-76, -26}, {-76, -56}}, color = {0, 0, 255}));
        connect(coolingTower.tubeWalls, tubeWalls.ext) annotation(
          Line(points = {{4, -8}, {-30, -8}, {-30, -6}, {-30, -6}}, color = {255, 127, 0}));
        connect(coolingTower.powerConsumption, powerConsumption) annotation(
          Line(points = {{52, 0}, {80, 0}, {80, 0}, {84, 0}}, color = {0, 0, 127}));
        connect(fanRpm, coolingTower.fanRpm) annotation(
          Line(points = {{-60, 72}, {-12, 72}, {-12, 12}, {4, 12}, {4, 12}}, color = {0, 0, 127}));
        connect(coolingTower.waterOutlet, coolingWaterOutlet) annotation(
          Line(points = {{28, -26}, {28, -26}, {28, -58}, {26, -58}}, color = {0, 0, 255}));
        connect(coolingWaterInlet, coolingTower.waterInlet) annotation(
          Line(points = {{28, 58}, {28, 58}, {28, 28}, {28, 28}}, color = {0, 0, 255}));
        annotation(
          Icon(graphics = {Polygon(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-70, 80}, {-70, -80}, {70, -80}, {70, 80}, {-70, 80}}), Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-12, 36}, {-28, 36}, {-40, 48}, {-28, 62}, {-12, 62}, {12, 36}, {30, 36}, {40, 48}, {30, 62}, {12, 62}, {0, 48}, {-12, 36}}), Rectangle(origin = {-22, -1}, lineColor = {255, 255, 255}, fillColor = {100, 100, 100}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-66, 7}, {52, -5}}), Rectangle(origin = {-22, -51}, lineColor = {89, 89, 89}, fillColor = {100, 100, 100}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-66, 7}, {52, -5}}), Rectangle(origin = {92, 3}, lineColor = {89, 89, 89}, fillColor = {100, 100, 100}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-62, 3}, {-50, -59}})}, coordinateSystem(initialScale = 0.1)));
      end CoolingTowerClosed;

      model Accumulator
        extends ThermoPower.Icons.Water.Accumulator;
        replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium "Liquid medium model" annotation(
           choicesAllMatching = true);
        Medium.ThermodynamicState liquidState "Thermodynamic state of the liquid";
        parameter SI.Volume V "Total volume";
        parameter SI.Volume Vl0 "Water nominal volume (at reference level)";
        parameter SI.Area A "Cross Sectional Area";
        parameter SI.Height zl0 "Height of water reference level over inlet/outlet connectors";
        parameter SI.Height zl_start "Water start level (relative to reference)" annotation(
          Dialog(tab = "Initialisation"));
        parameter SI.Pressure pg_start "Gas start pressure" annotation(
          Dialog(tab = "Initialisation"));
        parameter SI.Temperature Tg_start = 300 "Gas start temperature" annotation(
          Dialog(tab = "Initialisation"));
        parameter SI.MolarMass MM = 29e-3 "Gas molar mass";
        parameter SI.Temperature Tg0 = 300 "Nominal gas temperature";
        parameter SI.Pressure pg0 "Nominal gas pressure";
        parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(
          Evaluate = true);
        outer ThermoPower.System system "System wide properties";
        parameter ThermoPower.Choices.Init.Options initOpt = system.initOpt "Initialisation option" annotation(
          Dialog(tab = "Initialisation"));
        parameter Boolean noInitialPressure = false "Remove initial equation on pressure" annotation(
          Dialog(tab = "Initialisation"),
          choices(checkBox = true));
        Medium.MassFlowRate wl_in "Water inflow mass flow rate";
        Medium.MassFlowRate wl_out "Water outflow mass flow rate";
        SI.Height zl(start = zl_start) "Water level (relative to reference)";
        SI.Volume Vl "Volume occupied by water";
        Medium.AbsolutePressure pf "Water Pressure at the inlet/outlet flanges";
        Medium.Temperature Tg(start = Tg_start) "Gas temperature";
        SI.Volume Vg "Volume occupied by gas";
        Medium.AbsolutePressure pg(start = pg_start) "Gas pressure";
        SI.Density rho "Density of the water";
        ThermoPower.Water.FlangeA WaterInfl(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(
          Placement(transformation(extent = {{-44, -100}, {-24, -80}}, rotation = 0)));
        ThermoPower.Water.FlangeB WaterOutfl(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation(
          Placement(transformation(extent = {{24, -100}, {44, -80}}, rotation = 0)));
      protected
        constant SI.Acceleration g = Modelica.Constants.g_n;
        constant Real R = Modelica.Constants.R "Universal gas constant";
        parameter SI.SpecificHeatCapacityAtConstantPressure cpg = 7 / 2 * Rstar "Cp of gas";
        parameter Real Rstar = R / MM "Gas constant";
        final parameter SI.AmountOfSubstance N = pg0 * (V - (Vl0 + A * zl_start)) / (R * Tg0) "Total amount of gas";
      equation
//Equations for water and gas volumes and exchanged thermal power
        Vl = Vl0 + A * zl;
        Vg = V - Vl;
// Boundary conditions
// (Thermal effects of the water going out of the accumulator are neglected)
        WaterInfl.h_outflow = inStream(WaterOutfl.h_outflow);
        WaterOutfl.h_outflow = inStream(WaterInfl.h_outflow);
        wl_in = WaterInfl.m_flow;
        wl_out = WaterOutfl.m_flow;
        WaterInfl.p = pf;
        WaterOutfl.p = pf;
        rho * A * der(zl) = wl_in + wl_out "Water mass balance (density variations neglected)";
// Set liquid properties
        liquidState = Medium.setState_ph(1e5, 1e5);
        rho = 1000;
//Medium.density(liquidState);
        pf = pg + rho * g * (zl + zl0) "Stevino's law";
        pg * Vg = N * R * Tg "Gas state equation";
        N * MM * cpg * der(Tg) = Vg * der(pg) "Gas energy balance";
      initial equation
        if initOpt == ThermoPower.Choices.Init.Options.noInit then
// do nothing
        elseif initOpt == ThermoPower.Choices.Init.Options.fixedState then
          zl = zl_start;
          if not noInitialPressure then
            pg = pg_start;
          else
            Tg = Tg_start;
          end if;
        elseif initOpt == ThermoPower.Choices.Init.Options.steadyState then
          zl = zl_start;
          der(Tg) = 0;
          if not noInitialPressure then
            pg = pg_start;
          end if;
        elseif initOpt == ThermoPower.Choices.Init.Options.steadyStateNoP then
          zl = zl_start;
          der(Tg) = 0;
        else
          assert(false, "Unsupported initialisation option");
        end if;
        annotation(
          Diagram(graphics),
          Icon(graphics),
          Documentation(info = "<HTML>
      <p>This model describes a water-gas accumulator (the gas is modeled as ideal bi-atomic). <p>
      Water flows in and out through the interfaces at the component bottom (flow reversal supported). <p>
      The gas is supposed to flow in at constant temperature (parameter <tt>Tgin</tt>) and with variable flow-rate (<tt>GasInfl</tt> signal port), and to flow out by a valve operating in choked condition; the valve coefficient is determined by the working point at full opening (<tt>wg_out0,Tg0, Pg0</tt>) while the valve opening (in the range <tt>0-1</tt>) is an input signal (<tt>OutletValveOpening</tt> signal port).
      <p><b>Dimensional parameters</b></p>
      <ul>
      <li><tt>V</tt>: accumulator total volume;
      <li><tt>Vl0</tt>: volume occupied by water at the nominal level (reference value);
      <li><tt>zl0</tt>: height of water nominal level above the water connectors;
      <li><tt>A</tt>: cross-sectional area at actual water level;
      </ul>
      </HTML>", revisions = "<html>
      <ul>
      <li><i>30 May 2005</i>
      by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
      Initialisation support added.</li>
      <li><i>16 Dec 2004</i>
      by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
      Standard medium definition added.</li>
      <li><i>18 Jun 2004</i>
      by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
      Adapted to Modelica.Media.</li>
      <li><i>5 Feb 2004</i>
      by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
      First release.</li>
      </ul>
      </html>"));
      end Accumulator;

      model Pipe
        extends ThermoPower.Water.Flow1DFV(wnm = Modelica.Constants.inf);
        WaterWatt.Units.VolumeFlowRate_mch VFR = w * 3600 / 999 "volume flowrate in m3/h (standard density)";
      end Pipe;

      model PressDrop
        extends ThermoPower.Water.PressDrop;
        WaterWatt.Units.VolumeFlowRate_mch VFR = w * 3600 / 999 "volume flowrate in m3/h (standard density)";
      end PressDrop;

      model Valve
        extends ThermoPower.Water.ValveLin;
      end Valve;
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        Documentation(info="<html>
    <p>Adaptations to component models existing in ThermoPower performed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
    </html>"));
    end BaseClasses;

  end Components;




















  package Media
    extends Modelica.Icons.MaterialPropertiesPackage;

    model ColdWater
      extends Modelica.Media.CompressibleLiquids.LinearColdWater(reference_d = 999);
    end ColdWater;

    model WaterSteam
      extends Modelica.Media.Water.StandardWater;
    end WaterSteam;

    model Pulp
      extends Modelica.Media.CompressibleLiquids.LinearColdWater(reference_d = 999);
    end Pulp;

    model Bulk
      extends Modelica.Media.CompressibleLiquids.LinearColdWater(reference_d = 999);
    end Bulk;
  end Media;

  package Units
    extends Modelica.Icons.TypesPackage;
    type Energy_kWh = Real(final unit = "kW.h");
    type Tariff = Real(final unit = "1/(kW.h)");
    type VolumeFlowRate_mch = Real(final unit = "m3/h");
    type Power_kW = Real(final unit = "kW");
    type Energy_MWh = Real(final unit = "MW.h");
    type EnergyConsumption_kWh_per_hour = Real(final unit = "kWh/h");
    type SEC_kWh_per_m3 = Real(final unit = "kW.h/m3");
    type Per_hour = Real(final unit = "1/h");
    type Percentage = Real(final unit = "%");
    type EnergyConsumption_MWh_per_year = Real(final unit = "MWh/year");
    type OperationalTime_hour_per_year = Real(final unit = "h/year");
    type Time_hour = Real(final unit = "h");
  end Units;

  package Icons
    extends Modelica.Icons.IconsPackage;

    partial model BaseExample
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Ellipse(lineColor = {143, 143, 143}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}, endAngle = 360), Polygon(lineColor = {0, 0, 255}, fillColor = {156, 156, 156}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}));
    end BaseExample;
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end Icons;

  package Functions
    extends Modelica.Icons.Package;

    package PumpCharacteristics
      function quadraticNPSHr "Quadratic flow characteristic"
        extends WaterWatt.Functions.PumpCharacteristics.baseFlowNPSHr;
        input SI.VolumeFlowRate q_nom[3] "Volume flow rate for three operating points (single pump)" annotation(
          Dialog);
        input SI.Height NPSHr_nom[3] "Pump NPSHr for three operating points" annotation(
          Dialog);
      protected
        parameter Real q_nom2[3] = {q_nom[1] ^ 2, q_nom[2] ^ 2, q_nom[3] ^ 2} "Squared nominal flow rates";
        /* Linear system to determine the coefficients:
                                                                                                                                                                                        NPSHr_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
                                                                                                                                                                                        NPSHr_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
                                                                                                                                                                                        NPSHr_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
                                                                                                                                                                                        */
        parameter Real c2[3] = {0, 0, 1};
        parameter Real c[3] = Modelica.Math.Matrices.solve([c2, q_nom, q_nom2], NPSHr_nom) "Coefficients of quadratic NPSHr curve";
      algorithm
// Flow equation: NPSHr = c[1] + q_flow*c[2] + q_flow^2*c[3];
        NPSHr := c[1] + q_flow * c[2] + q_flow ^ 2 * c[3];
      end quadraticNPSHr;

      function baseFlowNPSHr
        extends Modelica.Icons.Function;
        input SI.VolumeFlowRate q_flow "Volumetric flow rate";
        output SI.Height NPSHr "Pump required net positive suction head";
      end baseFlowNPSHr;
    end PumpCharacteristics;
  end Functions;
  annotation(
    uses(Modelica(version = "3.2.2"), ThermoPower(version = "3.1")),
    Documentation(info="<html>
<p>A library containing components for the modelling of industrial water circuits (IWC), a specific type of water systems.
<p>The ThermoPower Library (https://github.com/casella/ThermoPower) is a necessary dependance. The WaterWatt models cannot be loaded without having loaded the ThermoPower library first.</p>
<p>Circuit models and customised component models created and developed by  Miguel C. Oliveira (dmoliveira@isq.pt) and Muriel Iten (mciten@isq.pt)</p>
</html>"));
    
    
end WaterWatt;
