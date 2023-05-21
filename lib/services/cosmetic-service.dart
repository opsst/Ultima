import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:ultima/services/service.dart';

class CosmeticsScrape{
  // var urlSearch = 'https://www.sephora.com/search?keyword=fenty%20beauty';
  APIService service = APIService();
  Future getSuggest(String product) async{
    product = product.replaceAll(' ', '%20');
    var browser = await puppeteer.launch(
      headless: true,
      // slowMo: Duration(seconds: 2)
    );
    var page = await browser.newPage();
    // page.cookies(
    //   urls: ['_gcl_au=1.1.961206468.1594951946; _med=refer; _fbp=fxb.2.1594951949275.1940955365; SPC_IA=-1; SPC_F=y1evilme0ImdfEmNWEc08bul3d8toc33; REC_T_ID=fab983c8-c7d2-11ea-a977-ccbbfe23657a; SPC_SI=uv1y64sfvhx3w6dir503ixw89ve2ixt4; _gid=GA1.3.413262278.1594951963; SPC_U=286107140; SPC_EC=GwoQmu7TiknULYXKODlEi5vEgjawyqNcpIWQjoxjQEW2yJ3H/jsB1Pw9iCgGRGYFfAkT/Ej00ruDcf7DHjg4eNGWbCG+0uXcKb7bqLDcn+A2hEl1XMtj1FCCIES7k17xoVdYW1tGg0qaXnSz0/Uf3iaEIIk7Q9rqsnT+COWVg8Y=; csrftoken=5MdKKnZH5boQXpaAza1kOVLRFBjx1eij; welcomePkgShown=true; _ga=GA1.1.1693450966.1594951955; _dc_gtm_UA-61904553-8=1; REC_MD_30_2002454304=1595153616; _ga_SW6D8G0HXK=GS1.1.1595152099.14.1.1595153019.0; REC_MD_41_1000044=1595153318_0_50_0_49; SPC_R_T_ID="Am9bCo3cc3Jno2mV5RDkLJIVsbIWEDTC6ezJknXdVVRfxlQRoGDcya57fIQsioFKZWhP8/9PAGhldR0L/efzcrKONe62GAzvsztkZHfAl0I="; SPC_T_IV="IETR5YkWloW3OcKf80c6RQ=="; SPC_R_T_IV="IETR5YkWloW3OcKf80c6RQ=="; SPC_T_ID="Am9bCo3cc3Jno2mV5RDkLJIVsbIWEDTC6ezJknXdVVRfxlQRoGDcya57fIQsioFKZWhP8/9PAGhldR0L/efzcrKONe62GAzvsztkZHfAl0I="']
    // );
    page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36');
    await page.goto('https://www.sephora.com/search?keyword='+product);
    // await page.goto('https://www.lazada.co.th/tag/bobbi-brown/',wait: Until.domContentLoaded);
    // await page.goto('https://www.konvy.com/list/?title=Bobbi%20Brown%20Extra%20Lip%20Tint',wait: Until.domContentLoaded);


    https://www.lazada.co.th/catalog/?spm=a2o4m.searchlist.search.2.36402186k6JISY&q=anua%20toner%2077&_keyori=ss&clickTrackInfo=textId--5044404390800774939__abId--333769__Score--1.674443800408162__pvid--f20646ad-ec24-4ee7-a6ed-f4c6fe4d1116__matchType--1__matchList--1-2__srcQuery--anua%20toner%2077__spellQuery--anua%20toner%2077__ctrScore--0.5747895240783691__cvrScore--0.014900356531143188&from=suggest_normal&sugg=anua%20toner%2077_0_1
    // var allResultsSelector = '._17mcb';
    // https://www.lazada.co.th/tag/anua-toner-70/?spm=a2o4m.home.search.8.11257f6dFVSVT5&q=anua%20toner%2070&_keyori=ss&clickTrackInfo=textId--5044404390800774932__abId--324452__Score--3.623494303515707E-5__pvid--6c50eaf5-a888-4bbf-a117-c300fe8f0bf9__matchType--1__matchList--1-2__srcQuery--anua%20toner%2070__spellQuery--anua%20toner%2070__ctrScore--0.009572863578796387__cvrScore--0.02043217420578003&from=suggest_normal&sugg=anua%20toner%2070_8_1&catalog_redirect_tag=true
    // await page.waitForSelector(allResultsSelector);
    // await page.click(allResultsSelector);
    var pageContent = await page.content;
    var res = parse(pageContent);
    // print(res);
    final pic = res.querySelectorAll('.css-foh208 > a > div > div > picture > img')[0].attributes['src'];
    print(pic);

  }

