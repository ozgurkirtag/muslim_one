import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';
import '../../data/asma_names.dart';
import '../../models/asma_name.dart';
import 'asma_name_detail_screen.dart';

import '../../widgets/banner_ad_widget.dart';
class AsmaNamesScreen extends StatefulWidget {
  const AsmaNamesScreen({super.key});

  @override
  State<AsmaNamesScreen> createState() => _AsmaNamesScreenState();
}

class _AsmaNamesScreenState extends State<AsmaNamesScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  static const _titles = {
    'tr': 'Esmaül Hüsna',
    'en': 'Asma ul Husna',
    'ar': 'أسماء الله الحسنى',
    'fr': 'Les beaux noms d’Allah',
    'de': 'Die schönsten Namen Allahs',
    'es': 'Los bellos nombres de Allah',
    'id': 'Asmaul Husna',
    'ms': 'Asmaul Husna',
    'ur': 'اسمائے حسنیٰ',
    'ru': 'Прекрасные имена Аллаха',
  };

  static const _subtitles = {
    'tr': 'Allah’ın güzel isimlerini keşfet',
    'en': 'Discover the beautiful names of Allah',
    'ar': 'تعرّف على أسماء الله الحسنى',
    'fr': 'Découvrez les beaux noms d’Allah',
    'de': 'Entdecke die schönsten Namen Allahs',
    'es': 'Descubre los bellos nombres de Allah',
    'id': 'Pelajari nama-nama Allah yang indah',
    'ms': 'Kenali nama-nama Allah yang indah',
    'ur': 'اللہ کے خوبصورت نام جانیے',
    'ru': 'Познакомьтесь с прекрасными именами Аллаха',
  };

  static const _searchHints = {
    'tr': 'İsim veya anlam ara',
    'en': 'Search name or meaning',
    'ar': 'ابحث بالاسم أو المعنى',
    'fr': 'Rechercher un nom ou un sens',
    'de': 'Name oder Bedeutung suchen',
    'es': 'Buscar nombre o significado',
    'id': 'Cari nama atau arti',
    'ms': 'Cari nama atau maksud',
    'ur': 'نام یا معنی تلاش کریں',
    'ru': 'Поиск по имени или значению',
  };

  String _t(Map<String, String> values) {
    final code = AppLocalization.languageCode(context);
    return values[code] ?? values['en']!;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = AppLocalization.languageCode(context);
    final isRtl = code == 'ar' || code == 'ur';
    final normalizedQuery = AsmaName.normalizeSearch(_query);
    final allNames = <AsmaName>[featuredAllahName, ...asmaNames];

    final filtered = allNames
        .where((name) {
          if (normalizedQuery.isEmpty) return true;

          final meaning = AsmaName.normalizeSearch(name.meaning(context));

          return name.arabic.contains(_query.trim()) ||
              name.searchableText.contains(normalizedQuery) ||
              meaning.contains(normalizedQuery);
        })
        .toList(growable: false);

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        bottomNavigationBar: const SafeArea(
          top: false,
          child: BannerAdWidget(),
        ),
        appBar: AppBar(title: Text(_t(_titles))),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
              sliver: SliverToBoxAdapter(
                child: _Header(title: _t(_titles), subtitle: _t(_subtitles)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: _t(_searchHints),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.gold,
                    ),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                    filled: true,
                    fillColor: AppColors.surface,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: AppColors.goldDark),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: AppColors.gold,
                        width: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverGrid.builder(
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.86,
                ),
                itemBuilder: (context, index) =>
                    _NameCard(name: filtered[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceSoft, AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.goldDark),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withValues(alpha: 0.12),
              border: Border.all(color: AppColors.goldDark),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.goldLight,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NameCard extends StatelessWidget {
  const _NameCard({required this.name});
  final AsmaName name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => AsmaNameDetailScreen(name: name),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold.withValues(alpha: 0.13),
                    border: Border.all(color: AppColors.goldDark),
                  ),
                  child: name.isFeatured
                      ? const Icon(
                          Icons.star_rounded,
                          color: AppColors.goldLight,
                          size: 17,
                        )
                      : Text(
                          '${name.number}',
                          style: const TextStyle(
                            color: AppColors.goldLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              ),
              const Spacer(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  name.arabic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 26,
                    height: 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name.displayName(context),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                name.meaning(context),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
