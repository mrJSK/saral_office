// // lib/core/widgets/service_search_field.dart

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../core/theme/app_theme.dart';
// import '../../core/database/models/service_master.dart';
// import '../../core/di/injection.dart';

// class ServiceSearchField extends ConsumerWidget {
//   final ServiceMaster? selectedService;
//   final Function(ServiceMaster?) onChanged;
//   final String? label;

//   const ServiceSearchField({
//     super.key,
//     required this.selectedService,
//     required this.onChanged,
//     this.label,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label ?? 'Service',
//           style: AppTheme.caption.copyWith(
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//         const SizedBox(height: 6),
//         GestureDetector(
//           onTap: () => _showServicePicker(context),
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
//                   CupertinoIcons.wrench_fill,
//                   size: 18,
//                   color: AppTheme.successGreen,
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     selectedService?.displayText ?? 'Select Service',
//                     style: selectedService != null
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

//   void _showServicePicker(BuildContext context) {
//     Navigator.push(
//       context,
//       CupertinoPageRoute(
//         builder: (context) => ServicePickerScreen(onSelected: onChanged),
//       ),
//     );
//   }
// }

// // Service Picker Screen with Comprehensive Details
// class ServicePickerScreen extends ConsumerStatefulWidget {
//   final Function(ServiceMaster) onSelected;

//   const ServicePickerScreen({super.key, required this.onSelected});

//   @override
//   ConsumerState<ServicePickerScreen> createState() =>
//       _ServicePickerScreenState();
// }

// class _ServicePickerScreenState extends ConsumerState<ServicePickerScreen> {
//   final _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final servicesAsync = ref.watch(serviceSearchProvider(_searchQuery));

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
//         middle: const Text('Select Service'),
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
//                 placeholder: 'Search activity number or description',
//                 onChanged: (value) {
//                   setState(() => _searchQuery = value);
//                 },
//               ),
//             ),
//             // Results Count
//             servicesAsync.whenData((services) {
//                   if (services.isNotEmpty) {
//                     return Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: AppTheme.spacingM,
//                         vertical: 8,
//                       ),
//                       color: AppTheme.backgroundLight,
//                       child: Text(
//                         '${services.length} service${services.length == 1 ? '' : 's'} found',
//                         style: AppTheme.caption.copyWith(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 }).value ??
//                 const SizedBox.shrink(),
//             // Service List
//             Expanded(
//               child: servicesAsync.when(
//                 data: (services) {
//                   if (services.isEmpty) {
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
//                                 ? 'Start typing to search services'
//                                 : 'No services found',
//                             style: AppTheme.body2,
//                           ),
//                         ],
//                       ),
//                     );
//                   }

//                   return ListView.separated(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.all(AppTheme.spacingM),
//                     itemCount: services.length,
//                     separatorBuilder: (_, __) =>
//                         const SizedBox(height: AppTheme.spacingM),
//                     itemBuilder: (context, index) {
//                       final service = services[index];
//                       return _ServiceDetailCard(
//                         service: service,
//                         onTap: () {
//                           widget.onSelected(service);
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
//                           'Error loading services',
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

// // Comprehensive Service Detail Card
// class _ServiceDetailCard extends StatelessWidget {
//   final ServiceMaster service;
//   final VoidCallback onTap;

