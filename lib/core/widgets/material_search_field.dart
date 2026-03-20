// // lib/core/widgets/material_search_field.dart

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../core/theme/app_theme.dart';
// import '../../core/database/models/material_master.dart';
// import '../../core/di/injection.dart';

// class MaterialSearchField extends ConsumerWidget {
//   final MaterialMaster? selectedMaterial;
//   final Function(MaterialMaster?) onChanged;
//   final String? label;

//   const MaterialSearchField({
//     super.key,
//     required this.selectedMaterial,
//     required this.onChanged,
//     this.label,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label ?? 'Material',
//           style: AppTheme.caption.copyWith(
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//         const SizedBox(height: 6),
//         GestureDetector(
//           onTap: () => _showMaterialPicker(context),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               color: AppTheme.backgroundLight,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: AppTheme.dividerColor, width: 1),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   CupertinoIcons.cube_box_fill,
//                   size: 18,
//                   color: AppTheme.warningOrange,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     selectedMaterial?.displayText ?? 'Select Material',
//                     style: selectedMaterial != null
//                         ? AppTheme.body1.copyWith(fontSize: 15)
//                         : AppTheme.body2,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 const Icon(
//                   CupertinoIcons.chevron_right,
//                   size: 18,
//                   color: AppTheme.textSecondary,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showMaterialPicker(BuildContext context) {
//     Navigator.push(
//       context,
//       CupertinoPageRoute(
//         builder: (context) => MaterialPickerScreen(onSelected: onChanged),
//       ),
//     );
//   }
// }

// // Material Picker Screen with Comprehensive Details
// class MaterialPickerScreen extends ConsumerStatefulWidget {
//   final Function(MaterialMaster) onSelected;

//   const MaterialPickerScreen({super.key, required this.onSelected});

//   @override
//   ConsumerState<MaterialPickerScreen> createState() =>
//       _MaterialPickerScreenState();
// }

// class _MaterialPickerScreenState extends ConsumerState<MaterialPickerScreen> {
//   final _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final materialsAsync = ref.watch(materialSearchProvider(_searchQuery));

//     return CupertinoPageScaffold(
//       backgroundColor: AppTheme.backgroundLight,
//       navigationBar: CupertinoNavigationBar(
//         backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
//         border: null,
//         leading: CupertinoButton(
//           padding: EdgeInsets.zero,
//           onPressed: () => Navigator.pop(context),
//           child: const Icon(CupertinoIcons.back),
//         ),
//         middle: const Text('Select Material'),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             // Search Bar
//             Container(
//               color: AppTheme.surfaceWhite,
//               padding: const EdgeInsets.all(AppTheme.spacingM),
//               child: CupertinoSearchTextField(
//                 controller: _searchController,
//                 placeholder: 'Search material code or description',
//                 onChanged: (value) {
//                   setState(() => _searchQuery = value);
//                 },
//               ),
//             ),
//             // Results Count
//             materialsAsync.whenData((materials) {
//                   if (materials.isNotEmpty) {
//                     return Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: AppTheme.spacingM,
//                         vertical: 8,
//                       ),
//                       color: AppTheme.backgroundLight,
//                       child: Text(
//                         '${materials.length} material${materials.length == 1 ? '' : 's'} found',
//                         style: AppTheme.caption.copyWith(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 }).value ??
//                 const SizedBox.shrink(),
//             // Material List
//             Expanded(
//               child: materialsAsync.when(
//                 data: (materials) {
//                   if (materials.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             CupertinoIcons.search,
//                             size: 64,
//                             color: AppTheme.textSecondary.withOpacity(0.3),
//                           ),
//                           const SizedBox(height: AppTheme.spacingM),
//                           Text(
//                             _searchQuery.isEmpty
//                                 ? 'Start typing to search materials'
//                                 : 'No materials found',
//                             style: AppTheme.body2,
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   return ListView.separated(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.all(AppTheme.spacingM),
//                     itemCount: materials.length,
//                     separatorBuilder: (_, __) =>
//                         const SizedBox(height: AppTheme.spacingM),
//                     itemBuilder: (context, index) {
//                       final material = materials[index];
//                       return _MaterialDetailCard(
//                         material: material,
//                         onTap: () {
//                           widget.onSelected(material);
//                           Navigator.pop(context);
//                         },
//                       );
//                     },
//                   );
//                 },
//                 loading: () =>
//                     const Center(child: CupertinoActivityIndicator()),
//                 error: (error, __) => Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(AppTheme.spacingL),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           CupertinoIcons.exclamationmark_triangle,
//                           size: 48,
//                           color: AppTheme.errorRed,
//                         ),
//                         const SizedBox(height: AppTheme.spacingM),
//                         const Text(
//                           'Error loading materials',
//                           style: TextStyle(
//                             fontFamily: 'SF Pro Display',
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: AppTheme.spacingS),
//                         Text(
//                           error.toString(),
//                           style: AppTheme.caption,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Comprehensive Material Detail Card
// class _MaterialDetailCard extends StatelessWidget {
//   final MaterialMaster material;
//   final VoidCallback onTap;

