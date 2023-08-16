import 'package:al_dana/app/data/data.dart';
import 'package:al_dana/app/modules/rewards/provider/reward_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewaardView extends StatefulWidget {
  const RewaardView({
    super.key,
    required this.customerId,
  });
  final String customerId;
  @override
  State<RewaardView> createState() => _RewaardViewState();
}

class _RewaardViewState extends State<RewaardView> {
  @override
  void initState() {
    super.initState();
    Provider.of<RewardProvider>(context, listen: false)
        .fetchReward(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Rewards'),
      ),
      body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.military_tech,
                size: 30,
                color: primary,
              ),
              const Text(
                'Your Reward Points',
                style: TextStyle(
                  fontSize: 30,
                  color: primary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<RewardProvider>(context)
                        .reward
                        ?.data
                        ?.rewardPoint
                        .toString() ??
                    '',
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}
