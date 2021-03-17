# profile_firewall

[![pdk-validate](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/pdk-validate.yml/badge.svg)](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/pdk-validate.yml) [![yamllint](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/yamllint.yml/badge.svg)](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/yamllint.yml)

Configures iptables firewall

By default this module will modify the firewall so that it will:
- Accept all icmp traffic
- Accept all lo traffic
- Accept all Related,Established traffic
- Blocks everything else

See usage for how to modify/add firewall rules

## Usage

-Add note about running it twice

### Adding firewall rules

Rules are added through hiera using the hash `profile_firewall::pre`

Keys must start with a 3-digit numer followed by a comment. The 3-digit number indicates firewall rule order, lower numbered rules are added before higher numbers.

Example Rules
```
profile_firewall::pre:
  "003 Allow traffic for port 45 from 10.0.0.0/8":
    proto: "tcp"
    dport: "45"
    source: "10.0.0.0/8"
    action: "accept"
  "004 Allow multiple ports on specific interface":
    proto: "tcp"
    dport: ["22", "25"]
    source: "10.0.0.0/8"
    iniface: "eth0"
    action: "accept"
```

### Ignore a firewall rule

By deault, Puppet will delete any firewall rules that are not set by Puppet itself. Ideally you should add all rules to be managed by puppet, but this module does allow you to designate a firewall rule so that it is not deleted.

This is done by setting this value in hiera `profile_firewall::ignores`

Keys must be in "CHAIN:TABLE:PROTOCOL" format. Values must be an Array of strings in Ruby regex format.

Example that tells puppet to leave any rule that has the string `Keep this`
```
profile_firewall::ignores:
  INPUT:filter:IPv4: "Keep this"
```

## Dependencies

- [puppetlabs/firewall](https://forge.puppet.com/modules/puppetlabs/firewall)

## Reference

### class profile_firewall (
-  Hash $ignores,
-  Hash $inbuilt_chains,
-  Hash $post,
-  Hash $pre,

See: [REFERENCE](REFERENCE.md)

