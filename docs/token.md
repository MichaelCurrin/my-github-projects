# Token
> Create a GitHub API token

This project relies on create a GitHub API access token with read-only access to your own repos.
 The token is then sent to GitHub API on a POST request.


To set this up:

1. Open **Personal access tokens** page on your GitHub account.
    1. Settings page.
    2. Developer Settings.
    3. [Tokens](https://github.com/settings/tokens) page.
2. Grant **read-only** permissions to your public repos.
    - Tick the `public_repo` option only.
3. **Create** the token.
4. **Copy** the token value.
    - The value will **not** be visible after you leave this screen, however, you can always regenerate the token value.

You may continue to the [Remote](remote.md) or local [Installation](installation.md) steps, where you will add the token to your secret environment variables.
