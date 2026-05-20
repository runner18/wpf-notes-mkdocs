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