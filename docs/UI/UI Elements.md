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






