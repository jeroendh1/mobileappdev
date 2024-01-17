import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqList = [
    FAQItem(
      question: 'Hoe reserveer ik een auto?',
      answer: 'Je kunt een auto reserveren door in te loggen op de app, naar het beschikbare aanbod te kijken en de gewenste auto te selecteren. Volg vervolgens de eenvoudige stappen om je reservering te voltooien.',
    ),
    FAQItem(
      question: 'Kan ik mijn reservering annuleren?',
      answer: 'Ja, je kunt een reservering annuleren via de app. Ga naar het gedeelte "Mijn Reserveringen", selecteer de betreffende reservering en volg de instructies om de annulering te voltooien.',
    ),
    FAQItem(
      question: 'Hoe kan ik de status van mijn reservering volgen?',
      answer: 'Je kunt de status van je reservering volgen in het gedeelte "Mijn Reserveringen" in de app. Hier vind je informatie over de bevestigde reservering, afhaallocatie en eventuele updates over de beschikbaarheid van de auto.',
    ),
    FAQItem(
      question: 'Welke documenten heb ik nodig om een auto te huren?',
      answer: 'Om een auto te huren, heb je meestal een geldig rijbewijs en een identiteitsbewijs nodig. Zorg ervoor dat je deze documenten bij de hand hebt wanneer je de auto komt ophalen op de afhaallocatie.',
    ),
    FAQItem(
      question: 'Kan ik de huurperiode verlengen?',
      answer: 'Ja, in de meeste gevallen kun je de huurperiode verlengen via de app. Ga naar het gedeelte "Mijn Reserveringen", selecteer de betreffende reservering en kies de optie om de huurperiode te verlengen. Houd er rekening mee dat extra kosten van toepassing kunnen zijn.',
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

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}