# OwnTech converters model in Modelica

This repository contains a Modelica package, `OwnModel`, to model [OwnTech](https://owntech.io/) power electronics converters, in particular the [TWIST](https://owntech.io/twist-2/) board.

## Usage

1. you need a Modelica simulation environment. 
   - `OwnModel` has been developed and tested with [OpenModelica](https://openmodelica.org/) 1.23
2. clone or download (and unzip) this repository
3. open the `OwnModel` package (can be done by double-clicking the `OwnModel/package.mo` file from your file browser)
4. Within your Modelica environment, navigate through the package. You can start with the `Examples/Buck` model which implements [Buck with PI control](https://docs.owntech.org/examples/TWIST/DC_DC/buck_voltage_mode/) example
   - Remark: by double-clicking on the TWIST block in this example, you can select between the *averaged* and the *switched* models of the converter.


## Package structure

The `OwnModel` package is structured like many Modelica libraries with the following subpackages:

- **Examples**: complete system models that can be directly simulated
- **Components**: models of subsystems (i.e. that cannot be simulated alone), including:
  - TWIST board
  - Power converter legs (switched or averaged model)
  - LC filter
- **Interfaces** (not needed by model users): [parent](https://mbe.modelica.university/behavior/equations/model_def/#inheritance) abstract/partial models that are used to factor out common aspects from sibling components

## Remarks

- the model named “TWIST” is in fact the TWIST board hardware (that is 2 legs) + the PWM modulators which are, in reality, located in the [SPIN controller](https://owntech.io/spin/) board. This vocabulary cheating allows having a simple model structure to select between the switched and the averaged model (since averaged only makes sense over a switching period of the PWM modulator)
  - As a consequence, the [Peak-current-mode control](https://docs.owntech.org/examples/TWIST/DC_DC/buck_current_mode/), which needs a modified PWM generator, is currently not modeled nor is it easy to model in the current version of the package.
