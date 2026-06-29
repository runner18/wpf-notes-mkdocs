## Navigation
Elements that related to moving around pages, etc.

### Add Tabs with TabControl
```xml
<!--
Source - https://stackoverflow.com/a/189624
Posted by Brad Leach
Retrieved 2026-05-18, License - CC BY-SA 2.5
-->

<TabControl TabStripPlacement="Right">
  <TabControl.Resources>
    <Style TargetType="{x:Type TabItem}">
      <Setter Property="Padding" Value="4" />
      <Setter Property="HeaderTemplate">
        <Setter.Value>
          <DataTemplate>
            <ContentPresenter Content="{TemplateBinding Content}">
              <ContentPresenter.LayoutTransform>
                <RotateTransform Angle="90" />
              </ContentPresenter.LayoutTransform>
            </ContentPresenter>
          </DataTemplate>
        </Setter.Value>
      </Setter>
    </Style>
  </TabControl.Resources>
  <TabItem Header="Tab Item 1" />
  <TabItem Header="Tab Item 2" />
  <TabItem Header="Tab Item 3" />
  <TabItem Header="Tab Item 4" />
</TabControl>

```

### Creating a Dialog
Following the MVVM approach, the ViewModel should have no knowledge of the View, and therefore should not be involved with creating a dialog. 

There are a couple of approaches you can take:

**Create a DialogService**  
The ViewModel would use this service to create a new window, meaning the ViewModel does not create the window directly.  The window would change depending on the ViewModel type passed in.

[This is a more simple example](https://stackoverflow.com/questions/25845689/opening-new-window-in-mvvm-wpf)  
[This is a more complex example](https://stackoverflow.com/questions/3801681/good-or-bad-practice-for-dialogs-in-wpf-with-mvvm?noredirect=1&lq=1)


**The Purist**  
[The top response to this](https://stackoverflow.com/questions/1043918/open-file-dialog-mvvm?noredirect=1&lq=1)  argues dialogs are a UI thing, meaning only UI should call it even if from the code-behind.


## Handling Images  
In short, set the Image's source to either BitmapImage or a Uri.

Ways to set the image types:
- Image.Source > Uri
- Image.Source > ImageSource/BitmapSource/BitmapImage > BitmapImage.UriSource  
  
Here's a full layout of image related classes, I found the names confusing:

- *System.Foundation namespace*
  - public sealed class **Uri** (the filepath)
- *System.Drawing namespace*
  - public abstract class **Image** (do NOT use for images like png)
- *System.Windows namespace*
  - *Controls namespace*
    - public abstract class **Image** (the UI element itself)
      - public ImageSource **Image.Source** (can set to ImageSource or Uri directly)
  - *Media namespace*
    - public abstract class **ImageSource**
    - *Imaging namespace*  
      - public abstract class  **BitmapSource** : ImageSource 
        - public sealed class **BitmapImage** : BitmapSource
          - public Uri **BitmapImage.UriSource** (the image's filepath)

Remember to set image to copy to output directory!

Some examples: 
```CS
```

1. Take the Uri
2. Set BitmapImage.Source to the Uri
3. Set the Image.Source to the BitmapImage
4. Altenatively, you can set the Image.Source directly to the Uri


## ContentControl

## ItemsControl

## HeaderedContentControl

## UserControl, CustomControl, CustomPanel


## ComboBox
In the CS:
```CS
public class Person
{
  public string Name;
  public int Age;
  public string Gender;
}

// assume this collection is already full of Person objects
ObservableCollection<Person> PersonCollection { get; } = new ObservableCollection();

public Person PersonYouWantToBindTo = new Person();
public string GenderYouWantToBindTo = string.Empty;

```

XAML Scenario #1 - the combo box will display **the names in the dropdown UI**, and will **give you a person object**

```xml
<ComboBox ItemsSource = {Binding PersonCollection}
  DisplayMemberPath = "Name"
  SelectedItem = {Binding PersonYouWantToBindTo}>
```

XAML Scenario #2 - the combo box will **display the names in the dropdown UI**, and will **give you a gender string**
```XML
<ComboBox ItemsSource = {Binding PersonCollection}
  DisplayMemberPath = "Name"
  SelectedValuePath = "Gender"
  SelectedValue = {Binding GenderYouWantToBindTo}/>
  ```

### Bind ComboBox to Enum
Add the following classes:


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
public class ValueDescription
{
    public object? Value { get; set; }
    public object? Description { get; set; }
}
```

Then in the xaml:
```xml
<UserControl . . .
             xmlns:edb="clr-namespace:ExampleSolution.MVVM.Extensions.EnumDataBinding">

<DataTemplate DataType="{x:Type sys:Enum}">
    <ComboBox ItemsSource="{Binding Path=., 
                  Converter={edb:EnumToCollectionConverter}, 
                  Mode=OneTime}"
               SelectedValuePath="Value" 
               DisplayMemberPath="Description"
               SelectedValue="{Binding Path=., 
                  Mode=TwoWay, 
                  UpdateSourceTrigger=PropertyChanged}"/>
</DataTemplate>
```

## Datagrid
DataGrid is used when you need to be able to edit stuff in your tabloe. Also supports automatic column generation.

To set the content of DataGrid
- set dataGrid.ItemsSource to "List\<ExampleClass> listOfObjects"
- Each object in listOfObjects will be a **row** in dataGrid
- eac property in ExampleClass can be a **column** in dataGrid

DataGrid auto generates each column based on each public property in ExampleClass. Set dataGrid.AutoGenerateColumns to **false** to add the columns yourself (don't forget to bind the column to a property in the object's class).

A helpful example:  https://wpf-tutorial.com/datagrid-control/custom-columns/

```XML
<DataGrid Name="dgUsers" AutoGenerateColumns="False">
  <DataGrid.Columns>

      <DataGridTextColumn Header="Name" Binding="{Binding Name}" />

      <DataGridTemplateColumn Header="Birthday">
          <DataGridTemplateColumn.CellTemplate>
              <DataTemplate>
                  <DatePicker SelectedDate="{Binding Birthday}" BorderThickness="0" />
              </DataTemplate>
          </DataGridTemplateColumn.CellTemplate>
      </DataGridTemplateColumn>

  </DataGrid.Columns>
</DataGrid>
```

```CS
using System;
using System.Collections.Generic;
using System.Windows;

namespace WpfTutorialSamples.DataGrid_control
{
	public partial class DataGridColumnsSample : Window
	{
		public DataGridColumnsSample()
		{
			InitializeComponent();

			List<User> users = new List<User>();
			users.Add(new User() { Id = 1, Name = "John Doe", Birthday = new DateTime(1971, 7, 23) });
			users.Add(new User() { Id = 2, Name = "Jane Doe", Birthday = new DateTime(1974, 1, 17) });
			users.Add(new User() { Id = 3, Name = "Sammy Doe", Birthday = new DateTime(1991, 9, 2) });

			dgUsers.ItemsSource = users;
		}
	}

	public class User
	{
		public int Id { get; set; }

		public string Name { get; set; }

		public DateTime Birthday { get; set; }
	}
}
```