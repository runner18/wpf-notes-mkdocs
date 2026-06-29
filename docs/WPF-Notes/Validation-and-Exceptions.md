# Validation and Exceptions
## test h2 header
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

## DataErrorInfo
### IDataErrorInfo (legacy)
### INotifyDataErrorInfo (modern)

## ValidationRules in binding 
### ExceptionValidationRule
## Validation.ErrorTemplate - Custom Visuals
## Global Exception Handling
[Helpful link to wpf-tutorial](https://wpf-tutorial.com/wpf-application/handling-exceptions/)
[StackOverflow post](https://stackoverflow.com/questions/1036457/what-is-best-practice-to-handle-all-exceptions-in-wpf-application)


From [Another StackOverflow post](https://stackoverflow.com/questions/1472498/wpf-global-exception-handler):
1. **AppDomain.CurrentDomain.UnhandledException** From all threads in the AppDomain
2. **Dispatcher.UnhandledException** From a single specific UI dispatcher thread 
3. **Application.Current.DispatcherUnhandledException** From the *main* UI dispatcher thread in your WPF application
4. **TaskScheduler.UnobservedTaskException** From within each AppDomain that uses a task scheduler for asynchronous 

Also
```CS
System.Windows.Threading.Dispatcher.CurrentDispatcher.UnhandledException += (sender, e) =>
{
	if(e.Exception is System.NullReferenceException nre && 
	nre.StackTrace?.Contains("LiveChartsCore.SkiaSharpView.WPF") == true && 
	nre.StackTrace?.Contains("DisposeTicker") == true)
}
```

### DispatcherUnhandledException
### AppDomain.UnhandledException

## Exception Settings
WPF lets you control what gets thrown
ExceptionSettings show in the bottom window when running the program.