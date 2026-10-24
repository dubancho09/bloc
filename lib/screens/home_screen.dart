import 'package:estados_app/widgets/custom_list_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado APP'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Tareas', style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              CustomListCard(
                nombre: 'Hacer tarea programacion',
                descripcion: 'Programacion orientada a objetos',
                estado: true,
              ),
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                  hint: Text('Ingrese el nombre de la tarea')
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                decoration: InputDecoration(
                  hint: Text('Ingrese la descripción de la tarea')
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Estado'),
                  SizedBox(width: 15,),
                  Switch(value: false, onChanged: (value){}),
                ],
              ),
              FilledButton(onPressed: (){}, child: Text('Guardar'))
            ],
          ),
        ),
      )
    );
  }
}