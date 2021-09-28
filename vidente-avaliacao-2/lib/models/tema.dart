class Tema {
  int valorTema = 0;

  Tema(this.valorTema);

  @override
  String toString() {
    return 'Tema{id: 1, valorTema: $valorTema}';
  }

  Map<String, dynamic> toMap() {
    return {'id': 1, 'valorTema': valorTema};
  }
}
