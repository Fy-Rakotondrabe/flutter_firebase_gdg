import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/hotel_model.dart';
import 'package:flutter_firebase/services/hotel_service.dart';
import 'package:flutter_firebase/views/widgets/hotel_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  final service = HotelService();
  final int pageSize = 4;

  List<Hotel> hotels = [];
  bool loading = false;
  Timestamp? lastItemIdx;
  bool isLastPage = false;

  @override
  void initState() {
    getHotels();
    _controller.addListener(() async {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange &&
          !isLastPage) {
        await getHotels();
      }
    });
    super.initState();
  }

  Future<void> getHotels() async {
    if (!isLastPage) {
      setState(() {
        loading = true;
      });
      final result = await service.getPaginateHotels(lastItemIdx, pageSize);
      if (result.length < pageSize) {
        setState(() {
          isLastPage = true;
        });
      }
      setState(() {
        hotels = [...hotels, ...result];
        loading = false;
        lastItemIdx = Timestamp.fromDate(
          result[result.length - 1].creationDate,
        );
      });
    }
  }

  Future<void> refresh() async {
    if (!isLastPage) {
      setState(() {
        loading = true;
        isLastPage = false;
        lastItemIdx = null;
      });
      final result = await service.getPaginateHotels(lastItemIdx, pageSize);
      if (result.length < pageSize) {
        setState(() {
          isLastPage = false;
        });
      }
      setState(() {
        hotels = result;
        loading = false;
        lastItemIdx = Timestamp.fromDate(
          result[result.length - 1].creationDate,
        );
      });
    }
  }

  Future<void> onSearchHotel(String value) async {
    setState(() {
      loading = true;
    });
    final result = await service.searchHotels(value);
    setState(() {
      hotels = result;
      loading = false;
    });
  }

  void resetSearch() {
    setState(() {
      hotels = [];
    });
    FocusScope.of(context).unfocus();
    getHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person_2_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => resetSearch(),
                  ),
                ),
                onSubmitted: (value) => onSearchHotel(value),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: Colors.black,
                color: Colors.white,
                onRefresh: () async {
                  refresh();
                },
                child: ListView.builder(
                  controller: _controller,
                  itemCount: hotels.length,
                  itemBuilder: (context, index) {
                    return HotelItem(
                      item: hotels[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
