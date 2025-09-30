import 'package:flutter/material.dart';
import 'search_models.dart';
import '_service_type_chip.dart';

class SearchVisitTile extends StatelessWidget {
  final VisitModel visit;
  final VoidCallback onEdit;

  const SearchVisitTile({super.key, required this.visit, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[50],
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Główna linia: data, godzina, typ usługi, cena, edycja
            Row(
              children: [
                const Icon(Icons.event, size: 16),
                const SizedBox(width: 4),
                Text('${visit.visitDate} ${visit.visitHour}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                ServiceTypeChip(type: visit.serviceType),
                const Spacer(),
                Text('${visit.price.toStringAsFixed(2)} zł', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edytuj wizytę',
                  onPressed: onEdit,
                ),
              ],
            ),

            const SizedBox(height: 2),
            // Opis
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8, top: 2, bottom: 2),
              child: Text(visit.description, style: const TextStyle(fontSize: 15)),
            ),
            // Szczegóły
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8, top: 2, bottom: 2),
              child: Row(
                children: [
                  const Icon(Icons.straighten, size: 16),
                  const SizedBox(width: 2),
                  Text('Nóż: ${visit.knife}'),
                  const SizedBox(width: 12),
                  const Icon(Icons.timer, size: 16),
                  const SizedBox(width: 2),
                  Text('${visit.duration} min'),
                  const SizedBox(width: 12),
                  const Icon(Icons.content_cut, size: 16),
                  const SizedBox(width: 2),
                  Text(visit.withHair ? 'z włosem' : 'pod włos'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
