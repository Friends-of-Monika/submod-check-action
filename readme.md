# Submod Check Action

Simple composite action for GitHub Actions workflows to perform checks on
your submod codebase.

## Usage

*For complete example see [submod-check-example.](https://github.com/friends-of-monika/submod-check-example)*

Download Doki Doki Literature Club Windows distribution package from [here](https://ddlc.moe/)
and host it *secretly* somewhere (for example, you can upload it to your Google
Drive and share it, obtaining unqiue share link only you should know).

Create repository secret (go to Settings > Secrets > Actions), name it
`DDLC_DOWNLOAD_URL` and paste your download link into its value.

Finally, add this step to your workflow `steps` section (make sure it goes
*after* `actions/checkout`):

```yaml
# ... the rest of your workflow .yml file ...
- name: "Check"
  uses: "friends-of-monika/submod-check-action@v1"
  with:
    ddlc-url: "${{ secrets.DDLC_DOWNLOAD_URL }}"
```