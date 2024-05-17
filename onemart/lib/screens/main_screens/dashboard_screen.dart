import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai%20assistance/chat_page.dart';
import 'package:flutter_application_1/screens/add_product_screen.dart';
import 'package:flutter_application_1/screens/main_screens/detail_product_screen.dart';
import 'package:flutter_application_1/screens/main_screens/profile_screen.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/text_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:random_color/random_color.dart';
import 'package:animation_search_bar/animation_search_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences _prefs;
  late String? userName = '';
  late TextEditingController _searchController;
  late List<Map<String, dynamic>> _products = [];
  late final List<Map<String, dynamic>> _filteredProducts = [];
  final RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    userName = _prefs.getString('user_nama');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Image.asset('assets/images/bg.png', width: 50, height: 50),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Text("Hi, $userName!"),
                // ), // memberikan jarak antara logo dan search bar
                Flexible(
                  child: AnimationSearchBar(
                    searchTextEditingController: _searchController,
                    isBackButtonVisible: false,
                    previousScreen: null,
                    hintText: 'Search Product',
                    centerTitle: 'OneMart',
                    textStyle: GoogleFonts.poppins(),
                    onChanged: _searchProducts,
                    searchBarWidth: MediaQuery.of(context).size.width -
                        150, // Adjust the width accordingly
                    searchBarHeight: 50, // Adjusted height to avoid overflow
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
              },
              icon: const Icon(Icons.add),
              tooltip: 'Add Product',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item = _filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(item: item),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              color: _randomColor.randomColor(
                                colorBrightness: ColorBrightness.light,
                              ),
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Hero(
                              tag: item['id'],
                              child: Image.network(
                                item['gambar'] ??
                                    "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ...",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 4),
                          child: Text(item['nama'],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Text('Harga  : Rp.${item['harga']}',
                            style: GoogleFonts.poppins(
                              color: kTextLightColor,
                            )),
                        Text(
                          item['promo'] == '0'
                              ? ''
                              : 'Diskon : ${item['promo']}%',
                          style: GoogleFonts.poppins(
                            color: kTextLightColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            label: 'AI Assistance',
          )
        ],
        currentIndex: 0,
        onTap: _onNavItemTapped,
      ),
    );
  }

  void _searchProducts(String query) {
    _filteredProducts.clear();
    if (query.isEmpty) {
      setState(() {
        _filteredProducts.addAll(_products);
      });
    } else {
      setState(() {
        _filteredProducts.addAll(_products.where((product) =>
            product['nama'].toLowerCase().contains(query.toLowerCase())));
      });
    }
  }

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatPage()),
        );
        break;
    }
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService.fetchData();
      setState(() {
        _products = products;
        _filteredProducts.addAll(_products);
      });
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchProducts();
  }
}
