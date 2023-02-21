import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/category/category.dart';
import 'package:pos_repository/pos_repository.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);

  static Route<void> route({Category? initialCategory}) {
    return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => CategoryItemBloc(
              posReopository: context.read<PosRepository>(),
              initialCategory: initialCategory),
          child: const CategoryItem(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryItemBloc, CategoryItemState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          current.status == CategoryItemStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const CategoryItemDetails(),
    );
  }
}

class CategoryItemDetails extends StatelessWidget {
  const CategoryItemDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNewContact =
    context.select((CategoryItemBloc bloc) => bloc.state.isNewCategory);
    final status = context.select((CategoryItemBloc bloc) => bloc.state.status);
    return Scaffold(
      appBar: AppBar(
        title: isNewContact
            ? const Text("Add Category")
            : const Text("Edit Category"),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                _NameField(),
                _DescField(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<CategoryItemBloc>().add(const CategorySubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
    );
  }
}

// Future<void> dialogBuilder(BuildContext context, {Category? initialCategory}) {
//   // final status = context.select((CategoryDialogBloc bloc) => bloc.state.status);
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return BlocProvider(
//           create: (BuildContext context) => CategoryDialogBloc(
//               posReopository: context.read<PosReopository>(),
//               initialCategory: initialCategory),
//           child: SizedBox(
//             height: 150,
//             child: AlertDialog(
//               title: const Text('Category'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [_NameField(), _DescField()],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: Theme.of(context).textTheme.labelLarge,
//                   ),
//                   child: const Text('Cancel'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     textStyle: Theme.of(context).textTheme.labelLarge,
//                   ),
//                   child: const Text('Save'),
//                   onPressed: () {
//                     context
//                         .read<CategoryDialogBloc>()
//                         .add(const CategorySubmitted());
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ));
//     },
//   );
// }

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoryItemBloc>().state;
    return TextFormField(
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Category Name',
        // hintText:'Enter category name',
      ),
      initialValue: state.name,
      onChanged: (value) =>
          context.read<CategoryItemBloc>().add(CategoryNameChanged(value)),
    );
  }
}

class _DescField extends StatelessWidget {
  const _DescField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoryItemBloc>().state;
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Category Description',
        // hintText:'Enter category description',
      ),
      initialValue: state.description,
      onChanged: (value) =>
          context.read<CategoryItemBloc>().add(CategoryDescChanged(value)),
    );
  }
}
