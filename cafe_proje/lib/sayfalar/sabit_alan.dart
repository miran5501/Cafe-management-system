import 'package:cafe_proje/models/global.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:cafe_proje/utils/constants/const.dart';
import 'package:flutter/material.dart';

class SabitAlanBar extends StatefulWidget {
  final Function(String id)?
      onSelected; // Tıklanan alanın ID'sini geri döndürmek için callback
  const SabitAlanBar({super.key, this.onSelected});

  @override
  State<SabitAlanBar> createState() => _SabitAlanBarState();
}

class _SabitAlanBarState extends State<SabitAlanBar> {
  int? selectedIndex;
  String id = "s";

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: koyuArkaPlan,
        boxShadow: [
          BoxShadow(
            color: gri.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      width: deviceWidth,
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FutureBuilder(
        future: apiService.getAlanlar(token: globalToken!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: List.generate(snapshot.data!.length, (index) {
                var alan = snapshot.data![index];
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        id = alan.id.toString();
                        selectedIndex = index;
                      });

                      if (widget.onSelected != null) {
                        widget.onSelected!(id);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? acikArkaPlan
                            : koyuArkaPlan,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          if (selectedIndex == index)
                            BoxShadow(
                              color: gri.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          alan.alanIsmi.toString(),
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
