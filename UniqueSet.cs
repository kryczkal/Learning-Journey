using System;

namespace MySet;
public class UniqueSet
{
    public UniqueSet()
    {
        _tab = Array.Empty<int>();
    }

    public UniqueSet(int[] input)
    {
        int[] temp = new int[input.Length];
        int arrPos = 0;

        foreach (var val in input)
        {
            bool found = false;
            for (int i = 0; i < arrPos; ++i)
            {
                if (temp[i] == val) found = true;
            }

            if (found) continue;

            temp[arrPos++] = val;
        }

        _tab = temp[..arrPos];
    }

    public UniqueSet Clone() => new UniqueSet(_tab);

    public void Deconstruct(out UniqueSet evenNumbers, out UniqueSet oddNumbers)
    {
        if (_tab == null)
        {
            evenNumbers = new UniqueSet();
            oddNumbers = new UniqueSet();
            return;
        }

        int[] evenNums = new int[_tab.Length];
        int[] oddNums = new int[_tab.Length];
        int evenArrPos = 0;
        int oddArrPos = 0;

        foreach (var val in _tab)
        {
            if (val % 2 == 0) evenNums[evenArrPos++] = val;
            else oddNums[oddArrPos++] = val;
        }

        evenNumbers = new UniqueSet(evenNums[..evenArrPos]);
        oddNumbers = new UniqueSet(oddNums[..oddArrPos]);
    }

    public override string ToString()
    {
        string result = "[";
        result += string.Join(';', _tab);
        result += "]";

        return result;
    }

    public int this[int i]
    {
        get
        {
            if (i >= Size) throw new IndexOutOfRangeException();
            return _tab[i];
        }
        set
        {
            if (i >= Size) throw new IndexOutOfRangeException();
            _tab[i] = value;
        }
    }

    public static bool operator ==(UniqueSet a, UniqueSet b)
    {
        if (a.Size != b.Size) return false;

        foreach (var val in a._tab)
        {
            bool found = false;

            foreach (var valB in b._tab)
            {
                if (val == valB)
                {
                    found = true;
                    break;
                }
            }

            if (!found) return false;
        }

        return true;
    }

    public static bool operator !=(UniqueSet a, UniqueSet b) => !(a == b);

    public static explicit operator UniqueSet(int[] tab) => new UniqueSet(tab);

    public static implicit operator int[](UniqueSet x)
    {
        int[] tab = new int[x.Size];
        x._tab.CopyTo(tab, 0);
        return tab;
    }

    public static implicit operator UniqueSet(int x) => new UniqueSet(new int[] { x });

    public static UniqueSet operator +(UniqueSet a, UniqueSet b)
    {
        int[] resArr = new int[a.Size + b.Size];
        a._tab.CopyTo(resArr, 0);
        b._tab.CopyTo(resArr, a.Size);

        return new UniqueSet(resArr);
    }

    public static UniqueSet operator --(UniqueSet a)
    {
        for (int i = 0; i < a.Size; ++i)
            a._tab[i]--;

        return a;
    }

    public static UniqueSet operator ^(UniqueSet a, UniqueSet b)
    {
        int[] resArr = new int[a.Size + b.Size];
        int arrPos = 0;

        foreach (var valA in a._tab)
        {
            bool found = false;

            foreach (var valB in b._tab)
            {
                if (valA == valB)
                {
                    found = true;
                    break;
                }
            }

            if (!found) resArr[arrPos++] = valA;
        }

        foreach (var valB in b._tab)
        {
            bool found = false;

            foreach (var valA in a._tab)
            {
                if (valA == valB)
                {
                    found = true;
                    break;
                }
            }

            if (!found) resArr[arrPos++] = valB;
        }

        return new UniqueSet(resArr[..arrPos]);
    }


    // -----------------------
    // Fields

    private int[] _tab;

    public int Size => _tab.Length;
}