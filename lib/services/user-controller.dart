import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ultima/model/cosmetic-model.dart';
import 'package:ultima/model/product-model.dart';
import 'package:ultima/services/service.dart';

import '../views/navigation-view.dart';

class userController extends GetxController{
  var instructionState = 0.obs;
  PageController? thisControl;

  var modeSelect = 0.obs;

  var statePage = 0.obs;
  var isScroll = false.obs;

  var t_cosmetic = [].obs;
  var cosmetic = [].obs;
  var skincare = [].obs;
  var fragrance = [].obs;

  // ใช้เรียกเครื่องสำอางแบ่งประเภทแล้ว
  var eyeshadow = [].obs;
  var blushOn = [].obs;
  var lipstick = [].obs;

  var currentExtent = 0.0.obs;
  var cosmeticSelect = 0.obs;

  var lipSelect = ''.obs;
  var lipIndex = 0.obs;
  var blushSelect = ''.obs;
  var blushIndex = 0.obs;
  var eyeSelect = ''.obs;
  var eyeIndex = 0.obs;
  var onCustomize = false.obs;
  var customizeIndex = 0.obs;

  var image = ''.obs;
  var pdt_name = ''.obs;
  var pdt_price = ''.obs;


  // var cosmeticModel = CosmeticModel();

  APIService service = APIService();

  initData() async{
    print('start');
    service.getAllCosmetic().then((res) {
    if (res == null){
      print('sddsd');
    }

    else {
      print(res.data['data'].length);
      res.data['data'].forEach((element) {

        var cosmeticModel = new CosmeticModel();

        cosmeticModel.id.value =element['Id']??'';
        cosmeticModel.cos_brand.value = element['cos_brand'];
        cosmeticModel.cos_name.value = element['cos_name'];
        cosmeticModel.cos_desc.value = element['cos_desc'];
        cosmeticModel.cos_cate.value = element['cos_cate'];
        cosmeticModel.cos_img.value = element['cos_img'];
        cosmeticModel.cos_istryon.value = element['cos_istryon']??false;
        cosmeticModel.cos_color_img.value = element['cos_color_img']??[];
        cosmeticModel.ing_id.value = element['ing_id']??[];
        cosmeticModel.cos_tryon_name.value = element['cos_tryon_name']??[];
        cosmeticModel.cos_tryon_color.value = element['cos_tryon_color']??[];
        cosmeticModel.l_link.value = element['l_link']??[];

        if(element['cos_istryon']==true){

          cosmetic.value.add(cosmeticModel);
          t_cosmetic.value.add(cosmeticModel);
          if(element['cos_cate']=="Lipstick"){
            lipstick.value.add(cosmeticModel);
          }else if(element['cos_cate']=="Blush on"){
            blushOn.value.add(cosmeticModel);
          }else if(element['cos_cate']=="Eyeshadows"){
            eyeshadow.value.add(cosmeticModel);
          }
        }
        else{
          cosmetic.value.add(cosmeticModel);
        }


      });
    }
    // print(lipstick.value[0].cos_name);
    // print(lipstick.value[1].cos_name);
    // Get.find<userController>().lipstick.value.forEach((element) {
    //   print(element.cos_tryon_name);
    //   print(element.cos_tryon_color);
    //
    // });
    // print(Get.find<userController>().blush_on.value);


    // print(res.data['data'].length);
    //   Get.off(
    //           () => NavigationBarView(),
    //       transition: Transition.rightToLeftWithFade
    //   );
    // }
    });
    service.getAllSkincare().then((res) {
      if (res == null){
        print('sddsd');
      }

      else {
        res.data['data'].forEach((element) {

          var productModel = new ProductModel();

            productModel.id.value =element['ID']??'';
          productModel.p_name.value = element['p_name'];
            productModel.p_brand.value = element['p_brand'];
            productModel.p_desc.value = element['p_desc'];
            productModel.p_cate.value = element['p_cate'];
            productModel.p_img.value = element['p_img'];
            productModel.ing_id.value = element['ing_id']??[];


            skincare.value.add(productModel);

        });
      }
      // print(lipstick.value[0].cos_name);
      // print(lipstick.value[1].cos_name);
      // Get.find<userController>().lipstick.value.forEach((element) {
      //   print(element.cos_tryon_name);
      //   print(element.cos_tryon_color);
      //
      // });
      // print(Get.find<userController>().blush_on.value);


      // print(res.data['data'].length);
      // Get.off(
      //         () => NavigationBarView(),
      //     transition: Transition.rightToLeftWithFade
      // );
      // }
    });
    service.getAllFragrance().then((res) {
      if (res == null){
        print('sddsd');
      }

      else {
        res.data['data'].forEach((element) {

          var productModel = new ProductModel();

          productModel.id.value =element['ID']??'';
          productModel.p_name.value = element['p_name'];
          productModel.p_brand.value = element['p_brand'];
          productModel.p_desc.value = element['p_desc'];
          productModel.p_cate.value = element['p_cate'];
          productModel.p_img.value = element['p_img'];
          productModel.ing_id.value = element['ing_id']??[];


          fragrance.value.add(productModel);

        });
      }
      // print(lipstick.value[0].cos_name);
      // print(lipstick.value[1].cos_name);
      // Get.find<userController>().lipstick.value.forEach((element) {
      //   print(element.cos_tryon_name);
      //   print(element.cos_tryon_color);
      //
      // });
      // print(Get.find<userController>().blush_on.value);


      // print(res.data['data'].length);
      Get.off(
              () => NavigationBarView(),
          transition: Transition.rightToLeftWithFade
      );
      // }
    });
    currentExtent = 0.0.obs;
    cosmeticSelect = 0.obs;

    lipSelect.value = '';
    lipIndex.value = -1;
    blushSelect.value = '';
    blushIndex.value = -1;
    eyeSelect.value = '';
    eyeIndex.value = -1;
    onCustomize.value = false;
    customizeIndex.value = 0;


  }

  startControl(PageController controller){
    thisControl = controller;
  }

  changePage(int page){
    statePage.value = page;
    thisControl?.jumpToPage(page);
    // thisControl?.animateToPage(page, duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

}