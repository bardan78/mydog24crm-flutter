import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search_client_tile.dart';
import 'search_models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<ClientModel> _results = [];
  bool _loading = false;
  Set<int> _expandedClients = {};

  Future<void> _search() async {
    setState(() { _loading = true; });
    try {
      final query = _controller.text.trim();
      if (query.isEmpty) {
        setState(() {
          _results = [];
          _expandedClients.clear();
          _loading = false;
        });
        return;
      }
      final url = Uri.parse('https://mydog24crm-app-844017125587.europe-central2.run.app/api/1/clients?q=$query');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('API response: ${response.body}');
        print('Parsed clients: ${data.length}');
        _results = data.map((json) => ClientModel.fromJson(json)).toList();
      } else {
        print('API error: ${response.statusCode}');
        _results = [];
      }
      _expandedClients.clear();
    } catch (e) {
      print('Search error: $e');
      _results = [];
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: przejście do ekranu dodawania klienta
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Dodaj klienta'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 80), // dolny padding na FAB
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Wyszukiwarka klientów', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'Imię, telefon lub właściciel',
                                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                isDense: true,
                                fillColor: Colors.grey[100],
                                filled: true,
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _loading ? null : _search,
                            icon: _loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.search),
                            label: const Text('Szukaj'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(90, 48),
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              if (_loading)
                const Center(child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ))
              else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _results.isNotEmpty
                        ? 'Znaleziono ${_results.length} klientów'
                        : 'Brak wyników',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                if (_results.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, idx) {
                      final client = _results[idx];
                      final expanded = _expandedClients.contains(client.id);
                      return SearchClientTile(
                        client: client,
                        expanded: expanded,
                        onExpand: (bool value) {
                          setState(() {
                            if (value) {
                              _expandedClients.add(client.id);
                            } else {
                              _expandedClients.remove(client.id);
                            }
                          });
                        },
                        onAddVisit: () {
                          // TODO: przejście do ekranu dodawania wizyty
                        },
                        onEditVisit: (visit) {
                          // TODO: przejście do ekranu edycji wizyty
                        },
                        onEditClient: () {
                          // TODO: przejście do ekranu edycji klienta
                        },
                      );
                    },
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
