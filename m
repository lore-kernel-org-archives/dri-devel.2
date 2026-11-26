Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2F606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=npnm.eu header.i=@npnm.eu header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=XoUVzbg0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA6D11283B;
	Fri, 27 Nov 2026 08:29:17 +0000 (UTC)
Received: from smtpout1.mo538.mail-out.ovh.net
 (smtpout1.mo538.mail-out.ovh.net [51.210.91.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62BD10E660
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:37:20 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4jZwzf16w0z67Hf;
 Thu, 26 Nov 2026 12:37:18 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <simona@ffwll.ch>; Thu, 26 Nov 2026 12:37:17 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.254.138])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jZwzd6G2Wz6MYl; Thu, 26 Nov 2026 12:37:17 +0000 (UTC)
Received: from npnm.eu (unknown [10.1.6.3])
 (Authenticated sender: laniel_francis@npnm.eu)
 by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 2F7BAB82161; 
 Thu, 26 Nov 2026 12:37:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004b9630277-25c9-4875-a9f6-99af4d3fd264,
 230BAD52BFC520DA66055B44D06E91CCCAB19385) smtp.auth=laniel_francis@npnm.eu
X-OVh-ClientIp: 159.26.112.43
From: Francis Laniel <laniel_francis@npnm.eu>
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] drm/nouveau/devinit/gf100-: fix display engine
 check in preinit
Date: Thu, 26 Nov 2026 14:37:14 +0200
Message-ID: <2858204.mvXUDI8C0e@pmachine>
In-Reply-To: <20261125111925.8651-1-laniel_francis@npnm.eu>
References: <20261125111925.8651-1-laniel_francis@npnm.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
x-ovh-tracer-id: 2881459338773603644
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE1qDi0Soti/4tnUiSxQb2gQr7FxqvYVam6SEq/87eXXB81y5tpavkUrC7wdjB7Tkj4LqTCiFvsbz+ZaKkSYpljATzQIRbSsbgqUHzEd/XZqIdaByia5otWAqBgf2yH9BXOVmbuPvB8WaW2DSjvUNHxhHSz9DzJUCumBiD3AVJQNrcx/FMleRUSKGfFNZQ/n86IjCTvcEkNjLqwnlLHVMTkH7DxSxLE0QfZ3jQ39ZhrPUdngP0f+5cd3TUef3RiE7fSph0RyHiMGsR90mu+ReEZzXXJctFiyi0hMMNQ2SDbrE1NsmhfDhlfjeopTcAsdHvbAMOp2tMNnfBqkvk8KP23jMbtxusYe6uWuCS4xn6TTMyrh84BUiNxxIUzdywRDu5+N8jA0Su4Yo1geUm4x01eL7r7kxAQm+5oQXcROlToQWLWZP2Z2/louvzRxkSaQy7wMs+d9Vyel3EgoSVRiVPBrD1raTPPtSiQ9Vgb7m31pJDRz8/1EhRfPF/ASVa0re0YoSqDGh/ziskt1mL6t3hopNAINw7x0y9GtNKFCCiuReZIkLWRQTs1V8G6SnYseJ351Tpka8pgC0JB5DBbV7fG3P4OoB+8FkIEWc3lrOVyHqtgYegUQf1XPwcZvCVZgK+QVvg2TG2B+pVif/7rZ/Y2SyKAa/9rXimeEZU0gZPosg
DKIM-Signature: a=rsa-sha256; bh=RQkJfhAebHnDToX49dPcuad16KB6cMedVUuroADXyWg=; 
 c=relaxed/relaxed; d=npnm.eu; h=From; s=ovhmo-selector-1;
 t=1795696638; v=1;
 b=XoUVzbg0mjfIRCIBeqGf5+qGvpx5E4ZmWX/+DLDqQr0k8RH0q2oj35btQG15D5NKf0hiKMeJ
 3s9F2Ru2O20+oU/7efKOl8N8VY6prQ9EuT1Ih1JFIX3qagbYpkO10FkuibgavKnKQ/T4xMpx9tY
 DYWj0l36FWF6LFeIy/30Xm9jseWTEVfzv+fBNeO8arsbWEfvL7+bJD4sXW918b207MPGmPNOnfm
 8l1j6WZetI080VCTP7woiJ8tXSA1PNt0LWFQDr6cTxzUcP+EMwi9jhjhJLbnZF6ptjKvXdD3Azp
 Z6OuPqhQYB3JdepPUuN1s2aNy3InFPTCcXzCTfkzAzq/g==
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le mercredi 25 novembre 2026, 13:19:24 heure normale d=E2=80=99Europe de l=
=E2=80=99Est Francis Laniel a =C3=A9crit :
> Hi,
>=20
> I had a problem booting 6.12.118 kernel with NVIDIA GP108GLM [Quadro P520=
]:
> ...
> [    1.657796] nouveau 0000:2d:00.0: fb: 0 MiB GDDR5
> ...
> [    2.590323] BUG: unable to handle page fault for address: ffffcdd5c140=
0000
> [    2.590326] #PF: supervisor read access in kernel mode
> [    2.590328] #PF: error_code(0x0000) - not-present page
> [    2.590330] PGD 100000067 P4D 100000067 PUD 100203067 PMD 101f29067 PT=
E 0
> [    2.590334] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    2.590337] CPU: 7 UID: 0 PID: 223 Comm: (udev-worker) Not tainted 6.1=
2.118+deb13-amd64 #1  Debian 6.12.118-1
> [    2.590340] Hardware name: LENOVO 20S4001JFR/20S4001JFR, BIOS N2XET27W=
 (1.17 ) 12/10/2020
