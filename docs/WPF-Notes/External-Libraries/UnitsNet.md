## Intro
UnitsNet is a popular library to help with units.

## IQuantity
This is a class that contains both the value and its unit information

## Getting Started
Below are some basic actions to perform with UnitsNet:

### Create a Quantity
```CS
// Method #1: pass in constructor
Length testLength = new Length(3.23, LengthUnit.Inch);
IQuantity testLength2 = new Length(3.23, LengthUnit.Inch);
Length testLength3 = Length.FromInches(3.23);

```

### Get a Unit / Full List of Units
```CS
VolumeFlowUnit exampleUnit = UnitsNet.Units.VolumeFlowUnit.CubicFootPerHour;
PressureUnit[]? pressureUnitsArray = UnitsNet.Pressure.Units;
```

### Get Abbreviations
```CS
// Get for SINGLE, SPECIFIC UNIT
UnitsNet.TemperatureUnit.GetAbbreviation(
    UnitsNet.Units.TemperatureUnit.DegreeFahrenheit);

// Get for EVERY SINGLE UNIT
foreach (UnitsNet.Units.PressureUnit pu in UnitsNet.Pressure.Units)
{
    anaInUnitsSource.Add(UnitsNet.Pressure.GetAbbreviation(pu));
}
```

// Get from abbreviation
``` CS
VolumeFlow? FuelSupplyRate = Quantity.FromUnitAbbreviation(double value, string unitAbbreviation)
```

### Declare Specific Unit Type

### Cast IQuantity to double
```CS
IQuantity? throttleIQuantity = DynoControlValue1;
QuantityValue? throttleQuantityValue = throttleIQuantity?.Value;
double throttleDouble = (double)(throttleQuantityValue ?? 0.0);

// or 

double throttleDouble2 = (double)(DynoControlValue1?.Value ?? 0.0);
// In this example the IQuantityValue, DynoControlValue1, is nullable. 

// The "?." makes DynoControlValue1?.Value return null 
// if DynoControlValue1 is null.

// The "?? 0.0" makes the whole thing not nullable by 
// having a emergency plan to set the value to 0.0 
// in case DynoControlValue1?.Value is null.
```

## Example enums and classes

### enum TemperatureUnit
``` CS
// namespace UnitsNet.Units
public enum TemperatureUnit
{
    DegreeCelsius = 1,
    DegreeDelisle = 2,
    DegreeFahrenheit = 3,
    // and so on...
}
```
### UnitsNet.Temperature --> Units
```CS
public static TemperatureUnit[] Units { get; set; } 
```

### UnitsNet.QuantityInfo
``` CS
public QuantityInfo(string name, Type unitType, UnitInfo[] unitInfos, IQuantity zero, BaseDimensions baseDimensions)
```





## List of Noticable Unit Classes
AccelerationUnit - AngleUnit - AreaDensityUnit - AreaUnit - DensityUnit - ElectricCurrentUnit (Ampere) - ElectricImpedanceUnit  - ElectricInductanceUnit - ElectricPotentialUnit (Volt) - ElectricResistanceUnit (Ohm) - EnergyUnit - ForceUnit (Newton, PoundForce) - FrequencyUnit (BeatPerMinute, CyclePerHour, Hertz) - MassUnit (gram, ounce, pound, tonne) - PowerUnit (Gigawatt, MechanicalHorsepower) - PressureUnit (Atmosphere, Bar, Pascal, PoundForcePerSquareInch/PSI) - RatioUnit (DecimalFraction, PartPerBillion, Percent) - SpeedUnit - TemperatureUnit - TorqueUnit - VolumeFlowUnit - VolumeUnit