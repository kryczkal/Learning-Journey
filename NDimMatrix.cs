using System;
using System.Numerics;

namespace NDimMatrix;

public class NDimMatrix<NumT>
    where NumT : INumber<NumT>
{
    public NDimMatrix(Array inputMatrix)
    {
        _matrix = inputMatrix;
    }

    // public 

    public Array Matrix => _matrix;

    // private fields

    private readonly Array _matrix;
}

public static class NDimMatrixExtension
{
    public static NumT Max<NumT>(this NDimMatrix<NumT> me)
        where NumT : INumber<NumT>
    {
        NumT max = default(NumT);
        bool isSet = false;

        foreach (var val in me.Matrix)
        {
            if (!isSet)
            {
                max = (NumT)val;
                isSet = true;
            }
            else if ((NumT)val > max) max = (NumT)val;
        }

        return max;
    }

    public static NumT Min<NumT>(this NDimMatrix<NumT> me)
        where NumT : INumber<NumT>
    {
        NumT min = default(NumT);
        bool isSet = false;

        foreach (var val in me.Matrix)
        {
            if (!isSet)
            {
                min = (NumT)val;
                isSet = true;
            }
            else if ((NumT)val < min) min = (NumT)val;
        }

        return min;
    }
    public static NumT[] Flatten<NumT>(this NDimMatrix<NumT> me)
        where NumT : INumber<NumT>
    {
        NumT[] ret = new NumT[me.Matrix.Length];
        int pos = 0;

        foreach (var val in me.Matrix)
        {
            ret[pos++] = (NumT)val;
        }

        return ret;
    }
}