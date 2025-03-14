//These wrap our button styles provided by the app design guide
import 'package:flutter/material.dart';
import 'package:moticar/utils/design_colours.dart';
import 'package:moticar/utils/design_spacing.dart';

class _Constants {
  static const buttonPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 20.0,
  );
}

class PrimaryButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool pending;
  final Function()? onPressed;

  const PrimaryButton(
      {super.key,
        required this.title,
        this.onPressed,
        this.pending = false,
        this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onPrimary,
        leadingDistribution: TextLeadingDistribution.even);
    final style = ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: _Constants.buttonPadding,
        disabledForegroundColor: DesignColours.lightBlue.withValues(alpha: 0.38),
        disabledBackgroundColor: DesignColours.lightBlue.withValues(alpha: 0.12));
    final content = Text(title, style: textStyle);
    if (pending) {
      return ElevatedButton(
          onPressed: null,
          style: style,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              Visibility(
                  visible: false,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child:
                  content), //LH We do this to maintain the size of the button when pending
            ],
          ));
    }
    if (icon != null) {
      return ElevatedButton.icon(
        icon: Icon(icon),
        onPressed: onPressed,
        style: style,
        label: content,
      );
    }
    return ElevatedButton(onPressed: onPressed, style: style, child: content);
  }
}

class SecondaryButton extends StatelessWidget {
  final String title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool pending;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Size? minSize;
  final Function()? onPressed;

  const SecondaryButton(
      {super.key,
        required this.title,
        this.onPressed,
        this.pending = false,
        this.leadingIcon,
        this.trailingIcon,
        this.borderColor,
        this.foregroundColor,
        this.backgroundColor,
        this.minSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
        color: foregroundColor ?? DesignColours.textBlack,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        leadingDistribution: TextLeadingDistribution.even);
    final style = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      shape: StadiumBorder(
          side:
          BorderSide(color: borderColor ?? Colors.black.withValues(alpha: 0.12))),
      padding: _Constants.buttonPadding,
      minimumSize: minSize,
    );
    final content = _ButtonContent(
        title: Text(
          title,
          style: textStyle,
        ),
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon);
    if (pending) {
      return ElevatedButton(
          onPressed: null,
          style: style,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              Visibility(
                  visible: false,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child:
                  content), //LH We do this to maintain the size of the button when pending
            ],
          ));
    }

    return ElevatedButton(onPressed: onPressed, style: style, child: content);
  }
}

class ErrorButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool pending;
  final Function()? onPressed;

  const ErrorButton(
      {super.key,
        required this.title,
        this.onPressed,
        this.pending = false,
        this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = TextButton.styleFrom(
      backgroundColor: theme.colorScheme.error,
      padding: _Constants.buttonPadding,
    );
    final content = Text(title);
    if (pending) {
      return TextButton(
          onPressed: null,
          style: style,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              Visibility(
                  visible: false,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child:
                  content), //LH We do this to maintain the size of the button when pending
            ],
          ));
    }
    if (icon != null) {
      return TextButton.icon(
        icon: Icon(icon),
        onPressed: onPressed,
        style: style,
        label: content,
      );
    }
    return TextButton(onPressed: onPressed, style: style, child: content);
  }
}

class _ButtonContent extends StatelessWidget {
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget title;

  const _ButtonContent(
      {this.leadingIcon, this.trailingIcon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (leadingIcon != null) ...[
          leadingIcon!,
          const SizedBox(width: DesignSpacing.itemSpacingCompact)
        ],
        title,
        if (trailingIcon != null) ...[
          const SizedBox(width: DesignSpacing.itemSpacingCompact),
          trailingIcon!
        ],
      ],
    );
  }
}