# Memory Management
## Dispose

## Events
If your class subscribes to an event:
```CS
exampleObject.PropertyChanged += PropertyChanged
```

Then implement IDisposable by having a Dispose() function that unsubscribes from everything.
```CS
public class ShortLivedHelper : IDisposable
{
    private readonly LongLivedService _service;

    public ShortLivedHelper(LongLivedService service)
    {
        _service = service;
        _service.DataChanged += OnDataChanged;
    }

    public void Dispose()
    {
        _service.DataChanged -= OnDataChanged;
    }

    private void OnDataChanged(object sender, EventArgs e) { }
}
```

## UI Virtualization
### VirtualizingStackPanel
### VirtualizationMode=Recycling
## Freezable Objects
## Keep Visible Elements Under 2000ish
### Fallback to OnRender
### Fallback to DrawingVisual
## Memory Disposal
### IDisposal in ViewModel
### WeakEventManager
### Unloaded event cleanup