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

## Customize Existing Elements with Templates
