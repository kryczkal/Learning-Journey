using System.Numerics;

namespace MyPair;

public class Pair<TKey, TValue> : IComparable<Pair<TKey, TValue>>
    where TKey : IComparable<TKey>
{
    public Pair(TKey k, TValue v)
    {
        _key = k;
        _value = v;
    }

    public TKey Key => _key;

    public TValue Value
    {
        set => _value = value;
        get => _value;
    }

    public int CompareTo(Pair<TKey, TValue>? other)
        => _key.CompareTo(other!._key);

    // private fields
    private TKey _key;
    private TValue _value;
}

public interface IMap<TKey, TValue>
    where TKey : IComparable<TKey>
{
    public int Count { get; }
    public bool Add(TKey k, TValue v);
    public Pair<TKey, TValue>? Find(TKey k);
}

public class SortedLinkedList<TKey, TValue> : IMap<TKey, TValue>
    where TKey : IComparable<TKey>
{
    public SortedLinkedList()
    {
        _head = new();
        _tail = _head;
    }

    public int Count => _count;
    public bool Add(TKey k, TValue v)
    {
        if (Count == 0)
        {
            _head = _tail = new();
            _head.data = new Pair<TKey, TValue>(k, v);
            ++_count;
            return true;
        }

        var ret = Find(k);
        if (ret != null) return false;

        Node? p = _head;
        while (p != null && (k.CompareTo(p.data.Key) > 0))
        {
            p = p.next;
        }

        Node? nd = new()
        {
            data = new Pair<TKey, TValue>(k, v),
            next = p
        };

        if (p == null)
        {
            nd.prev = _tail;
            _tail!.next = nd;
            _tail = nd;
        }
        else if (ReferenceEquals(p, _head))
        {
            _head = nd;
            p.prev = nd;
        }
        else
        {
            nd.prev = p.prev;
            nd.prev!.next = nd;
            p.prev = nd;
        }

        ++_count;
        return true;
    }

    public Pair<TKey, TValue>? PopFront()
    {
        if (_count == 0) return null;

        var ret = _head.data;

        if (_count == 1)
        {
            _head = _tail = null;
            _count = 0;
            return ret;
        }

        --_count;
        _head = _head.next;
        _head.prev = null;

        return ret;
    }

    public Pair<TKey, TValue>? Find(TKey k)
    {
        Node? p = _head;
        while (p != null && (p.data.Key.CompareTo(k) != 0))
            p = p.next;

        return p?.data;
    }

    // private fields

    private class Node
    {
        public Pair<TKey, TValue> data = null;
        public Node? next = null;
        public Node? prev = null;
    }

    private int _count = 0;
    private Node? _head;
    private Node? _tail;
}

public class BinaryTree<TKey, TValue> : IMap<TKey, TValue>
    where TKey : IComparable<TKey>
{
    public int Count => _count;
    public bool Add(TKey k, TValue v)
    {
        Node? nd = new()
        {
            data = new Pair<TKey, TValue>(k, v)
        };

        if (_count == 0)
        {
            _root = nd;
            ++_count;
            return true;
        }

        Node? pp = null;
        Node? p = _root;

        while (p != null && (k.CompareTo(p.data.Key) != 0))
        {
            pp = p;
            if (k.CompareTo(p.data.Key) > 0)
            {
                p = p.branches[(int)Node.bNames.right];
            }
            else
            {
                p = p.branches[(int)Node.bNames.left];
            }
        }

        if (p != null) return false;
        if (k.CompareTo(pp.data.Key) > 0)
        {
            pp.branches[(int)Node.bNames.right] = nd;
        }
        else
        {
            pp.branches[(int)Node.bNames.left] = nd;
        }

        ++_count;
        return true;
    }

    public Pair<TKey, TValue>? Find(TKey k)
    {
        Node? p = _root;

        while (p != null && (k.CompareTo(p.data.Key) != 0))
        {
            if (k.CompareTo(p.data.Key) > 0)
            {
                p = p.branches[(int)Node.bNames.right];
            }
            else
            {
                p = p.branches[(int)Node.bNames.left];
            }
        }

        return p?.data;
    }


    // private fields
    private class Node
    {
        public Pair<TKey, TValue>? data = null;
        public Node?[] branches = new Node[2];

        public enum bNames
        {
            left,
            right
        };
    }

    private Node? _root = null;
    private int _count = 0;
}

public static class IMapExtenstion
{
    public static bool ContainsAll<TKey, TValue>(this IMap<TKey, TValue> me, IEnumerable<TKey> ienum)
        where TKey : IComparable<TKey>
    {
        foreach (var key in ienum)
        {
            if (me.Find(key) == null) return false;
        }

        return true;

    }

    public static int SumForKeys<TKey>(this IMap<TKey, int> me, IEnumerable<TKey> ienum)
        where TKey : IComparable<TKey>
    {
        int sum = default;
        foreach (var key in ienum)
        {
            var pair = me.Find(key);
            if (pair != null) sum = sum + pair.Value;
        }

        return sum;
    }
}