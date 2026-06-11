# MVVM Pattern and Architecture
## Solution structure
The file path should look something like this:  

- C:\\jobs\\Test Projects\\testwpfapp
    - .git
    - .vs
    - bin
    - obj
    - .gitattributes
    - .gitignore
    - App.xaml
    - ...
    - README.md
    - testwpfapp1.csproj

## Model-View-ViewModel
### View is XAML + minimal code-behind
## INotifyPropertyChanged (Mandatory)
## Data Binding
### Quick Explanation
MVVM is a design practice that stands form meant to keep things separate and organized:  

- **Model** - just has properties, represents a "thing" (e.g. Car.cs)
- **View** - the graphics (e.g. MainWindow.xaml)
- **ViewModel** - the logic that controls a View (e.g. MainWindowViewModel.xaml)

### Note about Code-Behinds
Each View (e.g. MainWindow.xaml) has a code-behind (MainWindow.xaml.cs). The code-behind is NOT the ViewModel. This is the "old" pre-MVVM way of controlling a View, avoid when possible if you care about MVVM.


### Binding Properties
The ViewModel "controls" the View via use of binding, where the code is constantly checking the state of the "observable" properties in the ViewModel, and changing the View automatically as the ViewModel's properties change.

### The "Classic" Way (INotifyPropertyChanged)
``` CS
private bool _isStopLightOn;
public bool isStopLightOn
{
    get => _isStopLightOn;
    set
    {
        if (_isStopLightOn != value)
        {
            _isStopLightOn = value;
            OnPropertyChanged();
        }
    }
}
```

### Community Toolkit

The "classic" way can now be more concise with Community Toolkit:
```CS
private IQuantity? _localValue; // naming it "localValue" would work too
public IQuantity? LocalValue 
{
    get => _localValue;
    set => SetProperty(ref _localValue, value);
}
```

The "newest" way to have data-binding with CommunityToolkit:
```CS
public partial class ExampleClass : ObservableObject
{
    [ObservableProperty]
    public partial string ExampleString { get; set; }
    // be sure to capitalize the first letter! (see "ExampleString")
}


```

### PropertyChanged only works inside an ObservableObject


## Binding Modes

## UpdateSourceTrigger

## IValueConverter

## RelativeSource: Self, TemplatedParent, AncestorType

## StringFormat

## ObservableCollection\<T>, CollectionView / CollectionViewSource
## Service Layer and Dependency Injection
### Constructor Injection
### Composition Root
## ViewModel-first Navigation
### DataTemplate + Contentcontrol
## ViewModel communication
### EventAggregator
### WeakReferenceMessenger
## ViewModel lifecycle
### IDisposable
### IClosable
### INavigationAware
## Misc. Architecture things to explore
https://stackoverflow.com/questions/2420193/how-to-avoid-dependency-injection-constructor-madness
