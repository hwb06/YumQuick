import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category_bloc/category_bloc.dart';
import '../bloc/category_bloc/category_event.dart';
import '../bloc/category_bloc/category_state.dart';
import '../data/network/api_client.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_extensions.dart';
import '../helpers/app_routes.dart';
import '../helpers/app_styles.dart';
import '../widgets/app_widgets/app_bottom_nav.dart';
import '../widgets/app_widgets/error_view.dart';
import '../widgets/app_widgets/food_list_card.dart';
import '../widgets/home_widget/category_row.dart';
import '../widgets/home_widget/home_header.dart';

class CategoryScreen extends StatelessWidget {
  final String initialCategoryId;

  const CategoryScreen({super.key, required this.initialCategoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc(ApiClient())..add(CategoryStarted(initialCategoryId)),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView();

  void _snack(BuildContext c, String m) => ScaffoldMessenger.of(c)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          HomeHeader(
            showGreeting: false,
            onCartTap: () => _snack(context, 'Cart: coming soon'),
            onBellTap: () => _snack(context, 'Notifications: coming soon'),
            onProfileTap: () => _snack(context, 'Profile: coming soon'),
          ),
          Expanded(child: BlocBuilder<CategoryBloc, CategoryState>(builder: _content)),
        ],
      ),
      bottomNavigationBar: ColoredBox(
        color: AppColors.surface,
        child: AppBottomNav(
          currentIndex: -1,
          onTap: (i) => handleSubScreenNavTap(context, i),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, CategoryState s) {
    final bloc = context.read<CategoryBloc>();

    if (s.categories.isEmpty) {
      return _Sheet(
        child: s.status == CategoryStatus.failure
            ? ErrorView(
          message: s.error ?? 'Something went wrong',
          onRetry: () => bloc.add(CategoryStarted(s.selectedId)),
        )
            : const _Loader(),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(context.w(16), context.h(14), context.w(16), context.h(14)),
            child: CategoryRow(
              categories: s.categories,
              selectedId: s.selectedId,
              showLabels: false,
              onTap: (c) => bloc.add(CategorySelected(c.id)),
            ),
          ),
          Expanded(
            child: _Sheet(
              child: Column(
                children: [
                  _sortRow(context, s, bloc),
                  Expanded(child: _list(context, s, bloc)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortRow(BuildContext context, CategoryState s, CategoryBloc bloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(context.w(16), context.h(14), context.w(16), 6),
      child: Row(
        children: [
          Text('Sort By: ', style: AppStyles.body(size: context.sp(11), color: AppColors.textGrey)),
          PopupMenuButton<SortOption>(
            initialValue: s.sort,
            onSelected: (v) => bloc.add(CategorySortChanged(v)),
            itemBuilder: (_) => SortOption.values
                .map((o) => PopupMenuItem(value: o, child: Text(o.label)))
                .toList(),
            child: Text(s.sort.label, style: AppStyles.link(size: context.sp(11))),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _snack(context, 'Filters: coming soon'),
            child: Container(
              width: context.w(26),
              height: context.w(26),
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: Icon(Icons.tune_rounded, color: AppColors.white, size: context.w(14)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context, CategoryState s, CategoryBloc bloc) {
    if (s.status == CategoryStatus.loading) return const _Loader();
    if (s.status == CategoryStatus.failure) {
      return ErrorView(
        message: s.error ?? 'Something went wrong',
        onRetry: () => bloc.add(CategorySelected(s.selectedId)),
      );
    }
    if (s.foods.isEmpty) {
      return Center(child: Text('No items found', style: AppStyles.body(size: context.sp(14))));
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(context.w(16), 8, context.w(16), 16),
      itemCount: s.foods.length,
      separatorBuilder: (_, __) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1, color: AppColors.chipBg),
      ),
      itemBuilder: (_, i) => FoodListCard(
        food: s.foods[i],
        onTap: () => Navigator.pushNamed(context, AppRoutes.details, arguments: s.foods[i].id),
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  final Widget child;
  const _Sheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: child,
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: AppColors.primary));
}