# profile_firewall

[![pdk-validate](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/pdk-validate.yml/badge.svg)](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/pdk-validate.yml) [![yamllint](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/yamllint.yml/badge.svg)](https://github.com/ncsa/puppet-profile_firewall/actions/workflows/yamllint.yml)

Sets a default secure firewall that only allows:
- All icmp traffic
- All lo traffic
- All Related,Established traffic
- Blocks everything else

## Usage

## Reference

### class profile_firewall (
-  Boolean $manage_builtin_chains = true,
### class profile_firewall::builtin_chains (
-  Hash[ String[1], Hash[ String[1], Array, 1 ], 1 ] $tables,

See: [REFERENCE](REFERENCE.md)

## Contributing
