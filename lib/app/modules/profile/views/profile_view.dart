import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/data.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
   ProfileView({Key? key}) : super(key: key);
final GlobalKey<FormState> formKeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              leading: const GoBack(),
              title: Text(
                'Profile',
                style: tsPoppins(
                    size: 18, weight: FontWeight.w600, color: textDark80),
              ),
            ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: Get.height * 0.3,
              floating: false,
              pinned: true,
              backgroundColor: primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              title: Text(
                '',
                style:
                    tsPoppins(size: 16, weight: FontWeight.w500, color: white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      color: primary,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                chooseImagePickerSource(
                                    title: 'Profile photo',
                                    onGalleryTap: () {
                                      Get.back();
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                    onCameraTap: () {
                                      Get.back();
                                      controller.pickImage(ImageSource.camera);
                                    });
                              },
                              child: Stack(
                                children: [
                                  Obx(
                                    () => ClipOval(
                                      child: SizedBox.fromSize(
                                          size: const Size.fromRadius(40.0),
                                          child: controller
                                                  .file.value.path.isNotEmpty
                                              ? Image.file(
                                                  controller.file.value,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  controller
                                                      .currentUser.value.image,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    "assets/images/img_user_default.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 0,
                                    child: SvgPicture.asset(
                                        "assets/icons/ic_edit_pro.svg"),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => Text(
                                controller.currentUser.value.name,
                                style: tsPoppins(
                                    size: 14,
                                    color: white,
                                    weight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ),
          ];
        },
        body: Container(
          color: primary,
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/img_bg.png"),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0),
                  )),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Form(
                  key: formKeyProfile,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: tsPoppins(
                            size: 14,
                            weight: FontWeight.w600,
                            color: textDark80),
                      ),
                      Text(
                        'Re-check your details and update it if needed',
                        style: tsPoppins(
                            size: 11,
                            weight: FontWeight.w400,
                            color: textDark40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: controller.nameController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              style: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: textDark80),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '*Required';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputFormDecoration
                                  .underLinedInputTextDecoration(
                                      labelText: 'Name',
                                      labelStyle: tsPoppins(
                                          weight: FontWeight.w400,
                                          height: 3,
                                          size: 11,
                                          color: textDark40),
                                      borderSide:
                                          const BorderSide(color: textDark20)),
                            ),
                            SizedBox(
                              height: Get.height * .010,
                            ),
                          
                            TextFormField(
                              controller: controller.phoneController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              enabled: false,
                              style: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: textDark80),
                              decoration: InputFormDecoration
                                  .underLinedInputTextDecoration(
                                      labelText: 'Mobile Number',
                                      labelStyle: tsPoppins(
                                          weight: FontWeight.w400,
                                          height: 3,
                                          size: 11,
                                          color: textDark40),
                                      borderSide:
                                          const BorderSide(color: textDark20)),
                            ),
                            SizedBox(
                              height: Get.height * .015,
                            ),
                            SizedBox(
                              height: Get.height * .015,
                            ),
                            TextFormField(
                              controller: controller.emailController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: textDark80),
                              decoration: InputFormDecoration
                                  .underLinedInputTextDecoration(
                                      labelText: 'Email id',
                                      labelStyle: tsPoppins(
                                          weight: FontWeight.w400,
                                          height: 3,
                                          size: 11,
                                          color: textDark40),
                                      borderSide:
                                          const BorderSide(color: textDark20)),
                            ),
                            SizedBox(
                              height: Get.height * .015,
                            ),
                         
                            SizedBox(
                              height: Get.height * .015,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Obx(
                                () => controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: white,
                                        backgroundColor: primary,
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          if (formKeyProfile.currentState!
                                              .validate()) {
                                            controller.updateProfile();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            minimumSize: Size(Get.width, 50)),
                                        child: Text(
                                          'Update',
                                          style: tsPoppins(
                                              size: 16,
                                              weight: FontWeight.w600,
                                              color: white),
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  
  }
}
