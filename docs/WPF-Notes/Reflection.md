Reflection lets you get type information
```CS
int i = 42;
System.Type type = i.GetType();
System.Console.WriteLine(type);
```

The above example results in the following output:
```
System.Int32
```

### Get List of Properties in Class
```CS
obj.GetType().GetProperties();
typeof(Foo).GetProperties();
```

```CS
class Foo 
{
	public int A { get; set; }
	public string B { get; set; }
}

// ...

Foo foo = new Foo { A = 1, B = "abc" };
foreach(bar prop in Foo.GetType().GetProperties())
{
	Console.WriteLine("{0} = {1}", prop.Name, prop.GetValue(foo, null));
}
```