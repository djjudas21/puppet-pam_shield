# Changelog

## 2.0.0

* Update to `puppet/selinux` >= 1.0.0

Version 2.0.0 is exactly the same as 1.1.2, except that it requires `puppet/selinux`
>= 1.0.0, which is not backwards compatible with `puppet/selinux` < 1.0.0. Test carefully
before upgrading `puppet/selinux`, because everything that calls it to load a policy
will need to update its calling syntax.

## 1.1.2

* First entry in the changelog
