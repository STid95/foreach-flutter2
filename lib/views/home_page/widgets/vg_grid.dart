import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/logics/videogame_list_provider.dart';
import 'package:untitled2/models/game_type.dart';
import 'package:untitled2/models/video_game.dart';
import 'package:untitled2/views/home_page/widgets/filter_wrap.dart';
import 'package:untitled2/views/home_page/widgets/wrap_example_chips.dart';

import 'games_grid_view.dart';

class VGGrid extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useMemoized(() => ref.watch(videoGameListProvider.notifier).initialize());

    return Column(
      children: [
        const WrapExampleChips(),
        AddBtn(
          onAdd: () => ref.read(videoGameListProvider.notifier).add(
                //Cela va ainsi faire automatiquement rebuild mon grid
                VideoGame(
                  name: "WoW",
                  grade: 5.0,
                  types: [GameType.RPG],
                ),
              ),
        ),
        FilterWrap(
            onChipSelected: (isSelected, type) =>
                ref.read(filteredVideoGameListProvider.notifier).filterList(isSelected, type)),
        const GamesGridView(),
      ],
    );
  }
}

class AddBtn extends StatelessWidget {
  final void Function() onAdd;
  const AddBtn({
    required this.onAdd,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Add Videogame'),
      onPressed: onAdd,
    );
  }
}
