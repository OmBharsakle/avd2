import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _CupertinoWidgetState();
}

class _CupertinoWidgetState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cupertino and Material Widgets'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 170, child: ManualDateInput()),
              SizedBox(height: 50, child: DialogButton()),
              SizedBox(height: 100, child: TimePickerExample()),
              SizedBox(height: 100,child: CupertinoActionSheetExample()),
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  onTimerDurationChanged: (value) {
                    // Handle time duration change here
                  },
                ),
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime value) {
                    // Handle date change here
                  },
                ),
              ),
              SizedBox(height: 100,),

            ],
          ),
        ),
      ),
    );
  }
}

class DialogButton extends StatefulWidget {
  @override
  _DialogButtonState createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
  String selectedRingtone = 'None';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showRingtoneDialog(context);
        },
        child: const Text('Show Dialog'),
      ),
    );
  }

  void _showRingtoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Phone ringtone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('None'),
                value: 'None',
                groupValue: selectedRingtone,
                onChanged: (value) {
                  setState(() {
                    selectedRingtone = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Callisto'),
                value: 'Callisto',
                groupValue: selectedRingtone,
                onChanged: (value) {
                  setState(() {
                    selectedRingtone = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Ganymede'),
                value: 'Ganymede',
                groupValue: selectedRingtone,
                onChanged: (value) {
                  setState(() {
                    selectedRingtone = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Luna'),
                value: 'Luna',
                groupValue: selectedRingtone,
                onChanged: (value) {
                  setState(() {
                    selectedRingtone = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class TimePickerExample extends StatefulWidget {
  @override
  _TimePickerExampleState createState() => _TimePickerExampleState();
}

class _TimePickerExampleState extends State<TimePickerExample> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Selected time: ${selectedTime.format(context)}",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: const Text('Select Time'),
          ),
        ],
      ),
    );
  }
}

class ManualDateInput extends StatefulWidget {
  @override
  _ManualDateInputState createState() => _ManualDateInputState();
}

class _ManualDateInputState extends State<ManualDateInput> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Enter date (MM/DD/YYYY)',
                hintText: 'MM/DD/YYYY',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text = "${picked.month}/${picked.day}/${picked.year}";
                      });
                    }
                  },
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final enteredDate = _dateController.text;
                // Handle the entered date here
                print("Entered date: $enteredDate");
              },
              child: const Text('Submit Date'),
            ),
          ],
        ),
      ),
    );
  }
}


class CupertinoActionSheetExample extends StatefulWidget {
  @override
  _CupertinoActionSheetExampleState createState() => _CupertinoActionSheetExampleState();
}

class _CupertinoActionSheetExampleState extends State<CupertinoActionSheetExample> {
  String? _selectedDessert;

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(
          "Favourite Dessert",
          style: TextStyle(height: 1),
        ),
        message: const Text(
          "Please select the best dessert from the list below",
          style: TextStyle(height: 2),
        ),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            child: const Text(
              'Profiteroles',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              setState(() {
                _selectedDessert = 'Profiteroles';
              });
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Cannolis',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              setState(() {
                _selectedDessert = 'Cannolis';
              });
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Trifle',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              setState(() {
                _selectedDessert = 'Trifle';
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => _showCupertinoActionSheet(context),
              child: Text('Cupertino Action Sheet'),
            ),
            SizedBox(height: 20),
            if (_selectedDessert != null)
              Text(
                'Selected Dessert: $_selectedDessert',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}