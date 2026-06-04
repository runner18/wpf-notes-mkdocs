## Intro
UnitsNet is a popular library to help with units.

## Basic Structure of Unit DataTypes
``` CS
// ======== UnitsNet.Units ========
public enum TemperatureUnit
{
    DegreeCelsius = 1,
    DegreeDelisle = 2,
    DegreeFahrenheit = 3,
    // and so on...
}

//  ========UnitsNet.Temperature.Units ========
public static TemperatureUnit[] Units { get; set; } 
```

## Get a Unit / Full List of Units
```CS
VolumeFlowUnit exampleUnit = UnitsNet.Units.VolumeFlowUnit.CubicFootPerHour;
PressureUnit[]? pressureUnitsArray = UnitsNet.Pressure.Units;
```

## Get Abbreviations
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