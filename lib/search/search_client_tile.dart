import 'package:flutter/material.dart';
import 'search_models.dart';
import 'search_visit_tile.dart';

class SearchClientTile extends StatelessWidget {
  final ClientModel client;
  final bool expanded;
  final ValueChanged<bool> onExpand;
  final VoidCallback onAddVisit;
  final void Function(VisitModel) onEditVisit;
  final VoidCallback onEditClient;

  const SearchClientTile({
    super.key,
    required this.client,
    required this.expanded,
    required this.onExpand,
    required this.onAddVisit,
    required this.onEditVisit,
    required this.onEditClient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pierwszy wiersz: imię, rasa, ikona rozwijania
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${client.name} (${client.breed})',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () => onExpand(!expanded),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Drugi wiersz: właściciel i telefony
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(client.ownerName, style: const TextStyle(color: Colors.black87)),
                if (client.tel1 != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.phone, size: 16, color: Colors.green),
                  const SizedBox(width: 2),
                  Text(client.tel1!, style: const TextStyle(color: Colors.black87)),
                ],
                if (client.tel2 != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.phone, size: 16, color: Colors.green),
                  const SizedBox(width: 2),
                  Text(client.tel2!, style: const TextStyle(color: Colors.black87)),
                ],
                if (client.tel3 != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.phone, size: 16, color: Colors.green),
                  const SizedBox(width: 2),
                  Text(client.tel3!, style: const TextStyle(color: Colors.black87)),
                ],
              ],
            ),
            const SizedBox(height: 4),
            // Trzeci wiersz: pierwsza wizyta, liczba wizyt
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text('Pierwsza wizyta: ${client.firstVisitDate}', style: const TextStyle(color: Colors.black54)),
                const SizedBox(width: 16),
                const Icon(Icons.event_note, size: 16, color: Colors.blueAccent),
                const SizedBox(width: 4),
                Text('Wizyt: ${client.visits.length}', style: const TextStyle(color: Colors.black54)),
              ],
            ),
            if (expanded) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  children: [
                    Spacer(),
                    OutlinedButton.icon(
                      onPressed: onEditClient,
                      icon: const Icon(Icons.edit, color: Color(0xFF757575)),
                      label: const Text(
                        'Edytuj klienta',
                        style: TextStyle(color: Color(0xFF757575), fontWeight: FontWeight.normal, decoration: TextDecoration.none),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(120, 40),
                        side: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
                        foregroundColor: Color(0xFF757575),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: onAddVisit,
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Dodaj wizytę',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(120, 40),
                        elevation: 1.5,
                        shadowColor: Color(0xFFB2DFDB),
                      ),
                    ),
                  ],
                ),
              ),
              if (client.visits.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Brak wizyt'),
                )
              else
                ...client.visits.map((visit) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: SearchVisitTile(
                        visit: visit,
                        onEdit: () => onEditVisit(visit),
                      ),
                    )),
            ],
          ],
        ),
      ),
    );
  }
}
