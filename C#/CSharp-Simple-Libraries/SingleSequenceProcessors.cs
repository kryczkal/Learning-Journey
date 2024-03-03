using System.Collections;

namespace Sequences;

interface ISingleSequenceProcessor
{
    IEnumerable Process(IEnumerable sequence);
    string GetSignature();
}

public class SequenceSum : ISingleSequenceProcessor
{
    public string GetSignature() => "SequenceSum";

    public IEnumerable Process(IEnumerable sequence)
    {
        var enumer = sequence.GetEnumerator();

        int sum = 0;
        while (enumer.MoveNext())
        {
            sum += (int)enumer.Current;
            yield return sum;
        }
    }
}

public class SequenceRemainderer : ISingleSequenceProcessor
{
    public SequenceRemainderer(int val)
    {
        _val = val;
    }

    public string GetSignature() => $"SequenceRemainderer [ Rest = {_val} ]";


    public IEnumerable Process(IEnumerable sequence)
    {
        var enumer = sequence.GetEnumerator();

        while (enumer.MoveNext())
        {
            yield return (int)enumer.Current % _val;
        }
    }

    // private variables
    private readonly int _val;
}

public class EveryNFilter : ISingleSequenceProcessor
{
    public EveryNFilter(int start, int N, bool Memory = false)
    {
        _start = start;
        _N = N;
        _memory = Memory;
    }

    public string GetSignature() => $"EveryNFilter [ Start = {_start}, N = {_N}, Memory = {_memory}]";

    public IEnumerable Process(IEnumerable sequence)
    {
        int elem = 0;
        int memElem = 0;
        var enumer = sequence.GetEnumerator();

        // skipping to start point
        while (elem++ != _start - 1 && enumer.MoveNext())
            ;

        elem = _N - 1;
        while (enumer.MoveNext())
        {
            if (elem++ == _N - 1)
            {
                elem = 0;
                memElem = (int)enumer.Current;
                yield return (int)enumer.Current;
            }
            else
            {
                if (_memory) yield return memElem;
            }
        }
    }

    // private variables
    private readonly int _start;
    private readonly int _N;
    private readonly bool _memory;
}

public class EveryNSumMFilter : ISingleSequenceProcessor
{
    public EveryNSumMFilter(int start, int N, int M)
    {
        _start = start;
        _N = N;
        _M = M;
    }

    public string GetSignature() => $"EveryNSumMFilter [ Start = {_start}, N = {_N}, M = {_M}]";

    public IEnumerable Process(IEnumerable sequence)
    {
        int elem = 0;
        int memElem = 0;
        var enumer = sequence.GetEnumerator();

        // skipping to start point
        while (elem++ != _start - 1 && enumer.MoveNext())
            ;

        while (enumer.MoveNext())
        {
            int sum = 0;
            elem = 0;

            sum += (int)enumer.Current;
            while (elem++ != _M - 1 && enumer.MoveNext())
            {
                sum += (int)enumer.Current;
            }

            yield return sum;

            elem = 0;
            int range = _N - _M;
            while (elem++ != range && enumer.MoveNext())
                ;
        }
    }

    // private variables
    private readonly int _start;
    private readonly int _N;
    private readonly int _M;
}