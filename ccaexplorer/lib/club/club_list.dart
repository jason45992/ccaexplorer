import 'package:ccaexplorer/club/club_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ccaexplorer/event_list/event_app_theme.dart';
import 'package:ccaexplorer/club/club_data.dart';

class ClubHomeScreen extends StatefulWidget {
  @override
  _ClubHomeScreenState createState() => _ClubHomeScreenState();
}

class _ClubHomeScreenState extends State<ClubHomeScreen>
    with SingleTickerProviderStateMixin {
  final _bloc = ClubBloc();

  void initState() {
    _bloc.init(this);
    super.initState();
  }

  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _bloc,
          builder: (_, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.white,
                  height: 80,
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'CCA and Clubs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: 0.27,
                            color: EventAppTheme.darkerText,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  )),
              Container(
                height: 60,
                child: TabBar(
                  onTap: _bloc.onCategorySelected,
                  controller: _bloc.tabController,
                  indicatorWeight: 0.1,
                  isScrollable: true,
                  tabs: _bloc.tabs.map((e) => _TabWidget(e)).toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _bloc.scrollController,
                  itemCount: _bloc.items.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = _bloc.items[index];
                    if (item.isCategory) {
                      return _CategoryItem(item.category);
                    } else {
                      return _ClubItem(item.club);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabWidget extends StatelessWidget {
  const _TabWidget(this.tabCategory);
  final TabCategory tabCategory;

  Widget build(BuildContext context) {
    final selected = tabCategory.selected;
    return Opacity(
      opacity: selected ? 1 : 0.5,
      child: Card(
        elevation: selected ? 6 : 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tabCategory.category.name,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem(this.category);
  final ClubCategory category;

  Widget build(BuildContext context) {
    return Container(
      height: categoryHeight,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(
        category.name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.27,
          color: EventAppTheme.darkerText,
        ),
      ),
    );
  }
}

class _ClubItem extends StatelessWidget {
  const _ClubItem(this.club);
  final Club club;

  Widget build(BuildContext context) {
    return Container(
      height: clubHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          elevation: 6,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(club.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  club.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: EventAppTheme.darkerText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
