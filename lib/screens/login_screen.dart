import 'package:material_ui/material_ui.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.onLoginSuccess, this.onSignUp});

  final VoidCallback? onLoginSuccess;
  final VoidCallback? onSignUp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hasUnsavedInput = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateUnsavedInput);
    _passwordController.addListener(_updateUnsavedInput);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateUnsavedInput);
    _passwordController.removeListener(_updateUnsavedInput);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateUnsavedInput() {
    final hasInput =
        _emailController.text.isNotEmpty || _passwordController.text.isNotEmpty;
    if (hasInput != _hasUnsavedInput) {
      setState(() => _hasUnsavedInput = hasInput);
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    widget.onLoginSuccess?.call();
  }

  Future<void> _handleBlockedPop(bool didPop, Object? result) async {
    if (didPop) return;

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Discard credentials?'),
        content: const Text(
          'You have unsaved input. Do you want to clear the form?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: !_hasUnsavedInput,
      onPopInvokedWithResult: _handleBlockedPop,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _LoginHeader(),
                      const SizedBox(height: 32),
                      AppTextField(
                        controller: _emailController,
                        label: 'Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _passwordController,
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        enableVisibilityToggle: true,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _submit(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        label: 'Sign in',
                        rightIcon: Icons.arrow_forward,
                        fullWidth: true,
                        height: 52,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 12),
                      AppButton(
                        label: 'Create account',
                        variant: AppButtonVariant.text,
                        fullWidth: true,
                        onPressed: widget.onSignUp ?? () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.route_outlined,
            size: 26,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Welcome back',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign in to continue to Flutter Route Kit.',
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
