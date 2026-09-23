import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import 'login.dart';
import 'splash.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _anotacoes = [];

  void _abrirNovaAnotacao() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NovaAnotacaoScreen(),
      ),
    );

    if (resultado != null && mounted) {
      setState(() {
        _anotacoes.add({
          'titulo': resultado['titulo']!,
          'conteudo': resultado['conteudo']!,
        });
      });
    }
  }

  void _abrirAnotacao(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NovaAnotacaoScreen(
          tituloInicial: _anotacoes[index]['titulo'],
          conteudoInicial: _anotacoes[index]['conteudo'],
        ),
      ),
    );

    if (resultado != null && mounted) {
      setState(() {
        _anotacoes[index] = {
          'titulo': resultado['titulo']!,
          'conteudo': resultado['conteudo']!,
        };
      });
    }
  }

  void _excluirAnotacao(int index) {
    setState(() {
      _anotacoes.removeAt(index);
    });
  }

  void _fazerLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaEscuro = themeNotifier.value == ThemeMode.dark;
    final corTexto = Theme.of(context).colorScheme.onSurface;
    final corSecundaria =
        Theme.of(context).colorScheme.onSurfaceVariant;
    final corFundo = Theme.of(context).scaffoldBackgroundColor;
    final corCard = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: const Text(
          'Light Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: corFundo,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF9B4169),
              ),
              accountName: Text(
                widget.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                'Bem-vinda ao Light Notes ✨',
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color(0xFFF3DCE8),
                child: Icon(
                  Icons.person,
                  color: Color(0xFF9B4169),
                  size: 35,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.auto_awesome,
                color: Color(0xFF9B4169),
              ),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.note_alt_outlined,
                color: Color(0xFF9B4169),
              ),
              title: const Text('Minhas anotações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                temaEscuro
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: const Color(0xFF9B4169),
              ),
              title: Text(
                temaEscuro ? 'Tema claro' : 'Tema escuro',
              ),
              trailing: Switch(
                value: temaEscuro,
                activeColor: const Color(0xFF9B4169),
                onChanged: (value) {
                  themeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              onTap: () {
                themeNotifier.value = temaEscuro
                    ? ThemeMode.light
                    : ThemeMode.dark;
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.animation,
                color: Color(0xFF9B4169),
              ),
              title: const Text('Splash'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color(0xFF9B4169),
              ),
              title: const Text('Sair'),
              onTap: _fazerLogout,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, seja bem-vinda! 🌷',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: corTexto,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Um espaço para guardar suas ideias.',
              style: TextStyle(
                fontSize: 15,
                color: corSecundaria,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Text(
                  'Minhas anotações',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: corTexto,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_anotacoes.length} notas',
                  style: TextStyle(
                    color: corSecundaria,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: _anotacoes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3DCE8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              size: 48,
                              color: Color(0xFF9B4169),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nenhuma anotação ainda',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: corTexto,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Comece escrevendo algo especial.',
                            style: TextStyle(
                              color: corSecundaria,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _anotacoes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 14),
                          color: corCard,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.3),
                            ),
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF3DCE8),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.note_alt_outlined,
                                color: Color(0xFF9B4169),
                              ),
                            ),
                            title: Text(
                              _anotacoes[index]['titulo']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: corTexto,
                              ),
                            ),
                            subtitle: Text(
                              _anotacoes[index]['conteudo']!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: corSecundaria,
                              ),
                            ),
                            trailing: PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Color(0xFF9B4169),
                              ),
                              onSelected: (value) {
                                if (value == 'editar') {
                                  _abrirAnotacao(index);
                                } else if (value == 'excluir') {
                                  _excluirAnotacao(index);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'editar',
                                  child: Text('Editar'),
                                ),
                                const PopupMenuItem(
                                  value: 'excluir',
                                  child: Text('Excluir'),
                                ),
                              ],
                            ),
                            onTap: () => _abrirAnotacao(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirNovaAnotacao,
        backgroundColor: const Color(0xFF9B4169),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NovaAnotacaoScreen extends StatefulWidget {
  final String? tituloInicial;
  final String? conteudoInicial;

  const NovaAnotacaoScreen({
    super.key,
    this.tituloInicial,
    this.conteudoInicial,
  });

  @override
  State<NovaAnotacaoScreen> createState() =>
      _NovaAnotacaoScreenState();
}

class _NovaAnotacaoScreenState extends State<NovaAnotacaoScreen> {
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

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  void _salvarAnotacao() {
    if (_tituloController.text.trim().isEmpty ||
        _conteudoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o título e o conteúdo.'),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      {
        'titulo': _tituloController.text.trim(),
        'conteudo': _conteudoController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.tituloInicial != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando ? 'Editar anotação' : 'Nova anotação',
        ),
        actions: [
          IconButton(
            onPressed: _salvarAnotacao,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _conteudoController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: 'Conteúdo',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvarAnotacao,
                child: const Text('Salvar anotação'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}