# nessus-cookbook

This cookbook installs and registers a Nessus scanner. It can also add users to the Nessus scanner.

## Supported Platforms

Linux
  - Redhat Family (RHEL, Centos, Fedora, Scientific
  - Debian Family (Debian, Ubuntu)
  
Windows - coming soon

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nessus']['register']</tt></td>
    <td>Boolean</td>
    <td>register scanner.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nessus']['create_user']</tt></td>
    <td>Boolean</td>
    <td>create user accounts with nessuscli.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nessus']['installer_file_url']</tt></td>
    <td>String</td>
    <td>URL where the installer file can be found to pull down with remote_file resource.
    Also determins whether to use a repository. Set to nil to use package repository.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['nessus']['installer_file']</tt></td>
    <td>String</td>
    <td>Name of installation file.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['nessus']['fetch_type']</tt></td>
    <td>String</td>
    <td>Method to register scanner using nessuscli fetch</td>
    <td><tt>security-center</tt></td>
  </tr>
  <tr>
    <td><tt>['nessus']['user_databags']</tt></td>
    <td>Array</td>
    <td>Array of data bags files holding user information</td>
    <td><tt>['agent', 'user']</tt></td>
  </tr>

</table>

## Usage

### nessus::default

Include `nessus` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[nessus::default]"
  ]
}
```

## ToDo

  - Move registration serial to data bag.
  - Add windows installation support

## License and Authors

Author:: Daniel Washko(<dwashko@gannett.com>)
