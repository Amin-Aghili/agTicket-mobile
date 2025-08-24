import 'package:ag_ticket/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

import 'components/big_card.dart';
import 'components/small_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _selectedSegment = ValueNotifier('all');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: agLightGreyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SizedBox(height: 10),

              // Search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.black54),
                  ],
                ),
              ),

              SizedBox(height: 10),

              AdvancedSegment(
                activeStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 13),
                backgroundColor: Colors.black12,

                itemPadding: EdgeInsetsGeometry.symmetric(
                  vertical: 10,
                  horizontal: 200,
                ),

                //backgroundColor: Colors.grey[200],
                sliderColor: agPrimaryColor,
                segments: {
                  'all': 'All',
                  'active': 'Active',
                  'past': 'Past',
                  'draft': 'Draft',
                },
                borderRadius: BorderRadius.all(Radius.circular(20)),
                controller: _selectedSegment,
              ),

              SizedBox(height: 10),

              // Featured Event
              BigCard(
                imageUrl:
                    'https://zrrypgzzfovkbebsyzih.supabase.co/storage/v1/object/sign/event.images/Sample1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV84OTA4Yjk1Ni1iOGYxLTQwZDYtYjQ1My0xYzc2YzJlNzVhNTYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJldmVudC5pbWFnZXMvU2FtcGxlMS5qcGciLCJpYXQiOjE3NTUxODc3NTQsImV4cCI6MTc1Nzc3OTc1NH0.Fggoievp1Tkia91m7-oFMUa3cVO6MBR109GKtAnIQjE',
                title: 'Antalia Tour',
                subTitle: '12 Sep 2025 - 07:30 - 15:00',
              ),

              SizedBox(height: 20),

              BigCard(
                imageUrl:
                    'https://zrrypgzzfovkbebsyzih.supabase.co/storage/v1/object/sign/event.images/Sample2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV84OTA4Yjk1Ni1iOGYxLTQwZDYtYjQ1My0xYzc2YzJlNzVhNTYiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJldmVudC5pbWFnZXMvU2FtcGxlMi5qcGciLCJpYXQiOjE3NTUxODc3ODEsImV4cCI6MTc1Nzc3OTc4MX0.VvozDTmwNDvWxz7y27_u_ASwzIoUEQVblxwX6mqnc_M',
                title: 'Dance Tour',
                subTitle: '17 Sep 2025 - 14:00 - 17:00',
              ),

              SizedBox(height: 20),

              // Upcoming Event Section
              Text(
                'Upcoming Event',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SmallCard(),
                    const SizedBox(width: 10),
                    SmallCard(),
                    const SizedBox(width: 10),
                    SmallCard(),
                    const SizedBox(width: 10),
                    SmallCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      // bottomNavigationBar: GlassBottomNavBar(),
    );
  }
}