> [    2.590342] RIP: 0010:ioread32+0x32/0x60
> [    2.590347] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 76 08 89 fa ed c=
3 cc cc cc cc 8b 05 6c e5 6f 01 85 c0 75 11 b8 ff ff ff ff c3 cc cc cc cc <=
8b> 07 e9 d7 d4 66 00 83 e8 01 48 89 fe 48 c7 c2 72 53 51 b2 48 c7
> [    2.590350] RSP: 0018:ffffcdd5c1137338 EFLAGS: 00010292
> [    2.590353] RAX: ffffffffc0a55890 RBX: ffff8aa642386c00 RCX: 000000000=
0000000
> [    2.590355] RDX: 00000000bad0ac3c RSI: ffffcdd5c1400000 RDI: ffffcdd5c=
1400000
> [    2.590357] RBP: ffffcdd5c1137374 R08: 000000000000a500 R09: 000000000=
0000000
> [    2.590359] R10: ffffcdd5c1380000 R11: ffffcdd5c13fffff R12: ffffcdd5c=
1137470
> [    2.590360] R13: ffff8aa642386cb0 R14: ffffcdd5c1137380 R15: 000000000=
0000000
> [    2.590362] FS:  00007fa0fa647980(0000) GS:ffff8aad4d780000(0000) knlG=
S:0000000000000000
> [    2.590365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.590367] CR2: ffffcdd5c1400000 CR3: 000000010b472002 CR4: 000000000=
03706f0
> [    2.590369] Call Trace:
> [    2.590371]  <TASK>
> [    2.590373]  gp102_acr_wpr_patch+0xaf/0x1a0 [nouveau]
> [    2.590477]  nvkm_acr_oneinit+0x3bc/0x600 [nouveau]
> [    2.590550]  nvkm_subdev_oneinit_+0x42/0x90 [nouveau]
> [    2.590620]  ? ktime_get+0x3a/0xd0
> [    2.590624]  nvkm_subdev_init_+0x30/0xa0 [nouveau]
> [    2.590692]  ? nvkm_intr_rearm+0xc7/0x1c0 [nouveau]
> [    2.590759]  nvkm_subdev_init+0x48/0x60 [nouveau]
> [    2.590827]  nvkm_device_init+0x16b/0x1f0 [nouveau]
> [    2.590936]  nvkm_udevice_init+0x47/0x70 [nouveau]
> [    2.591044]  nvkm_object_init+0x41/0x120 [nouveau]
> [    2.591115]  nvkm_ioctl_new+0x160/0x220 [nouveau]
> [    2.591182]  ? __pfx_nvkm_client_child_new+0x10/0x10 [nouveau]
> [    2.591249]  ? __pfx_nvkm_udevice_new+0x10/0x10 [nouveau]
> [    2.593234]  nvkm_ioctl+0xa6/0x140 [nouveau]
> [    2.593305]  nvif_object_ctor+0x11a/0x1a0 [nouveau]
> [    2.593371]  nvif_device_ctor+0x2e/0x70 [nouveau]
> [    2.593438]  nouveau_drm_device_new+0x170/0x300 [nouveau]
> [    2.594065]  ? __pci_set_master+0x36/0xd0
> [    2.594068]  nouveau_drm_probe+0xc2/0x1e0 [nouveau]
> [    2.594167]  local_pci_probe+0x42/0x90
> [    2.594171]  pci_device_probe+0x25b/0x290
> [    2.594173]  really_probe+0xde/0x340
> [    2.594177]  ? pm_runtime_barrier+0x54/0x90
> [    2.594180]  ? __pfx___driver_attach+0x10/0x10
> [    2.594182]  __driver_probe_device+0x84/0x140
> [    2.594184]  driver_probe_device+0x1f/0xa0
> [    2.594186]  __driver_attach+0xbc/0x1d0
> [    2.594187]  bus_for_each_dev+0x8c/0xe0
> [    2.594190]  bus_add_driver+0x112/0x1f0
> [    2.594193]  driver_register+0x72/0xd0
> [    2.594195]  ? __pfx_nouveau_drm_init+0x10/0x10 [nouveau]
> [    2.594261]  do_one_initcall+0x5b/0x310
> [    2.594265]  do_init_module+0x60/0x230
> [    2.594269]  init_module_from_file+0x89/0xe0
> [    2.594272]  idempotent_init_module+0x11e/0x310
> [    2.594276]  __x64_sys_finit_module+0x5e/0xb0
> [    2.594278]  do_syscall_64+0x87/0x1b0
> [    2.594281]  ? filemap_read+0x340/0x370
> [    2.594285]  ? vfs_read+0x24d/0x370
> [    2.594288]  ? __x64_sys_pread64+0x98/0xd0
> [    2.594291]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
> [    2.594293]  ? syscall_exit_to_user_mode+0x37/0x1b0
> [    2.594295]  ? do_syscall_64+0x93/0x1b0
> [    2.594297]  ? do_sys_openat2+0x9c/0xe0
> [    2.594300]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
> [    2.594302]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
> [    2.594304]  ? syscall_exit_to_user_mode+0x37/0x1b0
> [    2.594306]  ? do_syscall_64+0x93/0x1b0
> [    2.594307]  ? do_syscall_64+0x93/0x1b0
> [    2.594309]  ? __flush_tlb_all+0x13/0x30
> [    2.594311]  ? __flush_smp_call_function_queue+0xab/0x410
> [    2.594314]  ? syscall_exit_to_user_mode+0x37/0x1b0
> [    2.594316]  ? clear_bhb_loop+0x70/0xc0
> [    2.594319]  ? clear_bhb_loop+0x70/0xc0
> [    2.594321]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    2.594323] RIP: 0033:0x7fa0fb1ad6b9
> [    2.594325] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 67 0d 00 f7 d8 64 89 01 48
> [    2.594329] RSP: 002b:00007ffc9ccb2f38 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [    2.594332] RAX: ffffffffffffffda RBX: 000055dd07c93360 RCX: 00007fa0f=
b1ad6b9
> [    2.594334] RDX: 0000000000000004 RSI: 00007fa0f98d544d RDI: 000000000=
000001d
> [    2.594336] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055dd0=
7c6f130
> [    2.594338] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0f=
98d544d
> [    2.594339] R13: 0000000000020000 R14: 000055dd07c912d0 R15: 000000000=
0000000
> [    2.594342]  </TASK>
> [    2.594343] Modules linked in: hid_generic usbhid hid i915(+) nouveau(=
+) mxm_wmi drm_gpuvm drm_exec gpu_sched drm_buddy i2c_algo_bit drm_display_=
helper crct10dif_pclmul crc32_pclmul cec crc32c_intel ghash_clmulni_intel r=
c_core drm_ttm_helper sha512_ssse3 iTCO_wdt ttm sha256_ssse3 intel_pmc_bxt =
xhci_pci sha1_ssse3 ucsi_acpi iTCO_vendor_support xhci_hcd rtsx_pci_sdmmc w=
atchdog aesni_intel drm_kms_helper typec_ucsi nvme mmc_core gf128mul usbcor=
e typec nvme_core i2c_i801 psmouse drm crypto_simd roles thunderbolt e1000e=
 video serio_raw rtsx_pci i2c_smbus nvme_auth cryptd usb_common battery wmi=
 button
