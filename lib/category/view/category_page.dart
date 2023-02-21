import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/category/category.dart';
import 'package:pos_repository/pos_repository.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryPageBloc(posRepository: context.read<PosRepository>())
            ..add(const CategorySubscriptionRequested()),
      child: const CategoryList(),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(CategoryItem.route()),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoryPageBloc, CategoryPageState>(
          builder: (context, state) {
        if (state.categories.isEmpty) {
          if (state.status == CategoryStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state.status != CategoryStatus.success) {
            return const SizedBox();
          } else {
            return const Center(
              child: Text('There is no category'),
            );
          }
        }
        return ListView(
          children: [
            for (final category in state.categories)
              Dismissible(
                  onDismissed: (_) => context
                      .read<CategoryPageBloc>()
                      .add(CategoryDeleted(category)),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Theme.of(context).colorScheme.error,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Color(0xAAFFFFFF),
                    ),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(CategoryItem.route(initialCategory: category)),
                    title: Text(category.name),
                    trailing: Text(category.description),
                  ))
          ],
        );
      }),
    );
  }
}
//
// Future<void> _dialogBuilder(BuildContext context, {Category? initialCategory}) {
//   // final status = context.select((CategoryDialogBloc bloc) => bloc.state.status);
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return BlocProvider(
//         create: (context) => CategoryItemBloc(
//             posReopository: context.read<PosReopository>(),
//             initialCategory: null),
//         child: AlertDialog(
//           title: const Text('Category'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [_NameField(), _DescField()],
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             const _SaveButton(),
//           ],
//         ),
//       );
//     },
//   );
// }
//
// class _NameField extends StatelessWidget {
//   const _NameField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<CategoryItemBloc>().state;
//     return TextFormField(
//       key: UniqueKey(),
//       initialValue: state.name,
//       onChanged: (value) =>
//           context.read<CategoryItemBloc>().add(CategoryNameChanged(value)),
//     );
//   }
// }
//
// class _DescField extends StatelessWidget {
//   const _DescField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<CategoryItemBloc>().state;
//     return TextFormField(
//       keyboardType: TextInputType.multiline,
//       minLines: 1,
//       maxLines: 3,
//       key: UniqueKey(),
//       initialValue: state.description,
//       onChanged: (value) =>
//           context.read<CategoryItemBloc>().add(CategoryDescChanged(value)),
//     );
//   }
// }
//
// class _SaveButton extends StatelessWidget {
//   const _SaveButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         textStyle: Theme.of(context).textTheme.labelLarge,
//       ),
//       child: const Text('Save'),
//       onPressed: () {
//         context
//             .read<CategoryItemBloc>()
//             .add(const CategorySubmitted());
//         Navigator.of(context).pop();
//       },
//     );
//   }
// }