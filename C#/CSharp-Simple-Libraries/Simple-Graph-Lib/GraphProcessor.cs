namespace SimpleGraphLib;

public static class GraphProcessor
{
    public static ((int degree, int v) min, (int degree, int v) max) FindMinAndMaxDegree(Graph x)
    {
        (int degree, int v) min = (x.GetVerticesCount(), x.GetVerticesCount());
        (int degree, int v) max = (-1, -1); ;

        for (int i = 0; i < x.GetVerticesCount(); ++i)
        {
            (int degree, int v) act = (0, i);
            for (int j = 0; j < x.GetVerticesCount(); ++j)
            {
                if (j == i) continue;

                if (x.GetEdge(i, j) != null || x.GetEdge(j, i) != null)
                    act.degree++;
            }

            if (x.GetEdge(i, i) != null)
                act.degree++;

            if (act.degree < min.degree) min = act;
            if (act.degree > max.degree) max = act;
        }

        return (min, max);
    }

    public static int[] FindAdjacentVertices(Graph x, int v)
    {
        if (v >= x.GetVerticesCount())
            return null;

        int[] ret = new int[x.GetVerticesCount()];
        int foundN = 0;

        for (int i = 0; i < x.GetVerticesCount(); ++i)
        {
            if (i == v) continue;

            if (x.GetEdge(v, i) != null || x.GetEdge(i, v) != null)
                ret[foundN++] = i;
        }

        return ret[..foundN];
    }

    public static Edge[] SortEdges(Edge[] arr)
    {
        for (int i = arr.Length - 1; i > 0; --i)
        {
            for (int j = 0; j < i; ++j)
                if (arr[j].GetWeight() > arr[j + 1].GetWeight())
                {
                    (arr[j], arr[j + 1]) = (arr[j + 1], arr[j]);
                }
        }
        return arr;
    }
}