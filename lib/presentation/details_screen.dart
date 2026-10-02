import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc/cart_cubit.dart';
import '../bloc/details_bloc/details_bloc.dart';
import '../bloc/details_bloc/details_event.dart';
import '../bloc/details_bloc/details_state.dart';
import '../data/models/topping.dart';
import '../data/network/api_client.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_extensions.dart';
import '../helpers/app_strings.dart';
import '../helpers/app_styles.dart';
import '../widgets/app_widgets/app_bottom_nav.dart';
import '../widgets/app_widgets/app_buttons.dart';
import '../widgets/app_widgets/error_view.dart';
import '../widgets/app_widgets/food_image.dart';
import '../widgets/app_widgets/rating_badge.dart';

class DetailsScreen extends StatelessWidget {
  final String foodId;

  const DetailsScreen({super.key, required this.foodId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsBloc(ApiClient())..add(DetailsStarted(foodId)),
      child: _DetailsView(foodId: foodId),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final String foodId;

  const _DetailsView({required this.foodId});

  void _addToCart(BuildContext context, DetailsState s) {
    final food = s.food!;
    context.read<CartCubit>().add(CartItem(
      foodId: food.id,
      name: food.name,
      image: food.image,
      qty: s.qty,
      unitPrice: s.unitPrice,
      toppings: s.selectedToppings.map((t) => t.name).toList(),
    ));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${s.qty} × ${food.name} added to cart')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, s) => Scaffold(
        backgroundColor: AppColors.secondary,
        body: Column(
          children: [
            _Header(state: s),
            Expanded(
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: _body(context, s),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ColoredBox(
          color: AppColors.surface,
          child: AppBottomNav(
            currentIndex: -1,
            onTap: (i) => handleSubScreenNavTap(context, i),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, DetailsState s) {
    final bloc = context.read<DetailsBloc>();

    if (s.status == DetailsStatus.failure) {
      return ErrorView(
        message: s.error ?? 'Something went wrong',
        onRetry: () => bloc.add(DetailsStarted(foodId)),
      );
    }
    final food = s.food;
    if (food == null) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(context.w(20), context.h(20), context.w(20), context.h(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodImage(src: food.image, width: double.infinity, height: context.w(190), radius: 22),
                context.h(14).vGap,
                Row(
                  children: [
                    Text('\$${s.total.toStringAsFixed(2)}',
                        style: AppStyles.heading(size: context.sp(22)).copyWith(color: AppColors.primary)),
                    const Spacer(),
                    _QtyStepper(
                      qty: s.qty,
                      onMinus: () => bloc.add(const DetailsQtyDecremented()),
                      onPlus: () => bloc.add(const DetailsQtyIncremented()),
                    ),
                  ],
                ),
                10.vGap,
                Text(food.name, style: AppStyles.heading(size: context.sp(15))),
                4.vGap,
                Text(food.description,
                    style: AppStyles.body(size: context.sp(11), color: AppColors.textGrey)),
                context.h(14).vGap,
                const Divider(height: 1, color: AppColors.chipBg),
                context.h(12).vGap,
                Text(food.optionsTitle, style: AppStyles.heading(size: context.sp(16))),
                6.vGap,
                ...food.toppings.map((t) => _ToppingTile(
                  topping: t,
                  selected: s.selectedIds.contains(t.id),
                  onTap: () => bloc.add(DetailsToppingToggled(t.id)),
                )),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, context.h(6), 0, context.h(14)),
          child: AppButton(
            label: AppStrings.addToCart,
            width: 200,
            onPressed: () => _addToCart(context, s),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final DetailsState state;

  const _Header({required this.state});

  @override
  Widget build(BuildContext context) {
    final food = state.food;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(context.w(8), context.h(8), context.w(16), context.h(20)),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 16),
            ),
            Expanded(
              child: food == null
                  ? const SizedBox.shrink()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(food.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.title(size: context.sp(20))),
                  ),
                  8.hGap,
                  RatingBadge(rating: food.rating),
                ],
              ),
            ),
            GestureDetector(
              onTap: food == null
                  ? null
                  : () => context.read<DetailsBloc>().add(const DetailsFavoriteToggled()),
              child: Container(
                width: context.w(32),
                height: context.w(32),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  state.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: AppColors.primary,
                  size: context.w(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _QtyStepper({required this.qty, required this.onMinus, required this.onPlus});

  Widget _btn(BuildContext context, IconData icon, VoidCallback onTap, {bool enabled = true}) =>
      GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: context.w(24),
          height: context.w(24),
          decoration: BoxDecoration(
            color: enabled ? AppColors.primary : AppColors.peach,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: context.w(14), color: enabled ? AppColors.white : AppColors.primary),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _btn(context, Icons.remove, onMinus, enabled: qty > 1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(12)),
          child: Text('$qty', style: AppStyles.heading(size: context.sp(15))),
        ),
        _btn(context, Icons.add, onPlus),
      ],
    );
  }
}

class _ToppingTile extends StatelessWidget {
  final Topping topping;
  final bool selected;
  final VoidCallback onTap;

  const _ToppingTile({required this.topping, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.w(8)),
        child: Row(
          children: [
            Expanded(child: Text(topping.name, style: AppStyles.body(size: context.sp(12)))),
            Text('\$${topping.price.toStringAsFixed(2)}',
                style: AppStyles.body(size: context.sp(11), color: AppColors.textGrey)),
            context.w(10).hGap,
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: context.w(18),
              height: context.w(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.primary : Colors.transparent,
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: selected
                  ? Icon(Icons.check, size: context.w(12), color: AppColors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}