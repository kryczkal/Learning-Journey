using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace MyDictionary;

interface IMyDictionary<TKey, TValue>
{
    int Count { get; }
    void Add(TKey key, TValue value);
    bool Contains(TKey key);
    bool TryGetValue(TKey key, out TValue value);
    bool Remove(TKey key);
}

public class MyDictionary<TKey, TValue> : IMyDictionary<TKey, TValue>, IEnumerable<(TKey, TValue)>
    where TKey : struct
{


    public bool Contains(TKey k) => _contains(k) != NotFound;

    public void Add(TKey key, TValue value)
    {
        var res = _contains(key);

        if (res != NotFound)
        {
            _arr[res].v = value;
        }
        else
        {
            _expandRightIfNecessary();
            _arr[_pos++] = (key, value);
        }
    }

    public bool TryGetValue(TKey key, out TValue value)
    {
        var res = _contains(key);

        if (res != NotFound)
        {
            value = _arr[res].v;
            return true;
        }

        value = default!;
        return false;
    }

    public bool Remove(TKey key)
    {
        var result = _contains(key);

        if (result == NotFound) return false;

        _shiftLeft(result);
        return true;
    }

    public int Count => _pos;

    public IEnumerator<(TKey, TValue)> GetEnumerator()
    {
        for (int i = 0; i < _pos; ++i) yield return _arr[i];
    }

    public override string ToString()
    {
        StringBuilder builder = new StringBuilder();

        foreach ((TKey, TValue) var in this)
        {
            builder.Append($"[{var.Item1}:{var.Item2}]");
        }

        return builder.ToString();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }

    // private methods 

    private int _contains(TKey k)
    {
        for (int i = 0; i < _pos; ++i)
        {
            if (_arr[i].k.Equals(k))
            {
                if (i == 0) return 0;

                (_arr[i], _arr[i - 1]) = (_arr[i - 1], _arr[i]);
                return i - 1;
            }
        }

        return NotFound;
    }

    private void _shiftLeft(int shiftBeg)
    {
        for (int i = shiftBeg; i < _pos; ++i)
        {
            _arr[i] = _arr[i + 1];
        }

        --_pos;
    }

    private void _expandRightIfNecessary()
    {
        if (_pos != _arr.Length) return;
        var temp = _arr;
        _arr = new (TKey k, TValue v)[2 * _pos];
        temp.CopyTo(_arr, 0);
    }

    // private variables
    private const int NotFound = -1;
    private (TKey k, TValue v)[] _arr = new (TKey k, TValue v)[4];
    private int _pos;
}

public static class MyDictionaryExtensions
{
    public static TKey[] GetKeys<TKey, TValue>(this MyDictionary<TKey, TValue> me)
        where TKey : struct
    {
        TKey[] ret = new TKey[me.Count];

        int pos = 0;
        foreach ((TKey, TValue) kv in me)
        {
            ret[pos++] = kv.Item1;
        }

        return ret;
    }

    public static TValue MaxValue<TKey, TValue>(this MyDictionary<TKey, TValue> me)
        where TKey : struct
        where TValue : IComparable<TValue>
    {
        TKey[] ret = new TKey[me.Count];

        TValue max = default!;
        bool isReplaced = false;
        foreach ((TKey, TValue) kv in me)
        {
            if (!isReplaced)
            {
                max = kv.Item2;
                isReplaced = true;
                continue;
            }

            if (kv.Item2.CompareTo(max) > 0) max = kv.Item2;
        }

        return max;
    }
}