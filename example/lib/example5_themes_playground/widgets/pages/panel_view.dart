import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/const/app_data.dart';
import '../../../shared/controllers/theme_controller.dart';
import '../../../shared/pages/page_examples.dart';
import '../../../shared/utils/app_scroll_behavior.dart';
import '../../../shared/widgets/universal/header_card.dart';
import '../panels/app_bar_settings/app_bar_settings.dart';
import '../panels/banner_bottom_sheet_snack_settings/banner_bottom_sheet_snack_settings.dart';
import '../panels/buttons_settings/buttons_settings.dart';
import '../panels/card_settings/card_settings.dart';
import '../panels/component_settings/component_settings.dart';
import '../panels/dialog_settings/dialog_settings.dart';
import '../panels/fab_chip_settings/fab_chip_settings.dart';
import '../panels/introduction/introduction_panel.dart';
import '../panels/material_panel/material_panel.dart';
import '../panels/navigation_bar_settings/android_navigation_bar_settings.dart';
import '../panels/navigation_bar_settings/bottom_navigation_bar_settings.dart';
import '../panels/navigation_bar_settings/navigation_bar_settings.dart';
import '../panels/navigation_rail_settings/navigation_rail_settings.dart';
import '../panels/panel_item.dart';
import '../panels/panel_selector.dart';
import '../panels/popup_icon_button_settings/popup_icon_button_settings.dart';
import '../panels/seeded_color_scheme_settings/seeded_color_scheme_settings.dart';
import '../panels/showcase_panels/effective_colors.dart';
import '../panels/showcase_panels/theme_code.dart';
import '../panels/showcase_panels/widget_showcase.dart';
import '../panels/surface_blend_settings/surface_blend_settings.dart';
import '../panels/switch_settings/list_tile_settings.dart';
import '../panels/switch_settings/switch_settings.dart';
import '../panels/tab_bar_settings/tab_bar_settings.dart';
import '../panels/text_field_settings/text_field_settings.dart';
import '../panels/text_theme_settings/primary_text_theme_settings.dart';
import '../panels/text_theme_settings/text_theme_settings.dart';
import '../panels/theme_colors_settings/theme_colors_settings.dart';
import '../panels/theme_selector.dart';
import '../panels/toggle_buttons_settings/toggle_buttons_settings.dart';

// Set the bool flag to true to show debug prints. Even if it is forgotten
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off there too. Often I just leave them true if it is one
// I want to see in dev mode, unless it is too chatty.
const bool _debug = !kReleaseMode && false;

/// This is the smaller more focused single panel view of the Themes Playground.
///
/// It shows only one panel at a time as a PageView. This is a nice layout
/// on mid size screen, like tablets, probably preferable on a phone too.
class PanelView extends StatefulWidget {
  const PanelView({
    super.key,
    required this.themeController,
  });
  final ThemeController themeController;

  @override
  State<PanelView> createState() => _PanelViewState();
}

class _PanelViewState extends State<PanelView> with TickerProviderStateMixin {
  late final PageController pageController;
  late final ScrollController scrollCtrl;
  late int previousPage;

  late final AnimationController scaleController = AnimationController(
    duration: const Duration(milliseconds: 280),
    lowerBound: 0.75,
    upperBound: 1.0,
    vsync: this,
  );
  late final Animation<double> scaleAnimation = CurvedAnimation(
    parent: scaleController,
    curve: Curves.fastOutSlowIn,
  );