> [    2.594376] CR2: ffffcdd5c1400000
> [    2.594378] ---[ end trace 0000000000000000 ]---
>=20
> With the following patch, the kernel was succesfull booting:
> [    1.404564] nouveau: loading out-of-tree module taints kernel.
> [    1.404624] nouveau: module verification failed: signature and/or requ=
ired key missing - tainting kernel
> [    1.739550] nouveau: detected PR support, will not use DSM
> [    1.739571] nouveau 0000:2d:00.0: enabling device (0006 -> 0007)
> [    1.739648] nouveau 0000:2d:00.0: NVIDIA GP108 (138000a1)
> [    1.776320] nouveau 0000:2d:00.0: bios: version 86.08.3e.00.26
> [    1.776582] nouveau 0000:2d:00.0: pmu: firmware unavailable
> [    1.860292] nouveau 0000:2d:00.0: fb: 2048 MiB GDDR5
> [    1.897865] nouveau 0000:2d:00.0: drm: VRAM: 2048 MiB
> [    1.897868] nouveau 0000:2d:00.0: drm: GART: 536870912 MiB
> [    1.897869] nouveau 0000:2d:00.0: drm: BIT table 'A' not found
> [    1.897871] nouveau 0000:2d:00.0: drm: BIT table 'L' not found
> [    1.897871] nouveau 0000:2d:00.0: drm: Pointer to TMDS table not found
> [    1.902700] nouveau 0000:2d:00.0: drm: MM: using COPY for buffer copies
> [    1.902820] [drm] Initialized nouveau 1.4.0 for 0000:2d:00.0 on minor 0
> [    1.902908] nouveau 0000:2d:00.0: [drm] No compatible format found
> [    1.902910] nouveau 0000:2d:00.0: [drm] Cannot find any crtc or sizes
>=20
> Basically, the patch mimics behavior existing in nv50_devinit_preinit().
>=20
> Francis Laniel (1):
>   drm/nouveau/devinit/gf100-: fix display engine check in preinit
>=20
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Best regards,
>=20

Sorry for the noise, a patch was already posted some days ago:
https://lore.kernel.org/all/20261123-nouveau-fix-disp-v1-1-ebdc525287ce@red=
hat.com/