//   const _MaterialDetailCard({required this.material, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppTheme.surfaceWhite,
//           borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//           border: Border.all(
//             color: AppTheme.warningOrange.withOpacity(0.2),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: CupertinoColors.systemGrey.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section with Material Code
//             Container(
//               padding: const EdgeInsets.all(AppTheme.spacingM),
//               decoration: BoxDecoration(
//                 color: AppTheme.warningOrange.withOpacity(0.08),
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(AppTheme.radiusMedium - 1),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppTheme.warningOrange,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           CupertinoIcons.barcode,
//                           size: 14,
//                           color: AppTheme.surfaceWhite,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           material.material,
//                           style: const TextStyle(
//                             fontFamily: 'SF Pro Display',
//                             fontSize: 13,
//                             fontWeight: FontWeight.w700,
//                             color: AppTheme.surfaceWhite,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppTheme.surfaceWhite,
//                       borderRadius: BorderRadius.circular(4),
//                       border: Border.all(
//                         color: AppTheme.warningOrange.withOpacity(0.3),
//                         width: 1,
//                       ),
//                     ),
//                     child: Text(
//                       material.materialType,
//                       style: TextStyle(
//                         fontFamily: 'SF Pro Display',
//                         fontSize: 10,
//                         fontWeight: FontWeight.w600,
//                         color: AppTheme.warningOrange,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Icon(
//                     CupertinoIcons.chevron_right_circle_fill,
//                     color: AppTheme.warningOrange.withOpacity(0.6),
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),

//             // Main Content
//             Padding(
//               padding: const EdgeInsets.all(AppTheme.spacingM),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Material Description
//                   _buildSectionHeader(
//                     'Material Description',
//                     CupertinoIcons.doc_text,
//                   ),
//                   const SizedBox(height: 8),
//                   _buildInfoRow(
//                     'Description',
//                     material.materialDesc,
//                     isBold: true,
//                     maxLines: 3,
//                   ),

//                   const SizedBox(height: 12),
//                   const Divider(height: 1, color: AppTheme.dividerColor),
//                   const SizedBox(height: 12),

//                   // Basic Information
//                   _buildSectionHeader(
//                     'Basic Information',
//                     CupertinoIcons.info_circle,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(child: _buildInfoRow('Plant', material.plant)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _buildInfoRow(
//                           'Base Unit',
//                           material.baseUnitOfMeasure,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 12),
//                   const Divider(height: 1, color: AppTheme.dividerColor),
//                   const SizedBox(height: 12),

//                   // Material Group Section
//                   _buildSectionHeader(
//                     'Material Classification',
//                     CupertinoIcons.square_grid_2x2,
//                   ),
//                   const SizedBox(height: 8),
//                   _buildInfoRow(
//                     'Material Group',
//                     '${material.materialGroup} - ${material.materialGroupDesc}',
//                   ),
//                   const SizedBox(height: 6),
//                   _buildInfoRow(
//                     'Sub Group',
//                     '${material.subGroup} - ${material.subGroupDesc}',
//                   ),

//                   const SizedBox(height: 12),
//                   const Divider(height: 1, color: AppTheme.dividerColor),
//                   const SizedBox(height: 12),

