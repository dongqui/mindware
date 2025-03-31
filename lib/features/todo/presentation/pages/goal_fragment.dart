import 'package:flutter/material.dart';

class GoalFragment extends StatelessWidget {
  const GoalFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "1. 나는 2025년 6월 78kg의 근육질 몸매를 가졌다",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "2. 나는 2025년 12월 어려보이고 깔끔한 피부를 가졌다.",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "3. 나는 2025년 패시브 수익이 발생하는 서비스를 개발했다.",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "4. 나는 2025년 부터 최소 월 1000만원 이상 패시브 수익 발생하고 있다",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "5. 나는 월 1억 이상 가능한 투자 실력을 지녔다",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "6. 2025년 순자산 2억을 돌파 했다!!",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
              Text(
                "7. 2025년 이쁘고 귀엽고 착하고 똑똑한 여자친구를 만나서 감사한다",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
