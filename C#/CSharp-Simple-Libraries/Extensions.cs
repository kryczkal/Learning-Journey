
using System.Collections;
using System.Dynamic;
using System.Numerics;
using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace MyExtensions;

public static class StringExtension
{
    public static string Random(int StrLen = 10)
    {
        Random rng = new Random();
        StringBuilder stringBuilder = new StringBuilder(StrLen);
        for (int i = 0; i < StrLen; i++)
        {
            stringBuilder.Append((char)rng.Next(33, 127));
        }
        return stringBuilder.ToString();
    }
    public static string AlphaNumeric(this string s)
    {
        StringBuilder stringBuilder = new StringBuilder();
        foreach (char ch in s)
        {
            if (Char.IsLetterOrDigit(ch)) stringBuilder.Append(ch);
        }
        return stringBuilder.ToString();

    }
}

public static class EnumerableExtensions
{
    public static T Median<T>(this IEnumerable<T> enumerable) where T : INumber<T>
    {
        List<T> list = new List<T>();
        foreach (T item in enumerable)
        {
            list.Add(item);
        }
        list.Sort();
        var n = list.Count;

        T median;

        var isOdd = n % 2 != 0;
        if (isOdd)
        {
            median = list[(n + 1) / 2 - 1];
        }
        else
        {
            median = (list[n / 2 - 1] + list[n / 2]) / T.CreateChecked(2);
        }
        return median;
    }
    public static T Mode<T>(this IEnumerable<T> enumerable) where T : INumber<T>
    {
        Dictionary<T, int> dict = new Dictionary<T, int>();
        foreach (T item in enumerable)
        {
            if (dict.ContainsKey(item)) dict[item]++;
            else dict[item] = 0;
        }
        return dict.dict.Values.Max();
    }
    public static float Average<T>(this IEnumerable<T> enumerable) where T : INumber<T>
    {
        List<T> list = new List<T>();
        foreach (T item in enumerable)
        {
            list.Add(item);
        }
        return 0;
    }
}