//   const _ServiceDetailCard({required this.service, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppTheme.surfaceWhite,
//           borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
//           border: Border.all(
//             color: AppTheme.successGreen.withOpacity(0.2),
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
//             // Header Section with Activity Number
//             Container(
//               padding: const EdgeInsets.all(AppTheme.spacingM),
//               decoration: BoxDecoration(
//                 color: AppTheme.successGreen.withOpacity(0.08),
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
//                       color: AppTheme.successGreen,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           CupertinoIcons.number,
//                           size: 14,
//                           color: AppTheme.surfaceWhite,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           service.activityNumber,
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
//                   const Spacer(),
//                   Icon(
//                     CupertinoIcons.chevron_right_circle_fill,
//                     color: AppTheme.successGreen.withOpacity(0.6),
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
//                   // Service Description Section
//                   _buildSectionHeader(
//                     'Service Description',
//                     CupertinoIcons.text_alignleft,
//                   ),
//                   const SizedBox(height: 8),
//                   _buildInfoRow(
//                     'Short Text',
//                     service.serviceShortText,
//                     isBold: true,
//                   ),
//                   if (service.serviceLongText != service.serviceShortText) ...[
//                     const SizedBox(height: 6),
//                     _buildInfoRow(
//                       'Long Text',
//                       service.serviceLongText,
//                       maxLines: 3,
//                     ),
//                   ],

//                   const SizedBox(height: 12),
//                   const Divider(height: 1, color: AppTheme.dividerColor),
//                   const SizedBox(height: 12),

//                   // Material & Service Group Section
//                   _buildSectionHeader(
//                     'Material & Service Group',
//                     CupertinoIcons.cube_box,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildInfoRow(
//                           'Material Group',
//                           service.materialGroup,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _buildInfoRow('Base Unit', service.baseUnit),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   _buildInfoRow('Group Description', service.materialGroupDesc),

//                   const SizedBox(height: 12),
//                   const Divider(height: 1, color: AppTheme.dividerColor),
//                   const SizedBox(height: 12),

//                   // Service Category Section
//                   _buildSectionHeader('Service Category', CupertinoIcons.tag),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildInfoRow('Code', service.serviceCategory),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _buildInfoRow(
//                           'Description',
//                           service.serviceCategoryDesc,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Valuation Section (if available)
//                   if (service.valuationClass != null ||
//                       service.valuationClassDesc != null) ...[
//                     const SizedBox(height: 12),
//                     const Divider(height: 1, color: AppTheme.dividerColor),
//                     const SizedBox(height: 12),
//                     _buildSectionHeader(
//                       'Valuation',
//                       CupertinoIcons.money_dollar_circle,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         if (service.valuationClass != null)
//                           Expanded(
//                             child: _buildInfoRow(
//                               'Class',
//                               service.valuationClass!,
//                             ),
//                           ),
//                         if (service.valuationClass != null &&
//                             service.valuationClassDesc != null)
//                           const SizedBox(width: 12),
//                         if (service.valuationClassDesc != null)
//                           Expanded(
//                             child: _buildInfoRow(
//                               'Description',
//                               service.valuationClassDesc!,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],

//                   // GL Account (if available)
//                   if (service.glAccount != null) ...[
//                     const SizedBox(height: 12),
//                     const Divider(height: 1, color: AppTheme.dividerColor),
//                     const SizedBox(height: 12),
//                     _buildSectionHeader(
//                       'Financial',
//                       CupertinoIcons.money_dollar,
//                     ),
//                     const SizedBox(height: 8),
//                     _buildInfoRow('G/L Account', service.glAccount!),
//                   ],

//                   // Deletion Indicator (if marked)
//                   if (service.deletionIndicator != null &&
//                       service.deletionIndicator!.isNotEmpty) ...[
//                     const SizedBox(height: 12),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppTheme.errorRed.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(
//                           color: AppTheme.errorRed.withOpacity(0.3),
//                           width: 1,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(
//                             CupertinoIcons.exclamationmark_triangle_fill,
//                             size: 14,
//                             color: AppTheme.errorRed,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             'Marked for Deletion',
//                             style: TextStyle(
//                               fontFamily: 'SF Pro Display',
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               color: AppTheme.errorRed,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
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
//         Icon(icon, size: 14, color: AppTheme.successGreen),
//         const SizedBox(width: 6),
//         Text(
//           title.toUpperCase(),
//           style: const TextStyle(
//             fontFamily: 'SF Pro Display',
//             fontSize: 11,
//             fontWeight: FontWeight.w700,
//             color: AppTheme.successGreen,
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
// }
// lib/core/widgets/service_search_field.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/theme/app_theme.dart';
import '../../core/database/models/service_master.dart';
import '../../core/di/injection.dart';

