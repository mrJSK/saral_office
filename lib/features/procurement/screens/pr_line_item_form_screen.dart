// lib/features/procurement/screens/pr_line_item_form_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saral_office/features/procurement/screens/pr_creation_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/material_search_field.dart';
import '../../../core/widgets/service_search_field.dart';
import '../../../core/database/models/material_master.dart';
import '../../../core/database/models/service_master.dart';
import '../models/purchase_requisition.dart';
import '../services/pr_service.dart';

class PRLineItemFormScreen extends ConsumerStatefulWidget {
  final String prNumber;
  final int itemNumber;
  final PRLineItem? existingItem;

  const PRLineItemFormScreen({
    super.key,
    required this.prNumber,
    required this.itemNumber,
    this.existingItem,
  });

  @override
  ConsumerState<PRLineItemFormScreen> createState() =>
      _PRLineItemFormScreenState();
}

class _PRLineItemFormScreenState extends ConsumerState<PRLineItemFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _shortTextController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _plantController = TextEditingController();
  final _storageLocationController = TextEditingController();
  final _materialGroupController = TextEditingController();
  final _assetNumberController = TextEditingController();
  final _costCenterController = TextEditingController();
  final _glAccountController = TextEditingController();

  // State
  MaterialMaster? _selectedMaterial;
  ServiceMaster? _selectedService;
  String _itemCategory = ''; // '' = Standard, 'D' = Service
  String _accountAssignment = ''; // '' = None, 'A' = Asset, 'K' = Cost Center
  String _selectedUnit = 'EA';
  DateTime _deliveryDate = DateTime.now().add(const Duration(days: 30));
  String? _valuationType;

  final List<String> _units = ['EA', 'M', 'KG', 'L', 'AU', 'PC', 'SET'];
  final List<String> _valuationTypes = [
    'NEW',
    'DAMAGED',
    'REFURBISHED',
    'SCRAP',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingItem != null) {
      _loadExistingItem();
    }
  }

  void _loadExistingItem() {
    final item = widget.existingItem!;
    _shortTextController.text = item.shortText;
    _quantityController.text = item.quantity.toString();
    _priceController.text = item.valuationPrice.toString();
    _plantController.text = item.plant;
    _storageLocationController.text = item.storageLocation ?? '';
    _materialGroupController.text = item.materialGroup;
    _assetNumberController.text = item.assetNumber ?? '';
    _costCenterController.text = item.costCenter ?? '';
    _glAccountController.text = item.glAccount ?? '';
    _selectedUnit = item.unit;
    _itemCategory = item.itemCategory!;
    _accountAssignment = item.accountAssignmentCategory;
    _deliveryDate = item.deliveryDate!;
    _valuationType = item.valuationType;
  }

  @override
  void dispose() {
    _shortTextController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _plantController.dispose();
    _storageLocationController.dispose();
    _materialGroupController.dispose();
    _assetNumberController.dispose();
    _costCenterController.dispose();
    _glAccountController.dispose();
    super.dispose();
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
        middle: Text(
          widget.existingItem != null
              ? 'Edit Item ${widget.itemNumber}'
              : 'Add Item ${widget.itemNumber}',
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildItemTypeSelector(),
                      const SizedBox(height: AppTheme.spacingL),
                      _buildMaterialServiceSection(),
                      const SizedBox(height: AppTheme.spacingL),
                      _buildQuantityPriceSection(),
                      const SizedBox(height: AppTheme.spacingL),
                      _buildPlantStorageSection(),
                      const SizedBox(height: AppTheme.spacingL),
                      _buildAccountAssignmentSection(),
                      const SizedBox(height: AppTheme.spacingL),
                      _buildDeliveryDateSection(),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTypeSelector() {
    return Container(
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
          const Text(
            'ITEM TYPE',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              Expanded(
                child: _buildTypeButton(
                  icon: CupertinoIcons.cube_box,
                  label: 'Material',
                  isSelected: _itemCategory.isEmpty,
                  onTap: () {
                    setState(() {
                      _itemCategory = '';
                      _selectedService = null;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildTypeButton(
                  icon: CupertinoIcons.wrench,
                  label: 'Service',
                  isSelected: _itemCategory == 'D',
                  onTap: () {
                    setState(() {
                      _itemCategory = 'D';
                      _selectedMaterial = null;
                      _accountAssignment = 'K'; // Service requires cost center
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue.withOpacity(0.1)
              : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppTheme.primaryBlue
                    : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialServiceSection() {
    return Container(
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
          Text(
            _itemCategory == 'D' ? 'SERVICE DETAILS' : 'MATERIAL DETAILS',
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          if (_itemCategory == 'D')
            ServiceSearchField(
              selectedService: _selectedService,
              onChanged: (service) {
                setState(() {
                  _selectedService = service;
                  if (service != null) {
                    _shortTextController.text = service.serviceShortText;
                    _materialGroupController.text = service.materialGroup;
                    _selectedUnit = service.baseUnit;
                  }
                });
              },
            )
          else
            MaterialSearchField(
              selectedMaterial: _selectedMaterial,
              onChanged: (material) {
                setState(() {
                  _selectedMaterial = material;
                  if (material != null) {
                    _shortTextController.text = material.materialDesc;
                    _plantController.text = material.plant;
                    _materialGroupController.text = material.materialGroup;
                    _selectedUnit = material.baseUnitOfMeasure;
                  }
                });
              },
            ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Short Text / Description *',
            controller: _shortTextController,
            hint: 'Item description',
            maxLines: 2,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Material Group',
            controller: _materialGroupController,
            hint: 'e.g., M0018',
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityPriceSection() {
    return Container(
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
          const Text(
            'QUANTITY & PRICE',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(
                  label: 'Quantity *',
                  controller: _quantityController,
                  hint: '0.00',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(child: _buildUnitPicker()),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Valuation Price *',
            controller: _priceController,
            hint: '0.00',
            keyboardType: TextInputType.number,
            prefix: const Text('INR '),
          ),
          if (_quantityController.text.isNotEmpty &&
              _priceController.text.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacingM),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Value',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  Text(
                    'INR ${_calculateTotal().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlantStorageSection() {
    return Container(
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
          const Text(
            'PLANT & STORAGE',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Plant *',
            controller: _plantController,
            hint: 'e.g., 4159',
            keyboardType: TextInputType.number,
          ),
          if (_itemCategory.isEmpty) ...[
            const SizedBox(height: AppTheme.spacingM),
            _buildTextField(
              label: 'Storage Location',
              controller: _storageLocationController,
              hint: 'e.g., 0003',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildValuationTypePicker(),
          ],
        ],
      ),
    );
  }

  Widget _buildAccountAssignmentSection() {
    return Container(
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
          const Text(
            'ACCOUNT ASSIGNMENT',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          if (_itemCategory != 'D')
            Row(
              children: [
                Expanded(
                  child: _buildAccountTypeButton(
                    label: 'None',
                    isSelected: _accountAssignment.isEmpty,
                    onTap: () {
                      setState(() {
                        _accountAssignment = '';
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: _buildAccountTypeButton(
                    label: 'Asset',
                    isSelected: _accountAssignment == 'A',
                    onTap: () {
                      setState(() {
                        _accountAssignment = 'A';
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: _buildAccountTypeButton(
                    label: 'Cost Center',
                    isSelected: _accountAssignment == 'K',
                    onTap: () {
                      setState(() {
                        _accountAssignment = 'K';
                      });
                    },
                  ),
                ),
              ],
            ),
          if (_accountAssignment == 'A') ...[
            const SizedBox(height: AppTheme.spacingM),
            _buildTextField(
              label: 'Asset Number *',
              controller: _assetNumberController,
              hint: 'Search or enter asset number',
            ),
          ],
          if (_accountAssignment == 'K' || _itemCategory == 'D') ...[
            const SizedBox(height: AppTheme.spacingM),
            _buildTextField(
              label: 'Cost Center *',
              controller: _costCenterController,
              hint: 'e.g., 1511415999',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildTextField(
              label: 'G/L Account',
              controller: _glAccountController,
              hint: 'General Ledger account',
              keyboardType: TextInputType.number,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAccountTypeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue.withOpacity(0.1)
              : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryDateSection() {
    return Container(
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
          const Text(
            'DELIVERY DATE',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          GestureDetector(
            onTap: _showDatePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.dividerColor),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    size: 18,
                    color: AppTheme.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _formatDate(_deliveryDate),
                      style: AppTheme.body1.copyWith(fontSize: 15),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    size: 18,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unit *',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _showUnitPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedUnit,
                  style: AppTheme.body1.copyWith(fontSize: 15),
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValuationTypePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Valuation Type',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _showValuationTypePicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _valuationType ?? 'Select valuation type',
                  style: AppTheme.body1.copyWith(
                    fontSize: 15,
                    color: _valuationType == null
                        ? AppTheme.textSecondary
                        : AppTheme.textPrimary,
                  ),
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    Widget? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        CupertinoTextField(
          controller: controller,
          placeholder: hint,
          keyboardType: keyboardType,
          maxLines: maxLines,
          prefix: prefix != null
              ? Padding(padding: const EdgeInsets.only(left: 12), child: prefix)
              : null,
          style: AppTheme.body1.copyWith(fontSize: 15),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.dividerColor),
          ),
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
        child: SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: AppTheme.primaryBlue,
            borderRadius: BorderRadius.circular(12),
            onPressed: _saveItem,
            child: Text(
              widget.existingItem != null ? 'Update Item' : 'Add Item',
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUnitPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const Text(
                    'Select Unit',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedUnit = _units[index];
                  });
                },
                children: _units.map((unit) {
                  return Center(
                    child: Text(unit, style: const TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showValuationTypePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const Text(
                    'Valuation Type',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _valuationType = _valuationTypes[index];
                  });
                },
                children: _valuationTypes.map((type) {
                  return Center(
                    child: Text(type, style: const TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const Text(
                    'Delivery Date',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _deliveryDate,
                minimumDate: DateTime.now(),
                onDateTimeChanged: (date) {
                  setState(() {
                    _deliveryDate = date;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    return quantity * price;
  }

  Future<void> _saveItem() async {
    if (!_validateForm()) return;

    final item = PRLineItem(
      prNumber: widget.prNumber,
      itemNumber: widget.itemNumber,
      material: _selectedMaterial?.material,
      shortText: _shortTextController.text,
      quantity: double.parse(_quantityController.text),
      unit: _selectedUnit,
      valuationPrice: double.parse(_priceController.text),
      plant: _plantController.text,
      storageLocation: _storageLocationController.text.isEmpty
          ? null
          : _storageLocationController.text,
      materialGroup: _materialGroupController.text,
      accountAssignmentCategory: _accountAssignment,
      itemCategory: _itemCategory,
      assetNumber: _assetNumberController.text.isEmpty
          ? null
          : _assetNumberController.text,
      costCenter: _costCenterController.text.isEmpty
          ? null
          : _costCenterController.text,
      glAccount: _glAccountController.text.isEmpty
          ? null
          : _glAccountController.text,
      valuationType: _valuationType,
      deliveryDate: _deliveryDate,
    );

    try {
      final prService = ref.read(prServiceProvider);
      await prService.addLineItem(widget.prNumber, item);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showError('Error saving item: $e');
    }
  }

  bool _validateForm() {
    if (_shortTextController.text.isEmpty) {
      _showError('Please enter item description');
      return false;
    }

    if (_quantityController.text.isEmpty ||
        double.tryParse(_quantityController.text) == null) {
      _showError('Please enter valid quantity');
      return false;
    }

    if (_priceController.text.isEmpty ||
        double.tryParse(_priceController.text) == null) {
      _showError('Please enter valid price');
      return false;
    }

    if (_plantController.text.isEmpty) {
      _showError('Please enter plant');
      return false;
    }

    if (_accountAssignment == 'A' && _assetNumberController.text.isEmpty) {
      _showError('Please enter asset number');
      return false;
    }

    if ((_accountAssignment == 'K' || _itemCategory == 'D') &&
        _costCenterController.text.isEmpty) {
      _showError('Please enter cost center');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Validation Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
