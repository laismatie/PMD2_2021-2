class Tema {
  int lightDark = 0;

  Tema(this.lightDark);

  @override
  String toString() {
    return 'Tema{id: 1, lightDark: $lightDark}';
  }

  Map<String, dynamic> toMap() {
    return {'id': 1, 'lightDark': lightDark};
  }
}
