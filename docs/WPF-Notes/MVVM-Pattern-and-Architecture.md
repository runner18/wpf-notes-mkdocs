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

## Troubleshooting Data Binding
To troubleshoot data binding issues, you want to check every step of the way to make sure things are changing. Some things you can do:

Trace Level High

Set trace level for binding to high.
```XML
Add this:
xmlns:diag="clr-namespace:System.Diagnostics;assembly=WindowsBase"

<TextBox 
       Text="{Binding Value, 
                    RelativeSource={RelativeSource FindAncestor, AncestorType={x:Type local:EditValueControl}}, 
                    Mode=TwoWay, 
                    diag:PresentationTraceSources.TraceLevel=High, 
                    UpdateSourceTrigger=PropertyChanged}" 
                Background="White"   
                Width="150" />
```

### DependencyProperty

If your binding involves a DependencyProperty of a user control, is the binding inside the user control using the RelativeSource FindAncestor stuff?

### Copy by Reference!
If you are binding with primatives (string, bool, int, etc.), remember they copy by VALUE not reference, meaning their bindings will NOT copy if you do booleanA = booleanB


```

```CS
var person = new Person { Name = "Alice" };
localValue.EditValue = person;

localValue.EditValue = new Person { Name = "Bob" };
// 'person' still points to Alice — you just redirected EditValue
```

``` CS
// Another example:
private string _testStringInstance;
public string TestStringInstance
{
    get
    {
        return _testStringInstance;
    }
    set
    {
        SetProperty(ref _testStringInstance, value);
    }
}

[ObservableProperty]
public partial LocalValue TestLocalValue { get; set; } = new LocalValue(); 

// in the constructor. . . 
TestStringInstance = "this is a test string";
TestLocalValue = new LocalValue()
{
    Label = "test string",
    DisplayValue = TestStringInstance,
    EditValue = TestStringInstance, // as soon as EditValue binds to a textbox, EditValue will cut ties with TestStringInstance
};

// !!! as soon as TestLocalValue.EditValue binds to a textbox, EditValue will cut ties with TestStringInstance and TestStringInstance will NOT change at all
```
## Binding Modes

## UpdateSourceTrigger

## IValueConverter

Converts a thing into a xaml-friendly thing.

### Example: EnumToCollectionConverter
```XML
<DataTemplate DataType="{x:Type sys:Enum}">
    <StackPanel>
        <ComboBox 
            ItemsSource="{Binding Path=., Converter={edb:EnumToCollectionConverter}, Mode=TwoWay}"
            SelectedValuePath="Value" 
            DisplayMemberPath="Description"
            SelectedValue="{Binding Path=., Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}"
            IsReadOnly="True"/>
    </StackPanel>
</DataTemplate>
```

```CS
class EnumToCollectionConverter : MarkupExtension, IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return EnumDataBindingHelper.GetAllValuesAndDescriptions(value.GetType());
    }
    public object? ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        return null;
    }
    public override object ProvideValue(IServiceProvider serviceProvider)
    {
        return this;
    }
}
```

```CS
public static class EnumDataBindingHelper
{
    public static string Description(this Enum value)
    {
        object?[]? attributes = value.GetType().GetField(value.ToString())?.GetCustomAttributes(typeof(DescriptionAttribute), false);
        if (attributes is null)
            return string.Empty;
        if(attributes.Any())
        {
            if(attributes.First() is DescriptionAttribute da)
            {
                return da.Description;
            }
        } 

        // If no description is found, the least we can do is replace underscores with spaces
        // You can add your own custom default formatting logic here
        TextInfo ti = CultureInfo.CurrentCulture.TextInfo;
        return ti.ToTitleCase(ti.ToLower(value.ToString().Replace("_", " ")));
    }

    public static IEnumerable<ValueDescription> GetAllValuesAndDescriptions(Type t)
    {
        if (!t.IsEnum)
            throw new ArgumentException($"{nameof(t)} must be enum type");

        return Enum.GetValues(t).Cast<Enum>().Select(
            (e) => new ValueDescription() { Value = e, Description = e.Description() }).ToList();
    }

}
```

I feel like the EnumDataBindingHelper could be combined with the EnumToCollectionConverter.
## RelativeSource: Self, TemplatedParent, AncestorType

## StringFormat

## ObservableCollection\<T>, CollectionView / CollectionViewSource
## Service Layer and Dependency Injection
### Constructor Injection
Example:
```CS
// SolutionName.Shared.SharedExtensions SharedExtensions.cs
public static class SharedExtensions
{
	public static IHostApplicationBuilder AddSharedDefaults(this IHostApplicationBuilder builder)
	{
		builder.Services.AddSingleton(ExampleClass)();
		builder.Services.AddSingleton(AnotherExampleClass)();
	}
}
```

```CS
// SolutionName.Communications.CommunicationsExtensions CommunicationExtensions.cs
public static class CommunicationsExtensions
{
	public static IHostApplicationBuilder AddCommunicationsDefaults(this IHostApplicationBuilder builder)
	{
		builder.Services.AddSingleton<IExampleA>(new ExampleA());
		builder.Services.AddSingleton<IExampleB>(new ExampleB());
	}
}
```

``` CS
// SolutionName.Program AppHost.cs
internal static class Program
{
	[STAThread]
	public static void Main(params string[] args)
	{
		// ...
		Microsoft.Extensions.Hosting.HostApplicationBuilder? builder;
		builder = Host.CreateApplicationBuilder(args);
		builder.AddAppDefaults();
		builder.AddCommunicationsDefaults();
		builder.AddDataDefautls();
		builder.AddMVVMdefaults();
		builder.AddSharedDefaults();
		
		builder.Services.AddSingleton<App>();
		
	}
}

```

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
