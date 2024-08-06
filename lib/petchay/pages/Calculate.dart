import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();
  final TextEditingController _acresController = TextEditingController();
  String _sspResult = '';
  String _ureaResult = '';
  String _mopResult = '';

  final Map<String, Map<String, dynamic>> _cropRotationGuide = {
    'Leafy Greens': {
      'nextCrop': 'Root Vegetables',
      'reason':
          'Leafy greens deplete the soil of certain nutrients, which root vegetables can replenish.',
      'image':
          'https://exat8rt6fi5.exactdn.com/wp-content/uploads/2022/05/carrot-01-600x600.jpg?strip=all&lossy=1&ssl=1',
      'phRange': [6.0, 7.5],
      'humidityRange': [50, 80],
    },
    'Carrot': {
      'nextCrop': 'Legumes',
      'reason':
          'Root vegetables can aerate the soil, and legumes can fix nitrogen in the soil.',
      'image':
          'https://publish.purewow.net/wp-content/uploads/sites/2/2022/06/types-of-legumes-cat.jpg',
      'phRange': [5.5, 7.0],
      'humidityRange': [60, 90],
    },
    'Brassicas': {
      'nextCrop': 'Nightshades',
      'reason':
          'Brassicas can be heavy feeders, and nightshades can utilize the remaining nutrients.',
      'image':
          'https://thepaleodiet.com/wp-content/uploads/2023/05/shutterstock_484615447-e1685464530522-1560x1013.jpg',
      'phRange': [6.0, 7.5],
      'humidityRange': [60, 80],
    },
    'Legumes': {
      'nextCrop': 'Cucurbits',
      'reason':
          'Legumes improve soil nitrogen levels, which benefit cucurbits.',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSotAzMEG4ybNMyF4HyfQKBLmT9bg4SA2Lsbg&s',
      'phRange': [6.0, 7.0],
      'humidityRange': [60, 80],
    },
    'Nightshades': {
      'nextCrop': 'Leafy Greens',
      'reason':
          'Nightshades can deplete soil nutrients, which leafy greens with a shorter growing season can follow.',
      'image':
          'https://blog-images-1.pharmeasy.in/blog/production/wp-content/uploads/2021/01/04140120/shutterstock_390988804-1.jpg',
      'phRange': [6.0, 7.0],
      'humidityRange': [60, 70],
    },
    'Cucumber': {
      'nextCrop': 'Brassicas',
      'reason':
          'Cucurbits help break down organic matter in the soil, which brassicas can benefit from.',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStlJXfV31u7eSqh2y3U6jYCqiAjCHYxaFRPw&s',
      'phRange': [5.5, 7.0],
      'humidityRange': [50, 70],
    },
    'Fruiting Vegetables': {
      'nextCrop': 'Root Vegetables',
      'reason':
          'Fruiting vegetables can deplete certain nutrients, and root vegetables can replenish them.',
      'image':
          'https://exat8rt6fi5.exactdn.com/wp-content/uploads/2022/05/carrot-01-600x600.jpg?strip=all&lossy=1&ssl=1',
      'phRange': [5.5, 7.5],
      'humidityRange': [60, 80],
    },
  };

  void _calculate() {
    double acres = double.tryParse(_acresController.text) ?? 0;
    double sspAmount = acres * 31.25;
    double ureaAmount = acres * 10.87;
    double mopAmount = acres * 4.17;

    setState(() {
      _sspResult = 'SSP: $sspAmount kg';
      _ureaResult = 'UREA: $ureaAmount kg';
      _mopResult = 'MOP: $mopAmount kg';
    });
  }

  void _showPredictionDialog(String crop, String reason, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Next Crop: $crop'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imagePath, height: 250, width: 250),
              const SizedBox(height: 10),
              Text(reason),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _calculate();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _predictCrop() {
    double? ph = double.tryParse(_phController.text);
    int? humidity = int.tryParse(_humidityController.text);
    String lastCrop = _cropController.text;

    if (ph != null &&
        humidity != null &&
        lastCrop.isNotEmpty &&
        _cropRotationGuide.containsKey(lastCrop)) {
      var nextCropInfo = _cropRotationGuide[lastCrop];
      var phRange = nextCropInfo?['phRange'];
      var humidityRange = nextCropInfo?['humidityRange'];

      if (ph != null &&
          humidity != null &&
          ph >= phRange![0] &&
          ph <= phRange[1] &&
          humidity >= humidityRange![0] &&
          humidity <= humidityRange[1]) {
        _showPredictionDialog(nextCropInfo?['nextCrop'],
            nextCropInfo?['reason'], nextCropInfo?['image']);
      } else {
        _showAlertDialog(
            'No match found', 'Enter correct data or try another crop.');
      }
    } else {
      _showAlertDialog('Invalid Input', 'Please enter valid data.');
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _incrementValue(TextEditingController controller) {
    double currentValue = double.tryParse(controller.text) ?? 0;
    controller.text = (currentValue + 1).toString();
  }

  void _decrementValue(TextEditingController controller) {
    double currentValue = double.tryParse(controller.text) ?? 0;
    if (currentValue > 0) {
      controller.text = (currentValue - 1).toString();
    }
  }

  Widget _buildNumberInputField(
      TextEditingController controller, String label) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _incrementValue(controller),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => _decrementValue(controller),
        ),
      ],
    );
  }

  Widget _buildWeatherContainer(String location, String temperature,
      String precipitation, String humidity, String wind) {
    return Container(
      width: 150,
      // Fixed width for each container
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 6, 56, 96),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud, color: Colors.white, size: 48),
          const SizedBox(height: 10),
          Text(
            location,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            temperature,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            'Precipitation: $precipitation',
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          Text(
            'Humidity: $humidity',
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          Text(
            'Wind: $wind',
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fertilizer Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather Containers in a scrollable row
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildWeatherContainer(
                      'HOME', '26°C', '14%', '77%', '23 km/h'),
                  const SizedBox(width: 8.0),
                  _buildWeatherContainer(
                      'Gandhipuram', '26°C', '30%', '77%', '21 km/h'),
                  const SizedBox(width: 8.0),
                  _buildWeatherContainer(
                      'Saravanampatti', '26°C', '30%', '78%', '21 km/h'),
                  const SizedBox(width: 8.0),
                  _buildWeatherContainer(
                      'Kuniyamuthur', '26°C', '30%', '79%', '21 km/h'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Form fields
            _buildNumberInputField(_phController, 'Enter pH of the land'),
            const SizedBox(height: 20),
            _buildNumberInputField(
                _humidityController, 'Enter humidity of the land'),
            const SizedBox(height: 20),
            TextField(
              controller: _cropController,
              decoration: InputDecoration(
                labelText: 'Enter last cultivated crop',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildNumberInputField(_acresController, 'Enter number of acres'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _predictCrop,
                child: const Text('Calculate'),
              ),
            ),
            const SizedBox(height: 20),
            // Result containers
            if (_sspResult.isNotEmpty) ...[
              _buildResultContainer('SSP', _sspResult),
              const SizedBox(height: 10),
              _buildResultContainer('UREA', _ureaResult),
              const SizedBox(height: 10),
              _buildResultContainer('MOP', _mopResult),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultContainer(String title, String result) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              result,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
