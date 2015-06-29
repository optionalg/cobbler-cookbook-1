# alti_skeleton-cookbook

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
    <td><tt>['alti']['skeleton']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### alti_skeleton::default

Include `alti_skeleton` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[alti_skeleton::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
