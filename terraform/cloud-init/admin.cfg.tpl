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
    content: H4sICPs6M14AA2RlcGxveV9jYWFzcC5zaACVV+9T20YQ/Wz9FRvbM0Ab2SUfQ0iHEBNcGqCBNNNpOs5ZOuGr5TuNTsJxKfnb+/b0m0BD/AEs3e673be7786DJ+O50uO5sAvPG+BDF0GqkoyUJbyUIRlNuVX6igQFUmepiMnKjExEFxfHtJQbS4XjNCoNswWc1ypb0KVMUxGZdEWhTGKzAVwQ5zaTKWkTSvuUtMS7zNBKLCXZPJXwlgWeg845hPmG35IIV0o7RxIwTEySxyLDOt7yegd6i76MR9YuxiLPFiZV/8hw5hAjFcsHAxb3hdzs28QLi7VIQ7evg8W7boxMJ9BsxktWSlIRCb2porS0ENeS5lJqxK8yJWKOkaLUrIqAWlAyWBjqXwI/MnFs1hx0UCQbqlQGGRKUSEGmbJHr8Hnfs3mIMJUOaUy+FivEmc8lQP2/jdKjwOhoFNKzl+NQXo91HsdF/R/78QZ0qNIgVxnNU4nqpcwJktKh9U0UlfSt0DI0+D5keY0eG26jeL64gv+O576GYVVSFc5SKzoES+2ap25JbhBxLVQs5rEsC7Zqd4mHcjyhCtiPyethVeNfQTYjlUVGVWpMbbIGd9T3esgd7nqX/IT6U1uUbmEQVZKaaxUW/dU0ZxXhz7S9GeudPp1M/pgdn11cer0A80bD6hld4fV6mx38KSLafid3bCbSjCFrchBCb6liEHYD6NnBm8np5ex8+vqW/ZjIfptJti5zxre9Pfz5odlhoqsJfEwGqDU4IeyhwiYeSnOt2QWo2wuls+eUpRviEJ2IYAIqi9pni2kD9y47QGq5huyggDqsK9SOgHffGWGDyWfl2AhzV+NYBEsWpruRcp16ErZlztKKoOcNejK2kIKvSigyiqVA/hwD4OoZtwuz1iTm5rogCevWKUKtCZ0Wa5f4AiLZFPiCiztw1R1U5B8ajVxyx7YB6ucMfMiExY2B71Shz47IZeAKWIM8npBByUgFU3ASKc+N1XmprbZIXiPvGbdEIZ+FVvLK0W+vTyuKOvLLE0+XhstXKiuIixU6BiIBHlFn1qSnFID9DKUmN9msSuqK+JzZOD1xOFIEi0L31wuWODceCVQsa3TXYXPD8OLpwdvJHQOO1OkI5x8gGv+Y/IgVRcTxzMVMLyuBaSVc8DGtFbpsz0pF3ImJ4/DgfDqbnL4+P5ueXra3rMiJDXpsLmKhA1D0+/SceSjXVsLxhkK7BsFbQXwuxfVSo6XeoL3TfrHu/zQKhLCJb3FcgsIR1Mnr2A23r1L0UgnXSfpfWrj+30UbHf76/uJy8m7G/O2XYF7n5WOA8E2sl+QfjWjrJklRheGz260djyX3T/JD6n8ZD2/asLd9+os81oBKfg/LZuJzMOYB3bRPyRGVjY7Bdl3MfRvgfNgji1NO1L3IPuT7SCNLTewn4B8T2CnWsB0Ig3RfuPK/MiazuPoknUavpyBSKdSi5MT1aaxseTFpU+S9PXDA3BiPLEnhAWNHy7AFcA/Lu47lggEXxryO2/dRTUxeDHjfd3cD34fcXqF3hzct2Nv68dal/ospb1epXAnldLuVaD1e7Xn4wMeRVask3uDqlghr6xvat/ubh76dJTw//Q9RGY5iaPePzz7tEXL6WBH26ZF8we1jmzG+G4EZNEsd3D3UffQa8tpblA+MGeJw6BK4NunyIdo46w9n706+yrp0amddZVrYV5m2vb8703KXb2Ta3qJ8aDLlVE9c4atT3bv/WoKPi1h+TvgUOHn/anJ4dno0fbM/vDk+gxbc1Yaxuwi7Cyu9dBLNv1bSwBsEInvxYnJ21H3Lv058Q9fKGxSnwvJK7/f58htkMXEmRQlgs1ah7DdmYdes6cr7jJOucWLCe63Ew2bgGEV1d3ObiEDaxk9EjZtIeJD8CKvI1fNGrWRZru5n7a4S4m6V5dZ7kAauy3/N6PzeDQ4AAA==
  - path: /home/sles/.bashrc
    encoding: b64
    permissions: "0644"
    content: c2V0IC1vIHZpCmFsaWFzIGtnbj0ia3ViZWN0bCBnZXQgbm9kZXMgLW8gd2lkZSIKYWxpYXMga2dkPSJrdWJlY3RsIGdldCBkZXBsb3ltZW50cyAtbyB3aWRlIgphbGlhcyBrZ3A9Imt1YmVjdGwgZ2V0IHBvZHMgLW8gd2lkZSIKYWxpYXMga2dwYT0ia3ViZWN0bCBnZXQgcG9kcyAtbyB3aWRlIC0tYWxsLW5hbWVzcGFjZXMiCmFsaWFzIGthZj0ia3ViZWN0bCBhcHBseSAtZiIK
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
  - SUSEConnect --url http://rmt.suse.hpc.local
  - SUSEConnect -p sle-module-containers/15.1/x86_64
  - SUSEConnect -p caasp/4.0/x86_64 --url http://rmt.suse.hpc.local
  - zypper install --force-resolution --no-confirm --force kernel-default
  - mkdir /public
  - chmod 777 /public
  - zypper --non-interactive install nfs-kernel-server
  - sudo systemctl --now enable nfs-server
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
