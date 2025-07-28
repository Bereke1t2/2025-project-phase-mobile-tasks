import 'package:flutter/material.dart';
// import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/data/dataRepo.dart';
import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/pages/update.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  RangeValues _currentRangeValues = RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Search  Product', style: TextStyle(fontSize: 16)),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF3F51F3)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Headphones",
                          hintStyle: const TextStyle(color: Color(0xFF666666)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFB0B0B0)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                        textAlignVertical: TextAlignVertical.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(width: 10),
                    // spacing between textfield and icon
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFF3F51F3),
                      ),
                      child: Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: ProductList.length,
                    itemBuilder: (context, index) {
                      return ProductTile(product: ProductList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: 338,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF3E3E3E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(

                    decoration: InputDecoration(
                      
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical:10,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF3E3E3E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height:10),
                  SliderTheme(
               data: SliderTheme.of(context).copyWith(
                activeTrackColor: Color.fromRGBO(63, 81, 243, 1),
                thumbColor: Color.fromRGBO(63, 81, 243, 1),
                valueIndicatorColor: Color.fromRGBO(63, 81, 243, 1),
              ),
              child: RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '\$${_currentRangeValues.start.round()}',
                  '\$${_currentRangeValues.end.round()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
                  SizedBox(height: 20),
                  Button(onPressed: (){}, name: 'Apply',color: Color(0xFF3F51F3),)

                  // spacing between buttons
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