class ServiceSearchField extends ConsumerWidget {
  final ServiceMaster? selectedService;
  final Function(ServiceMaster?) onChanged;
  final String? label;

  const ServiceSearchField({
    super.key,
    required this.selectedService,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? 'Service',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _showServicePicker(context),
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
                  CupertinoIcons.wrench_fill,
                  size: 18,
                  color: AppTheme.successGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedService?.displayText ?? 'Select Service',
                    style: selectedService != null
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

  void _showServicePicker(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ServicePickerScreen(onSelected: onChanged),
      ),
    );
  }
}

// Service Filter State
class ServiceFilter {
  final Set<String> materialGroups;
  final Set<String> serviceCategories;

  ServiceFilter({Set<String>? materialGroups, Set<String>? serviceCategories})
    : materialGroups = materialGroups ?? {},
      serviceCategories = serviceCategories ?? {};

  ServiceFilter copyWith({
    Set<String>? materialGroups,
    Set<String>? serviceCategories,
  }) {
    return ServiceFilter(
      materialGroups: materialGroups ?? this.materialGroups,
      serviceCategories: serviceCategories ?? this.serviceCategories,
    );
  }

  bool get hasFilters =>
      materialGroups.isNotEmpty || serviceCategories.isNotEmpty;
  int get activeFilterCount => materialGroups.length + serviceCategories.length;
}

// Provider for service filter state
final serviceFilterProvider = StateProvider<ServiceFilter>((ref) {
  return ServiceFilter();
});

// Provider for filtered services
final filteredServiceSearchProvider =
    FutureProvider.family<List<ServiceMaster>, String>((ref, query) async {
      final isarService = ref.watch(isarServiceProvider);
      final filter = ref.watch(serviceFilterProvider);

      final allServices = await isarService.searchServices(query);

      if (!filter.hasFilters) {
        return allServices;
      }

      return allServices.where((service) {
        if (filter.materialGroups.isNotEmpty) {
          if (!filter.materialGroups.contains(service.materialGroup)) {
            return false;
          }
        }

        if (filter.serviceCategories.isNotEmpty) {
          if (!filter.serviceCategories.contains(service.serviceCategory)) {
            return false;
          }
        }

        return true;
      }).toList();
    });

