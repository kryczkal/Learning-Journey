namespace SimpleGraphLib;

public abstract class Graph
{
    protected readonly int verticesCount;

    public Graph(int vCount = 0)
    {
        verticesCount = vCount;
    }

    public abstract void AddEdge(Edge x);
    public abstract void RemoveEdge(Edge x);
    public abstract Edge GetEdge(int x1, int x2);
    public abstract int GetEdgesCount();
    public int GetVerticesCount() => verticesCount;
}