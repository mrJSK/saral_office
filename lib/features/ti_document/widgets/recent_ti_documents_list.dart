// lib/features/ti_document/widgets/recent_ti_documents_list.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';
import '../models/ti_document.dart';
import '../providers/ti_document_provider.dart';
import '../screens/create_ti_document_screen.dart';
import 'ti_document_card.dart';

class RecentTIDocumentsList extends ConsumerStatefulWidget {
  const RecentTIDocumentsList({super.key});

  @override
  ConsumerState<RecentTIDocumentsList> createState() =>
      _RecentTIDocumentsListState();
}

class _RecentTIDocumentsListState extends ConsumerState<RecentTIDocumentsList> {
  bool isSelectionMode = false;
  final Set<int> selectedIds = {};

  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      selectedIds.clear();
    });
  }

  void toggleItemSelection(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
        if (selectedIds.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        selectedIds.add(id);
      }
    });
  }

  // Handle long press to enter selection mode
  void handleLongPress(int id) {
    if (!isSelectionMode) {
      setState(() {
        isSelectionMode = true;
        selectedIds.add(id);
      });
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> deleteSelected() async {
    if (selectedIds.isEmpty) return;

    final confirm = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete TI Documents'),
        content: Text(
          'Are you sure you want to delete ${selectedIds.length} document${selectedIds.length > 1 ? 's' : ''}?',
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final isar = ref.read(isarProvider);
        await isar.writeTxn(() async {
          await isar.tIDocuments.deleteAll(selectedIds.toList());
        });

        // Refresh the list
        ref.invalidate(recentTIDocumentsProvider);

        toggleSelectionMode();
      } catch (e) {
        debugPrint('❌ Error deleting TI documents: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentsAsync = ref.watch(recentTIDocumentsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    CupertinoIcons.doc_append,
                    size: 20,
                    color: AppTheme.successGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  isSelectionMode && selectedIds.isNotEmpty
                      ? '${selectedIds.length} Selected'
                      : 'Recent TI Documents',
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Delete button (when items are selected)
                if (isSelectionMode && selectedIds.isNotEmpty)
                  CupertinoButton(
                    padding: const EdgeInsets.only(right: 16),
                    minSize: 0,
                    onPressed: deleteSelected,
                    child: const Icon(
                      CupertinoIcons.trash,
                      color: CupertinoColors.destructiveRed,
                      size: 22,
                    ),
                  ),
                // Select/Done button
                documentsAsync.maybeWhen(
                  data: (data) => data.isNotEmpty
                      ? CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          onPressed: toggleSelectionMode,
                          child: Text(
                            isSelectionMode ? 'Done' : 'Select',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isSelectionMode
                                  ? AppTheme.primaryBlue
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingM),

        // Documents List
        documentsAsync.when(
          data: (documents) {
            if (documents.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: documents.length > 5 ? 5 : documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final isSelected = selectedIds.contains(document.id);

                return TIDocumentCard(
                  document: document,
                  isSelectionMode: isSelectionMode,
                  isSelected: isSelected,
                  onTap: () {
                    if (isSelectionMode) {
                      toggleItemSelection(document.id);
                    } else {
                      _handleDocumentTap(context, document, ref);
                    }
                  },
                  onLongPress: () => handleLongPress(document.id),
                );
              },
            );
          },
          loading: () => _buildLoadingState(),
          error: (error, stack) => _buildErrorState(error.toString()),
        ),
      ],
    );
  }

  // Handle document tap - Load and navigate to edit screen
  void _handleDocumentTap(
    BuildContext context,
    TIDocument savedDocument,
    WidgetRef ref,
  ) {
    try {
      // Convert TIDocument to TIDocumentModel
      final documentModel = TIDocumentModel.fromIsarDocument(savedDocument);

      // Load into provider
      ref.read(tiDocumentProvider.notifier).load(documentModel);

      // Navigate to create screen (which will load the data)
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => const CreateTIDocumentScreen()),
      );
    } catch (e) {
      debugPrint('❌ Error loading TI document: $e');
    }
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.doc_append,
            size: 48,
            color: AppTheme.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'No TI Documents Yet',
            style: AppTheme.headline3.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Create your first TI document to get started',
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: const Center(child: CupertinoActivityIndicator(radius: 16)),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.errorRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: AppTheme.errorRed.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_triangle_fill,
            color: AppTheme.errorRed,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Failed to load TI documents',
              style: AppTheme.body2.copyWith(color: AppTheme.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}
