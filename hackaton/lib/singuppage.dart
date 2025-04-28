import 'package:flutter/material.dart';
class singuppage extends StatefulWidget {
  const singuppage({super.key});

  @override
  State<singuppage> createState() => _singuppageState();
}

class _singuppageState extends State<singuppage> {
  final confirmController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool dontshowpassword1 = true;
  bool dontshowpassword2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Center(child:Icon(Icons.import_contacts,color: Colors.black,size: 50,)),
              //name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 12.5),
                child: TextField(
                  controller: emailController,
                  obscureText: false ,
                  decoration: InputDecoration(

                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                  ),
                ),
              ),

              //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 12.5),
                child: TextField(
                  controller: passwordController,
                  obscureText: dontshowpassword1,
                  decoration: InputDecoration(
                      suffixIcon:  Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12.5),
                        child: dontshowpassword1 ?IconButton(
                            onPressed: (){
                              setState(() {
                                dontshowpassword1 = !dontshowpassword1;
                              });
                            },
                            icon: const Icon(Icons.visibility)
                        )
                            :IconButton(
                            onPressed: (){
                              setState(() {
                                dontshowpassword1 = !dontshowpassword1;
                              });
                            },
                            icon: const Icon(Icons.visibility_off)
                        ),
                      ),

                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                  ),
                ),
              ),

              //password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 12.5),
                child: TextField(
                  controller: confirmController,
                  obscureText: dontshowpassword2 ,
                  decoration: InputDecoration(
                      suffixIcon:  Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12.5),
                        child: dontshowpassword2 ?IconButton(
                            onPressed: (){
                              setState(() {
                                dontshowpassword2 = !dontshowpassword2;
                              });
                            },
                            icon: const Icon(Icons.visibility)
                        )
                            :IconButton(
                            onPressed: (){
                              setState(() {
                                dontshowpassword2 = !dontshowpassword2;
                              });
                            },
                            icon: const Icon(Icons.visibility_off)
                        ),
                      ),

                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Theme.of(context).colorScheme.background,
                      filled: true,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                  ),
                ),
              ),

              // sigen  up

              GestureDetector(
                //onTap: signupuser,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Theme.of(context).colorScheme.tertiary)
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // signe in withe text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or Signe up with',
                        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // google option and apple
              Padding(
                padding: const EdgeInsets.all(12.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    GestureDetector(
                      //onTap: () => AuthService().signinwithgoogle(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Image.asset(
                          'lib/images/google.png',
                          height: 40,
                        ),
                      ),
                    ),

                    const SizedBox(width: 25),

                    // apple button
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Image.asset(
                        'lib/images/apple.png',
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),

              //allrady a meber
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Alredy a  member?',
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    //onTap:  widget.onTap ,
                    child: Text(
                      'Sigen in now!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
