ansible-postfix Ansible Role
=========================================

This role installs and configures Postfix. It will install a systemd service if
one is not already available too. The systemd service file included in this
role does not support multiple instance of postfix.

Requirements
------------

None.

Role Variables
--------------

* `postfix_tld` (string): TLD used in mailname (mailname will be ${hostname}.${postfix_tld}).
* `postfix_mailname` (string): used by MTA to know its own hostname
* `postfix_disable_local` (boolean): Default is false, if set to true and
`postfix_relay_config` is defined local mail will be disabled.
* `postfix_relay_config` (string): can be used to enable relay functionality
of postfix.
* `postfix_postmap_files` (List): List of files to hash with the postmap binary.
* `postfix_config_templates` (List): List of configuration templates.



Dependencies
------------

None.

Example Playbooks
-----------------

Simplest playbook with local mail only:

```yaml
---
- hosts: servers
  roles:
    - ansible-postfix
```

Playbook with no local mail and configured to use gmail as relay:

```yaml
---
- hosts: servers
  postfix_disable_local: true
  postfix_relay_config: |+
    default_transport = smtp
    relay_transport = relay
    relayhost =  smtp-relay.gmail.com:587
    smtp_always_send_ehlo = yes
    smtp_helo_name = domain.tld
    smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
    smtp_tls_security_level = encrypt
    smtp_tls_mandatory_ciphers = high
    smtp_tls_loglevel = 2
  roles:
    - ansible-postfix
```

Playbook overriding included main.cf template:
```yaml
---
- hosts: servers
  roles:
    - role: ansible-postfix
      postfix_config_templates:
        - src: 'main.cf'
          dest: '/etc/postfix/main.cf'
        - src: 'sasl'
          dest: '/etc/postfix/sasl_password'
      postfix_postmap_files:
        - sasl_password
```

License
-------

[MIT][license]

Author Information
------------------

Author:: [Carlos Hernandez][hurricanehrndz] <[carlos@techbyte.ca](carlos@techbyte.ca)>

[hurricanehrndz]: https://github.com/hurricanehrndz
[license]: http://opensource.org/licenses/MIT
