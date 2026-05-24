import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController adminController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  void login() {
    String admin = adminController.text;
    String password = passwordController.text;

    if (admin == 'admin' && password == '1234') {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder:(context) => 
          const DashboardShell(),
        ),
      );
    }
    else {
      setState(() {
        errorMessage = 'Username or Password is incorrect';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/iconImage/greengif.gif',
                ),
                fit: BoxFit.cover,
              )
            ),
          ),

          AnimatedPadding(
            duration: Duration(milliseconds: 20),

            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom * 0.52
              : 0,
            ),

            child: Align(
              alignment: Alignment.bottomCenter,


            child: Container(
              height: 385,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Color(0xFF000000),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withValues(alpha: 0.07),
                    blurRadius: 10, 
                    spreadRadius: 1,
                    offset: Offset(0, -12),
                  )
                ]
              ),

              child: Padding(
                padding: EdgeInsets.only(
                  top: 40,
                  ),
                child: Column(
                  children: [
                          SizedBox(
                            height: 55,
                            width: 336,

                            child: TextField(

                              controller: adminController,

                            style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Color(0xFF797979),
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: Color(0xFF1B1B1B),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),

                        

                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 30, right: 20),
                          child: SvgPicture.asset(
                            'assets/iconImage/email.svg',
                            width: 20,
                            height: 16,
                          ),
                        ),

                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                          ),
                          ),
                          
                          
                      
                      

                    SizedBox(height: 20),


                    SizedBox(
                      height: 55,
                      width: 336,

                      child: TextField(

                        controller: passwordController,

                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color(0xFF797979),
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: Color(0xFF1B1B1B),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),

                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 30, right: 23),
                          child: SvgPicture.asset(
                            'assets/iconImage/lock.svg',
                            width: 20,
                            height: 18,
                          ),
                        ),

                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),

                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      errorMessage,

                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 10,

                        foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Color(0xFFCA2828),
                            Color(0xFFFFBB00),
                          ],
                        ).createShader(
                          const Rect.fromLTWH(120, 0, 200, 20),
                        ),
                      ),
                    ),




                    SizedBox(height: 18),

                    SizedBox(
                      width: 336,
                      height: 55,

                      child: ElevatedButton(
                        onPressed: login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFFFFF),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700, 
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Having trouble accessing your account?\nContact admin for help.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'PlusJakartaSans',
                        color: Color(0xFF797979),
                      ),
                    ),
                  ],


                  ),
                ),
              ),
            )

            
            ),


          
        ],
      ),
    );
  }
}
