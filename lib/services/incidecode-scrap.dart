import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:ultima/services/service.dart';
// import 'package:ultima/services/service.dart';

// import 'package:Florxy/NetworkHandler.dart';


class Product{
  String name = "";
  String link = "";
  Product(this.name,this.link);

}

// class Ingredient{
//   String ing_name = '';
//   String ing_met = '';
//   String ing_irr = '';
//   String ing_rate = '';
//   // Ingredient(this.ing_name,this.ing_met,this.ing_irr,this.ing_rate);
//
// }

class Real{
  String p_name = "";
  String p_brand = "";
  String p_desc = "";
  String p_img = "";
  String p_cate = "";
  List p_ing = [];
// Real(this.p_name, this.p_brand, this.p_desc, this.p_img, this.p_ing);
}

class Search{
  String thisURL = "";
  final String beforePage = "&activetab=products&ppage=";
  bool isNext = false;
  bool isPrev = false;
  // List<String> prodPage = [];
  List prodList = [];
}

class Scraper {
  static const URL = 'https://incidecoder.com/search?query=';
  static const URL2 = 'https://incidecoder.com/';


  static Future<Real> getBrand(String path) async {
    // Search obj = new Search();

    // obj.thisURL = path;

    final response = await http.get(Uri.parse("https://incidecoder.com"+path));

    var body = response.body;
    var ing_name = '';
    var ing_link = '';
    // var ing_met = [];
    // var ing_irr = [];
    // var ing_rate = '';
    var alling_name = [];
    var alling_link = [];
    // var alling_met = [];
    // var alling_irr = [];
    // var alling_rate = [];
    String? img = "";
    final parse_body = parse(body);
    final name = parse_body.querySelectorAll('#product-title')[0].innerHtml.trim().replaceAll("&amp", "&");
    final brand = parse_body.querySelectorAll('#product-brand-title > a')[0].innerHtml.trim();
    if (parse_body.querySelectorAll('#product-main-image').length>0&&parse_body.querySelectorAll('#product-main-image')[0].querySelectorAll('img').length>0){
      img = parse_body.querySelectorAll('#product-main-image')[0].querySelectorAll('img')[0].attributes['src'];
    }
    else{
      img = "";
    }
    var detail = "";
    if(parse_body.querySelectorAll('#product-details')[0].text.trim().contains("span")){
      // detail = parse_body.querySelectorAll('#product-details > span')[0].text.trim();
      // detail = detail + parse_body.querySelectorAll('#product-details > span')[0].text.trim().replaceAll("\n       ", "");
      //   print("if");
    }
    else{
      detail = parse_body.querySelectorAll('#product-details')[0].text.trim().replaceAll("\n        ", "").replaceAll("[more]", "").replaceAll("[less]", "");
      // print("else");

    }
    var category = "";
    var detail_low = name.toLowerCase() ;
    if(detail_low.contains("body wash")||detail_low.contains("body")||detail_low.contains("soap")||detail_low.contains("body lotion")||detail_low.contains("shower")){
      category = "Bath & Body";
    }
    else if(detail_low.contains("eyebrown")|| detail_low.contains("cc")|| detail_low.contains("primer")|| detail_low.contains("concealer")|| detail_low.contains("powder")|| detail_low.contains("palette")|| detail_low.contains("bronzer")|| detail_low.contains("bb")|| detail_low.contains("brow")|| detail_low.contains("contour")|| detail_low.contains("corrector")|| detail_low.contains("foundation")|| detail_low.contains("blush")){
      category = "Makeup";
    }
    else if(detail_low.contains("hand")){
      category = "Hand Care";
    }
    else if(detail_low.contains("shampoo")){
      category = "Shampoo";
    }
    else if(detail_low.contains("conditioner")){
      category = "Conditioner";
    }
    else if(detail_low.contains("hair")||detail_low.contains("sculp")){
      category = "Haircare";
    }
    else if(detail_low.contains("perfume")||detail_low.contains("parfum")||detail_low.contains("cologne")){
      category = "Fragrance";
    }
    else if(detail_low.contains("nail")){
      category = "Nail Care";
    }
    else if(detail_low.contains("mask")||detail_low.contains("sleep")){
      category = "Mask";
    }
    else if(detail_low.contains("toner")){
      category = "Toner";
    }
    else if(detail_low.contains("pad")||detail_low.contains("treatment")){
      category = "Treatment";
    }
    else if(detail_low.contains("sun cream") || detail_low.contains("sunscreen")|| detail_low.contains("sun")){
      category = "Sunscreen";
    }
    else if(detail_low.contains("serum")||detail_low.contains("ampoule")){
      category = "Serum";
    }
    else if(detail_low.contains("eye serum")||detail_low.contains("eye cream")||detail_low.contains("eye repair")||detail_low.contains("eye gel")||detail_low.contains("eye treatment")){
      category = "Eye Care";
    }
    else if(detail_low.contains("emulsion")){
      category = "Emulsion";
    }
    else if(detail_low.contains("essence")||detail_low.contains("mist")){
      category = "Essence";
    }
    else if(detail_low.contains("lip balm")){
      category = "Lip Moisturizers";
    }
    else if(detail_low.contains("cleanser")||detail_low.contains("facial foam")){
      category = "Cleanser";
    }
    else if(detail_low.contains("cleansing")||detail_low.contains("micellar")||detail_low.contains("makeup remover")){
      category = "Cleansing";
    }
    else if(detail_low.contains("cream")|| detail_low.contains("lotion")|| detail_low.contains("gel") ||detail_low.contains("balm")||detail_low.contains("oil")){
      category = "Moisturizers & Oil";
    }





    Real res = new Real();
    // Ingredient res_ing = new Ingredient();
    res.p_name = name;
    res.p_brand = brand;
    res.p_desc = detail;
    res.p_img = img!;
    res.p_cate = category;
    var ram = [];
    // print(name);
    // print(brand);
    // print(img);
    // print(detail);
    final all_Ing = parse_body.querySelectorAll('#showmore-section-ingredlist-table > table > tbody > tr');
    var i = 0;
    for (var ing in all_Ing){
      var x = ing.querySelectorAll('td > a');
      for (var y in x){
        // y = y.querySelectorAll('a');
        if(y.classes.contains('black')){
          ing_name = y.innerHtml.trim();
          ing_link = y.attributes['href'].toString();
          // print(y.attributes['href']);
        }
        // else if(y.classes.contains('lilac')){
        //   ing_met.add(y.innerHtml.trim());
        // }

      }
      // var j = ing.querySelectorAll('td > span > span');
      // for (var k in j){
      //   ing_irr.add(k.attributes['title'].toString());
      // }
      // if(ing.querySelectorAll('.our-take').isNotEmpty){
      //   ing_rate = ing.querySelectorAll('.our-take')[0].innerHtml.trim();
      // }
      // res_ing.ing_name = ing_name;
      // res_ing.ing_met = ing_met.toString();
      // res_ing.ing_irr = ing_irr.toString();
      // res_ing.ing_rate = ing_rate;

      alling_name.add(ing_name);
      alling_link.add(ing_link);

      // alling_met.add(ing_met);
      // alling_irr.add(ing_irr);
      // alling_rate.add(ing_rate);

      // print(alling_name);
      // print(alling_met);
      // print(alling_irr);
      // print(alling_rate);



      // print(res_ing.ing_name);
      // print('-----');
      // print(ing_name);
      // print(ing_met);
      // print(ing_irr);
      // print(ing_rate);
      // print('-----');
      // i = i+1;
      // print(res_ing.ing_name);
      // ram.add(res_ing);
      // for (var s in ram){
      //   print(s.ing_name);
      //   print(s.ing_met);
      //
      // }
      // ing_met = [];
      // ing_irr = [];
      // ing_rate = '';

    }
    ram.add(alling_name);
    ram.add(alling_link);
    // ram.add(alling_met);
    // ram.add(alling_irr);
    // ram.add(alling_rate);

    // print(all_Ing);
    // print(ram[0].ing_name);
    // print(ram[1].ing_name);

    // for(var chk in ram){
    //   print(chk.ing_name);
    // }
    res.p_ing = ram;
    // print(res.p_img);
    return res;
    // return obj.prodList;

  }

