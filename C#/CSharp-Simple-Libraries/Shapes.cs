namespace Shapes;

public abstract class Shape2D
{
    private static int ObjCount = 0;
    protected readonly int ObjectNumber;

    protected Shape2D()
    {
        ObjectNumber = ++ObjCount;
        System.Console.WriteLine($"Shape2D ({ObjectNumber}) created");
    }

    ~Shape2D()
    {
        System.Console.WriteLine($"Shape2D ({ObjectNumber}) destroyed");
    }

    public abstract double CalculateArea();

    public virtual string PrintShape2D() => "Shape(Shape2d)";
}

public class Circle : Shape2D
{
    public readonly double Radius;
    public Circle(double radius)
    {
        Radius = radius;
        System.Console.WriteLine($"Circle({ObjectNumber}) with radius={radius} created");
    }

    ~Circle()
    {
        System.Console.WriteLine($"Circle ({ObjectNumber}) destroyed");
    }

    public override double CalculateArea()
    {
        return Math.PI * Radius * Radius;
    }

    public override string PrintShape2D() => $"Circle(r={Radius})";
}

public abstract class Shape3D
{
    private static int _objectCount = 0;
    private readonly int _objectNumber;
    protected readonly Shape2D BaseShape;
    protected readonly double Height;

    public static int NumberOfCreatedObjects => _objectCount;


    public Shape3D(Shape2D baseShape, double height)
    {
        BaseShape = baseShape;
        Height = height;

        _objectNumber = ++_objectCount;
    }

    public abstract double CalculateCapacity();
    public virtual string PrintShape3D() => $"Shape3D with base {BaseShape.PrintShape2D()} and height: {Height}";
}

public class Cone : Shape3D
{
    private static int _objectCount = 0;
    protected readonly int ObjectNumber;
    private readonly double _radius;

    public static int NumberOfCreatedObjects => _objectCount;


    public Cone(Circle circ, double height) :
        base(circ, height)
    {
        ObjectNumber = ++_objectCount;
        _radius = circ.Radius;
    }

    public override double CalculateCapacity()
    {
        return (Math.PI * _radius * _radius * Height) / 3;
    }

    public override string PrintShape3D() => $"Cone(h={Height}) with base: {BaseShape.PrintShape2D()}";
}

public class Cylinder : Shape3D
{
    private static int _objectCount = 0;
    protected readonly int ObjectNumber;
    private readonly double _radius;

    public static int NumberOfCreatedObjects => _objectCount;

    public Cylinder(Circle circ, double height) :
        base(circ, height)
    {
        ObjectNumber = ++_objectCount;
        _radius = circ.Radius;
    }

    public override double CalculateCapacity()
    {
        return (Math.PI * _radius * _radius * Height);
    }

    public string PrintShape3D() => $"Cylinder(h={Height}) with base: {BaseShape.PrintShape2D()}";
}