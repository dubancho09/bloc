import 'package:flutter/material.dart';

class CustomListCard extends StatelessWidget {

  final String nombre;
  final String descripcion;
  final bool estado;

  const CustomListCard({
    required this.nombre,
    required this.descripcion,
    required this.estado,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
            
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombre), 
                    Text(descripcion)
                  ],
                ),
                Switch(value: estado, onChanged: (value){})
              ],
            ),
          ),
    );
  }
}