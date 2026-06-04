### Casting/Checking Data Types
#### is vs as keywords

```CS
// ======== is ======== JUST DO THIS ONE
if(obj is Boat b) // if obj is not Boat type, statement is false
{
    b.FunctionSpecificToBoatClass();
}

// ======== as ======== THIS ONE MIGHT BE FASTER BUT IT'S MORE WORDY
Car c = obj as Car; // if obj is not Car type, c is set to null
if(c != null)
{
    c.FunctionSpecificToCarClass();
}

// !! This is INCORRECT:
if(obj is Boat)
{
    // obj is never actually casted to boat type, so this will not work
    obj.FunctionSpecificToBoatClass(); // INCORRECT
}

// !! This works but is NOT IDEAL:
if(obj is Boat)
{
    // this takes two type checks, not necessary
    ((Boat)obj).FunctionSpecificToBoatClass(); 
}

// !! This is DANGEROUS
// if obj is not Boat type you will get an error!
((Boat)obj).FunctionSpecificToBoatClass();
```