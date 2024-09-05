import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WrapExampleChips extends HookConsumerWidget {
  const WrapExampleChips({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choiceChipSelected = useState(false);
    return Wrap(
      children: [
        ChoiceChip(
            selectedColor: Colors.red,
            disabledColor: Colors.blue,
            showCheckmark: false,
            label: Icon(Icons.ac_unit_outlined),
            selected: choiceChipSelected.value,
            onSelected: (selected) => choiceChipSelected.value = selected),
        Chip(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          label: Text('Simple Chip'),
          backgroundColor: Colors.white,
        ),
        ActionChip(label: Text('Retirer mes filtres'), onPressed: () => choiceChipSelected.value = false)
      ],
    );
  }
}
