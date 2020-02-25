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
  - path: /root/recover_deployment.sh
    encoding: b64
    permissions: "0744"
    content: IyEvYmluL2Jhc2gKIyMgUnVuIGFzIHJvb3QgaWYgdGhlIGNsb3VkIGluaXQgc2NyaXB0cyBkb2Vzbid0IGZpbmlzaCBjb3JyZWN0bHkKY2hvd24gLVIgc2xlczp1c2VycyAvaG9tZS9zbGVzCnN1ZG8gLUggLXUgc2xlcyBiYXNoIC90bXAvZGVwbG95X2NhYXNwLnNoCg==
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
#  - SUSEConnect --url ${rmt_server_url}
##  - SUSEConnect --url http://rmt.suse.hpc.local
#  - SUSEConnect -p sle-module-containers/15.1/x86_64
#  - SUSEConnect -p caasp/4.0/x86_64 --url ${rmt_server_url}
##  - SUSEConnect -p caasp/4.0/x86_64 --url http://rmt.suse.hpc.local
#  - zypper install --force-resolution --no-confirm --force kernel-default
  - mkdir /public
  - chmod 777 /public
#  - zypper --non-interactive install nfs-kernel-server w3m
  - systemctl --now --no-block enable nfs-server
#  - zypper --non-interactive install -t pattern SUSE-CaaSP-Management
#  - zypper --non-interactive update
  - chown -R sles:users /home/sles
#  - sleep 180
  - sudo -H -u sles bash /tmp/deploy_caasp.sh
#  - sleep 120
  - reboot

bootcmd:
  - ip link set dev eth0 mtu 1400

final_message: "The system is finally up, after $UPTIME seconds"