  late final AnimationController fadeController = AnimationController(
    duration: const Duration(milliseconds: 280),
    lowerBound: 0.1,
    upperBound: 1.0,
    vsync: this,
  );
  late final Animation<double> fadeAnimation = CurvedAnimation(
    parent: fadeController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.themeController.viewIndex,
    );
    previousPage = widget.themeController.viewIndex;
    scrollCtrl = ScrollController();
    scaleController.value = 1.0;
    fadeController.value = 1.0;
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollCtrl.dispose();
    scaleController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeCtrl = widget.themeController;
    final MediaQueryData media = MediaQuery.of(context);
    // Flag used to hide some blend mode options that wont fit when
    // using toggle buttons on small media.
    final bool showAllBlends = media.size.width > 445;
    final bool isPinned = media.size.height >= AppData.pinnedSelector;
    final bool isPhone = media.size.width < AppData.phoneWidthBreakpoint ||
        media.size.height < AppData.phoneHeightBreakpoint;
    final double margins = AppData.responsiveInsets(media.size.width);
    final double buttonHeight = AppData.panelButtonHeight +
        (isPhone ? AppData.panelButtonPhoneHeightReduce : 0);
    final double headerExtent = buttonHeight + media.padding.top + margins * 2;
    if (_debug) {
      debugPrint('headerExtent ............ : $headerExtent');
      debugPrint('margins ................. : $margins');
      debugPrint('kToolbarHeight .......... : $kToolbarHeight');
      debugPrint('media.viewPadding.top.... : ${media.viewPadding.top}');
      debugPrint('media.viewPadding.bottom. : ${media.viewPadding.bottom}');
      debugPrint('media.padding.top ....... : ${media.padding.top}');
      debugPrint('media.padding.bottom..... : ${media.padding.bottom}');
      debugPrint('media.size.width ........ : ${media.size.width}');
      debugPrint('media.size.height ....... : ${media.size.height}');
    }
    return Scrollbar(
      controller: scrollCtrl,
      interactive: false,
      child: NestedScrollView(
        controller: scrollCtrl,
        headerSliverBuilder: (BuildContext context, bool value) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: isPinned,
              floating: true,
              delegate: PanelSelectorHeaderDelegate(
                vsync: this,
                extent: headerExtent,
                controller: themeCtrl,
                page: themeCtrl.viewIndex,
                previousPage: previousPage,
                onSelect: () {
                  if (previousPage != themeCtrl.viewIndex) {
                    setState(() {
                      previousPage = themeCtrl.viewIndex;
                    });
                    // This is handmade scale and fade up animation
                    // when user taps on header item. We use it instead
                    // animating to the page with the page controller.
                    // Instead we jump to the page and trigger a slight
                    // fade and zoom in effect, without it it is hard too
                    // notice that the page changed.
                    scaleController.value = 0.7;
                    fadeController.value = 0.2;
                    scaleController.forward();
                    fadeController.forward();
                    pageController.jumpToPage(themeCtrl.viewIndex);
                  }
                },
              ),
            ),
            // SliverAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: margins),
                child: ThemeSelector(controller: themeCtrl),
              ),
            ),
          ];
        },
        body: PageView.builder(
          controller: pageController,
          itemCount: panelItems.length,
          onPageChanged: (int pageIndex) {
            setState(() {
              previousPage = themeCtrl.viewIndex;
            });
            themeCtrl.setViewIndex(pageIndex);
          },
          itemBuilder: (BuildContext context, int pageIndex) {
            return ScaleTransition(
              scale: scaleAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: <Widget>[
                  PanelPage(IntroductionPanel(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      ThemeColorsSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(SeededColorSchemeSettings(themeCtrl), pageIndex,
                      themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      SurfaceBlendSettings(themeCtrl, allBlends: showAllBlends),
                      pageIndex,
                      themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(EffectiveColors(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(ComponentSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(TextFieldSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(AppBarSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(TabBarSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(BottomNavigationBarSettings(themeCtrl), pageIndex,
                      themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      NavigationBarSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      NavigationRailSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(AndroidNavigationBarSettings(themeCtrl), pageIndex,
                      themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(ButtonsSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      ToggleButtonsSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(FabChipSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      PopupIconButtonSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(SwitchesSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(ListTileSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(DialogSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(BannerBottomSheetSnackSettings(themeCtrl),
                      pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(const MaterialPanel(), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(CardSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(TextThemeSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(
                      PrimaryTextThemeSettings(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(const PageExamples(), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(const WidgetShowcase(), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                  PanelPage(ThemeCode(themeCtrl), pageIndex, themeCtrl,
                      key: ValueKey<int>(pageIndex)),
                ].elementAt(pageIndex),
              ),
            );
          },
        ),
      ),
    );
  }
}

// A PanelPage wrapper that puts the content of our panels, in a ListView
// inside a HeaderCard. The ListView is needed so it grows as far as needed
// inside the page in the PageView.
class PanelPage extends StatelessWidget {
  const PanelPage(
    this.child,
    this.panelPage,
    this.controller, {
    super.key,
  });
  final Widget child;
  final int panelPage;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color iconColor = isLight
        ? Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x99),
            theme.colorScheme.onBackground)
        : Color.alphaBlend(theme.colorScheme.primary.withAlpha(0x7F),
            theme.colorScheme.onBackground);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // A custom breakpoint, when the layout width is larger than 1200dp
      // we show the code panel in a side-by side view, but only if we are not
      // on the last 3 pages, there we do not want it.
      final bool showCodeSideBySide =
          constraints.maxWidth >= AppData.codeViewWidthBreakpoint &&
              panelPage < panelItems.length - 3;
      final double margins =
          AppData.responsiveInsets(MediaQuery.of(context).size.width);

      // We get double implicit scrollbars and that causes issues with the
      // scroll controller.
      return ScrollConfiguration(
        behavior: const NoScrollbarBehavior(),
        // This ListView allows the content in the PageView to scroll
        // vertically as apart of the NestedScroll view the PageView is
        // included in.
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            margins,
            0,
            margins,
            margins + MediaQuery.of(context).padding.bottom,
          ),
          children: <Widget>[
            HeaderCard(
              title: Text(panelItems[panelPage].panelLabel),
              leading: Icon(panelItems[panelPage].icon, color: iconColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: child),
                  if (showCodeSideBySide)
                    Expanded(
                      child: ThemeCode(controller),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
