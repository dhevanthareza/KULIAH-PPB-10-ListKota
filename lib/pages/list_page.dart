import 'package:flutter/material.dart';
import 'package:list_kota/api/client.dart';
import 'package:list_kota/component/loading.dart';
import 'package:list_kota/model.dart/city_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isLoading = true;
  List<CityModel> cities = [];
  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  fetchProduct() async {
    List<dynamic> response = await Request.get('/list.php');
    setState(() {
      cities = response.map((e) => CityModel.fromJson(e)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Kota"),
      ),
      body: isLoading
          ? Center(
              child: Loading(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text("${cities[index].name}")),
                  );
                },
              ),
            ),
    );
  }
}
