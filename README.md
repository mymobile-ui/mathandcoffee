# mathandcoffee

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Pushing your local changes to GitHub

1. Make sure you have [Git](https://git-scm.com/) installed and that your
   GitHub account is configured locally. You can confirm the configuration by
   running `git config user.name` and `git config user.email`.
2. Check that all desired changes are staged and committed:
   ```bash
   git status
   git add <files-to-include>
   git commit -m "Describe your changes"
   ```
3. Add the GitHub repository as a remote if it has not been added yet:
   ```bash
   git remote add origin https://github.com/<username>/<repository>.git
   ```
   Replace `<username>` and `<repository>` with your GitHub username and the
   repository name.
4. Push the committed changes to the main branch (or another branch if you are
   using a different workflow):
   ```bash
   git push origin main
   ```
5. If you are collaborating through pull requests, push to a feature branch
   instead:
   ```bash
   git push origin your-feature-branch
   ```
   Then open a pull request on GitHub.

If you encounter authentication prompts during `git push`, follow the on-screen
instructions to use a personal access token (recommended) or SSH keys.
