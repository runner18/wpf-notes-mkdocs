# Behaviors and Properties
## Attached Properties
### Grid.Row
### Dockpanel.Dock

### Add DependencyProperty to UserControl
Basically, Add the DependencyProperty to the code-behind, then bind to it in the xaml using a special relative-ancestor binding (see below)

```CS
// In the code behind (LocalValueControl.xaml.cs)
 public object DisplayValue
 {
     get
     {
         return (object)GetValue(DisplayValueProperty);
     }
     set
     {
         SetValue(DisplayValueProperty, value);
     }
 }

 public static readonly DependencyProperty DisplayValueProperty = 
        DependencyProperty.Register("DisplayValue",
            typeof(object), 
            typeof(LocalValueControl), 
            new FrameworkPropertyMetadata(""));
```

```XML
<!--In the xaml designer (LocaolValueControl.xaml)-->
<ContentControl Grid.Column="2"  
    Content="{Binding DisplayValue, 
        RelativeSource={RelativeSource FindAncestor, 
            AncestorType={x:Type local:LocalValueControl}}}"/>
```

Note! Dependency properties are only if you need to set the properties from the parent, potentially the parent's DataContext: 
```xml
<!--Inside the xaml of a parent window using LocalValueControl-->
<LocalValueControl DisplayValue={Binding ExampleParentValue}/>
```
If the UserControl is just using its own DataContext, these are not needed:
```xml
<!--When the LocalValueControl is using its own DataContext-->
<LocalValueControl DataContext={Binding ExampleParentObject}/>
```
### Troubleshooting: A "Binding" cannot be set...DependencyProperty
This likely means there is an issue with the DependencyProperty setup.   
In my case I had the wrong first parameter for DependencyProperty.Register().

## Behaviors
### Interaction.Behaviors
### TriggerAction
### EventTrigger
## Custom Attached Behaviors
### UI Logic without Code-Behind
This is a test change