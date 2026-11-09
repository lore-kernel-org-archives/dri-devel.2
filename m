Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D2606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=lDa5l2x7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2007F10E26D;
	Mon,  9 Nov 2026 20:58:05 +0000 (UTC)
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C484610E26D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1794257878; bh=wYqquk6SPvkJFiwXkBubwliKKN5e9OCXPUckD5D6B5M=;
 h=Subject:From:To:Cc:Date:References:From:Subject:Reply-To;
 b=lDa5l2x7VbPXr1UEhkFwo+XoA/XGPb/TPYd7MdWsRL3u6o8K7Iurd5jf3+8gxpYPz/OCGFdMVEQ1EkisSbQfn4JP4+JOeNZFGvn/xb7EXdShWTeUjXHdzkE4hPUEW4nTCs9GSWnxytdnoHoVx1YgCMmoe8EmGZ2a8xy2uNkIt0h/yZHrc1T9Mi8imUVqIODvaDvHQRQmspI/tSGRvv6/osQeuigCoin4IOW3UVkHxyg1egluFz85o1HTH/uQeFik/K3GBc4i0BZ/myWDnTMBcdX0ts2CC0Sty6DM72bO+j+qLRrXmZ9vrtCRHX+WdAToWX7Pgy5OB/gZp+st7UUyBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794257878; bh=m/qPLzjJx3LnfJXeg8rkOOXKsoh7Rp3BzhW2xggu3/F=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=RPqWv/sNV9arvKpmEHkv0ODl8OcOMTgZ/aLsVdRKx5QUHa5fAqzoS+2aadTWEV+C+0iqAOZMFN3vGugdINkwxZx/u4N47tFzXMzfSD/qrIvLi9Ah7daGuGGPK5+51D1LdmF2105w+CaLSi/AQYg424Sik+CXjrfhTEbnFEykulK25v5doTWMjHeaGjMM68YiU/tN6ypgu8QkGEY7lc2vnEP8lYvMi2pshILtw+2LbraAwlF9ZIQSe/zMdLphViNy1WPpJ5I0q88pVzdgtrQ5pWRwEb66NhRxmWUXVOA0ENEHEcOIAd+Kq3fq2udVUylRUwkIrt/DtiHZRfQ1y2yHzg==
