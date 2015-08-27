* Utilities

systemctl: check the status of currentunits

    [root@lambda] ~# systemctl
    UNIT                                          LOAD   ACTIVE       SUB          JOB             DESCRIPTION
    dev-hugepages.automount                       loaded active       running                      Huge Pages File System Automount Point
    proc-sys-fs-binfmt_misc.automount             loaded active       waiting                      Arbitrary Executable File Formats File System Automount Point
    ntpd.service                                  loaded maintenance  maintenance                  Network Time Service
    avahi-daemon.socket                           loaded active       listening                    Avahi mDNS/DNS-SD Stack Activation Socket

  LOAD   = Reflects whether the unit definition was properly loaded.
  ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
  SUB    = The low-level unit activation state, values depend on unit type.
  JOB    = Pending job for the unit.

221 units listed. Pass --all to see inactive units, too.

 * UNIT column
   * name of unit
 * ACTIVE column
   * active
   * inactive
   * maintenance => error
   
  ~# systemctl status ntpd.service
    ntpd.service - Network Time Service
      Loaded: loaded (/etc/systemd/system/ntpd.service)
      Active: maintenance
      Main: 953 (code=exited, status=255)
      CGroup: name=systemd:/systemd-1/ntpd.service

* References

[systemd-for-admins-1](http://0pointer.de/blog/projects/systemd-for-admins-1.html)
