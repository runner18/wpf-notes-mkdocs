# Resources Styles and Templates

## Table of Contents




### ContentControl
Gets or sets the the DataTemplate. Multiple elements can use ContentTemplate.   
Use a UI element such as "ContentControl":
```xml
<DataTemplate x:Key="template1">
  <TextBlock Text="{Binding}" FontSize="12" FontWeight="Bold"   
            TextWrapping="Wrap"/>
</DataTemplate>

<ContentControl Name="contCtrl" ContentTemplate="{StaticResource template1}" 
    Content="This is the content of the content control."/>
```

### ContentTemplate

### DataTemplate
DataTemplates let you change the look of UI depending on the data type.  
In a resource dictionary (global or local), add DataTemplate:
```xml
<DataTemplate DataType="{x:Type scvm:NumericSettingControlViewModel}">
    <sc:NumericSettingControl/>
</DataTemplate>
<DataTemplate DataType="{x:Type scvm:StringSettingControlViewModel}">
    <sc:StringSettingControl MinWidth="400"/>
</DataTemplate>
```
If a ContentControl's source matches the DataType of a DataTemplate, the ContentControl will *transform* into the content of said matching DataTemplate.

#### Example: DataType="{x:Type sys:Int32}", etc.
```xml
<UserControl 
    x:Class="DynaFlo_PC_App.MVVM.Views.ValueControls.LocalValueControl"
    xmlns:sys="clr-namespace:System;assembly=mscorlib">

    <UserControl.Resources>
        <DataTemplate DataType="{x:Type sys:Int32}">
            <TextBox Text="{Binding Path=.}" Width="200"/>
        </DataTemplate>
    </UserControl.Resources>
     
</UserControl>
```

### ItemsControl
```xml
<ItemsControl ItemsSource="{Binding AutoCalResultsList}">
    <ItemsControl.ItemsPanel>
        <ItemsPanelTemplate>
            <StackPanel Orientation="Vertical"/>
        </ItemsPanelTemplate>
    </ItemsControl.ItemsPanel>
</ItemsControl>
```
ItemsControl is similar except it makes a UI list by binding to, well, a list (ObservableCollection, whatever). Each member of the list transforms according to a matching DataTemplate.


### Example #1
ItemsControl will create a list of UI elements.  

Because of the DataTemplate...  
if IBoat item in **IBoatList** is type **SpeedBoatClass**  
its corresponding UI element will be  **NumericSettingControl**.  
```XML
<DataTemplate DataType="{x:Type scvm:SpeedBoatClass}">
    <sc:NumericSettingControl/>
</DataTemplate>
<DataTemplate DataType="{x:Type scvm:SailBoatClass}">
    <sc:StringSettingControl MinWidth="400"/>
</DataTemplate>

<ItemsControl ItemsSource="{Binding IBoatList}">
    <ItemsControl.ItemsPanel>
        <ItemsPanelTemplate>
            <StackPanel Orientation="Vertical"/>
        </ItemsPanelTemplate>
    </ItemsControl.ItemsPanel>
</ItemsControl>
```

### Example #2
```xml
<ContentControl Visibility="{Binding UnitsVisiblity, RelativeSource={RelativeSource FindAncestor, AncestorType={x:Type local:BooleanSettingControl2}}}"
                ContentTemplate="{StaticResource UnitsTemplate}" Focusable="false" Content="{Binding}"/>
```

### Troubleshooting
#### Two-way binding requires Path
Change this:
```xml
<DataTemplate DataType="{x:Type sys:String}">
    <TextBox Text="{Binding}" Width="200"/>
</DataTemplate>
```

To this:
```xml
<DataTemplate DataType="{x:Type sys:String}">
    <TextBox Text="{Binding Path=.}" Width="200"/>
</DataTemplate>
```

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



## Styles

### Setter

### BasedOn

### TargetType

