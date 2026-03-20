// lib/features/procurement/screens/pr_line_items_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';
import '../models/purchase_requisition.dart';
import 'pr_export_screen.dart';
import 'pr_line_item_form_screen.dart';

class PRLineItemsScreen extends ConsumerStatefulWidget {
  final String prNumber;

  const PRLineItemsScreen({super.key, required this.prNumber});

  @override
  ConsumerState<PRLineItemsScreen> createState() => _PRLineItemsScreenState();
}

class _PRLineItemsScreenState extends ConsumerState<PRLineItemsScreen> {
  List<PRLineItem> _items = [];
  PurchaseRequisition? _pr;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prService = ref.read(prServiceProvider);
    final data = await prService.getPRWithItems(widget.prNumber);

    setState(() {
      _pr = data['pr'] as PurchaseRequisition?;
      _items = data['items'] as List<PRLineItem>;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: Text('PR ${_pr?.displayNumber ?? ''}'),
        trailing: _pr != null
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _navigateToExport(),
                child: const Icon(CupertinoIcons.share),
              )
            : null,
      ),
      child: _isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: Column(
                children: [
                  _buildHeaderInfo(),
                  Expanded(
                    child: _items.isEmpty
                        ? _buildEmptyState()
                        : _buildItemsList(),
                  ),
                  _buildBottomActions(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeaderInfo() {
    if (_pr == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _pr!.documentType,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryBlue,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _pr!.documentTypeDescription,
                  style: AppTheme.body2.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Purchase Group', _pr!.purchasingGroup),
          if (_pr!.requisitioner != null) ...[
            const SizedBox(height: 6),
            _buildInfoRow('Requisitioner', _pr!.requisitioner!),
          ],
          const SizedBox(height: 6),
          _buildInfoRow('Created', _formatDate(_pr!.createdAt!)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label:',
          style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: AppTheme.body2.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.square_list,
            size: 64,
            color: AppTheme.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'No line items yet',
            style: AppTheme.body1.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap "Add Item" to get started',
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spacingM),
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildItemCard(item, index);
      },
    );
  }

  Widget _buildItemCard(PRLineItem item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusMedium - 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Item ${item.itemNumber}',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.surfaceWhite,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (item.isService) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'SERVICE',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.successGreen,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
                if (item.isAsset) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.warningOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ASSET',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.warningOrange,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () => _editItem(index),
                  child: const Icon(
                    CupertinoIcons.pencil,
                    size: 18,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                const SizedBox(width: 8),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () => _deleteItem(index),
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 18,
                    color: AppTheme.errorRed,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.material != null) ...[
                  _buildItemDetailRow('Material', item.material!),
                  const SizedBox(height: 8),
                ],
                _buildItemDetailRow('Description', item.shortText),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildItemDetailRow(
                        'Quantity',
                        '${item.quantity} ${item.unit}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildItemDetailRow(
                        'Price',
                        '${item.currency} ${item.valuationPrice.toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildItemDetailRow(
                  'Total Value',
                  '${item.currency} ${item.totalValue.toStringAsFixed(2)}',
                  isBold: true,
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildItemDetailRow('Plant', item.plant)),
                    if (item.storageLocation != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildItemDetailRow(
                          'SLoc',
                          item.storageLocation!,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                _buildItemDetailRow(
                  'Delivery Date',
                  _formatDate(item.deliveryDate!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemDetailRow(
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: AppTheme.textPrimary,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        border: Border(top: BorderSide(color: AppTheme.dividerColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: AppTheme.primaryBlue,
                borderRadius: BorderRadius.circular(10),
                onPressed: _addItem,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.add,
                      size: 20,
                      color: AppTheme.surfaceWhite, // ADD THIS LINE
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Add Item',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.surfaceWhite, // ADD THIS LINE
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_items.isNotEmpty) ...[
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: AppTheme.successGreen,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: _navigateToExport,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.checkmark_alt,
                        size: 20,
                        color: AppTheme.surfaceWhite, // ADD THIS LINE
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Complete',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.surfaceWhite, // ADD THIS LINE
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _addItem() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => PRLineItemFormScreen(
          prNumber: widget.prNumber,
          itemNumber: _items.isEmpty ? 10 : (_items.last.itemNumber + 10),
        ),
      ),
    ).then((_) => _loadData());
  }

  void _editItem(int index) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => PRLineItemFormScreen(
          prNumber: widget.prNumber,
          itemNumber: _items[index].itemNumber,
          existingItem: _items[index],
        ),
      ),
    ).then((_) => _loadData());
  }

  void _deleteItem(int index) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Item'),
        content: Text(
          'Are you sure you want to delete item ${_items[index].itemNumber}?',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
              final prService = ref.read(prServiceProvider);
              await prService.deleteLineItem(_items[index].id);
              _loadData();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _navigateToExport() {
    if (_items.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Items'),
          content: const Text(
            'Please add at least one line item before exporting.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => PRExportScreen(prNumber: widget.prNumber),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
