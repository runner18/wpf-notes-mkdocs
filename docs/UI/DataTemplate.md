## Summary
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
You can use a UI element such as "ContentControl".  

If a ContentControl's source matches the DataType of a DataTemplate, the ContentControl will *transform* into the content of said matching DataTemplate.

ItemsControl is similar except it makes a UI list by binding to, well, a list (ObservableCollection, whatever). Each member of the list transforms accordingly.

## Chatbot Answer

(Take this with a grain of salt it's from a chatbot)

How to create a ViewModel that can handle multiple data types and read status:
```cs
public enum { PositionerReadWrite, PositionerReadOnly, PcOnly }
public enum ValueDataType { Numeric, Boolean, Enum, String }

public class ValueViewModel : INotifyPropertyChanged
{
    // Identification and configuration
    public string Label { get; }
    public ValueCategory Category { get; }
    public ValueDataType DataType { get; }
    public bool IsReadOnly { get; } // controls UI editablility
    public IEnumerable<string> EnumOptions { get; } // only relevant when DataType == Enum
    
    // The "user-set" value - shown to the user, editable if not read-only
    [ObservableProperty]
    public partial DisplayValue { get; set; }

    // The "source" value from HART / DB, for revert or comparison
    public object SourceValue { get; private set; }
    public object IsModified { get; private set; }

    // Methods to commit/revert
    public void AcceptPending() { SourceValue = DisplayValue; IsModified = false; }
    public void RejectPending() { DisplayValue = SourceValue; IsModified = false; }

    // Logic to save to the right place(s) according to category
    public async Task SaveAsync()
    {
        if (!IsModified) return;
        if(Category == ValueCategory.PcOnly || Category == ValueCategory.PositionerReadOnly || Category == ValueCategory.PositionerReadWrite)
        {
            // always write to database
            await DatabaseService.WriteAsync(...);
        }
        if(Category == ValueCategory.PositionerReadWrite)
        {
            // also write to embeddded device
            await HartService.WriteAsync(...);
        }
        AcceptPending();
    }
}
```

Implement DataTemplateSelector
```CS
public class ValueTemplateSelector : DataTemplateSelector
{
    public DataTemplate NumericReadWriteTemplate { get; set; }
    public DataTemplate NumericReadOnlyTemplate { get; set; }
    public DataTemplate BooleanTemplate { get; set; }
    public DataTemplate EnumTemplate { get; set; }
    public DataTemplate StringReadWriteTemplate { get; set; }
    public DataTemplate StringReadOnlyTemplate { get; set; }

    public override DataTemplate SelectTemplate(object item, DependencyObject container)
    {
        if (item is ValueViewModel vm)
        {
            if (vm.DataType == ValueDataType.Enum)
                return EnumTemplate;
            if (vm.DataType == ValueDataType.Boolean)
                return BooleanTemplate;
            // For numeric/string, factor in read‑only
            if (vm.IsReadOnly)
                return vm.DataType == ValueDataType.Numeric ? NumericReadOnlyTemplate : StringReadOnlyTemplate;
            else
                return vm.DataType == ValueDataType.Numeric ? NumericReadWriteTemplate : StringReadWriteTemplate;
        }
        return base.SelectTemplate(item, container);
    }
}
```

In the XAML:
```xml
<ContentControl Content="{Binding MyValueViewModel}"
                ContentTemplateSelector="{StaticResource ValueTemplateSelector}" />

<DataTemplate x:Key="NumericReadWriteTemplate">
    <TextBox Text="{Binding DisplayValue, UpdateSourceTrigger=PropertyChanged}"
             IsEnabled="{Binding IsReadOnly, Converter={StaticResource InvertBoolConverter}}"/>
</DataTemplate>

<DataTemplate x:Key="EnumTemplate">
    <ComboBox ItemsSource="{Binding EnumOptions}"
              SelectedItem="{Binding DisplayValue}"
              IsEnabled="{Binding IsReadOnly, Converter={StaticResource InvertBoolConverter}}"/>
</DataTemplate>
```