//                   // Status Information
//                   _buildSectionHeader(
//                     'Status & Configuration',
//                     CupertinoIcons.checkmark_shield,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildStatusBadge(
//                               'Split Valuation',
//                               material.splitValuationStatus,
//                               material.splitValuationStatus.toUpperCase() ==
//                                   'YES',
//                             ),
//                             const SizedBox(height: 8),
//                             _buildStatusBadge(
//                               'Serial Number',
//                               material.serialNumberStatus,
//                               material.serialNumberStatus.toUpperCase() ==
//                                   'YES',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: AppTheme.warningOrange),
//         const SizedBox(width: 6),
//         Text(
//           title.toUpperCase(),
//           style: const TextStyle(
//             fontFamily: 'SF Pro Display',
//             fontSize: 11,
//             fontWeight: FontWeight.w700,
//             color: AppTheme.warningOrange,
//             letterSpacing: 0.8,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoRow(
//     String label,
//     String value, {
//     bool isBold = false,
//     int maxLines = 2,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontFamily: 'SF Pro Display',
//             fontSize: 10,
//             fontWeight: FontWeight.w600,
//             color: AppTheme.textSecondary,
//             letterSpacing: 0.3,
//           ),
//         ),
//         const SizedBox(height: 3),
//         Text(
//           value.isEmpty ? '-' : value,
//           style: TextStyle(
//             fontFamily: 'SF Pro Display',
//             fontSize: isBold ? 14 : 13,
//             fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
//             color: value.isEmpty
//                 ? AppTheme.textSecondary
//                 : AppTheme.textPrimary,
//             height: 1.3,
//           ),
//           maxLines: maxLines,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusBadge(String label, String status, bool isActive) {
//     return Row(
//       children: [
//         Container(
//           width: 8,
//           height: 8,
//           decoration: BoxDecoration(
//             color: isActive ? AppTheme.successGreen : AppTheme.textSecondary,
//             shape: BoxShape.circle,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontFamily: 'SF Pro Display',
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600,
//                 color: AppTheme.textSecondary,
//               ),
//             ),
//             Text(
//               status.toUpperCase(),
//               style: TextStyle(
//                 fontFamily: 'SF Pro Display',
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: isActive
//                     ? AppTheme.successGreen
//                     : AppTheme.textSecondary,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
// lib/core/widgets/material_search_field.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/theme/app_theme.dart';
import '../../core/database/models/material_master.dart';
import '../../core/di/injection.dart';

class MaterialSearchField extends ConsumerWidget {
  final MaterialMaster? selectedMaterial;
  final Function(MaterialMaster?) onChanged;
  final String? label;

  const MaterialSearchField({
    super.key,
    required this.selectedMaterial,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? 'Material',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _showMaterialPicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.cube_box_fill,
                  size: 18,
                  color: AppTheme.warningOrange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedMaterial?.displayText ?? 'Select Material',
                    style: selectedMaterial != null
                        ? AppTheme.body1.copyWith(fontSize: 15)
                        : AppTheme.body2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
    );
  }

  void _showMaterialPicker(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MaterialPickerScreen(onSelected: onChanged),
      ),
    );
  }
}

// Material Filter State
class MaterialFilter {
  final Set<String> materialGroups;
  final Set<String> subGroups;

  MaterialFilter({Set<String>? materialGroups, Set<String>? subGroups})
    : materialGroups = materialGroups ?? {},
      subGroups = subGroups ?? {};

  MaterialFilter copyWith({
    Set<String>? materialGroups,
    Set<String>? subGroups,
  }) {
    return MaterialFilter(
      materialGroups: materialGroups ?? this.materialGroups,
      subGroups: subGroups ?? this.subGroups,
    );
  }

  bool get hasFilters => materialGroups.isNotEmpty || subGroups.isNotEmpty;
  int get activeFilterCount => materialGroups.length + subGroups.length;
}

// Provider for material filter state
final materialFilterProvider = StateProvider<MaterialFilter>((ref) {
  return MaterialFilter();
});

