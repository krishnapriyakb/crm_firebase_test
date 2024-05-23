import 'package:carousel_slider/carousel_slider.dart';
import 'package:crm_firebase_test/modals/message_modal.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final MessageModal message;
  const CustomCarousel({super.key, required this.message});
  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            Text(
              widget.message.customWidgets.confirmationType,
              style: const TextStyle(fontSize: 20),
            ),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: widget.message.customWidgets.imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Text(
              widget.message.customWidgets.bodyText[0].toString(),
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      foregroundColor: Colors.black),
                  onPressed: () {},
                  child: const Text("Reject"),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        foregroundColor: Colors.black),
                    onPressed: () {
                      widget.message.customWidgets.confirmationStatus = 1;
                    },
                    child: const Text("Accept"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
