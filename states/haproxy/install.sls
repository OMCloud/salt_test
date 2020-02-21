include:
  - pkg.pkg-init

haproxy-install:
  file.managed:
    - name: /usr/local/src/{{ pillar['haproxy']['version'] }}.tar.gz
    - source: salt://haproxy/files/{{ pillar['haproxy']['version'] }}.tar.gz
    - mode: 755
    - user: root
    - group: root

  cmd.run:
    - name: cd /usr/local/src/ && tar xvf {{ pillar['haproxy']['version'] }}.tar.gz && cd {{ pillar['haproxy']['version'] }} && make TARGET=linux2628 PREFIX=/usr/local/haproxy && make install PREFIX=/usr/local/haproxy && cp /usr/local/haproxy/sbin/haproxy /usr/sbin/
    - unless: test -d /usr/local/haproxy
    - require:
      - pkg: pkg-init
      - file: haproxy-install

/etc/init.d/haproxy:
  file.managed:
    - source: salt://haproxy/files/haproxy.init
    - mode: 755
    - user: root
    - group: root
    - require:
      - cmd: haproxy-install

haproxy-config-dir:
  file.directory:
    - name: /etc/haproxy
    - mode: 755
    - user: root
    - group: root

haproxy-init:
  cmd.run:
    - name: chkconfig --add haproxy
    - unless: chkconfig --list | grep haproxy
    - require:
      - file: /etc/init.d/haproxy
