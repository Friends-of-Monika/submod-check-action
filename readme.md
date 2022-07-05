# Submod Check Action

Simple composite action for GitHub Actions workflows to perform checks on
your submod codebase.

## Usage

*For complete example see [submod-check-example.](https://github.com/friends-of-monika/submod-check-example)*

Add this step to your workflow `steps` section (make sure it goes
*after* `actions/checkout`):

```yaml
# ... the rest of your workflow .yml file ...
- name: "Check"
   uses: "friends-of-monika/submod-check-action@v2"
```