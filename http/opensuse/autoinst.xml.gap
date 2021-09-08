<?xml version="1.0"?>
<!DOCTYPE profile>

<!-- http://doc.opensuse.org/projects/autoyast/configuration.html -->

<profile xmlns="http://www.suse.com/1.0/yast2ns" 
    xmlns:config="http://www.suse.com/1.0/configns">
    <general>
        <mode>
            <confirm config:type="boolean">false</confirm>
            <forceboot config:type="boolean">true</forceboot>
            <final_reboot config:type="boolean">false</final_reboot>
        </mode>
    </general>
    <report>
        <messages>
            <show config:type="boolean">false</show>
            <timeout config:type="integer">10</timeout>
            <log config:type="boolean">true</log>
        </messages>
        <warnings>
            <show config:type="boolean">true</show>
            <timeout config:type="integer">10</timeout>
            <log config:type="boolean">true</log>
        </warnings>
        <errors>
            <show config:type="boolean">true</show>
            <timeout config:type="integer">10</timeout>
            <log config:type="boolean">true</log>
        </errors>
    </report>

    <keyboard>
        <keymap>english-us</keymap>
    </keyboard>
    <language>
        <language>en_US</language>
        <languages>en_US</languages>
    </language>
    <timezone>
        <hwclock>UTC</hwclock>
        <timezone>Etc/UTC</timezone>
    </timezone>
    <partitioning config:type="list">
        <drive>
            <enable_snapshots config:type="boolean">false</enable_snapshots>
            <initialize config:type="boolean">true</initialize>
            <partitions config:type="list">
                <partition>
                    <create config:type="boolean">true</create>
                    <crypt_fs config:type="boolean">false</crypt_fs>
                    <filesystem config:type="symbol">swap</filesystem>
                    <format config:type="boolean">true</format>
                    <fstopt>defaults</fstopt>
                    <loop_fs config:type="boolean">false</loop_fs>
                    <mount>swap</mount>
                    <mountby config:type="symbol">uuid</mountby>
                    <partition_id config:type="integer">130</partition_id>
                    <partition_nr config:type="integer">1</partition_nr>
                    <raid_options/>
                    <resize config:type="boolean">false</resize>
                    <size>512M</size>
                </partition>
                <partition>
                    <create config:type="boolean">true</create>
                    <crypt_fs config:type="boolean">false</crypt_fs>
                    <filesystem config:type="symbol">btrfs</filesystem>
                    <format config:type="boolean">true</format>
                    <loop_fs config:type="boolean">false</loop_fs>
                    <mount>/</mount>
                    <mountby config:type="symbol">uuid</mountby>
                    <partition_id config:type="integer">131</partition_id>
                    <partition_nr config:type="integer">2</partition_nr>
                    <raid_options/>
                    <resize config:type="boolean">false</resize>
                    <size>max</size>
                    <subvolumes config:type="list">
                        <listentry>boot/grub2/i386-pc</listentry>
                        <listentry>boot/grub2/x86_64-efi</listentry>
                        <listentry>home</listentry>
                        <listentry>opt</listentry>
                        <listentry>srv</listentry>
                        <listentry>tmp</listentry>
                        <listentry>usr/local</listentry>
                        <listentry>var/crash</listentry>
                        <listentry>var/lib/mailman</listentry>
                        <listentry>var/lib/named</listentry>
                        <listentry>var/lib/pgsql</listentry>
                        <listentry>var/log</listentry>
                        <listentry>var/opt</listentry>
                        <listentry>var/spool</listentry>
                        <listentry>var/tmp</listentry>
                    </subvolumes>
                </partition>
            </partitions>
            <pesize/>
            <type config:type="symbol">CT_DISK</type>
            <use>all</use>
        </drive>
    </partitioning>

    <bootloader>
        <loader_type>grub2</loader_type>
    </bootloader>

    <networking>
        <ipv6 config:type="boolean">false</ipv6>
        <keep_install_network config:type="boolean">true</keep_install_network>
        <dns>
            <dhcp_hostname config:type="boolean">true</dhcp_hostname>
            <dhcp_resolv config:type="boolean">true</dhcp_resolv>
            <domain>pietro.local</domain>
            <hostname>opensuse-leap-x64</hostname>
        </dns>
        <interfaces config:type="list">
            <interface>
                <bootproto>dhcp</bootproto>
                <device>eth0</device>
                <startmode>auto</startmode>
                <usercontrol>no</usercontrol>
            </interface>
        </interfaces>
    </networking>

    <firewall>
        <enable_firewall config:type="boolean">true</enable_firewall>
        <start_firewall config:type="boolean">true</start_firewall>
    </firewall>

    <software>
        <image/>
        <instsource/>
        <packages config:type="list">
            <package>curl</package>
            <package>gcc</package>
            <package>glibc-locale</package>
            <package>grub2-branding-openSUSE</package>
            <package>grub2</package>
            <package>iputils</package>
            <package>kernel-default-devel</package>
            <package>kernel-default</package>
            <package>make</package>
            <package>man</package>
            <package>wget</package>
            <package>curl</package>
            <package>vim</package>
            <package>cloud-init</package>
            <package>net-tools-deprecated</package>
            <package>perl</package>
            <package>rsyslog</package>
            <package>sudo</package>
            <package>wget</package>
            <package>yast2-firstboot</package>
            <package>yast2-trans-en_US</package>
            <package>yast2</package>
            <package>zypper</package>
        </packages>
        <patterns config:type="list">
            <pattern>sw_management</pattern>
            <pattern>yast2_install_wf</pattern>
            <pattern>minimal_base</pattern>
        </patterns>
        <remove-packages config:type="list">
            <package>bash-completion</package>
            <package>telnet</package>
            <package>virtualbox-guest-kmp-default</package>
            <package>virtualbox-guest-tools</package>
            <package>snapper</package>
            <package>snapper-zypp-plugin</package>
        </remove-packages>
    </software>
    <services-manager>
        <default_target>multi-user</default_target>
        <services>
            <disable config:type="list"/>
            <enable config:type="list">
                <service>sshd</service>
            </enable>
        </services>
    </services-manager>
    <groups config:type="list">
        <group>
            <gid>100</gid>
            <groupname>users</groupname>
            <userlist/>
        </group>
    </groups>
    <user_defaults>
        <expire/>
        <group>100</group>
        <groups/>
        <home>/home</home>
        <inactive>-1</inactive>
        <no_groups config:type="boolean">true</no_groups>
        <shell>/bin/bash</shell>
        <skel>/etc/skel</skel>
        <umask>022</umask>
    </user_defaults>

    <users config:type="list">
        <user>
            <user_password>$6$rounds=4096$nzQEF180AoRzif8$LGrhp/3J/c.Y.DRZZwjPKFfmk9z.vqekzIzkhxL7tFo.E3c6UL.WEpxPHYQwMkDoI9wtR09vPK8JrNRq.ruxY0</user_password>
            <encrypted config:type="boolean">true</encrypted>
            <username>root</username>
        </user>
        <user>
            <fullname>Cloud User</fullname>
            <gid>100</gid>
            <home>/home/cloud-user</home>
            <password_settings>
                <expire/>
                <flag/>
                <inact>-1</inact>
                <max>99999</max>
                <min>0</min>
                <warn>7</warn>
            </password_settings>
            <shell>/bin/bash</shell>
            <uid>1000</uid>
            <encrypted config:type="boolean">true</encrypted>
            <user_password>$6$rounds=4096$nzQEF180AoRzif8$LGrhp/3J/c.Y.DRZZwjPKFfmk9z.vqekzIzkhxL7tFo.E3c6UL.WEpxPHYQwMkDoI9wtR09vPK8JrNRq.ruxY0</user_password>
            <username>cloud-user</username>
        </user>
    </users>
    <kdump>
        <add_crash_kernel config:type="boolean">false</add_crash_kernel>
    </kdump>
</profile>
