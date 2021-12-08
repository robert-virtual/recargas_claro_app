
import 'package:flutter/material.dart';
import 'package:recargas_claro_app/models/recarga.dart';
class RecargaItem extends StatefulWidget {
  const RecargaItem({
    Key? key,
    required this.recarga,
    this.close = false,
    this.onPressed
  }) : super(key: key);
  final Recarga recarga;
  final bool close;
  final void Function()? onPressed;

  
  @override
  State<RecargaItem> createState() => _RecargaItemState();
}

class _RecargaItemState extends State<RecargaItem> {
  @override
  Widget build(BuildContext context) {


    return  Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.recarga.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Visibility(
                  visible: widget.close,
                  child: IconButton(
                      onPressed: widget.onPressed,
                      icon: const Icon(Icons.close)),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.recarga.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.recarga.duration,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Text(
                  "Lps. ${widget.recarga.price}",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}