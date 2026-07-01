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
foreach(PropertyInfo[] prop in Foo.GetType().GetProperties())
{
	Console.WriteLine("{0} = {1}", prop.Name, prop.GetValue(foo, null));
}
```

Things to note:
- **GetProperties()** - gets an array of each property's PropertyInfo
- **PropertyInfo.Name** - gets the property name
- **PropertyInfo.GetValue()** - gets the value of the property, returns *object?*
- **PropertyInfo.PropertyType.Name** - gets the name of the data type (e.g. string)
### EqualityComparer
EqualityComparer\<T>.Default is a build-in .NET class from *System.Collections.Generic*. It figures out the right way to compare two values of type T without you having to write type-specific comparison logic.

For a double it compares numbers, for a bool is compares true/false, etc.

The alternative would be writing
```
if (T is double) ... else if (T is bool) ...
```
which defeats the purpose of generics.

### default!
These are two separate things comvined:
- default is a C# keyword meaning "the zero-like value for this type"
	- 0 for numeric types
	- false for bool
	- null for reference types
- ! is the null-forgiving operator, which just tells the compiler "I know this looks like it could be null, don't warn me about it." It has no effect at runtime, it only suppresses a compiler warning.
So *private T _deviceValue = default!;* means "start with the zero value for whatever T is, and don't warn me that it might be null".


