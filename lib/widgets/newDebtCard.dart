import 'package:flutter/material.dart';
import '../appConfig.dart';

class NewDebtCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final Function? funci;
  const NewDebtCard(
      {super.key,
      required this.productName,
      required this.productPrice,
      this.funci});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig().shadowColor,
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(productName)),
                ],
              ),
              Text('$productPrice Gs',
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            funci!();
          },
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppConfig().shadowColor,
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.delete,
              size: 27,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
