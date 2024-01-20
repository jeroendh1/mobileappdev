import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/faq.dart';

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqList = [
    FAQItem(
      question: 'Hoe reserveer ik een auto?',
      answer: 'Je kunt een auto reserveren door in te loggen op de app, naar het beschikbare aanbod te kijken en de gewenste auto te selecteren. Volg vervolgens de eenvoudige stappen om je reservering te voltooien.',
    ),
    FAQItem(
      question: 'Kan ik mijn reservering annuleren?',
      answer: 'Nee, je kunt een reservering niet annuleren via de app.',
    ),
    FAQItem(
      question: 'Hoe kan ik de status van mijn reservering volgen?',
      answer: 'Je kunt de status van je reservering volgen in het gedeelte "history" in de app. Hier vind je informatie over de bevestigde reservering en eventuele updates over de beschikbaarheid van de auto.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('FAQ Page', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                faqList[index].question,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF9B401),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(faqList[index].answer, style: TextStyle(color: Colors.black)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}