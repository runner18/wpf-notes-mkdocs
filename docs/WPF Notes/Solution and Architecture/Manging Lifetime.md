# Dispose

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