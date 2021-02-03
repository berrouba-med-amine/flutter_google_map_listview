import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant {
  String name;
  String adress;
  int stars;
  String openAt;
  LatLng location;
  String image;

  Restaurant(
      {this.name,
      this.adress,
      this.stars,
      this.openAt,
      this.location,
      this.image});

  // return list of restaurants
  static List<Restaurant> getRestaurants() {
    return [
      Restaurant(
          name: "El Djezair",
          adress: "24 Avenue Souidani Boudjemaa, El Mouradia 16000",
          stars: 5,
          openAt: "8h00",
          location: LatLng(36.7543915, 3.0440121),
          image:
              "https://www.airfrance.fr/FR/common/common/img/tbaf/news/ALG/hotel-el-djazair-lhistorique-saint-george/ALG-hotel-el-djazair-lhistorique-saint-george-1_1-1024x1024.jpg"),
      Restaurant(
          name: "Gourara",
          adress: "Timimoune",
          stars: 4,
          openAt: "8h00",
          location: LatLng(29.2627708, 0.2196342),
          image:
              "https://exp.cdn-hotels.com/hotels/16000000/15090000/15088800/15088721/ff58c275_z.jpg"),
      Restaurant(
          name: "Saoura",
          adress: "TAGHIT",
          stars: 4,
          openAt: "8h00",
          location: LatLng(30.920141, -2.0333192),
          image:
              "https://media-cdn.tripadvisor.com/media/photo-s/0f/bd/39/11/photo1jpg.jpg"),
      Restaurant(
          name: "Le Caid",
          adress: "Bou Saâda",
          stars: 4,
          openAt: "8h00",
          location: LatLng(35.2164002, 4.1760848),
          image:
              "https://media-cdn.tripadvisor.com/media/photo-s/09/bc/43/2b/bou-saada.jpg"),
    ];
  }
}