  static Future<List> getData(String path) async {
    Search obj = new Search();

    obj.thisURL = path;

    final response = await http.get(Uri.parse(URL + path));

    var body = response.body;


    int count = 2;
    bool isFin = true;
    while (isFin){
      // if(count>1){
      //   break;
      // }
      print(count);

      var new_response = await http.get(Uri.parse(URL+path+obj.beforePage+count.toString()));
      var new_body = new_response.body;
      var new_html = parse(new_body);
      body = body + new_body;
      final links = new_html.querySelectorAll('.paddingb1, .center, .fs18');
      for (var link in links) {
        var str = link.innerHtml.trim();
        if(str.toLowerCase().contains('next page')){
          isFin = true;
          break;

        }
        else{
          isFin = false;
        }

      }
      count = count +1;
    }

    var html = parse(body);


    final products = html.querySelectorAll('a > .klavika, .simpletextlistitem');
    for (var product in products){
      // print('${product.text.trim()} ${product.attributes['href']}');
      var link = product.attributes['href'];
      if (link == null){

      }
      else{
        obj.prodList.add(Product(product.text.trim(), link));
      }
    }


    // print(links[1].innerHtml.split("<a"));
    // print(body.runtimeType);
    return obj.prodList;

  }
  static Future<List> getData2(String path) async {
    Search obj = new Search();

    obj.thisURL = path;

    final response = await http.get(Uri.parse('https://incidecoder.com/brands/'+ path));

    var body = response.body;


    bool isFin = true;
    int count = 1;

    while (isFin){
      var new_response = await http.get(Uri.parse('https://incidecoder.com/brands/'+path+'?offset='+count.toString()));
      var new_body = new_response.body;
      var new_html = parse(new_body);
      body = body + new_body;
      // print(body);
      final links = new_html.querySelectorAll('.center, .fs16');
      for (var link in links) {
        var str = link.innerHtml.trim();
        // print(str);
        if(str.toLowerCase().contains('next page')){
          isFin = true;
          break;

        }
        else {
          isFin = false;
        }
      }
      print(count);
      count = count + 1;
    }



    var html = parse(body);


    final products = html.querySelectorAll('a > .klavika, .simpletextlistitem');
    for (var product in products){
      // print('${product.text.trim()} ${product.attributes['href']}');
      var link = product.attributes['href'];
      if (link == null){

      }
      else{
        obj.prodList.add(Product(product.text.trim(), link));
      }
    }


    // print(links[1].innerHtml.split("<a"));
    // print(body.runtimeType);
    return obj.prodList;

  }
  // Future<String> hasnext(String path)async {
  //   final response = await http.get(Uri.parse(URL + path));
  //
  //   final body = response.body;
  //
  //   final html = parse(body);
  //
  //   int count = 2;
  //
  //   final links = html.querySelectorAll('.paddingb1, .center, .fs18');
  //   for (var link in links) {
  //     var str = link.innerHtml.trim();
  //     while (true){
  //       if(str.toLowerCase().contains('next page')){
  //         obj.isNext = true;
  //       }
  //     }
  //
  //
  //   }
  // }
  static Future<List> getIng(String link) async{

    String path = URL2;
    List Ing = [];
    List ingReturn = [];
    print(link);
    var response = await http.get(Uri.parse(path+link));
    var body = response.body;
    var parse_body = parse(body);
    // ing name
    var ingname = parse_body.querySelector('.ingredinfobox .klavikab')?.innerHtml.trim();
    // ing rate
    String? ingrate = "";

    if(parse_body.querySelector('.ingredinfobox .ourtake')?.innerHtml.trim() == null){
      ingrate = "";
    }
    else{
      ingrate = parse_body.querySelector('.ingredinfobox .ourtake')?.innerHtml.trim();
    }
    // print(rate);
    var funcs = parse_body.querySelectorAll('.itemprop .value');
    String ingcall= '';
    List ingfunc= [];
    String ingirr= '';
    String ingcome= '';
    String ingcos= '';

    for (var func in funcs){
      // func = func.querySelector('.value')?.innerHtml.trim();
      var check = func.previousElementSibling?.innerHtml;
      // print(func.innerHtml);
      // print(func.previousElementSibling?.innerHtml);
      if(check=="Also-called-like-this:"){
        ingcall = func.innerHtml.trim();
      }else if (check == "What-it-does: "){
        var ram = func.querySelectorAll('.value > a');
        for (var efunc in ram){
          ingfunc.add(efunc.innerHtml.trim());
        }
      }else if (check=="Irritancy: "){
        ingirr = func.innerHtml.trim();
      }else if (check=="Comedogenicity: "){
        ingcome = func.innerHtml.trim();
      }
    }
    var cosings = parse_body.querySelectorAll('#cosing-data > div > div');
    for (var cosing in cosings){
      if(cosing.innerHtml.trim().replaceAll("<b>","").replaceAll("</b>", "").trim() == ""){

      }
      else{
        ingcos = ingcos + cosing.text.trim().replaceAll("<b>","").replaceAll("</b>", "").replaceAll("\n", "").replaceAll("                    ", "").replaceAll("      ", "");
        // ingcos = cosing.innerHtml.trim().replaceAll("<b>","").replaceAll("</b>", "").replaceAll("\n", "").replaceAll("                    ", "").trim();
        // print(ingcos);
        // print(cosing.innerHtml.trim().replaceAll("<b>","").replaceAll("</b>", "").replaceAll("\n", "").replaceAll("                    ", "").trim());
      }
    }
    var ingquick = [];
    var quick = parse_body.querySelectorAll('.starlist > li');
    if(quick.length > 0){
      for (var each in quick){
        // print(each.innerHtml.trim());
        ingquick.add(each.innerHtml.trim().replaceAll("<strong>","").replaceAll("</strong>", "").replaceAll("&nbsp", "").replaceAll(";", ""));
      }
    }

    var ingdetail = "";
    var details = parse_body.querySelectorAll('.content > p:not(a)');
    if(details.length  > 0){
      var count = 1;
      for (var detail in details){
        if(count <= 4){
          // print(detail.text);
          ingdetail = ingdetail + detail.text.replaceAll("<strong>","").replaceAll("</strong>", "").replaceAll("&nbsp", "").replaceAll(";", "");
        }
        else{
          break;
        }
        count++;
      }
    }
    var ingproofs = [];
    var proofs = parse_body.querySelectorAll('#proof >div >ul> li');
    if(proofs.length>0){
      for(var proof in proofs){
        // print(proof.innerHtml.trim());
        ingproofs.add(proof.innerHtml.trim());
      }
    }
    Ing.add(ingname);
    Ing.add(ingrate);
    Ing.add(ingcall);
    Ing.add(ingfunc);
    Ing.add(ingirr);
    Ing.add(ingcome);
    Ing.add(ingcos);
    Ing.add(ingquick);
    Ing.add(ingdetail);
    Ing.add(ingproofs);

    ingReturn.add(Ing);
    // var body = response.body;
    // print(body);
    return (ingReturn);
  }
  getSuggest(String product) async {
    var response = await http.get(Uri.parse(product),headers: {
      "User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"
    });
    var body = response.body;
    var parse_body = parse(body);
    // var ingname = parse_body.querySelector('.ICdUp > div');
    // print(body);
    // print(parse_body);
    return body;

  }
}





