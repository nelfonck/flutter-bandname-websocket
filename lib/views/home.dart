


import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1) ,
    Band(id: '3', name: 'Heroes del silencio', votes: 2),
    Band(id: '4', name: 'Bon jovi', votes: 4),
    Band(id: '5', name: 'Slipknot', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Band Names', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( contex, i ) => _bandTile( bands[i] )
        
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed:() => addNewBand()
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 8.0) ,
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white)),
        ),
      ),
      key: Key( band.id ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( band.name.substring(0,2) ),
              backgroundColor: Colors.blue[ 100 ],
            ),
            title: Text( band.name ),
            trailing: Text( '${band.votes}', style: const TextStyle( fontSize: 20), ),
            onTap: (){},
          ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: ( context ) {
          return  AlertDialog(
            title: const Text('New band name'),
            content:  TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: const Text('Add'),
                textColor: Colors.blue,
                onPressed:()=> addBandToList( textController.text ),
              )
            ],
          );
        }
      );

    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: ( context ) {
          return  CupertinoAlertDialog(
            title: const Text('New band name'),
            content:  TextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Add'),
                onPressed:()=> addBandToList( textController.text ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Dismiss'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      );
    }

  }

  addBandToList( String name) {

    if ( name.isNotEmpty){
      setState(() {
        bands.add( Band(id: DateTime.now().toString(), name: name, votes: 0));
      });
    }
    Navigator.pop(context);
  }
}