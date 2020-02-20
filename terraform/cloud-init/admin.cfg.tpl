#cloud-config

# set locale
locale: en_US.UTF-8

# set timezone
timezone: America/Denver

# Set FQDN
fqdn: ${fqdn}

# set root password
chpasswd:
  list: |
    root:linux
    ${username}:${password}
  expire: False

ssh_authorized_keys:
${authorized_keys}

# need to disable gpg checks because the cloud image has an untrusted repo
zypper:
  repos:
${repositories}
  config:
    gpgcheck: "off"
    solver.onlyRequires: "true"
    download.use_deltarpm: "true"

# need to remove the standard docker packages that are pre-installed on the
# cloud image because they conflict with the kubic- ones that are pulled by
# the kubernetes packages
#packages:
#${packages}

write_files:
  - path: /home/sles/.all_nodes
    permissions: "0644"
    content: |
      caasp-master-0.caasp-susecon.lab
      caasp-worker-0.caasp-susecon.lab
      caasp-worker-1.caasp-susecon.lab
  - path: /home/sles/.ssh/config
    encoding: b64
    permissions: "0644"
    content: SE9TVCBjYWFzcC1sYi5jYWFzcC1zdXNlY29uLmxhYiBjYWFzcC1sYiBsYgogIEhPU1ROQU1FIGNhYXNwLWxiLmNhYXNwLXN1c2Vjb24ubGFiCkhPU1QgY2Fhc3AtbWFzdGVyLTAuY2Fhc3Atc3VzZWNvbi5sYWIgY2Fhc3AtbWFzdGVyLTAgbWFzdGVyLTAKICBIT1NUTkFNRSBjYWFzcC1tYXN0ZXItMC5jYWFzcC1zdXNlY29uLmxhYgpIT1NUIGNhYXNwLXdvcmtlci0wLmNhYXNwLXN1c2Vjb24ubGFiIGNhYXNwLXdvcmtlci0wIHdvcmtlci0wCiAgSE9TVE5BTUUgY2Fhc3Atd29ya2VyLTAuY2Fhc3Atc3VzZWNvbi5sYWIKSE9TVCBjYWFzcC13b3JrZXItMS5jYWFzcC1zdXNlY29uLmxhYiBjYWFzcC13b3JrZXItMSB3b3JrZXItMQogIEhPU1ROQU1FIGNhYXNwLXdvcmtlci0xLmNhYXNwLXN1c2Vjb24ubGFiIAoK
  - path: /home/sles/.ssh/id_rsa
    encoding: b64
    permissions: "0600"
    content: LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUJGd0FBQUFkemMyZ3RjbgpOaEFBQUFBd0VBQVFBQUFRRUExSzIwUlBFQVIwaDc3Y3ZHT0lQNGhiM2xKU0IweXVPZmREV0RlTGNRZ2JMcWU4UkhuWjgzCkJpRWduMnlOaTNMOEJrYlpuZzU0U2R3c2dPSTlnUE41M2xqU3FMUSswcUdMV0VNeXovVVpneG4wUzlmcFN4M213RHIwN2UKQ2NSdGNTL0dzdVVIYkYwVEw1cndYQzJiV1ZYeUFrKysra2ZmRjFHemRqbDl5d3dtTHJJTzA4SlhrZFV3UXdBRXM2UktNdApXeGNhenV4THVzZlh3WVJDNDJJb0dRTFB6VEpEYS93VTYyd2NzY3ZDY01jazFxMk9taDI2d0xwVlZsQTV3VUxwdE8wQmQxCkE2bHBZQUgzbEREUTFIK2gzcnhqNWxsZy9nbGJ0RStxTzBGSXovSWZteFppRSswcWFBSHBNNGo3SHpCZHNUNGZ6MUtzMGQKTklQSU9nS0l1d0FBQThpOWpuZjd2WTUzK3dBQUFBZHpjMmd0Y25OaEFBQUJBUURVcmJSRThRQkhTSHZ0eThZNGcvaUZ2ZQpVbElIVEs0NTkwTllONHR4Q0JzdXA3eEVlZG56Y0dJU0NmYkkyTGN2d0dSdG1lRG5oSjNDeUE0ajJBODNuZVdOS290RDdTCm9ZdFlRekxQOVJtREdmUkwxK2xMSGViQU92VHQ0SnhHMXhMOGF5NVFkc1hSTXZtdkJjTFp0WlZmSUNUNzc2Ujk4WFViTjIKT1gzTERDWXVzZzdUd2xlUjFUQkRBQVN6cEVveTFiRnhyTzdFdTZ4OWZCaEVMallpZ1pBcy9OTWtOci9CVHJiQnl4eThKdwp4eVRXclk2YUhickF1bFZXVURuQlF1bTA3UUYzVURxV2xnQWZlVU1ORFVmNkhldkdQbVdXRCtDVnUwVDZvN1FValA4aCtiCkZtSVQ3U3BvQWVremlQc2ZNRjJ4UGgvUFVxelIwMGc4ZzZBb2k3QUFBQUF3RUFBUUFBQVFBdmlkaEdwTHdVTXU2SW04amwKN3hISkMwWkNBenczOGFNOXZZeHltakRWWE9HdTRwUERkc2c4MVlET1FkeHR0RGtEU2lqd2ZIbUV3UE10cCtScGc0TFZJWApPTkJDVWF2Y05BNmx4Y1FZUC9XdmpSVHlTMWhxeUNnV3NvRk5HNXYrOWRmck91aHEzMjhmYi9tVUVSbXRZVm1rREtFNm5vCkFPWFZQSTlGYmE0UTlOVWFJVkJzb3EwTms3aXFlVDY5Wk9LdFM2OHJsK0VBQ2RSTWF4SjU3M0loK2YzL2dBV01LUlltWGQKZ2VJSDQ2NDdlM0FseHhIYmJjNTJnWHltVGlvdjVtTG44dUNscU9CaTdjUUkzUXlKa0RiQlQ4NndHbGtkNG5pQjZWMzV0RgpjVFFNYnpyVmZ6YUFCL1czaHpGR2NjMUpTNGhaOXllQ1gwdkdUYVdVRjErSkFBQUFnUUN2TEU2MkZEODVXemxnQVVZSWttCnAreWw2S3RSNUI0c3pVV1JsNURkSjFCdm5yaVpFSGwxN1NwcVdpcVZRNFVUbFkxRFlSaHQ0NHBoUm1yK1Z2K0lwSHdRa3UKUU0rNXB2THZhTSsxV0lzRGVPNjNpNllBUnBUVkVSZjN4MVVGbWZDN2xKQ09pWVNHT0ViblE2djBDL3dEK0pMQTlXU0V2NQpsQWRCZnZQMUV4TWdBQUFJRUE2OVBrRStxRHpyZVcwU0xyZlNNNGtmeHlpUHh6eXdzMFk0MXo0RjhiME83dklwVVJNaVFzCjhRV2xyN05LOUJ4cjZpS1NNU0RLTlF1SXFCeElyaExFa3ZsTThuSEx0eWlQRkI0RmdVdXdidytzV1JIN1ByTTB6NnVoSkgKQ0JLNEN4ckxDTk1YTXcxNVFSVytHcFM4eFYwMDkxbk5HNUV3V1ZoTmhGNGpFUFBtY0FBQUNCQU9iZTViVDZ5VDB5Y0JNMQpvSlpGWjcxYlIvNUZWa0h6TExFSUZzUG9kclkwN1ZGeVFLNFYrYUtzMG40d3pnSEZYemg5S1l3a2xaa1BXSTlYQjh2RG15CnhEbjBRVjVvR1NIbVRGbThaWWN3LzJyTVh4VGY2UFZMTjNLUWdnVlpQQzF4NkwvOVQwZmx1TWpQZW1NRGNUWVJkMldmanEKZmRkMVpncnY5S1NYNjBhTkFBQUFFSE5zWlhOQVkyRmhjM0F0WVdSdGFXNEJBZz09Ci0tLS0tRU5EIE9QRU5TU0ggUFJJVkFURSBLRVktLS0tLQo=
  - path: /home/sles/.ssh/id_rsa.pub
    encoding: b64
    permissions: "0600"
    content: c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCQVFEVXJiUkU4UUJIU0h2dHk4WTRnL2lGdmVVbElIVEs0NTkwTllONHR4Q0JzdXA3eEVlZG56Y0dJU0NmYkkyTGN2d0dSdG1lRG5oSjNDeUE0ajJBODNuZVdOS290RDdTb1l0WVF6TFA5Um1ER2ZSTDErbExIZWJBT3ZUdDRKeEcxeEw4YXk1UWRzWFJNdm12QmNMWnRaVmZJQ1Q3NzZSOThYVWJOMk9YM0xEQ1l1c2c3VHdsZVIxVEJEQUFTenBFb3kxYkZ4ck83RXU2eDlmQmhFTGpZaWdaQXMvTk1rTnIvQlRyYkJ5eHk4Snd4eVRXclk2YUhickF1bFZXVURuQlF1bTA3UUYzVURxV2xnQWZlVU1ORFVmNkhldkdQbVdXRCtDVnUwVDZvN1FValA4aCtiRm1JVDdTcG9BZWt6aVBzZk1GMnhQaC9QVXF6UjAwZzhnNkFvaTcgc2xlc0BjYWFzcC1hZG1pbgo=
  - path: /tmp/deploy_caasp.sh
    encoding: gz+b64
    permissions: "0744"
    content: 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
  - path: /home/sles/.bashrc
    encoding: b64
    permissions: "0644"
    content: c2V0IC1vIHZpCmFsaWFzIGtnbj0ia3ViZWN0bCBnZXQgbm9kZXMgLW8gd2lkZSIKYWxpYXMga2dkPSJrdWJlY3RsIGdldCBkZXBsb3ltZW50cyAtbyB3aWRlIgphbGlhcyBrZ3A9Imt1YmVjdGwgZ2V0IHBvZHMgLW8gd2lkZSIKYWxpYXMga2dwYT0ia3ViZWN0bCBnZXQgcG9kcyAtbyB3aWRlIC0tYWxsLW5hbWVzcGFjZXMiCmFsaWFzIGthZj0ia3ViZWN0bCBhcHBseSAtZiIKYWxpYXMgc2NzPSJza3ViYSBjbHVzdGVyIHN0YXR1cyIK
  - path: /etc/exports
    encoding: b64
    permissions: "0644"
    content: L3B1YmxpYyAxMC4xMTAuMC4wLzIyKHJ3LG5vX3Jvb3Rfc3F1YXNoKQo=
  - path: /etc/idmapd.conf
    encoding: b64
    permissions: "0644"
    content: W0dlbmVyYWxdCgpWZXJib3NpdHkgPSAwClBpcGVmcy1EaXJlY3RvcnkgPSAvdmFyL2xpYi9uZnMvcnBjX3BpcGVmcwpEb21haW4gPSBjYWFzcC1zdXNlY29uLmxhYgoKW01hcHBpbmddCgpOb2JvZHktVXNlciA9IG5vYm9keQpOb2JvZHktR3JvdXAgPSBub2JvZHkK