## ControlTemplate
[link to MS docs](https://learn.microsoft.com/en-us/dotnet/api/system.windows.controls.controltemplate?view=windowsdesktop-10.0)

```XML
<!--button style 2-->
<Style x:Key="ButtonStyle2" TargetType="{x:Type Button}">
    <Setter Property="FontSize" Value="16"/>
    <Setter Property="BorderBrush" Value="{StaticResource OnBackground}"/>
    <Setter Property="BorderThickness" Value="3"/>
    <Setter Property="Border.CornerRadius" Value="3"/>
    <Setter Property="Background" Value="{StaticResource Primary}"/>
    <Setter Property="Padding" Value="10,5"/>
    <Setter Property="Template">
        <Setter.Value>
            <ControlTemplate TargetType="{x:Type Button}">
                <Border x:Name="border" 
                        BorderBrush="{TemplateBinding BorderBrush}" 
                        BorderThickness="{TemplateBinding BorderThickness}" 
                        Background="{TemplateBinding Background}" 
                        SnapsToDevicePixels="True"
                        CornerRadius="{TemplateBinding Border.CornerRadius}">
                    <ContentPresenter x:Name="contentPresenter"
                                      Focusable="False"
                                      HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}"
                                      Margin="{TemplateBinding Padding}"
                                      RecognizesAccessKey="True"
                                      SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"
                                      VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                </Border>
            </ControlTemplate>
        </Setter.Value>
    </Setter>
</Style>
```
Note: **CornerRadius="{Binding Border.CornerRadius}"** 
allows border radius to be set from outside template
## DataTemplate

## Triggers

## StaticResource vs DynamicResource

## Scope: Application.Resources, Window.Resouces, FrameworkElement.Resources

## Add Global Resource (ResourceDictionary, MergedDictionaries)

### Add integers, etc.
Add this to the namesapce:
```xml
xmlns:sys="clr-namespace:System;assembly=System.Runtime"
```

Add this to the Resource Dictionary
```xml
<sys:Int32 x:Key="FuelChannelNameWidth">215</sys:Int32>
```

Use this in code-behind:
```CS
object? widthResource = Application.Current.TryFindResource("FuelChannelNameWidth");
if(widthResource is int channelWidth)
{
    b.DescriptionWidth = channelWidth;
}
```

### Merge Dictionaries
Dictionaries let you store styles and other values that you need global, reusable access to.

**Method #1 (GOOD, USE THIS): Add a dictionary to the App.xaml in the main .exe/app/program resources**
```xml
<!--Inside App.xaml; you can reference your UI-related project from the main project-->
<Application.Resources>
    <ResourceDictionary>
        <ResourceDictionary.MergedDictionaries>
            <ResourceDictionary Source="/ExampleSolution.MVVM;component/Dictionary/MVVMResourceDictionary.xaml"/>
            <ResourceDictionary Source="/ExampleSolution.MVVM;component/Styles/ControlResources.xaml"/>
        </ResourceDictionary.MergedDictionaries>
    </ResourceDictionary>
</Application.Resources>
```
Now these dictionaries are readable everywhere and only loaded once!
Make sure the Source path is correct!  
[Blog post](https://ikriv.com/blog/?p=1551) on this, You can also [add it to code-behind of app.xaml if you need](https://stackoverflow.com/a/9739536)  

#### Troubleshoot
Warning: I did run into an issue where the Views were not seeing the StaticResource's. For some reason the InvalidatesImplicitDataTemplateResources property for a ResourceDictionary was checked by default. Then it fixed itself. I do not know why.

**Method #2 (NOT IDEAL): Place merged dictionary in every single control/window**
```XML
    <!--This will create a copy of the dictionary for EVERY window/control which takes up a bunch of memory-->
    <UserControl.Resources>
        <ResourceDictionary>
            <ResourceDictionary.MergedDictionaries>
                <ResourceDictionary Source="/DynaFlo_PC_App.MVVM;component/Styles/SystemColors.xaml"/>
                <ResourceDictionary Source="/DynaFlo_PC_App.MVVM;component/Styles/ControlResources.xaml"/>
            </ResourceDictionary.MergedDictionaries>
        </ResourceDictionary>
    </UserControl.Resources>
```
If you place a Merged Dictionary in every single window and control, it creates a copy for each one, which takes up a BUNCH of memory.

Ideally you add a merged dictionary to the App.xaml once. Now everything can access it. (App.xaml, not MainWindow.xaml! child controls may not be a child of MainWindow!)

Dictionaries are referenced based on something called the Visual Tree. I do not understand this yet.


## x:Shared="False"

