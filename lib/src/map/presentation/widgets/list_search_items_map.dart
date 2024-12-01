import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListSearchItemsMapWidget extends StatelessWidget {
  const ListSearchItemsMapWidget({
    required this.zipCode,
    required this.street,
    required this.city,
    required this.onTap,
    super.key,
  });

  final String zipCode;
  final String street;
  final String city;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            leading: SvgPicture.asset(MediaRes.markerItem),
            title: Text(
              zipCode,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$street - $city',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colours.quartz,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () => onTap(zipCode),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
