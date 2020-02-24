keepalived-install:
  file.managed:
    - name: /usr/local/src/{{ pillar[keepalived][version] }}.tar.gz
    - source: salt://keepalived/files/{{ pillar[keepalived][version] }}.tar.gz
    - mode: 755
    - user: root
    - group: root

  cmd.run:
    - name: cd /usr/local/src/ && tar zxf {{ pillar[keepalived][version] }}.tar.gz && cd {{ pillar[keepalived][version] }} && ./configure --prefix=/usr/local/keepalived --disable-fwmark && make && make install && cp /usr/local/keepalived/sbin/keepalived /usr/sbin/
    - unless: test -d /usr/local/keepalived
    - require: 
      - file: keepalived-install

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.sysconfig
    - mode: 644
    - user: root
    - group: root


/etc/init.d/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.init
    - mode: 755
    - user: root
    - group: root

keepalived-init:
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list | grep keepalived
    - require: 
      - file: /etc/init.d/keepalived

/etc/keepalived:
  file.directory:
    - user: root
    - group: root
