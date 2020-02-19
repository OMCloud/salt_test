/etc/my.cnf:
  file.managed:
    - name: /tmp/my.cnf
    - source: salt://files/my.cnf
    - template: jinja
    - defaults:
       PORT: {{ pillar['mysql']['PORT'] }}
       MAX_CONNECTIONS: 500 
