import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sequenze_tech/product.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildScrollableContent(context),
          _buildFloatingNavigationBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.transparent),
        ),
      ),
      title: _buildAppBarTitle(),
      actions: _buildAppBarActions(),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        const Text('👋'),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '29/12/2022',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              'Joshua Scanlan',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: const Icon(Icons.shopping_basket_outlined, color: Colors.white),
        onPressed: () {},
      ),
      const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/profile_pic.jpg'),
        ),
      ),
    ];
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(color: Colors.black.withOpacity(0.3)),
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top),
          _buildSearchBar(),
          _buildSectionTitle('Most Popular Beverages'),
          _buildPopularBeveragesList(context),
          const SizedBox(height: 20),
          _buildSectionTitle('Get it instantly'),
          _buildInstantBeverageCard(
            context,
            'Latte',
            'Caffè latte is a milk coffee made up of one or two shots of espresso, steamed milk, and a final, thin layer of frothed milk on top.',
            '4.9',
            '458',
            'assets/img_6.png',
          ),
          const SizedBox(height: 160),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search favorite Beverages',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildPopularBeveragesList(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildBeverageCard(
              context, 'Hot Cappuccino', 'assets/img_5_rem.png', '4.5', '458'),
          _buildBeverageCard(
              context, 'Hot Cappuccino', 'assets/img_1_rem.png', '4.9', '250'),
          _buildBeverageCard(
              context, 'Hot Cappuccino', 'assets/img_1_rem.png', '3.9', '650'),
        ],
      ),
    );
  }

  Widget _buildBeverageCard(BuildContext context, String name, String imagePath,
      String rating, String reviews) {
    return GestureDetector(
      onTap: () =>
          _navigateToProductPage(context, name, imagePath, rating, reviews),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 15),
        child: Card(
          color: Colors.grey[800],
          child: Column(
            children: [
              Image.asset(imagePath,
                  height: 110, width: 200, fit: BoxFit.cover),
              const SizedBox(height: 20),
              Text(name,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 10),
              _buildRatingRow(rating, reviews),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(String rating, String reviews) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.yellow, size: 16),
        const SizedBox(width: 5),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('$rating ($reviews)',
                style: const TextStyle(color: Colors.grey))),
        const SizedBox(width: 30),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: 30,
      height: 30,
      child: ElevatedButton(
        child: const Icon(Icons.add, color: Colors.white, size: 20),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(1.0),
        ),
      ),
    );
  }

  Widget _buildInstantBeverageCard(BuildContext context, String name,
      String description, String rating, String reviews, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToProductPage(
          context, name, imagePath, rating, reviews,
          description: description),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellow, size: 16),
                              const SizedBox(width: 5),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('$rating ($reviews)',
                                      style:
                                          const TextStyle(color: Colors.grey))),
                              const SizedBox(width: 30),
                            ]),
                        Text(
                          description,
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child:
                        Image.asset(imagePath, height: 160, fit: BoxFit.cover),
                  ),
                ],
              ),
              // const SizedBox: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(20, 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                    ),
                    child: const Text('ADD',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToProductPage(BuildContext context, String name,
      String imagePath, String rating, String reviews,
      {String? description}) {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => ProductOrderPage(
          productName: name,
          imageUrl: imagePath,
          rating: double.parse(rating),
          ratingCount: int.parse(reviews),
          description: description ?? 'A delicious $name to enjoy.',
          fillingOptions: const ['Full', '1/2 Full', '3/4 Full', '1/4 Full'],
          milkOptions: const [
            'Skim Milk',
            'Full Cream Milk',
            'Almond Milk',
            'Soy Milk',
            'Lactose Free Milk',
            'Oat Milk'
          ],
          sugarOptions: const ['Sugar X1', 'Sugar X2', '1/2 Sugar', 'No Sugar'],
        ),
      ),
    );
  }

  Widget _buildFloatingNavigationBar() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.wallet), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.delete), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message_outlined), label: ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
