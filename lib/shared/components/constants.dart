import 'package:flutter/material.dart';

/*void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
  String? t = CacheHelper.getData(key: 'token');
  print(t);
  navigateAndKill(context, ShopLoginScreen());
  });
}*/

/// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}

String? token = '';

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

var details = {
  'Cedar Apple Rust_B':
      'cedar-apple rust, plant disease that primarily affects eastern red cedar and various apple and crab apple species, is caused by the fungus Gymnosporangium juniperi-virginianae. Both hosts, the junipers and the apples, are required for completion of the rust fungus’s two-year life cycle.',
  'Cedar Apple Rust_T':
      'Firstly His spray controls both fungi and insects (Orchard Spray for apple trees). secondly Typically, you should spray every 7-10 days during the period of infection. After that, you no longer need to treat your tree for the rest of the year (Immunox multi-purpose fungicide). In The End There is a strain of bacteria that is effective at treating cedar apple rust on apple trees. It is a special strain of Bacillus subtilis, sold commercially as (CEASE Biological Fungicide)',
  'Apple Healthy_B':
      'This case is not a disease this could be a paper renew, do not worry , have a good day :)',
  'Corn Common Rust_B':
      'Common Rust,The most useful visual characteristic differentiating common and southern rust is the location of sporulating pustules (pustules where spores are produced). Common rust pustules frequently occur on both the upper and lower leaf surfaces. Pustules of the common rust fungus tend to be circular to elongate, darker in color, less densely scattered, and slightly larger than those of southern rust that appears on the upper leaf surface. Pustules darken in color later in the season as the fungus produces teliospores instead of red urediniospores.Southern Rust, In contrast to the pustules of common rust, those of southern rust are circular to oval, light cinnamon-brown to orange in color and predominantly on the upper-leaf surface',
  'Corn Common Rust_T':
      'Firstly Fungicides. Then Cultural Practices. In The End Hybrid Sweet Corn',
  'Corn Healthy_B':
      'This case is not a disease this could be a paper renew, do not worry , have a good day :)',
  'Pepper bell Bacterial spot_B':
      'Bacterial spot is one of the most devastating diseases of pepper and tomato. The disease occurs worldwide where pepper and tomato are grown in warm, moist areas. When it occurs soon after transplanting and weather conditions remain favorable for disease development, the results are usually total crop loss.',
  'Pepper bell Bacterial spot_T':
      '- There are no recognized chemical treatments for bacterial leaf spot disease. Your best bet is prevention and mechanical control at the first sign of symptoms of bacterial leaf spot.Seed treatment with hot water, soaking seeds for 30 minutes in water pre-heated to 125 F/51 C, is effective in reducing bacterial populations on the surface and inside the seeds.',
  'Pepper bell healthy_B':
      'This case is not a disease this could be a paper renew, do not worry , have a good day :)',
  'Strawberry Leaf scorch_B':
      'Treat leaf scorch by letting your plants dry out. The best way to treat this 	disease is to alter watering practices and allow for dryer conditions. If 	that isn’t possible, you can treat your strawberries with organic fungicides 	like Captan 50 WP and Copper compounds.',
  'Strawberry Leaf scorch_T': 'Firstly Captan 50 WP 	And  Copper Compounds',
  'Strawberry Healthy_B':
      'This case is not a disease this could be a paper renew, do not worry , have a good day :)',
  'Tomato Early blight_B':
      'Early blight is one of the most common tomato and potato diseases, occurring nearly every season in Minnesota. It affects leaves, fruits and stems and can be severely yield-limiting when susceptible tomato cultivars are used and weather is favorable. Severe defoliation can occur.  In tomatoes, fruit can be damaged by sun.',
  'Tomato Early blight_T': '- Revus Top ',
  'Tomato Healthy_B':
      'This case is not a disease this could be a paper renew, do not worry , have a good day :)',
  'Tomato Late blight_B':
      'Symptoms of late blight may be found on any above-ground part of the tomato plant. Infected leaves typically have green to brown patches of dead tissue surrounded by a pale green or gray border. When the weather is very humid and wet, late blight infections can appear water-soaked or dark brown in color, and are often described as appearing greasy. ',
  'Tomato Late blight_T':
      'Plant resistant cultivars when available. Remove volunteers from the garden prior to planting and space plants far enough apart to allow for plenty of air circulation. Water in the early morning hours, or use soaker hoses, to give plants time to dry out during the day — avoid overhead irrigation. Destroy all tomato debris after harvest.',
  'Potato Early blight_B':
      'Early blight of potatoes, causal agent Alternaria solani, causes major yield losses in most potato growing areas of the world. Leaf symptoms are characteristic dark brown to black lesions with concentric rings. In this review morphological, physiological and molecular characters of the pathogen as well as the disease cycle, epidemiology and control of the disease are discussed. The early blight situation on potatoes in South Africa is also summarised.',
  'Potato Early blight_T':
      'Firstly Treatment of early blight includes prevention by planting potato varieties that are resistant to the disease; late maturing are more resistant than early maturing varieties. Secondly Avoid overhead irrigation and allow for sufficient aeration between plants to allow the foliage to dry as quickly as possible. Practice a 2-year crop rotation. That is, do not replant potatoes or other crops in this family for 2 years after a potato crop has been harvested. Then Keep the potato plants healthy and stress free by providing adequate nutrition and sufficient irrigation, especially later in the growing season after flowering when plants are most susceptible to the disease. In The End Remove plant debris and weed hosts at the end of the season to mitigate areas where the disease may overwinter.',
  'Potato Healthy_B':
      'This case is not a disease this could be a paper renew, do not worry , have a good day :)',
  'Potato Late blight_B':
      'Late blight is caused by the fungal-like oomycete pathogen Phytophthora infestans. The primary host is potato, but P. infestans also can infect other solanaceous plants, including tomatoes, petunias and hairy nightshade. These infected species can act as source of inoculum to potato.',
  'Potato Late blight_T':
      'Firstly Plant late blight-free seed tubers. Secondly Do not mix seed lots because cutting can transmit late blight. Third Use a seed piece fungicide treatment labeled for control of late blight. Recommended seed treatments include Revus, Reason and mancozeb. Then Avoid planting problem areas that may remain wet for extended periods or may be difficult to spray. In The End Avoid excessive and/or nighttime irrigation.',
};