X-YMail-OSG: rxiHsZQVM1kH8Cuus4X4ulQ8i7sFOO3wwQ1Z71fW7vapw3SmWhksYY_z1xicH2Z
 O4a0TmwIe.0YSglHQztb998XA62AsTuhquooOae2Xm_BEhbIQ551hEaIYGuIHrnpNpT17SBT55yP
 4l2UlU50NeuezSpe_D56KJWRrb0fWouPZ1wPdPNL69qthJJ4HizeFoQ5nkvN3QO6aBY_W0eQBblQ
 MBzXNFTkEjG6QvLBtXmBf662nNFBXuhRdoeOI3FoS8xmSyWgUNJF6dC_1nnoK4UIpik.mITimjzV
 1E_HQQHYfiEJRIZKKA81vVpFr6Ug2F3S4EwBHEMb0RVSQqsXWSED2d3ISNj0anKoTnQ5xNgzRKPQ
 V.MWL8xqADaGqKXWrG8oG16xB6B2GFQciFIHJeUWju1TKmYSKRVFm3LLO2Typ3Gsmjo39M6BrpKS
 grAkUem3HhQc2cBgBcCUlClncwNEkOL1NlTt0v63fY_c4LcNktQ4AhcfynvdSljkSTZ9zY7ebVHo
 zHDL0.Q3tlau4Z16Bq12RidSherAi3fiIUOZDkOj_LFRRAz02FtCvWrPNcluhr45.MkwhY5hFuFh
 UV8iOd5VM2lPbbWlGojsHdDjDaQpa.uhFv0Woddn.xliWC_u6iy_oZGNej6cEa2zmL5kvXnaKfSa
 2IMM1XwHQ7e1hmT0j3iXIyCuGec5gX9B1wrCCBdqOoPoMGjWirsBRsGZUfaot0XW416rSaX1AJ0v
 htpdYUa_7fNPKJR5_B1XYXimnMIf.v2shztlm7mz1hLxD6xiPB8y3VR_zFuP0KEQMmwCMw3GQlB0
 T2JhGMgMbxoyzpinDPGyjAIRaTkM_SQr0l2YGf8Oes5Jh6ylwMkTwSXKqsOMw6fG7EOQesHjnqyd
 WEa0COD3hiQcdO29KsHugNhuSb0oStPNjUyXxB88wy62aGaFCoLn0xz9SOTpET1wLh.M15D84f0H
 gT8z6a9pkmu77X.KoG1.xQExEqYogCKysZoRPXfkBa6fhF2u_tgLWc.aPUaNH93l969XPf0JMX72
 AxqjXNT68mW_ZbzVBz.CejGU9G922UMWjaFY3dP62bb7H0KD.C5IBKB9DC67FSxxncx3uV9J.NmS
 S36nlzm3bD.27gzs6PDNUhXSfgbYOpq.yO_VwAVVFRCGMD1GQY9fhSCXxIrBCrL1idQ.9QhAR8mZ
 FU8LdW7bA4RNiiYEPdAO5VpCtGXQ_5VisonwwxtHKpwkRrRv7jJRA3clQkAX4RkrRAaAxMN7e2I_
 gHzBgR8a6CDB059APV560Pcurva04sTzNG.cljK5A7ckOr3ngqL8weoHaoNNWVgMxGUioip8w1L2
 L0Bsj0xHqMBatuVwiBrcaI7PkrIaHrCYYpu9MLA2LdFy5OmKAc4829wvhO1fIt.HUJ_Sb7efwjTZ
 EOms9HVm_VS5OD2sfH.1dQG_GJ1vev8WnFpte5L8nl6qyx7i.p8XqPXZpxMcbnO2ziniYtbcwJKZ
 H0ELFeY99zYq8_ZLGShqq1ctC_EzOxI9utp1EIECtVw3Z6EIPQJcF_0nSOcMIyZIkMi9JU_XUwDO
 OntICO4oJUH5.aKrEb7ipPWb08GkgABAVXaBkddEFlqNE4YSM2wcgfwqZ2wRhDnIXv7G.zA06Sat
 dF_9hFviJ2eC5ojRV1jcc9XP24RfPZb3tIe8rygf.8z2etW8BkLnOFA._lNlUtZND4fRKxcJUigT
 CbD3zDKwSsnRDiXbuNcbk.rvWsgv5Ac7lu7vuhyS6pQOA9hYqhUTrEd.QWJbX93lovrjmbmLqHF0
 QR9G9UMD3tEUaZCUR7FHb7UYB5uyUrtA_9hzAlL0WNMt2kDtfBU_NLbrBgQbuK36wLNUFAGkiA_4
 fiM2FUWdo0ek0kECKmq_MedS9Md58sal7dJj1hllevkQGa5NC2iDhMX7WFB_Cvd1D7IvwbFz6ftH
 6JKwdn6h6NDH.zkZ9lsKKYc8jej4k8I_g.JWHG8N56ok4LA3yc8P.I.Fbb59c3H9ZO3oDm_ju7IF
 cgxKZ8rj.H9yfYTbW9z6eXnQAUhDw6DleHE3THYA7191aFFoleYzgcMrsgH3Bk3Dh4OKzmoSsRYP
 V5nzXPyxNZa4JB97eg9f_EwTtF5lUpSkvb7jvYhbuAd_JM8mCT5agEXu1hlJrbbKkMrKXB1Jc0Ei
 zvjIIj58ECUJqVCfQRBhVKQmkMGipNYWZqjTZatpQGz_Wb9o2TBzPLOZ0A7EWJ.M7IO5sjqNv3oM
 t5fD7VMUu5VeA0cYnu2FOBn8JYqFQIgQWThEOAP_5TqakNSHixhP9hbn_wX3cgRYWf.fpi6M0
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 5e6c61fe-95ee-47b0-8477-ff499c8da5b1
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 9 Nov 2026 20:57:58 +0000
Received: by hermes--production-ir2-5dd9bf4598-jgkl4 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 525c055f5af95739d588e1c70eb60200; 
 Mon, 09 Nov 2026 20:57:56 +0000 (UTC)
Message-ID: <629c8bdedca971d38b08ffd32acec1a804ff7d7d.camel@aol.com>
Subject: [REGRESSION] nouveau oops on 7.4-rc2
From: Ruben Wauters <rubenru09@aol.com>
To: lyude@redhat.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 20:57:44 +0000
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 SWKQ8KA==
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-N+9gnj3F/THkC5JRrEUY"
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <629c8bdedca971d38b08ffd32acec1a804ff7d7d.camel.ref@aol.com>
X-Mailer: WebService/1.1.26943
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-N+9gnj3F/THkC5JRrEUY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since 7.4, I have been encountering the following oops when booting my
computer. The issue is present in rc1 and rc2, 7.3 boots fine.
The kernel booted fine and passed to init, which then tried to start
gdm, gdm did not launch, leading me to dig and encounter the following
oops in the journal.

