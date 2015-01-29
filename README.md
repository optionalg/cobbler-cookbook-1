# alti-skeleton-cookbook-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

centos

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['alti-skeleton-cookbook']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### alti-skeleton-cookbook::default

Include `alti-skeleton-cookbook` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[alti-skeleton-cookbook::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
