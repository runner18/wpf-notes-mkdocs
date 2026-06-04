## Customize Existing Elements with Templates


## Have Global Reusable Styles

### Colors 
```xml
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
    <!--Sometimes the "Color" type is needed for setting color-->
    <Color x:Key="PrimaryColor">#c17a0c</Color>
    <Color x:Key="PrimaryVariantColor">#724332</Color>
    <Color x:Key="OnPrimaryColor">WhiteSmoke</Color>
    <Color x:Key="BackgroundColor">#080173</Color>
    <Color x:Key="OnBackgroundColor">WhiteSmoke</Color>
    <Color x:Key="SurfaceColor">Gainsboro</Color>
    <Color x:Key="OnSurfaceColor">#FF0C1C34</Color>
    
    <!--Other times the "SolidColorBrush" type is needed instead for setting color-->
    <!--The "SolidColorBrush" type uses the "Color" type-->
    <SolidColorBrush x:Key="Primary" Color="{StaticResource PrimaryColor}"/>
    <SolidColorBrush x:Key="PrimaryVariant" Color="{StaticResource PrimaryVariantColor}"/>
    <SolidColorBrush x:Key="OnPrimary" Color="{StaticResource OnPrimaryColor}"/>
    <SolidColorBrush x:Key="Background" Color="{StaticResource BackgroundColor}"/>
    <SolidColorBrush x:Key="OnBackground" Color="{StaticResource OnBackgroundColor}"/>
    <SolidColorBrush x:Key="Surface" Color="{StaticResource SurfaceColor}"/>
    <SolidColorBrush x:Key="OnSurface" Color="{StaticResource OnSurfaceColor}"/>
</ResourceDictionary>
```

### How to Reference Multiple Dictionaries
There are sort of two ways to reference a dictionary:  
1. Placing a Merged Dictionary directly into a window or control
2. Add a dictionary to the .exe/main app/program/title project resources

**Method #1 (good): Add a dictionary to the main .exe/app/program resources**
```xml
<Application.Resources>
    <ResourceDictionary>
        <ResourceDictionary.MergedDictionaries>
            <ResourceDictionary Source="/AW_DTC.MVVM;component/Dictionary/MVVMResourceDictionary.xaml"/>
        </ResourceDictionary.MergedDictionaries>
    </ResourceDictionary>
</Application.Resources>
```

**Method #2 (bad): Place a merged dictionary directly into a window or control**




If you place a Merged Dictionary in every single window and control, it creates a copy for each one, which takes up a BUNCH of memory.

Ideally you add a merged dictionary to the App.xaml once. Now everything can access it. (App.xaml, not MainWindow.xaml! child controls may not be a child of MainWindow!)

Dictionaries are referenced based on something called the Visual Tree. I do not understand this yet.

### Merging Multiple Dictionaries
```xml
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                    xmlns:ui="http://schemas.lepo.co/wpfui/2022/xaml"
                    xmlns:sys="clr-namespace:System;assembly=mscorlib"
                    xmlns:scvm="clr-namespace:solution_name.MVVM.ViewModels.SettingControls"
                    xmlns:sc="clr-namespace:solution_name.MVVM.Views.SettingControls">

    <ResourceDictionary.MergedDictionaries>
        <ResourceDictionary Source="/solution_name.MVVM;component/Styles/SystemColors.xaml"/>
    </ResourceDictionary.MergedDictionaries>
```