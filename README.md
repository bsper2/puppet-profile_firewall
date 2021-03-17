# profile_firewall

[![pdk-validate](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/pdk-validate.yml/badge.svg)](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/pdk-validate.yml) [![yamllint](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/yamllint.yml/badge.svg)](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/yamllint.yml)

Configures iptables firewall

By default firewall will be modified to only allow:
- All icmp traffic
- All lo traffic
- All Related,Established traffic
- Blocks everything else

See usage for how to modify/add firewall rules

## Usage

TODO fill this out

-Add note about running it twice

### Adding firewall rules

### Ignore a firewall rule

By deault, Puppet will delete any firewall rules that are not set by Puppet itself. Ideally you should add all rules to be managed by puppet, but this module does allow you to designate a firewall rule so that it is not deleted.


## Dependencies

- [puppetlabs/firewall](https://forge.puppet.com/modules/puppetlabs/firewall)

## Reference

### class profile_firewall (
-  Hash $ignores,
-  Hash $inbuilt_chains,
-  Hash $post,
-  Hash $pre,

See: [REFERENCE](REFERENCE.md)

