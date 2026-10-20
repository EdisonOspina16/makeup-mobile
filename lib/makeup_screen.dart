import 'package:flutter/material.dart';
import 'package:movies/repositories/makeup_note_repository.dart';
import 'package:movies/makeup_card.dart';
import 'package:movies/makeup_detail.dart';
import 'package:movies/models/makeup.dart';
import 'package:movies/services/makeup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeupScreen extends StatefulWidget {
  final MakeupNoteRepository repository;

  const MakeupScreen({super.key, required this.repository});

  @override
  State<MakeupScreen> createState() => _MakeupScreenState();
}

class _MakeupScreenState extends State<MakeupScreen> {
  int? favoriteMakeupId;
  late final MakeupService _service;
  late Future<List<Makeup>> _futureMakeups;

  void retryMakeupList() {
    setState(() {
      _futureMakeups = _service.getMakeups();
    });
  }

  Future<void> saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteMakeupId == null) {
      await prefs.remove('favoriteMakeupId');
    } else {
      await prefs.setInt('favoriteMakeupId', favoriteMakeupId!);
    }
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favoriteMakeupId = prefs.getInt('favoriteMakeupId');
    });
  }

  @override
  void initState() {
    super.initState();
    _service = MakeupService('https://dummyjson.com/c/7718-7cf9-46ba-9f1c');
    _futureMakeups = _service.getMakeups();
    loadFavorite();
  }

  Future<void> _syncPending() async {
    final pending = await widget.repository.pendingCount();
    final synced = await widget.repository.syncPending();
    if (!mounted) return;
    final message = pending == 0
        ? 'No hay registros pendientes'
        : 'Sincronizados $synced de $pending registros';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void openMakeupDetail(Makeup makeup) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MakeupDetailPage(makeup: makeup, repository: widget.repository)),
    );
  }

  void toggleFavorite(int makeupId) {
    setState(() {
      favoriteMakeupId = favoriteMakeupId == makeupId ? null : makeupId;
    });
    saveFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Mi maquillaje'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Sincronizar pendientes',
            onPressed: _syncPending,
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Makeup>>(
      future: _futureMakeups,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'No pudimos cargar los productos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: retryMakeupList,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }

        final makeups = snapshot.data ?? [];
        if (makeups.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.brush_outlined, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Todavía no hay productos disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: makeups.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Encuentra tus esenciales',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${makeups.length} productos para explorar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toca un producto para ver sus detalles o guárdalo con el corazón.',
                    ),
                  ],
                ),
              );
            }

            final makeup = makeups[index - 1];
            return MakeupCard(
              makeup: makeup,
              isFavorite: makeup.id == favoriteMakeupId,
              onTap: () => openMakeupDetail(makeup),
              onFavoriteTap: () => toggleFavorite(makeup.id),
            );
          },
        );
      },
    );
  }
}
