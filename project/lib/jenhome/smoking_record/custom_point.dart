class MyPoint<T extends num>  {
  T x;
  T y;

  /// Creates a point with the provided [x] and [y] coordinates.
  MyPoint(T wx, T wy)
      : x = wx,
        y = wy;
}