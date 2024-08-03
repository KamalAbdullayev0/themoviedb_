import 'package:flutter/material.dart';
import 'package:themoviedb/Theme/app_button_style.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login to your account',
            style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 20),
          _FormWidget(),
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textstyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
            style: textstyle,
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: Text('Register'),
          ),
          SizedBox(height: 25),
          Text(
            'If you signed up but didnt get your verification email',
            style: textstyle,
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: Text('Verify email'),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({super.key});

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin');

  String? errorText = null;
  void _auth() {
    final login = _loginController.text;
    final password = _passwordController.text;

    if (login.isEmpty || password.isEmpty) {
      errorText = null;
      print('Empty fields');
      return;
    }
    if (login == 'admin' && password == 'admin') {
      Navigator.of(context).pushReplacementNamed('/main_screen');
      errorText = null;
    } else {
      errorText = 'Wrong login or password';
      print('Wrong login or password');
    }
    setState(() {});
  }

  void _resetPassword() {
    print('Reset password');
  }

  @override
  Widget build(BuildContext context) {
    const textstyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );

    //final color = const Color(0xFF01B4E6);
    const textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errorText != null) ...[
            Text(
              'Wrong login or password',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
          Text("Username", style: textstyle),
          SizedBox(height: 5),
          TextField(
            controller: _loginController,
            decoration: textFieldDecoration,
          ),
          SizedBox(height: 20),
          Text("Password", style: textstyle),
          SizedBox(height: 5),
          TextField(
            controller: _passwordController,
            decoration: textFieldDecoration,
            obscureText: true,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: _auth,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  ),
                ),
                child: Text('Login'),
              ),
              SizedBox(width: 10),
              TextButton(
                onPressed: _resetPassword,
                style: AppButtonStyle.linkButton,
                child: Text('Reset password'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
