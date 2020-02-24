keepalived-install:
  file.managed:
    - name: /usr/local/src/{{ pillar[keepalived][version] }}.tar.gz
    - source: salt://keepalived/files/{{ pillar[keepalived][version] }}.tar.gz
    - mode: 755
    - user: root
    - group: root