It is worth noting that my laptop, where I encountered this oops, has
two gpus in a hybrid system, one intel integrated, and one nvidia.

It looks to me like something return an -ENOPROTOOPT (likely due to the
hybrid GPU situation) and then another func tried to deference this
without checking for errors.

Some quick digging shows that it could potentially be related to atomic
mode setting being enabled in 7.4, whereas it wasn't before.

I tried to take a look myself at a patch, but unfortunately I got a bit
lost in nouveau, sorry for not being able to fix it, I hope you're able
to. If you need any further information, please don't hesitate to
contact me.

Ruben Wauters

Oops: Oops: 0010 [#1] SMP NOPTI
CPU: 6 UID: 0 PID: 464 Comm: (udev-worker) Not tainted 7.4.0-rc2 #1
PREEMPT(lazy)=20
Hardware name: ASUSTeK COMPUTER INC. Vivobook_ASUSLaptop
X3500PCB_K3500PC/X3500PCB, BIOS X3500PCB.305 10/13/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffce1000a37668 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8dff8a97d300 RCX: ffffffffaff4b406
RDX: 0000000000000000 RSI: ffff8dff8a97d300 RDI: ffff8dff86b91000
RBP: ffff8dff86b91000 R08: ffff8dff8a97d300 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000000 R12: ffff8dff86b91000
R13: 0000000000000001 R14: ffff8dff86b91000 R15: ffff8dff8299fa00
FS:  00007f9bcede9880(0000) GS:ffff8e0349bd8000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000104854004 CR4: 0000000000f72ef0
PKRU: 55555554
Call Trace:
 <TASK>
 drm_atomic_commit+0xb1/0xe0
 ? __pfx___drm_printfn_info+0x10/0x10
 drm_client_modeset_commit_atomic+0x25c/0x2d0
 drm_client_modeset_commit_locked+0x61/0x180
 ? drm_master_internal_acquire+0x1d/0x40
 drm_client_modeset_commit+0x25/0x40
 drm_fb_helper_single_fb_probe+0x1aa/0x1c0 [drm_client_lib]
 __drm_fb_helper_initial_config_and_unlock+0xa8/0x1b0 [drm_client_lib]
 drm_fbdev_client_hotplug+0x79/0xb0 [drm_client_lib]
 ? drm_client_init+0x116/0x150
 drm_client_register+0x79/0xc0
 drm_fbdev_client_setup+0xc9/0x1e0 [drm_client_lib]
 drm_client_setup+0x6a/0x90 [drm_client_lib]
 nouveau_drm_probe+0x15b/0x1e0 [nouveau]
 local_pci_probe+0x4a/0x90
 ? cpu_hotplug_disable+0x15/0x30
 pci_call_probe+0x5a/0x1a0
 pci_device_probe+0xdb/0x180
 call_driver_probe+0x23/0x100
 ? driver_sysfs_add+0x55/0xc0
 really_probe+0xd7/0x2d0
 ? __pm_runtime_resume+0x50/0x60
 __driver_probe_device+0x9c/0x1b0
 driver_probe_device+0x1f/0x80
 ? __pfx___driver_attach+0x10/0x10
 __driver_attach+0xcc/0x200
 bus_for_each_dev+0x9c/0x100
 ? bus_add_driver+0x84/0x280
 bus_add_driver+0x1d0/0x280
 ? __pfx_init_module+0x10/0x10 [nouveau]
 ? __pfx_init_module+0x10/0x10 [nouveau]
 driver_register+0x75/0xe0
 nouveau_drm_init+0x60/0xff0 [nouveau]
 do_one_initcall+0x89/0x340
 do_init_module+0x8e/0x2b0
 init_module_from_file+0xfe/0x170
 idempotent_init_module+0x23e/0x360
 __x64_sys_finit_module+0x7f/0x110
 do_syscall_64+0xc2/0x4d0
 ? switch_fpu_return+0x5e/0xf0
 ? ksys_pread64+0x61/0xd0
 ? arch_exit_to_user_mode_prepare.isra.0+0x84/0xa0
 ? do_syscall_64+0xff/0x4d0
 ? do_sys_openat2+0x75/0xe0
 ? switch_fpu_return+0x5e/0xf0
 ? arch_exit_to_user_mode_prepare.isra.0+0x84/0xa0
 ? do_syscall_64+0xff/0x4d0
 ? do_syscall_64+0xff/0x4d0
 ? clear_bhb_loop+0x60/0xb0
 ? do_syscall_64+0x37/0x4d0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9bce71f95d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 6b 64 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdb99bcab8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000564b33e33130 RCX: 00007f9bce71f95d
RDX: 0000000000000000 RSI: 00007f9bced703af RDI: 000000000000004a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000564b33e30d90
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9bced703af
R13: 0000000000020000 R14: 0000564b33e2dd30 R15: 0000000000000000
 </TASK>
Modules linked in: drm_gpusvm_helper drm_suballoc_helper snd_hda_intel
snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic
soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda
soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
snd_soc_acpi_intel_match vfat snd_soc_acpi_intel_sdca_quirks fat
nouveau(+) soundwire_generic_allocation snd_soc_sdw_utils snd_soc_acpi
crc8 i915 soundwire_bus snd_soc_sdca intel_rapl_msr
intel_uncore_frequency intel_uncore_frequency_common snd_soc_avs
intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp coretemp
snd_soc_hda_codec mt7921e snd_hda_ext_core mt7921_common snd_hda_codec
kvm_intel mt792x_lib snd_hda_core mt76_connac_lib mt76 snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_ctl_led kvm snd_soc_core asus_nb_wmi
mac80211 snd_compress ac97_bus btusb asus_armoury snd_pcm_dmaengine
btmtk irqbypass uvcvideo spi_nor snd_pcm drm_gpuvm btrtl rapl mxm_wmi
btbcm
 intel_cstate mtd uvc drm_ttm_helper firmware_attributes_class iTCO_wdt
drm_buddy btintel videobuf2_vmalloc intel_pmc_bxt
processor_thermal_device_pci_legacy ttm snd_timer mei_pxp >
 fsdev_dax ucsi_acpi typec_ucsi typec hid_multitouch i2c_hid_acpi
i2c_hid video wmi thunderbolt pinctrl_tigerlake intel_oc_wdt vmd
serio_raw rtsx_usb_sdmmc mmc_core rtsx_usb
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffce1000a37668 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8dff8a97d300 RCX: ffffffffaff4b406
RDX: 0000000000000000 RSI: ffff8dff8a97d300 RDI: ffff8dff86b91000
RBP: ffff8dff86b91000 R08: ffff8dff8a97d300 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000000 R12: ffff8dff86b91000
R13: 0000000000000001 R14: ffff8dff86b91000 R15: ffff8dff8299fa00
FS:  00007f9bcede9880(0000) GS:ffff8e0349bd8000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000104854004 CR4: 0000000000f72ef0
PKRU: 55555554

--=-N+9gnj3F/THkC5JRrEUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQLCBAABCgCsFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmryM8gbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRERTg2Q0QzNUQzRDBGNTVFNDI0MjJE
OThEMjdFNTBDMDUwQUUwQ0UxEhxydWJlbnJ1MDlAYW9sLmNvbQAKCRDSflDAUK4M
4RtbEACa4luU+mu0gmvvQNR7mFH+RMeJDI1nu6OdORNNkz4EfkTXL1Tl9fpiBV9f
H5bOLzFYzXkVFZQneW4r3KcqGbzL1FhEDR8KAvCzIlmDO/Y5Hs8D3TxDrHE/LwDy
zyudvcmf6l/gKTsOLhUgMocWFLMNSh9imuaL+41HBa2F92UrelT8Fh1PWp/nyrfI
NFQUzCMBnUfEciDH2tP76bgztMC9KjHT6G10+9oWnf+2CZTO+TNLovi2ab8QEnqo
q4X8SFFksbQk2FqBKYp5gn4NiLBMSCDq8cQBPOS5jyZHPzG9qhDq20D5dm2UAQUR
94XGgF6HSvWQbHU0itQCCm4Ux1sN5e+rbnOdK+XVtdlJkpOVrzHN4bm/b6zzkOI1
2CiKaR2vrhPXi+kQFGSr+WhKmrfFeLescP9kN9e67lVWZ6ZdEkREJTEJBcOaLmR4
JUn61xvud9gWGq+dogKs2RJXhKePKX2IHzFCfVee1sNPBLEkiVRZ+Xmg5k7NkoCw
9GhkwU3DTU49DZfpbUsaMLT+2MirMZAORZa3SjZaPUAvQ+eKXzWsrdEUBlQ8sTsm
7LCHis/suloewal48hi/JxuCbBz7Yz0AZEKHCuX89QX9bIgdtoCr7wBtKqVISZ5f
KslRKC9H4wjt9CpD3DWEg4gqaQBMTe9BkOUj2EDF2Qvtwb5uyw==
=b/MQ
-----END PGP SIGNATURE-----

--=-N+9gnj3F/THkC5JRrEUY--
