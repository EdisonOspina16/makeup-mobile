import 'package:flutter/material.dart';
import 'package:movies/models/makeup.dart';
import 'package:movies/repositories/makeup_note_repository.dart';
import 'package:movies/models/makeup_note.dart';



class MakeupDetailPage extends StatefulWidget {
  final Makeup makeup;
  final MakeupNoteRepository repository;

  const MakeupDetailPage({
    super.key,
    required this.makeup,
    required this.repository,
  });

  @override
  State<MakeupDetailPage> createState() => _MakeupDetailPageState();
}
class _MakeupDetailPageState extends State<MakeupDetailPage> {
  MakeupNoteRepository get _repository => widget.repository;
  MakeupNote? _saved;
  bool _loaded = false;
  final TextEditingController _noteController = TextEditingController();
  int _raiting = 0;
  

  @override
  void initState() {
    super.initState();
    _loadLocalNote();
  }


  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _savelocalNote() async {
    if (_raiting < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La prioridad debe ser mayor o igual a 2 para guardar'),
        ),
      );
      return;
    }

    final synced = await _repository.saveNote(
      makeupId: widget.makeup.id,
      note: _noteController.text,
      rating: _raiting,
    );
    final saved = await _repository.getNote(widget.makeup.id);

    if (!mounted) return;
    setState(() => _saved = saved);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          synced
              ? 'Guardado y sincronizado'
              : 'Guardado localmente, pendiente de sincronizar',
        ),
      ),
    );
  }

  Future<void> _loadLocalNote() async {
    final saved = await _repository.getNote(widget.makeup.id);
    if (!mounted) return;

    setState(() {
      _loaded = true;
      _saved = saved;
      if (saved != null) {
        _noteController.text = saved.note;
        _raiting = saved.rating;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle del producto'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Card(
                        elevation: 3,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: AspectRatio(
                          aspectRatio: 4 / 5,
                          child: Image.asset(
                            widget.makeup.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: colors.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    Icons.brush_outlined,
                                    size: 72,
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    widget.makeup.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.brush_outlined, size: 18),
                        label: Text(widget.makeup.category),
                        side: BorderSide.none,
                        backgroundColor: colors.secondaryContainer,
                      ),
                      Chip(
                        avatar: const Icon(Icons.attach_money, size: 18),
                        label: Text('\$${widget.makeup.price}'),
                        side: BorderSide.none,
                        backgroundColor: colors.secondaryContainer,
                      ),
                      Chip(
                        avatar: Icon(
                          widget.makeup.available
                              ? Icons.inventory_2_outlined
                              : Icons.remove_shopping_cart_outlined,
                          size: 18,
                        ),
                        label: Text(
                          widget.makeup.available ? 'Disponible' : 'Agotado',
                        ),
                        side: BorderSide.none,
                        backgroundColor: colors.surfaceContainerHighest,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Descripción',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.makeup.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text(
                    'Prioridad y nota personal',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Escribe tu nota',
                      helperText: 'Prioridad de 1 a 5 (mínimo 2 para guardar)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: List.generate(5, (index) {
                      final value = index + 1;
                      return ChoiceChip(
                        label: Text(value.toString()),
                        selected: _raiting == value,
                        onSelected: (selected) {
                          setState(() {
                            _raiting = value;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  if (_loaded)
                    Text(
                      _saved == null
                          ? 'No hay información guardada'
                          : (_saved!.pendingSync ? 'Pendiente' : 'Sincronizado'),
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _savelocalNote,
                    child: const Text('Guardar nota'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
