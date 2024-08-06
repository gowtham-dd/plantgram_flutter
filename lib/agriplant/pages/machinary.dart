import 'package:flutter/material.dart';

class MachinaryPage extends StatefulWidget {
  const MachinaryPage({Key? key}) : super(key: key);

  @override
  State<MachinaryPage> createState() => _MachinaryPageState();
}

class _MachinaryPageState extends State<MachinaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RENT IT'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMachineryItem(
            'Tractor',
            '₹1500 per day',
            'A powerful tractor suitable for various farming tasks.',
            'https://www.cnet.com/a/img/resize/11d467ce9e3eae10b80a208d001155dc79d235f5/hub/2021/11/02/256ff691-8176-4632-acb5-db1278edaae5/john-deere-autonomous-self-driving-tractor-1009701.jpg?auto=webp&fit=crop&height=1200&width=1200',
          ),
          const SizedBox(height: 16.0),
          _buildMachineryItem(
            'Combine Harvester',
            '₹3000 per day',
            'Efficient combine harvester for large-scale harvesting.',
            'https://www.shutterstock.com/image-photo/combine-harvester-harvests-ripe-wheat-600nw-1494272252.jpg',
          ),
          const SizedBox(height: 16.0),
          _buildMachineryItem(
            'Plough',
            '₹800 per day',
            'Heavy-duty plough for breaking up soil.',
            'https://m.media-amazon.com/images/I/61ZY96c35YL._AC_UF1000,1000_QL80_.jpg',
          ),
          const SizedBox(height: 16.0),
          _buildMachineryItem(
            'Seed Drill',
            '₹1200 per day',
            'Efficient seed drill for precise seed planting.',
            'https://5.imimg.com/data5/YK/OU/MY-2302245/seed-drill-machine.jpg',
          ),
          const SizedBox(height: 16.0),
          _buildMachineryItem(
            'Rotavator',
            '₹1800 per day',
            'Powerful rotavator for soil tillage.',
            'https://agriculturepost.com/wp-content/uploads/2021/08/Mahindra-launches-new-heavy-duty-Rotavator-%E2%80%93-Mahindra-Mahavator.jpg',
          ),
          // Add more machinery items here
        ],
      ),
    );
  }

  Widget _buildMachineryItem(
      String name, String rate, String description, String imageUrl) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  rate,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 9, 9, 9)),
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
              ),
              onPressed: () {
                _showConfirmationDialog();
              },
              child: const Text(
                'Book Now',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: const Text('Do you want to confirm the booking?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Look for Details'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Handle booking confirmation here
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
