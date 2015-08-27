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



* Writing A Unit

  [Unit]
  Description=Daemon to detect crashing apps
  After=syslog.target
  [Service]
  ExecStart=/usr/sbin/abrtd
  Type=forking
  [Install]
  WantedBy=multi-user.target 
  
The [Unit] section contains generic information about the service. systemd
the daemon shall be started after Syslog
[Service] which encodes information about the service itself. It contains all those settings that apply only to services, and not the other kinds of units systemd maintains (mount points, devices, timers, ...)
ExecStart= takes the path to the binary to execute when the service shall be started up.
Type= configures how the service notifies the init system that it finished starting up.
[Install]. It encodes information about how the suggested installation should look like, i.e. under which circumstances and by which triggers the service shall be started. In this case we simply say that this service shall be started when the multi-user.target unit is activated. This is a special unit (see above) that basically takes the role of the classic SysV Runlevel 3.
WantedBy= has little effect on the daemon during runtime. It is only read by the systemctl enable command, which is the recommended way to enable a service in systemd. This command will simply ensure that our little service gets automatically activated as soon as multi-user.target is requested, which it is on all normal boots[4].

cp myunit.txt /etc/systemd/system/<service>.service
systemctl daemon-reload
systemctl start abrtd.service
systemctl status abrtd.service
systemctl stop abrtd.service
systemctl enable abrtd.service => enable it after 


* References

[systemd-for-admins-1](http://0pointer.de/blog/projects/systemd-for-admins-1.html)
