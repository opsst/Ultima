import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ultima/model/cosmetic-model.dart';
import 'package:ultima/services/service.dart';

import '../views/navigation-view.dart';

class userController extends GetxController{
  var instruction_State = 0.obs;
  PageController? thisControl;
  var statePage = 0.obs;
  var isScroll = false.obs;

  var cosmetic = [].obs;

  var eyeshadow = [].obs;
  var blush_on = [].obs;
  var lipstick = [].obs;

  // var cosmeticModel = CosmeticModel();

  APIService service = APIService();

  initData() async{
    print('start');
    service.getAllCosmetic().then((res) {
    if (res == null){
      print('sddsd');
    }

    else {
      res.data['data'].forEach((element) {

        var cosmeticModel = new CosmeticModel();

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

        cosmetic.value.add(cosmeticModel);
        if(element['cos_cate']=="Lipstick"){
          lipstick.value.add(cosmeticModel);
        }else if(element['cos_cate']=="Blush on"){
          blush_on.value.add(cosmeticModel);
        }else if(element['cos_cate']=="Eyeshadows"){
          eyeshadow.value.add(cosmeticModel);
        }

      });
    }
    print(lipstick.value[0].cos_name);
    print(lipstick.value[1].cos_name);

    // print(res.data['data'].length);
      Get.off(
              () => NavigationBarView(),
          transition: Transition.rightToLeftWithFade
      );
    // }
    });
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