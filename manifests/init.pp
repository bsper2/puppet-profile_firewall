# @summary Initial firewall configuration
#
# @param ignores
#   Lists of regex's telling Puppet to NOT remove matching rules, even if the
#   rules were not added by Puppet.
#
#   Keys must be in "CHAIN:TABLE:PROTOCOL" format.
#   Values must be an Array of strings in Ruby regex format.
#   See README for some basic examples, or the following for more details:
#   https://forge.puppet.com/puppetlabs/firewall/reference#firewallchain
#
# @param pre
#   Exceptions to start the firewall rules
#   Keys must begin with a 3-digit numer followed by a comment.
#   The 3-digit number indicates firewall rule order, lower numbered rules are
#   added before higher numbers.
#   See README for some basic examples, or the following for more details:
#   https://forge.puppet.com/puppetlabs/firewall/readme#beginning-with-firewall
#
# @param post
#   Exceptions to end the firewall rules.
#   Keys must begin with a 3-digit numer followed by a comment.
#   The 3-digit number indicates firewall rule order, lower numbered rules are
#   added before higher numbers.
#   See README for some basic examples, or the following for more details:
#   https://forge.puppet.com/puppetlabs/firewall/readme#beginning-with-firewall
#
# @param inbuilt_chains
#   Default Linux chains. Module defaults should be sufficient.
#   Keys must be in "CHAIN:TABLE:PROTOCOL" format.
#   Values must be Hash of valid puppetlabs::firewallchain parameters
#
# @example
#   include profile_firewall
class profile_firewall (
  Hash $ignores,
  Hash $inbuilt_chains,
  Hash $post,
  Hash $pre,
) {

  # DON'T EVER DO THIS ---
  # SEE: https://tickets.puppetlabs.com/browse/MODULES-5171
  # specifically..."using the resources resource will just purge 
  #                 all resources independent of the ignore statement"
  # resources { 'firewall':
  #   purge =>  true,
  # }
  # resources { 'firewallchain':
  #   purge =>  true,
  # }
  # --- YOU HAVE BEEN WARNED

  class { 'firewall':
    ebtables_manage => true,
  }

  # CREATE DEFAULT CHAINS
  $default_params = {
    ensure => present,
    purge  => true,
  }
  $inbuilt_chains.each | $chain_name, $inbuilt_params | {

    # Combine params from hiera with chain defaults
    $custom_params = $inbuilt_params ? {
      undef   => $default_params,
      default => $default_params + $inbuilt_params,
    }

    # Add any ignores for this chain
    $chain_params = $ignores[$chain_name] ? {
      undef   => $custom_params,
      default => $custom_params + { ignore => $ignores[$chain_name] },
    }

    # Debugging
    # $chain_params.each | $key, $val | {
    #   notify {"FWchain ${chain_name} ${key} ${val}" :}
    # }

    firewallchain { $chain_name :
        * => $chain_params,
    }

  }

  create_resources( firewall, $pre )
  create_resources( firewall, $post )

}
