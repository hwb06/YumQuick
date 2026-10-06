import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_event.dart';
import '../bloc/home_bloc/home_state.dart';
import '../data/models/food_summary.dart';
import '../data/models/home_data.dart';
import '../data/network/api_client.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_extensions.dart';
import '../helpers/app_routes.dart';
import '../helpers/app_strings.dart';
import '../helpers/app_styles.dart';
import '../widgets/app_widgets/app_bottom_nav.dart';
import '../widgets/app_widgets/error_view.dart';
import '../widgets/home_widget/best_seller_list.dart';
import '../widgets/home_widget/category_row.dart';
import '../widgets/home_widget/home_header.dart';
import '../widgets/home_widget/promo_banner.dart';
import '../widgets/home_widget/recommend_card.dart';
import '../widgets/home_widget/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(ApiClient())..add(const HomeStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _tab = 0;

  void _openDetails(FoodSummary f) =>
      Navigator.pushNamed(context, AppRoutes.details, arguments: f.id);

  void _snack(String msg) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));

  Future<void> _logout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to log in again.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Log out')),
        ],
      ),
    );
    if (ok != true) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.welcome, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isHome = _tab == 0;

    return Scaffold(
      backgroundColor: isHome ? AppColors.secondary : AppColors.surface,
      body: isHome
          ? Column(
        children: [
          HomeHeader(
            onCartTap: () => _snack('Cart: coming soon'),
            onBellTap: () => _snack('Notifications: coming soon'),
            onProfileTap: _logout,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: _body(context),
            ),
          ),
        ],
      )
          : SafeArea(
        child: Center(
          child: Text('Coming soon', style: AppStyles.heading(size: context.sp(18))),
        ),
      ),
      bottomNavigationBar: ColoredBox(
        color: AppColors.surface,
        child: AppBottomNav(currentIndex: _tab, onTap: (i) => setState(() => _tab = i)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (p, c) => c.status == HomeStatus.failure && c.data != null,
      listener: (_, state) => _snack(state.error ?? 'Refresh failed'),
      builder: (context, state) {
        if (state.data != null) return _content(context, state.data!);
        if (state.status == HomeStatus.failure) {
          return ErrorView(
            message: state.error ?? 'Something went wrong',
            onRetry: () => context.read<HomeBloc>().add(const HomeStarted()),
          );
        }
        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
      },
    );
  }

  Widget _content(BuildContext context, HomeData d) {
    final bloc = context.read<HomeBloc>();
    final pad = EdgeInsets.symmetric(horizontal: context.pagePad);


    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        bloc.add(const HomeRefreshed());
        await bloc.stream.firstWhere((s) => s.status != HomeStatus.loading);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: context.h(16)),
        children: [
          Padding(
            padding: pad,
            child: CategoryRow(
              categories: d.categories,
              showLabels: true,
              onTap: (c) => Navigator.pushNamed(context, AppRoutes.category, arguments: c.id),
            ),
          ),
          12.vGap,
          Padding(padding: pad, child: const Divider(height: 1, color: AppColors.chipBg)),
          12.vGap,
          Padding(
            padding: pad,
            child: SectionHeader(
              title: AppStrings.bestSeller,
              onViewAll: () => Navigator.pushNamed(context, AppRoutes.category, arguments: 'all'),
            ),
          ),
          10.vGap,
          BestSellerList(items: d.bestSellers, onTap: _openDetails),
          context.h(16).vGap,
          PromoBanner(items: d.promos),
          context.h(16).vGap,
          Padding(padding: pad, child: const SectionHeader(title: AppStrings.recommend)),
          10.vGap,
          Padding(
            padding: pad,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              mainAxisSpacing: context.w(12),
              crossAxisSpacing: context.w(12),
              childAspectRatio: 1.0,
              children: d.recommended
                  .map((f) => RecommendCard(food: f, onTap: () => _openDetails(f)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}