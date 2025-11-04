import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_app/task/domain/entities/author/doc_entity.dart';

import '../../../di.dart';
import '../bloc/authors/authors_bloc.dart';
import 'author_details_page.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Authors', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: BlocProvider(create: (context) => sl<AuthorsBloc>(), child: const _AuthorsPageContent()),
    );
  }
}

// Content Widget
class _AuthorsPageContent extends StatelessWidget {
  const _AuthorsPageContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              const _SearchBar(),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.withValues(alpha: 0.1), Colors.grey.withValues(alpha: 0.05)],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: BlocBuilder<AuthorsBloc, AuthorsState>(
              builder: (context, state) {
                return _AuthorsStateHandler(state: state);
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Modern Search Bar
class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _searchController = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<AuthorsBloc>().add(AuthorsLoadEvent(searchQuery: query));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Focus(
        onFocusChange: (focused) {
          setState(() => _isFocused = focused);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isFocused ? Theme.of(context).primaryColor.withValues(alpha: 0.5) : Colors.transparent,
              width: 2,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 16),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Search authors...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              
              prefixIcon: Icon(
                Icons.search_rounded,
                color: _isFocused ? Theme.of(context).primaryColor : Colors.grey[400],
                size: 24,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear_rounded, color: Colors.grey[600]),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            onChanged: _onSearchChanged,
          ),
        ),
      ),
    );
  }
}

// State Handler
class _AuthorsStateHandler extends StatelessWidget {
  final AuthorsState state;

  const _AuthorsStateHandler({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is AuthorsInitialState) {
      return _AuthorsInitialState(message: "Start typing to search");
    }
    if (state is AuthorsLoadingState) {
      return const _ShimmerLoadingView();
    } else if (state is AuthorsLoadedState) {
      return _AuthorsListView(authors: (state as AuthorsLoadedState).authorResponse.docs ?? []);
    } else if (state is AuthorsErrorState) {
      return _ErrorView(message: (state as AuthorsErrorState).error);
    }
    return const SizedBox.shrink();
  }
}

// Shimmer Loading View
class _ShimmerLoadingView extends StatelessWidget {
  const _ShimmerLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                // Avatar shimmer
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                ),
                const SizedBox(width: 16),
                // Text shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 14,
                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Authors List View
class _AuthorsListView extends StatelessWidget {
  final List<DocEntity> authors;

  const _AuthorsListView({required this.authors});

  @override
  Widget build(BuildContext context) {
    if (authors.isEmpty) {
      return const _EmptyView();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<AuthorsBloc>().add(AuthorsLoadEvent(searchQuery: ""));
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: Theme.of(context).primaryColor,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: authors.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _AuthorCard(author: authors[index], index: index);
        },
      ),
    );
  }
}

// Empty View
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.people_outline_rounded, size: 64, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          Text(
            'No authors found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text('Try adjusting your search', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

// Modern Author Card
class _AuthorCard extends StatelessWidget {
  final DocEntity author;
  final int index;

  const _AuthorCard({required this.author, required this.index});

  Color _getAvatarColor(int index) {
    final colors = [Colors.blue, Colors.purple, Colors.orange, Colors.teal, Colors.pink, Colors.indigo];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final avatarColor = _getAvatarColor(index);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetailsPage(author: author, color: avatarColor)));
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [avatarColor, avatarColor.withValues(alpha: 0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: avatarColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        (author.name?[0] ?? ""),
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author.name ?? "-",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(

                              child: Text(
                                author.birthDate ?? "",
                                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.cloud_off_rounded, size: 64, color: Colors.red[400]),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600], height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.read<AuthorsBloc>().add(AuthorsLoadEvent(searchQuery: ""));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.refresh_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('Try Again', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthorsInitialState extends StatelessWidget {
  final String message;

  const _AuthorsInitialState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.search_rounded, size: 64, color: Colors.blue[400]),
            ),
            const SizedBox(height: 24),
            Text(
              'Input something to search',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600], height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.read<AuthorsBloc>().add(AuthorsLoadEvent(searchQuery: ""));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.refresh_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('Try Again', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
