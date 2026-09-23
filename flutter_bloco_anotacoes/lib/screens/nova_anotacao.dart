
import 'package:flutter/material.dart';

class NovaAnotacaoScreen extends StatefulWidget {
  final String? tituloInicial;
  final String? conteudoInicial;

  const NovaAnotacaoScreen({
    super.key,
    this.tituloInicial,
    this.conteudoInicial,
  });

  @override
  State<NovaAnotacaoScreen> createState() => _NovaAnotacaoScreenState();
}

class _NovaAnotacaoScreenState extends State<NovaAnotacaoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _conteudoController;

  @override
  void initState() {
    super.initState();

    _tituloController = TextEditingController(
      text: widget.tituloInicial ?? '',
    );

    _conteudoController = TextEditingController(
      text: widget.conteudoInicial ?? '',
    );
  }

  void _salvarAnotacao() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'titulo': _tituloController.text.trim(),
      'conteudo': _conteudoController.text.trim(),
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.tituloInicial != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      appBar: AppBar(
        title: Text(
          editando ? 'Editar anotação' : 'Nova anotação',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF54263D),
          ),
        ),
        backgroundColor: const Color(0xFFFFF8FB),
        iconTheme: const IconThemeData(
          color: Color(0xFF9B4169),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Escreva seus pensamentos ✨',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF54263D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Um espaço só seu para guardar ideias e momentos.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9B7185),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Título',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF54263D),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  hintText: 'Dê um nome para sua anotação',
                  prefixIcon: Icon(
                    Icons.title,
                    color: Color(0xFF9B4169),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Digite um título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Sua anotação',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF54263D),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _conteudoController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Escreva aqui...',
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.all(18),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Digite uma anotação';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _salvarAnotacao,
                icon: const Icon(Icons.favorite_border),
                label: Text(
                  editando ? 'Salvar alterações' : 'Salvar anotação',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}