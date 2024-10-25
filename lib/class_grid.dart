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
  final List<String> columnLabels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final List<String> rowLabels = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
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

  // Initialize the grid with empty student names
  List<List<String?>> studentNames = List.generate(
    10,
    (index) => List.generate(10, (index) => null),
  );

  // Function to show input dialog for student names
  Future<void> _showInputDialog(BuildContext context, int row, int col) async {
    TextEditingController controller = TextEditingController();
    String? currentName = studentNames[row][col];

    if (currentName != null) {
      controller.text = currentName;
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Enter Student Name for ${columnLabels[col]}${rowLabels[row]}',
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
      },
    );
  }

  // Function to show information dialog for student
  void _showStudentInfo(BuildContext context, int row, int col) {
    String studentName = studentNames[row][col]!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Student Info',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
          content: Text(
            studentName,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  studentNames[row][col] = null;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                    ...List.generate(10, (row) {
                      return pw.TableRow(
                        children: [
                          // Row Labels
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              rowLabels[row],
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.teal,
                              ),
                            ),
                          ),
                          // Data Cells
                          ...List.generate(10, (col) {
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
            // Dropdown for selecting semester
            DropdownButton<String>(
              value: selectedSemester,
              items: semesters.map((String semester) {
                return DropdownMenuItem<String>(
                  value: semester,
                  child: Text(semester),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSemester = newValue!;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              underline: Container(
                height: 2,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 50),
                ...columnLabels.map((label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 11, // 10 columns + 1 for row labels
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 110, // 10 rows * 11 columns
                itemBuilder: (context, index) {
                  int row = index ~/ 11;
                  int col = index % 11;

                  if (col == 0) {
                    // First column is for row labels
                    return Center(
                      child: Text(
                        rowLabels[row],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                    );
                  } else {
                    // Grid cells
                    int gridColIndex = col - 1;
                    return GestureDetector(
                      onTap: () {
                        if (studentNames[row][gridColIndex] == null) {
                          _showInputDialog(context, row, gridColIndex);
                        } else {
                          _showStudentInfo(context, row, gridColIndex);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: studentNames[row][gridColIndex] == null
                              ? Colors.grey[200]
                              : Colors.teal[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: studentNames[row][gridColIndex] == null
                                ? Colors.grey
                                : Colors.teal,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: studentNames[row][gridColIndex] == null
                              ? const Icon(Icons.add, color: Colors.grey)
                              : const Icon(Icons.check, color: Colors.teal),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
