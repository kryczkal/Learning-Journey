namespace CharSet;

public class CharSet
{
    public CharSet(params (char c, int i)[] p)
    {
        foreach (var input in p)
        {
            if (_dict.ContainsKey(input.c))
                _dict[input.c] += input.i;
            else _dict.Add(input.c, input.i);
        }
    }

    public override string ToString()
    {
        string res = "{";
        int keyCount = _dict.Count;

        foreach (var pair in _dict)
        {
            res += "(" + pair.Key.ToString() + ':' + pair.Value.ToString() + ")";
            if (--keyCount != 0) res += ',';
        }

        return res + '}';
    }

    public static CharSet operator +(CharSet a, char b)
    {
        CharSet ret = new CharSet();

        foreach (var pair in a._dict)
        {
            ret._dict.Add(pair.Key, pair.Value);
        }

        if (ret._dict.ContainsKey(b)) ret._dict[b]++;
        else ret._dict.Add(b, 1);

        return ret;
    }

    public static CharSet operator +(char a, CharSet b) => b + a;

    public static CharSet operator +(CharSet a, CharSet b)
    {
        CharSet ret = new CharSet();

        foreach (var pair in a._dict)
        {
            ret._dict.Add(pair.Key, pair.Value);
        }

        foreach (var pair in b._dict)
        {
            if (ret._dict.ContainsKey(pair.Key)) ret._dict[pair.Key] += pair.Value;
            else ret._dict.Add(pair.Key, pair.Value);
        }

        return ret;
    }

    public static CharSet operator *(CharSet a, CharSet b)
    {
        CharSet ret = new CharSet();

        foreach (var valA in a._dict)
        {
            foreach (var valB in b._dict)
            {
                if (valA.Key == valB.Key)
                {
                    ret._dict.Add(valA.Key, Math.Min(valA.Value, valB.Value));
                    break;
                }
            }
        }

        return ret;
    }

    public static CharSet operator ++(CharSet a)
    {
        foreach (var key in a._dict.Keys)
            a._dict[key]++;

        return a;
    }

    public static bool operator ==(CharSet a, CharSet b)
    {
        if (a._dict.Count != b._dict.Count) return false;

        foreach (var valA in a._dict)
        {
            if (!b._dict.ContainsKey(valA.Key)) return false;
            if (b._dict[valA.Key] != valA.Value) return false;
        }

        return true;
    }

    public static bool operator !=(CharSet a, CharSet b)
    {
        return !(a == b);
    }

    public static bool operator <(CharSet a, CharSet b)
    {
        return b > a;
    }

    public static bool operator >(CharSet a, CharSet b)
    {
        if (a._dict.Count < b._dict.Count) return false;

        foreach (var valB in b._dict)
        {
            if (!a._dict.ContainsKey(valB.Key)) return false;
            if (a._dict[valB.Key] < valB.Value) return false;
        }

        return true;
    }

    // ---------------------
    // private fields

    private Dictionary<char, int> _dict = new Dictionary<char, int>();
}