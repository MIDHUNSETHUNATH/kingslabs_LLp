
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kingslabs_task/controllers/auth.dart';






class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 169, 243, 236),
        title: Center(
          child: Text(
            "LoGin.",
            style: TextStyle(fontSize: 23.sp, fontFamily: "Lobster", color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: const Color.fromARGB(255, 125, 238, 227),
              width: 3.0.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 2.r,
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 50.h, left: 30.w, right: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.pink, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.pink, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30.h),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: () async {
                          controller.login();
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20.r),
                          child: Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

