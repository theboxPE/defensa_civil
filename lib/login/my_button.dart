import 'package:defensa_civil/voluntario.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          ),
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}


class MyButton2 extends StatelessWidget {
  
  const MyButton2({super.key, required RegisterForm onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No esta resgistrado?',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          'Registrar ahora',
          style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
