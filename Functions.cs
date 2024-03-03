namespace Functions;
public static class Functions
{
    public static Func<double, double> Constant(double x) => ((double y) => x);
    public static Func<double, double> Identity() => ((double x) => x);

    public static Func<double, double> Polynomial(params double[] coefs)
    {
        if (coefs.Length == 0) return (double x) => 0;

        return (double x) =>
        {
            double a = coefs[0];
            for (int i = 1; i < coefs.Length; ++i)
            {
                a = a * x + coefs[i];
            }

            return a;
        };
    }
}

public static class Transformations
{
    public static Func<double, double> Derivative(Func<double, double> f, double h = 0.000001) =>
        ((double x) => (f(x + h) - f(x - h)) / (2 * h));

    private delegate void Deleg(ref double x);
    private static Func<double, double> _composer(Func<double, double, double> helper, Func<double, double> f, params Func<double, double>[] fs)
    {
        Deleg d = (ref double d1) => d1 = f(d1);
        foreach (var func in fs)
        {
            d += (ref double d1) => d1 = helper(d1, func(d1));
        }

        return d1 =>
        {
            d(ref d1);
            return d1;
        };
    }

    public static Func<double, double> Min(Func<double, double> f, params Func<double, double>[] fs)
        => _composer(Math.Min, f, fs);
    public static Func<double, double> Max(Func<double, double> f, params Func<double, double>[] fs)
        => _composer(Math.Max, f, fs);
    public static Func<double, double> Compose(Func<double, double> f, params Func<double, double>[] fs)
        => _composer(((d, d1) => d1), f, fs);
}

public static class NumericalMethods
{
    public static double Bisection(Func<double, double> f, double a, double b, double eps = 0.000001)
    {
        double fa = f(a);
        double fb = f(b);
        if (fa * fb >= 0) return double.NaN;
        double midP = (b + a) / 2;

        while (b - a > eps)
        {
            double midV = f(midP);

            if (fa * midV < 0)
            {
                fb = midV;
                b = midP;
            }
            else if (fb * midV < 0)
            {
                fa = midV;
                a = midP;
            }
            else
            {
                return midP;
            }
            midP = (b + a) / 2;
        }

        return midP;
    }
}