sealed class Either<L, R> {
   T fold<T>(T Function(L) l, T Function(R) r);
   R getOrElse(R Function() f) {
     switch(this) {
         case Right(:R value):
           return value;
           case _:
             return f();
     }
   }
   bool isRight() {
     return this is Right;
   }

   bool isLeft() {
     return this is Left;
   }
}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Left && runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Left{value: $value}';
  }

  @override
  T fold<T>(T Function(L p1) l, r) {
    return l(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Right && runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Right{value: $value}';
  }

  @override
  T fold<T>(l, T Function(R p1) r) {
    return r(value);
  }
}