// void initChaptersTitleScrap() async {
//   final rawUrl =
//       'https://unacademy.com/course/gravitation-for-iit-jee/D5A8YSAJ';
//   final webScraper = WebScraper('https://unacademy.com');
//   final endpoint = rawUrl.replaceAll(r'https://unacademy.com', '');
//   if (await webScraper.loadWebPage(endpoint)) {
//     final titleElements = webScraper.getElement(
//         'div.Week__Wrapper-sc-1qeje5a-2 > a.Link__StyledAnchor-sc-1n9f3wx-0 '
//             '> div.ItemCard__ItemInfo-xrh60s-1 '
//             '> h6.H6-sc-1gn2suh-0',
//         []);
//     print(titleElements);
//     final titleList = <String>[];
//     titleElements.forEach((element) {
//       final title = element['title'];
//       titleList.add('$title');
//     });
//     print(titleList);
//     if (mounted)
//       setState(() {
//         this.titleList = titleList;
//       });
//   } else {
//     print('Cannot load url');
//   }
// }

Future<void> main() async{
  // // NetworkHandler networkHandler = NetworkHandler()
  // String baseurl = "https://localhost:8080";
  // String formater(String url) {
  //   print(baseurl+url);
  //   return baseurl + url;
  // }
  //
  // Future<http.Response> post(String url, Map<String, String> body) async {
  //   // String? token = await storage.read(key:"token");
  //
  //   url = formater(url);
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-type": "application/json",
  //       // "Authorization":"Bearer $token"
  //     },
  //     body: json.encode(body),
  //   );
  //   return response;
  // }


  //  final stopwatch = Stopwatch()..start();
  //  List results = await Scraper.getData('1');
  //  // print(results);
  // for(int i=0;i<results.length;i++){
  //   print('${results[i].name} , ${results[i].link}');
  //  }
  //  print(stopwatch.elapsed);
  // List results = [];
  // results = await Scraper.getData2('innisfree');
  // for (var result in results) {
  //   print(result.link);
  APIService service = APIService();
  Real x = await Scraper.getBrand('/products/the-inkey-list-retinol-serum');
  var ing = [];
  var Ing_id = [];
  print(x.p_ing[0]);
  // print('+++++++++');
  // print(x.p_ing[1]);
  // print('------------');
  for (var ing in x.p_ing[1]){
    //   // print(ing);
    List y = await Scraper.getIng(ing);
    // print(y[0]);
    var data = jsonEncode({
      "name": y[0][0],
      "rate": y[0][1],
      "calling": y[0][2],
      "func":y[0][3],
      "irr": y[0][4],
      "come": y[0][5],
      "cosing": y[0][6],
      "quick": y[0][7],
      "detail": y[0][8],
      "proof":y[0][9],
      "link": ing
    });
    // print(data);
    var check = await service.addIng(data);
    print(check.statusCode);
    if (check.statusCode == 200){
      var k = check.data;
      // print(x['ing_id']);
      Ing_id.add(k['ing_id']);
    }
    // int i = 1;

    // for (var all in y[0]){
    //   // print(i);
    //   // print(all);
    //   ing.add(all);
    //   // i++;
    // }
  }

  // print(Ing_id);
  var fin_data = jsonEncode({
    "p_name": x.p_name,
    "p_brand": x.p_brand,
    "p_desc": x.p_desc,
    "p_cate": x.p_cate,
    "p_img": x.p_img,
    "ing_id": Ing_id
  });
  print(fin_data);
  if (x.p_cate=="Fragrance"){
    var fin =  await service.addFragrance(fin_data);

  }else{
    var fin =  await service.addSkincare(fin_data);

  }

  // print(fin.statusCode);

  // var list_ing = ing.toString().split(',');
  // for (var element in list_ing){
  //
  //   // print(element.trimLeft());
  //   var check = await service.addIng(element.trimLeft());
  //   // print(check.statusCode);
  //   if (check.statusCode == 200){
  //     var x = check.data;
  //
  //     // print(x['ing_id']);
  //     Ing_id.add(x['ing_id']);
  //   }
  // }
  // var Ing_final = Ing_id.toSet().toList();
  // print(Ing_id);
  // List y = await Scraper.getIng(x.p_ing[1]);
  // print(x.p_name+y.length.toString());
  // var i = 0;
  // for ( i; i<y.length; i++){
  //   print(y[i]);
  //   print('-------------------------------------------');
  // }
  // }
  //
  // Real x = await Scraper.getBrand('/products/evershine-moringa-refresh-toner-essence');
  //
  // print(x.p_ing[0]);
  // print(y.length);
  // for(var y in x.p_ing){
  //   print(y);
  //   for(var z in y){
  //     print(z);
  //   }
  //     // print(i);
  //     // print(y.runtimeType);
  //     // i = i + 1 ;
  //   }
  // Map<String, String> data = {
  //   "p_name":x.p_name,
  //   "p_brand":x.p_brand,
  //   "p_desc": x.p_desc,
  //   "p_img": x.p_img,
  // };
  // // var networkHandler;
  // var response = await post("/product/add", data);
  // print (response);
  // print(x.p_ing[]);
  // }


}