// Provider for filtered materials
final filteredMaterialSearchProvider =
    FutureProvider.family<List<MaterialMaster>, String>((ref, query) async {
      final isarService = ref.watch(isarServiceProvider);
      final filter = ref.watch(materialFilterProvider);

      final allMaterials = await isarService.searchMaterials(query);

      if (!filter.hasFilters) {
        return allMaterials;
      }

      return allMaterials.where((material) {
        if (filter.materialGroups.isNotEmpty) {
          if (!filter.materialGroups.contains(material.materialGroup)) {
            return false;
          }
        }

        if (filter.subGroups.isNotEmpty) {
          if (!filter.subGroups.contains(material.subGroup)) {
            return false;
          }
        }

        return true;
      }).toList();
    });

// Provider for unique material groups
final materialGroupsProvider = FutureProvider<List<MaterialGroupInfo>>((
  ref,
) async {
  final isar = ref.watch(isarProvider);
  final materials = await isar.materialMasters.where().findAll();

  final groupMap = <String, MaterialGroupInfo>{};

  for (final material in materials) {
    final key = material.materialGroup;
    if (!groupMap.containsKey(key)) {
      groupMap[key] = MaterialGroupInfo(
        code: material.materialGroup,
        description: material.materialGroupDesc,
        count: 1,
      );
    } else {
      groupMap[key] = groupMap[key]!.copyWith(count: groupMap[key]!.count + 1);
    }
  }

  final groups = groupMap.values.toList()
    ..sort((a, b) => a.code.compareTo(b.code));

  return groups;
});

// Provider for unique sub groups
final materialSubGroupsProvider = FutureProvider<List<MaterialSubGroupInfo>>((
  ref,
) async {
  final isar = ref.watch(isarProvider);
  final materials = await isar.materialMasters.where().findAll();

  final groupMap = <String, MaterialSubGroupInfo>{};

  for (final material in materials) {
    final key = material.subGroup;
    if (!groupMap.containsKey(key)) {
      groupMap[key] = MaterialSubGroupInfo(
        code: material.subGroup,
        description: material.subGroupDesc,
        count: 1,
      );
    } else {
      groupMap[key] = groupMap[key]!.copyWith(count: groupMap[key]!.count + 1);
    }
  }

  final groups = groupMap.values.toList()
    ..sort((a, b) => a.code.compareTo(b.code));

  return groups;
});

// Material Group Info
class MaterialGroupInfo {
  final String code;
  final String description;
  final int count;

  MaterialGroupInfo({
    required this.code,
    required this.description,
    required this.count,
  });

  MaterialGroupInfo copyWith({String? code, String? description, int? count}) {
    return MaterialGroupInfo(
      code: code ?? this.code,
      description: description ?? this.description,
      count: count ?? this.count,
    );
  }
}

// Material Sub Group Info
class MaterialSubGroupInfo {
  final String code;
  final String description;
  final int count;

  MaterialSubGroupInfo({
    required this.code,
    required this.description,
    required this.count,
  });

  MaterialSubGroupInfo copyWith({
    String? code,
    String? description,
    int? count,
  }) {
    return MaterialSubGroupInfo(
      code: code ?? this.code,
      description: description ?? this.description,
      count: count ?? this.count,
    );
  }
}

// Material Picker Screen with Filters
class MaterialPickerScreen extends ConsumerStatefulWidget {
  final Function(MaterialMaster) onSelected;

  const MaterialPickerScreen({super.key, required this.onSelected});

  @override
  ConsumerState<MaterialPickerScreen> createState() =>
      _MaterialPickerScreenState();
}