  Future getCosmetics(String product, String cate) async{
    product = product.replaceAll(' ', '%20');
    var browser = await puppeteer.launch(
      headless: false,
      // slowMo: Duration(seconds: 2)
    );
    var page = await browser.newPage();
    // page.cookies(
    //   urls: ['_gcl_au=1.1.961206468.1594951946; _med=refer; _fbp=fxb.2.1594951949275.1940955365; SPC_IA=-1; SPC_F=y1evilme0ImdfEmNWEc08bul3d8toc33; REC_T_ID=fab983c8-c7d2-11ea-a977-ccbbfe23657a; SPC_SI=uv1y64sfvhx3w6dir503ixw89ve2ixt4; _gid=GA1.3.413262278.1594951963; SPC_U=286107140; SPC_EC=GwoQmu7TiknULYXKODlEi5vEgjawyqNcpIWQjoxjQEW2yJ3H/jsB1Pw9iCgGRGYFfAkT/Ej00ruDcf7DHjg4eNGWbCG+0uXcKb7bqLDcn+A2hEl1XMtj1FCCIES7k17xoVdYW1tGg0qaXnSz0/Uf3iaEIIk7Q9rqsnT+COWVg8Y=; csrftoken=5MdKKnZH5boQXpaAza1kOVLRFBjx1eij; welcomePkgShown=true; _ga=GA1.1.1693450966.1594951955; _dc_gtm_UA-61904553-8=1; REC_MD_30_2002454304=1595153616; _ga_SW6D8G0HXK=GS1.1.1595152099.14.1.1595153019.0; REC_MD_41_1000044=1595153318_0_50_0_49; SPC_R_T_ID="Am9bCo3cc3Jno2mV5RDkLJIVsbIWEDTC6ezJknXdVVRfxlQRoGDcya57fIQsioFKZWhP8/9PAGhldR0L/efzcrKONe62GAzvsztkZHfAl0I="; SPC_T_IV="IETR5YkWloW3OcKf80c6RQ=="; SPC_R_T_IV="IETR5YkWloW3OcKf80c6RQ=="; SPC_T_ID="Am9bCo3cc3Jno2mV5RDkLJIVsbIWEDTC6ezJknXdVVRfxlQRoGDcya57fIQsioFKZWhP8/9PAGhldR0L/efzcrKONe62GAzvsztkZHfAl0I="']
    // );
    page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36');
    await page.goto(product);
    // await page.goto('https://www.lazada.co.th/tag/bobbi-brown/',wait: Until.domContentLoaded);
    // await page.goto('https://www.konvy.com/list/?title=Bobbi%20Brown%20Extra%20Lip%20Tint',wait: Until.domContentLoaded);


    https://www.lazada.co.th/catalog/?spm=a2o4m.searchlist.search.2.36402186k6JISY&q=anua%20toner%2077&_keyori=ss&clickTrackInfo=textId--5044404390800774939__abId--333769__Score--1.674443800408162__pvid--f20646ad-ec24-4ee7-a6ed-f4c6fe4d1116__matchType--1__matchList--1-2__srcQuery--anua%20toner%2077__spellQuery--anua%20toner%2077__ctrScore--0.5747895240783691__cvrScore--0.014900356531143188&from=suggest_normal&sugg=anua%20toner%2077_0_1
    // var allResultsSelector = '._17mcb';
    // https://www.lazada.co.th/tag/anua-toner-70/?spm=a2o4m.home.search.8.11257f6dFVSVT5&q=anua%20toner%2070&_keyori=ss&clickTrackInfo=textId--5044404390800774932__abId--324452__Score--3.623494303515707E-5__pvid--6c50eaf5-a888-4bbf-a117-c300fe8f0bf9__matchType--1__matchList--1-2__srcQuery--anua%20toner%2070__spellQuery--anua%20toner%2070__ctrScore--0.009572863578796387__cvrScore--0.02043217420578003&from=suggest_normal&sugg=anua%20toner%2070_8_1&catalog_redirect_tag=true
    // await page.waitForSelector(allResultsSelector);
    // await page.click(allResultsSelector);
    var pageContent = await page.content;
    await browser.close();
    var res = parse(pageContent);
    // print(res);
    // var Cos_brand =  res.querySelector('[data-at*="brand_name"]')!.innerHtml;
    var Cos_brand = res.querySelector('.product-brand > a')!.innerHtml;
    print(Cos_brand);
    // var Cos_name =  res.querySelector('[data-at*="product_name"]')!.innerHtml;
    var Cos_name = res.querySelector('.product-heading > h1')!.innerHtml;
    print(Cos_name);

    var Cos_desc = '';
    var before_desc =  res.querySelectorAll('.product-description .read-more-block-container > div > div > p');
    before_desc.removeLast();
    for(var content in before_desc){
      Cos_desc = Cos_desc + content.innerHtml.replaceAll('<b>', '\n').replaceAll('</b>', '\n').replaceAll('<br>', ' ');
    }
    // var Cos_desc =  res.querySelector('.css-1540hs > div')!.innerHtml.replaceAll('<b>', '\n').replaceAll('</b>', '').replaceAll('<br>', '').trimLeft();
    print(Cos_desc);
    var Cos_cate = cate;

    // var Cos_img = [];
    // var img = res.querySelectorAll('.css-b8zput');
    // img.forEach((element) {
    //   Cos_img.add(parse(element.innerHtml).querySelector('img')!.attributes['src']);
    // });
    // print(Cos_img);

    var Cos_img = [];
    var img = res.querySelectorAll('.desktop-image-carousel-container .image-container > img');
    // // print(Cos_color_img);
    img.forEach((element) {
      Cos_img.add(element.attributes['src']);
      // Cos_img.add(parse(element.innerHtml).attributes['src']);
    });
    print(Cos_img);

    // var Cos_color_img = [];
    // var color = res.querySelectorAll('[data-at*="swatch"]');
    // // print(Cos_color_img);
    // color.forEach((element) {
    //   Cos_color_img.add(parse(element.querySelector('div')!.innerHtml).querySelector('img')!.attributes['src']);
    // });

    var Cos_color_img = [];
    var color = res.querySelectorAll('.product-variant-swatch > img');
    // print(Cos_color_img);
    color.forEach((element) {
      Cos_color_img.add(element.attributes['src']);
    });
    print(Cos_color_img);



    var Ing_id = [];
    // var ing = res.querySelector('#ingredients > div > div')!.innerHtml;
    var ing = res.querySelector('.product-ingredients-values')!.innerHtml;
    var list_ing = ing.toString().split(',');
    for (var element in list_ing){
      // print(element.trimLeft());
      var check = await service.checkIng(element.trimLeft());
      // print(check.statusCode);
      if (check.statusCode == 200){
        var x = check.data;
        // print(x['ing_id']);
        Ing_id.add(x['ing_id']);
      }
    }
    var Ing_final = Ing_id.toSet().toList();
    print(Ing_id);

    dynamic req =
      {
        "cos_brand": Cos_brand,
        "cos_name": Cos_name,
        "cos_desc": Cos_desc.trimLeft(),
        "cos_cate": Cos_cate,
        "cos_img": Cos_img,
        "cos_is-try-on": true,
        "cos_color-img": Cos_color_img,
        "cos_try-on-name":[],
        "cos_try-on-color":[],
        "cos_ing_id": Ing_final
      };
    service.addCosmetic(req);



    // var Cos_img = img.toString().substring(img.indexOf("src=")+4,img.indexOf('"',img.indexOf("src=")+4));
    // print(Cos_img);
    // img.forEach((element) {
    //   Cos_img.add(element.attributes['src']);
    // });
    // print(Cos_img);




    // final Cos_color_img = res.querySelectorAll('.css-b83rh7 > button > div > img');
    // for(var each in Cos_color_img){
    //   print(each.attributes['src']);
    //   print('-------------');
    // }

  }

}

main(){
  // CosmeticsScrape().getSuggest('Bobbi Brown Long-Wear Waterproof Cream Eyeshadow Stick');
  CosmeticsScrape().getCosmetics('https://www.sephora.co.th/products/rare-beauty-soft-pinch-tinted-lip-oil','Lipstick');
}