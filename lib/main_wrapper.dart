import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_play/provider/grid_provider.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final gridProvider = context.watch<GridProvider>();
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            const double controlsHeight = 160;
            final double gridSize = min(
              maxWidth,
              maxHeight - controlsHeight,
            ).clamp(100.0, maxWidth);

            return Column(
              children: [
                SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: gridSize,
                    height: gridSize,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: GridProvider.gridCount,
                            childAspectRatio: 1.0,
                          ),
                      itemCount: GridProvider.totalCells,
                      itemBuilder: (context, index) {
                        final bool isActive = index == gridProvider.activeIndex;
                        return Padding(
                          padding: EdgeInsets.all(1.0),
                          child: AnimatedContainer(
                            duration: const Duration(microseconds: 150),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              color:
                                  isActive ? Colors.blue : Colors.grey.shade400,
                              borderRadius:
                                  isActive
                                      ? BorderRadius.circular(6)
                                      : BorderRadius.zero,
                            ),
                            child: Center(
                              child:
                                  isActive
                                      ? Container(color: Colors.blue)
                                      : SizedBox.shrink(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Spacer(),

                /// Controller
                SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 36,
                        onPressed: gridProvider.moveUp,
                        icon: const Icon(Icons.arrow_upward),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 36,
                            onPressed: gridProvider.moveLeft,
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            iconSize: 36,
                            onPressed: gridProvider.moveDown,
                            icon: const Icon(Icons.arrow_downward),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            iconSize: 36,
                            onPressed: gridProvider.moveRight,
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
