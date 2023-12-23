import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Quote extends StatefulWidget {
  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('QuoteDay').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center( 
            child: CircularProgressIndicator(color:Colors.purple),
          );
        }

        var quotes = snapshot.data!.docs;
        List<Widget> quoteWidgets = [];
        for (var quote in quotes) {
          var quoteText = quote['Quote'];
          var quoteWidget = Container(
            padding: EdgeInsets.all(5),
            child: Text(
              quoteText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          );
          quoteWidgets.add(quoteWidget);
        }

        return Column(
          children: quoteWidgets,
        );
      },
    );
  }
}