runcmd:
  # Since we are currently inside of the cloud-init systemd unit, trying to
  # start another service by either `enable --now` or `start` will create a
  # deadlock. Instead, we have to use the `--no-block-` flag.
#  - [ systemctl, enable, --now, --no-block, haproxy ]
${register_scc}
#  - [ zypper, in, --force-resolution, --no-confirm, --force, podman, kernel-default, cri-o, kubernetes-kubeadm,  kubernetes-client, skuba-update ]
#  - [ reboot ]
  - SUSEConnect --url ${rmt_server_url}
#  - SUSEConnect --url http://rmt.suse.hpc.local
  - SUSEConnect -p sle-module-containers/15.1/x86_64
  - SUSEConnect -p caasp/4.0/x86_64 --url ${rmt_server_url}
#  - SUSEConnect -p caasp/4.0/x86_64 --url http://rmt.suse.hpc.local
  - zypper install --force-resolution --no-confirm --force kernel-default
  - mkdir /public
  - chmod 777 /public
  - zypper --non-interactive install nfs-kernel-server w3m
  - systemctl --now --no-block enable nfs-server
  - zypper --non-interactive install -t pattern SUSE-CaaSP-Management
  - zypper --non-interactive update
  - chown -R sles:users /home/sles
#  - sleep 180
  - sudo -H -u sles bash /tmp/deploy_caasp.sh
  - sleep 120
  - reboot

bootcmd:
  - ip link set dev eth0 mtu 1400

final_message: "The system is finally up, after $UPTIME seconds"