// Provider for unique service material groups
final serviceMaterialGroupsProvider = FutureProvider<List<ServiceGroupInfo>>((
  ref,
) async {
  final isar = ref.watch(isarProvider);
  final services = await isar.serviceMasters.where().findAll();

  final groupMap = <String, ServiceGroupInfo>{};

  for (final service in services) {
    final key = service.materialGroup;
    if (!groupMap.containsKey(key)) {
      groupMap[key] = ServiceGroupInfo(
        code: service.materialGroup,
        description: service.materialGroupDesc,
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

// Provider for unique service categories
final serviceCategoriesProvider = FutureProvider<List<ServiceGroupInfo>>((
  ref,
) async {
  final isar = ref.watch(isarProvider);
  final services = await isar.serviceMasters.where().findAll();

  final categoryMap = <String, ServiceGroupInfo>{};

  for (final service in services) {
    final key = service.serviceCategory;
    if (!categoryMap.containsKey(key)) {
      categoryMap[key] = ServiceGroupInfo(
        code: service.serviceCategory,
        description: service.serviceCategoryDesc,
        count: 1,
      );
    } else {
      categoryMap[key] = categoryMap[key]!.copyWith(
        count: categoryMap[key]!.count + 1,
      );
    }
  }

  final categories = categoryMap.values.toList()
    ..sort((a, b) => a.code.compareTo(b.code));

  return categories;
});

// Service Group Info
class ServiceGroupInfo {
  final String code;
  final String description;
  final int count;

  ServiceGroupInfo({
    required this.code,
    required this.description,
    required this.count,
  });

  ServiceGroupInfo copyWith({String? code, String? description, int? count}) {
    return ServiceGroupInfo(
      code: code ?? this.code,
      description: description ?? this.description,
      count: count ?? this.count,
    );
  }
}

// Service Picker Screen with Filters
class ServicePickerScreen extends ConsumerStatefulWidget {
  final Function(ServiceMaster) onSelected;

  const ServicePickerScreen({super.key, required this.onSelected});

  @override
  ConsumerState<ServicePickerScreen> createState() =>
      _ServicePickerScreenState();
}

class _ServicePickerScreenState extends ConsumerState<ServicePickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(serviceFilterProvider.notifier).state = ServiceFilter();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(
      filteredServiceSearchProvider(_searchQuery),
    );
    final filter = ref.watch(serviceFilterProvider);

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
        middle: const Text('Select Service'),
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
                      color: AppTheme.successGreen,
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
                placeholder: 'Search activity number or description',
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
            if (filter.hasFilters) _buildActiveFilters(filter),
            servicesAsync.whenData((services) {
                  if (services.isNotEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM,
                        vertical: 8,
                      ),
                      color: AppTheme.backgroundLight,
                      child: Text(
                        '${services.length} service${services.length == 1 ? '' : 's'} found',
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
              child: servicesAsync.when(
                data: (services) {
                  if (services.isEmpty) {
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
                                ? 'No services match the selected filters'
                                : (_searchQuery.isEmpty
                                      ? 'Start typing to search services'
                                      : 'No services found'),
                            style: AppTheme.body2,
                            textAlign: TextAlign.center,
                          ),
                          if (filter.hasFilters) ...[
                            const SizedBox(height: AppTheme.spacingM),
                            CupertinoButton(
                              onPressed: () {
                                ref.read(serviceFilterProvider.notifier).state =
                                    ServiceFilter();
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
                    itemCount: services.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppTheme.spacingM),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return _ServiceDetailCard(
                        service: service,
                        onTap: () {
                          widget.onSelected(service);
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
                          'Error loading services',
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

  Widget _buildActiveFilters(ServiceFilter filter) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: 8,
      ),
      color: AppTheme.successGreen.withOpacity(0.1),
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
                  color: AppTheme.successGreen,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: () {
                  ref.read(serviceFilterProvider.notifier).state =
                      ServiceFilter();
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.successGreen,
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
                  ref.read(serviceFilterProvider.notifier).state = filter
                      .copyWith(materialGroups: newGroups);
                }),
              ),
              ...filter.serviceCategories.map(
                (category) => _buildFilterChip('Category: $category', () {
                  final newCategories = Set<String>.from(
                    filter.serviceCategories,
                  )..remove(category);
                  ref.read(serviceFilterProvider.notifier).state = filter
                      .copyWith(serviceCategories: newCategories);
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
          color: AppTheme.successGreen.withOpacity(0.3),
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
      builder: (context) => _ServiceFilterSheet(),
    );
  }
}

// Service Filter Sheet
class _ServiceFilterSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(serviceFilterProvider);
    final materialGroupsAsync = ref.watch(serviceMaterialGroupsProvider);
    final categoriesAsync = ref.watch(serviceCategoriesProvider);

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
                  color: AppTheme.successGreen,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Filter Services',
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
                          ref.read(serviceFilterProvider.notifier).state =
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
                  _buildSectionHeader('Service Categories', CupertinoIcons.tag),
                  const SizedBox(height: AppTheme.spacingM),
                  categoriesAsync.when(
                    data: (categories) => _buildGroupList(
                      categories,
                      filter.serviceCategories,
                      (category) {
                        final newCategories = Set<String>.from(
                          filter.serviceCategories,
                        );
                        if (newCategories.contains(category.code)) {
                          newCategories.remove(category.code);
                        } else {
                          newCategories.add(category.code);
                        }
                        ref.read(serviceFilterProvider.notifier).state = filter
                            .copyWith(serviceCategories: newCategories);
                      },
                    ),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppTheme.spacingM),
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    error: (_, __) => const Text('Error loading categories'),
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
                      ref.read(serviceFilterProvider.notifier).state =
                          ServiceFilter();
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
                    color: AppTheme.successGreen,
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
        Icon(icon, size: 16, color: AppTheme.successGreen),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppTheme.successGreen,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupList(
    List<ServiceGroupInfo> groups,
    Set<String> selectedGroups,
    Function(ServiceGroupInfo) onToggle,
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
              ? AppTheme.successGreen.withOpacity(0.1)
              : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppTheme.successGreen : AppTheme.dividerColor,
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
                    ? AppTheme.successGreen
                    : AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.successGreen
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
                          ? AppTheme.successGreen
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
                    ? AppTheme.successGreen.withOpacity(0.2)
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
                      ? AppTheme.successGreen
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

// Comprehensive Service Detail Card
class _ServiceDetailCard extends StatelessWidget {
  final ServiceMaster service;
  final VoidCallback onTap;

  const _ServiceDetailCard({required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: AppTheme.successGreen.withOpacity(0.2),
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
                color: AppTheme.successGreen.withOpacity(0.08),
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
                      color: AppTheme.successGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          CupertinoIcons.number,
                          size: 14,
                          color: AppTheme.surfaceWhite,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          service.activityNumber,
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
                  const Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right_circle_fill,
                    color: AppTheme.successGreen.withOpacity(0.6),
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
                    'Service Description',
                    CupertinoIcons.text_alignleft,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Short Text',
                    service.serviceShortText,
                    isBold: true,
                  ),
                  if (service.serviceLongText != service.serviceShortText) ...[
                    const SizedBox(height: 6),
                    _buildInfoRow(
                      'Long Text',
                      service.serviceLongText,
                      maxLines: 3,
                    ),
                  ],
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 12),
                  _buildSectionHeader(
                    'Material & Service Group',
                    CupertinoIcons.cube_box,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          'Material Group',
                          service.materialGroup,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoRow('Base Unit', service.baseUnit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow('Group Description', service.materialGroupDesc),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 12),
                  _buildSectionHeader('Service Category', CupertinoIcons.tag),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow('Code', service.serviceCategory),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoRow(
                          'Description',
                          service.serviceCategoryDesc,
                        ),
                      ),
                    ],
                  ),
                  if (service.valuationClass != null ||
                      service.valuationClassDesc != null) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: AppTheme.dividerColor),
                    const SizedBox(height: 12),
                    _buildSectionHeader(
                      'Valuation',
                      CupertinoIcons.money_dollar_circle,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (service.valuationClass != null)
                          Expanded(
                            child: _buildInfoRow(
                              'Class',
                              service.valuationClass!,
                            ),
                          ),
                        if (service.valuationClass != null &&
                            service.valuationClassDesc != null)
                          const SizedBox(width: 12),
                        if (service.valuationClassDesc != null)
                          Expanded(
                            child: _buildInfoRow(
                              'Description',
                              service.valuationClassDesc!,
                            ),
                          ),
                      ],
                    ),
                  ],
                  if (service.glAccount != null) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: AppTheme.dividerColor),
                    const SizedBox(height: 12),
                    _buildSectionHeader(
                      'Financial',
                      CupertinoIcons.money_dollar,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow('G/L Account', service.glAccount!),
                  ],
                  if (service.deletionIndicator != null &&
                      service.deletionIndicator!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.errorRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppTheme.errorRed.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.exclamationmark_triangle_fill,
                            size: 14,
                            color: AppTheme.errorRed,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Marked for Deletion',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.errorRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
        Icon(icon, size: 14, color: AppTheme.successGreen),
        const SizedBox(width: 6),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.successGreen,
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
}
