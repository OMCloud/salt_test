selinux-config:
  file.managed:
    - name: /etc/selinux/config
    - source: salt://init/files/selinux-config
    - user: root
    - group: root
    - mode: 0644
