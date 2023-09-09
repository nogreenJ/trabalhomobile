class Contato {
  int id;
  String nome;
  String endereco;
  String fone;
  String email;
  Contato(this.id, this.nome, this.endereco, this.fone, this.email);

  @override
  String toString() {
    return 'Contato(nome: $nome)';
  }

  String info() {
    return '$endereco, $fone, $email';
  }
}