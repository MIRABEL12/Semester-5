import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TransparanPage(),
    );
  }
}

class TransparanPage extends StatefulWidget {
  const TransparanPage({super.key});

  @override
  _TransparanPageState createState() => _TransparanPageState();
}

class _TransparanPageState extends State<TransparanPage> {
  String? _selectedYear = '2024';
  String? _selectedMonth = 'November';

  final List<String> _years = ['2020', '2021', '2022', '2023', '2024'];
  final List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade400),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Laporan Transparansi Donasi',
          style: TextStyle(
              color: Colors.blue.shade400, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Berikut ini merupakan informasi seluruh donasi kita.',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Dropdown untuk memilih bulan
                _buildDropdownButton(
                  label: 'Bulan:',
                  value: _selectedMonth,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMonth = newValue;
                    });
                  },
                  items: _months,
                ),
                const SizedBox(width: 16),
                // Dropdown untuk memilih tahun
                _buildDropdownButton(
                  label: 'Tahun:',
                  value: _selectedYear,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedYear = newValue;
                    });
                  },
                  items: _years,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  horizontalMargin: 12,
                  headingRowHeight: 40,
                  dataRowHeight: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Tanggal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Nama Pasien',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Nama Akun Bank',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Jumlah',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Keperluan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('6 Nov 2024')),
                      DataCell(
                          Text('Yuk Bantu Syafira Sembuh dari Penyakitnya!')),
                      DataCell(Text('SITI MARIAM (BCA:########1631)')),
                      DataCell(Text('Rp 950.000')),
                      DataCell(Text('Terimakasih para donatur...')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('6 Nov 2024')),
                      DataCell(
                          Text('Bantu Andini Berjuang Lawan Thalassemia!')),
                      DataCell(Text('BPK RUDIONO SITOHANG (BNI:########2384)')),
                      DataCell(Text('Rp 95.000')),
                      DataCell(Text('Assalamualaikum...')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('7 Nov 2024')),
                      DataCell(Text('Bantu Doni Dalam Pengobatan Kanker!')),
                      DataCell(Text('MARIAM (BCA:########1234)')),
                      DataCell(Text('Rp 1.200.000')),
                      DataCell(Text('Doakan Doni sembuh...')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('7 Nov 2024')),
                      DataCell(Text('Bantu Membeli Obat Tiko!')),
                      DataCell(Text('SITI NURAINI (BNI:########5678)')),
                      DataCell(Text('Rp 200.000')),
                      DataCell(Text('Mohon doa dan bantuan...')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
    required List<String> items,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12, // Smaller font size for the label
            color: Colors.black, // Label color
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 4, vertical: 2), // Smaller padding
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black, // Dropdown text color
                    fontSize: 12, // Smaller dropdown text
                  ),
                ),
              );
            }).toList(),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 16, // Smaller icon
            ),
            underline: const SizedBox(), // Remove underline
            isExpanded: false,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
