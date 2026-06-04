## When Creating a New UserControl . . .
1. Add any dictionaries you need
``` xml
    <UserControl.Resources>
        <ResourceDictionary>
            <ResourceDictionary.MergedDictionaries>
                <ResourceDictionary Source="/ExampleSolution.MVVM;component/Styles/SystemColors.xaml"/>
                <ResourceDictionary Source="/ExampleSolution.MVVM;component/Styles/ControlResources.xaml"/>
            </ResourceDictionary.MergedDictionaries>
        </ResourceDictionary>
    </UserControl.Resources>
```

2. Add needed namespaces
``` xml
<UserControl
    . . .
    xmlns:child="clr-namespace:ExampleSolution.MVVM.Views.MenuControls.ConfigureControls"
    xmlns:sc="clr-namespace:ExampleSolution.MVVM.Views.SettingControls"
    xmlns:vms="clr-namespace:ExampleSolution.MVVM.ViewModels.MenuControls"
    d:DataContext="{d:DesignInstance vms:ConfigureViewModel}">
```
Don't forget to add the DataContext!

## Syntax


## Namespaces

## Code-behind vs XAML-only UI

## x:Name vs Name

## Design-time attributes (d:DataContext, d:DesignInstance)