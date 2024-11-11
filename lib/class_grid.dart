import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        fontFamily: 'Montserrat',
      ),
      home: const ClassGrid(),
    );
  }
}

class ClassGrid extends StatefulWidget {
  const ClassGrid({Key? key}) : super(key: key);

  @override
  State<ClassGrid> createState() => _ClassGridState();
}

class _ClassGridState extends State<ClassGrid> {
  final List<String> semesters = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8'
  ];

  String selectedSemester = 'Semester 1';
  int numberOfColumns = 0; // Initialize to 0 to keep grid empty
  int numberOfRows = 0; // Initialize to 0 to keep grid empty
  List<String> columnLabels = []; // To hold dynamic column labels

  // Initialize the grid with empty student names
  List<List<String?>> studentNames = []; // Start with an empty list

  // Function to show input dialog for student names
  Future<void> _showInputDialog(BuildContext context, int row, int col) async {
    TextEditingController controller = TextEditingController();
    String? currentName = studentNames[row][col];

    if (currentName != null) {
      controller.text = currentName;
    }

    showDialog<String>(context: context, builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          'Enter Student Name for ${columnLabels[col]}${row + 1}',
          style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Student Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Save'),
            onPressed: () {
              setState(() {
                studentNames[row][col] = controller.text.isEmpty ? null : controller.text;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  // Function to generate and save PDF
  Future<void> _generatePdf() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Class Grid - $selectedSemester',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.teal,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey, width: 1),
                  children: [
                    // Header Row with Column Labels
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            ' ',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                              color: PdfColors.teal,
                            ),
                          ),
                        ),
                        ...columnLabels.map(
                          (label) => pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              label,
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.teal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Rows with data
                    ...List.generate(numberOfRows, (row) {
                      return pw.TableRow(
                        children: [
                          // Row Labels
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              (row + 1).toString(),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.teal,
                              ),
                            ),
                          ),
                          // Data Cells
                          ...List.generate(numberOfColumns, (col) {
                            return pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                studentNames[row][col] ?? '',
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            );
          },
        ),
      );

      // Save the PDF
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/ClassGrid.pdf");
      await file.writeAsBytes(await pdf.save());

      // Show the PDF preview
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

    } catch (e) {
      print('Error while generating PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update column labels based on the number of columns
    columnLabels = List.generate(numberOfColumns, (index) => String.fromCharCode(65 + index)); // A, B, C, D...

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Class Grid',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 6.0,
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generatePdf,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            // Input field for the number of columns
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Columns',
                hintText: 'Enter a number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                int? input = int.tryParse(value);
                if (input != null && input > 0 && input <= 10) {
                  setState(() {
                    numberOfColumns = input;
                    // Reset the grid
                    studentNames = List.generate(numberOfRows, (index) => List.generate(numberOfColumns, (index) => null));
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            // Input field for the number of rows
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Rows',
                hintText: 'Enter a number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                int? input = int.tryParse(value);
                if (input != null && input > 0 && input <= 10) {
                  setState(() {
                    numberOfRows = input;
                    // Reset the grid
                    studentNames = List.generate(numberOfRows, (index) => List.generate(numberOfColumns, (index) => null));
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            // GridView for the class
            Expanded(
              child: numberOfRows > 0 && numberOfColumns > 0 // Only show the grid if both are greater than 0
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, // Default to 5 columns
                        childAspectRatio: 1,
                      ),
                      itemCount: numberOfRows * numberOfColumns,
                      itemBuilder: (context, index) {
                        int row = index ~/ numberOfColumns;
                        int col = index % numberOfColumns;

                        return GestureDetector(
                          onTap: () => _showInputDialog(context, row, col),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: studentNames[row][col] != null ? Colors.green[800] : Colors.grey[300], // Dark green if student name exists
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: studentNames[row][col] != null
                                ? const Icon(Icons.check, color: Colors.white) // Show tick if student name exists
                                : const SizedBox.shrink(), // Empty if no student name
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('Please enter the number of rows and columns.')),
            ),
          ],
        ),
      ),
    );
  }
}