class _MaterialPickerScreenState extends ConsumerState<MaterialPickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(materialFilterProvider.notifier).state = MaterialFilter();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final materialsAsync = ref.watch(
      filteredMaterialSearchProvider(_searchQuery),
    );
    final filter = ref.watch(materialFilterProvider);

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
        middle: const Text('Select Material'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showFilterSheet(context),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(CupertinoIcons.slider_horizontal_3, size: 24),
              if (filter.hasFilters)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.warningOrange,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.surfaceWhite,
                        width: 2,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${filter.activeFilterCount}',
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.surfaceWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppTheme.surfaceWhite,
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search material code or description',
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
            if (filter.hasFilters) _buildActiveFilters(filter),
            materialsAsync.whenData((materials) {
                  if (materials.isNotEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM,
                        vertical: 8,
                      ),
                      color: AppTheme.backgroundLight,
                      child: Text(
                        '${materials.length} material${materials.length == 1 ? '' : 's'} found',
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }).value ??
                const SizedBox.shrink(),
            Expanded(
              child: materialsAsync.when(
                data: (materials) {
                  if (materials.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            filter.hasFilters
                                ? CupertinoIcons.clear_circled
                                : CupertinoIcons.search,
                            size: 64,
                            color: AppTheme.textSecondary.withOpacity(0.3),
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          Text(
                            filter.hasFilters
                                ? 'No materials match the selected filters'
                                : (_searchQuery.isEmpty
                                      ? 'Start typing to search materials'
                                      : 'No materials found'),
                            style: AppTheme.body2,
                            textAlign: TextAlign.center,
                          ),
                          if (filter.hasFilters) ...[
                            const SizedBox(height: AppTheme.spacingM),
                            CupertinoButton(
                              onPressed: () {
                                ref
                                        .read(materialFilterProvider.notifier)
                                        .state =
                                    MaterialFilter();
                              },
                              child: const Text('Clear Filters'),
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(AppTheme.spacingM),
                    itemCount: materials.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppTheme.spacingM),
                    itemBuilder: (context, index) {
                      final material = materials[index];
                      return _MaterialDetailCard(
                        material: material,
                        onTap: () {
                          widget.onSelected(material);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (error, __) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          size: 48,
                          color: AppTheme.errorRed,
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        const Text(
                          'Error loading materials',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingS),
                        Text(
                          error.toString(),
                          style: AppTheme.caption,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilters(MaterialFilter filter) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: 8,
      ),
      color: AppTheme.warningOrange.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Active Filters',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.warningOrange,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: () {
                  ref.read(materialFilterProvider.notifier).state =
                      MaterialFilter();
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.warningOrange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...filter.materialGroups.map(
                (group) => _buildFilterChip('Group: $group', () {
                  final newGroups = Set<String>.from(filter.materialGroups)
                    ..remove(group);
                  ref.read(materialFilterProvider.notifier).state = filter
                      .copyWith(materialGroups: newGroups);
                }),
              ),
              ...filter.subGroups.map(
                (subGroup) => _buildFilterChip('Sub: $subGroup', () {
                  final newSubGroups = Set<String>.from(filter.subGroups)
                    ..remove(subGroup);
                  ref.read(materialFilterProvider.notifier).state = filter
                      .copyWith(subGroups: newSubGroups);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.warningOrange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              CupertinoIcons.xmark_circle_fill,
              size: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => _MaterialFilterSheet(),
    );
  }
}

// Material Filter Sheet
class _MaterialFilterSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(materialFilterProvider);
    final materialGroupsAsync = ref.watch(materialGroupsProvider);
    final subGroupsAsync = ref.watch(materialSubGroupsProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.dividerColor)),
            ),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: AppTheme.warningOrange,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Filter Materials',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(CupertinoIcons.xmark_circle_fill),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Material Groups',
                    CupertinoIcons.square_grid_2x2,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  materialGroupsAsync.when(
                    data: (groups) =>
                        _buildGroupList(groups, filter.materialGroups, (group) {
                          final newGroups = Set<String>.from(
                            filter.materialGroups,
                          );
                          if (newGroups.contains(group.code)) {
                            newGroups.remove(group.code);
                          } else {
                            newGroups.add(group.code);
                          }
                          ref.read(materialFilterProvider.notifier).state =
                              filter.copyWith(materialGroups: newGroups);
                        }),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppTheme.spacingM),
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    error: (_, __) => const Text('Error loading groups'),
                  ),
                  const SizedBox(height: AppTheme.spacingXL),
                  _buildSectionHeader(
                    'Sub Groups',
                    CupertinoIcons.square_stack_3d_down_right,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  subGroupsAsync.when(
                    data: (subGroups) => _buildSubGroupList(
                      subGroups,
                      filter.subGroups,
                      (subGroup) {
                        final newSubGroups = Set<String>.from(filter.subGroups);
                        if (newSubGroups.contains(subGroup.code)) {
                          newSubGroups.remove(subGroup.code);
                        } else {
                          newSubGroups.add(subGroup.code);
                        }
                        ref.read(materialFilterProvider.notifier).state = filter
                            .copyWith(subGroups: newSubGroups);
                      },
                    ),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppTheme.spacingM),
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    error: (_, __) => const Text('Error loading sub groups'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: const BoxDecoration(
              color: AppTheme.backgroundLight,
              border: Border(top: BorderSide(color: AppTheme.dividerColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    color: AppTheme.surfaceWhite,
                    onPressed: () {
                      ref.read(materialFilterProvider.notifier).state =
                          MaterialFilter();
                    },
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  flex: 2,
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    color: AppTheme.warningOrange,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      filter.hasFilters
                          ? 'Apply Filters (${filter.activeFilterCount})'
                          : 'Apply',
                      style: const TextStyle(
                        color: AppTheme.surfaceWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.warningOrange),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppTheme.warningOrange,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupList(
    List<MaterialGroupInfo> groups,
    Set<String> selectedGroups,
    Function(MaterialGroupInfo) onToggle,
  ) {
    return Column(
      children: groups
          .map(
            (group) => _buildGroupItem(
              group.code,
              group.description,
              group.count,
              selectedGroups.contains(group.code),
              () => onToggle(group),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSubGroupList(
    List<MaterialSubGroupInfo> subGroups,
    Set<String> selectedSubGroups,
    Function(MaterialSubGroupInfo) onToggle,
  ) {
    return Column(
      children: subGroups
          .map(
            (subGroup) => _buildGroupItem(
              subGroup.code,
              subGroup.description,
              subGroup.count,
              selectedSubGroups.contains(subGroup.code),
              () => onToggle(subGroup),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGroupItem(
    String code,
    String description,
    int count,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.warningOrange.withOpacity(0.1)
              : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppTheme.warningOrange : AppTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.warningOrange
                    : AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.warningOrange
                      : AppTheme.dividerColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      CupertinoIcons.checkmark,
                      size: 14,
                      color: AppTheme.surfaceWhite,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppTheme.warningOrange
                          : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.warningOrange.withOpacity(0.2)
                    : AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? AppTheme.warningOrange
                      : AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Comprehensive Material Detail Card
class _MaterialDetailCard extends StatelessWidget {
  final MaterialMaster material;
  final VoidCallback onTap;

  const _MaterialDetailCard({required this.material, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: AppTheme.warningOrange.withOpacity(0.2),
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
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.warningOrange.withOpacity(0.08),
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
                      color: AppTheme.warningOrange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.barcode,
                          size: 14,
                          color: AppTheme.surfaceWhite,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          material.material,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.surfaceWhite,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceWhite,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppTheme.warningOrange.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      material.materialType,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningOrange,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right_circle_fill,
                    color: AppTheme.warningOrange.withOpacity(0.6),
                    size: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'Material Description',
                    CupertinoIcons.doc_text,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Description',
                    material.materialDesc,
                    isBold: true,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 12),
                  _buildSectionHeader(
                    'Basic Information',
                    CupertinoIcons.info_circle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildInfoRow('Plant', material.plant)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoRow(
                          'Base Unit',
                          material.baseUnitOfMeasure,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 12),
                  _buildSectionHeader(
                    'Material Classification',
                    CupertinoIcons.square_grid_2x2,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Material Group',
                    '${material.materialGroup} - ${material.materialGroupDesc}',
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    'Sub Group',
                    '${material.subGroup} - ${material.subGroupDesc}',
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 12),
                  _buildSectionHeader(
                    'Status & Configuration',
                    CupertinoIcons.checkmark_shield,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatusBadge(
                              'Split Valuation',
                              material.splitValuationStatus,
                              material.splitValuationStatus.toUpperCase() ==
                                  'YES',
                            ),
                            const SizedBox(height: 8),
                            _buildStatusBadge(
                              'Serial Number',
                              material.serialNumberStatus,
                              material.serialNumberStatus.toUpperCase() ==
                                  'YES',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppTheme.warningOrange),
        const SizedBox(width: 6),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.warningOrange,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool isBold = false,
    int maxLines = 2,
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
          value.isEmpty ? '-' : value,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: value.isEmpty
                ? AppTheme.textSecondary
                : AppTheme.textPrimary,
            height: 1.3,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String label, String status, bool isActive) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.successGreen : AppTheme.textSecondary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              status.toUpperCase(),
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppTheme.successGreen
                    : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
