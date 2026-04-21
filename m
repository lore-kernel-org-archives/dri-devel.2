Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A54DF8FA6D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 13:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A068610ECBB;
	Tue, 21 Apr 2026 13:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="HC2i69fQ";
	dkim-atps=neutral
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F2110ECBA;
 Tue, 21 Apr 2026 13:23:30 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43C0240E00C2; 
 Tue, 21 Apr 2026 13:23:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BJuGyDmcOu9e; Tue, 21 Apr 2026 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1776777797; bh=aZk/HTzmS1ayn2m7urSQ5EJlZ9GaLYiizCP3pZXimjU=;
 h=Date:From:To:Cc:Subject:From;
 b=HC2i69fQaG7sLyugW6Kq4HRg+PITC+2tDwJNbYkg9VZfob22H6CgMCpaqXKXvrT8b
 qnCVzZMoU23h/+mSfBM7Nkiq6qocSpKmj5voA0KpXwE/P4gbq+clnRzBFldStZ/hs/
 gxbV/OV3BRu5JvQvZAfRWvCGyRuVm//hnMp+2pXR2qjBAJmRTd3mh4XL4X512D1tp3
 BksHwazlJpdkDhjdauf3aL6R30UHYJ2pfnZ5pTQJgJtcPf2TW/sfy/bglqE9neppJ/
 nFaHgQ+GooyYjWUrI8tz1csSua8gNIaIUkPurUYsCXYMQ9O1wT0BqsiZb6xvpyUVrL
 DSVao6MvS0a9yea/G/1HvP+8cwaI8Khsf71ji3Qs0o9EwWyNF+byTq9sB1uBMz/nVx
 KqjDPp4qRGC9y0PAxNQx2d+B3VG6V8zK5J5vLDanhIIABDzzxzXBJLyg/oLiyHbim4
 e424QHR+jubukWNVm9RXKecXwucYsnmk39+yej4ZhPnHTWv/4ulJUusBaC0ov/OA/C
 kxDdrkqbnEuBrmIE1XWSElC5UealzRjCBksE/719SFq3FPNjiHwRhZcWkNof4m8a8k
 k8hjTCE+u3h4L3HD5UPXNQ2+d5EGfPsnDIKJhaS/S71ro6yECgsIFmaS7b791J+6RF
 bip10+G1Pz+6g4+XdryYzVW8=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id
 A909A40E00BA; Tue, 21 Apr 2026 13:23:09 +0000 (UTC)
Date: Tue, 21 Apr 2026 15:23:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: amdgpu: WARNING:
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58 at
 dc_assert_fp_enabled+0x10/0x20 [amdgpu], CPU#5: (udev-worker)/418
Message-ID: <20260421132303.GCaed6N9mDwutP6sEx@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

this is latest Linus from today on a Zen2 laptop:


[   13.269334] amdgpu: Virtual CRAT table created for CPU
[   13.271577] amdgpu: Topology: Add CPU node
[   13.273954] amdgpu 0000:06:00.0: enabling device (0006 -> 0007)
[   13.275307] amdgpu 0000:06:00.0: initializing kernel modesetting (RENOIR 0x1002:0x1636 0x17AA:0x5099 0xD1).
[   13.278650] amdgpu 0000:06:00.0: register mmio base: 0xFD300000
[   13.279377] amdgpu 0000:06:00.0: register mmio size: 524288
[   13.305063] amdgpu 0000:06:00.0: detected ip block number 0 <common_v2_0_0> (soc15_common)
[   13.305918] amdgpu 0000:06:00.0: detected ip block number 1 <gmc_v9_0_0> (gmc_v9_0)
[   13.306681] amdgpu 0000:06:00.0: detected ip block number 2 <ih_v4_0_0> (vega10_ih)
[   13.307386] amdgpu 0000:06:00.0: detected ip block number 3 <psp_v12_0_0> (psp)
[   13.308085] amdgpu 0000:06:00.0: detected ip block number 4 <smu_v12_0_0> (smu)
[   13.308799] amdgpu 0000:06:00.0: detected ip block number 5 <dce_v1_0_0> (dm)
[   13.309476] amdgpu 0000:06:00.0: detected ip block number 6 <gfx_v9_0_0> (gfx_v9_0)
[   13.310149] amdgpu 0000:06:00.0: detected ip block number 7 <sdma_v4_0_0> (sdma_v4_0)
[   13.310854] amdgpu 0000:06:00.0: detected ip block number 8 <vcn_v2_0_0> (vcn_v2_0)
[   13.311514] amdgpu 0000:06:00.0: detected ip block number 9 <jpeg_v2_0_0> (jpeg_v2_0)
[   13.312206] amdgpu 0000:06:00.0: Fetched VBIOS from VFCT
[   13.312855] amdgpu 0000:06:00.0: [drm] ATOM BIOS: 113-RENOIR-026, build: 505466  , ver: 017.010.000.015.000000, 2020/03/10
[   13.342880] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
[   13.343759] amdgpu 0000:06:00.0: Trusted Memory Zone (TMZ) feature enabled
[   13.345092] amdgpu 0000:06:00.0: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   13.345840] amdgpu 0000:06:00.0: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[   13.346631] amdgpu 0000:06:00.0: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[   13.347360] amdgpu 0000:06:00.0: [drm] Detected VRAM RAM=512M, BAR=512M
[   13.348049] amdgpu 0000:06:00.0: [drm] RAM width 128bits DDR4
[   13.352916] amdgpu 0000:06:00.0:  512M of VRAM memory ready
[   13.353724] amdgpu 0000:06:00.0:  7568M of GTT memory ready.
[   13.355321] amdgpu 0000:06:00.0: [drm] GART: num cpu pages 262144, num gpu pages 262144
[   13.357336] amdgpu 0000:06:00.0: [drm] PCIE GART of 1024M enabled.
[   13.358047] amdgpu 0000:06:00.0: [drm] PTB located at 0x000000F41FC00000
[   13.361785] amdgpu 0000:06:00.0: [drm] Loading DMUB firmware via PSP: version=0x01010028
[   13.365792] amdgpu 0000:06:00.0: [VCN instance 0] Found VCN firmware Version ENC: 1.21 DEC: 6 VEP: 0 Revision: 0
[   13.371337] amdgpu 0000:06:00.0: reserve 0x400000 from 0xf41f800000 for PSP TMR
[   13.460228] amdgpu 0000:06:00.0: RAS: optional ras ta ucode is not available
[   13.470922] amdgpu 0000:06:00.0: RAP: optional rap ta ucode is not available
[   13.476769] amdgpu 0000:06:00.0: psp gfx command LOAD_TA(0x1) failed and response status is (0x7)
[   13.478172] amdgpu 0000:06:00.0: smu driver if version = 0x0000000e, smu fw if version = 0x0000000e, smu fw program = 0, smu fw version = 0x00374700 (55.71.0)
[   13.480330] amdgpu 0000:06:00.0: SMU is initialized successfully!
[   13.482557] ------------[ cut here ]------------
[   13.483460] WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58 at dc_assert_fp_enabled+0x10/0x20 [amdgpu], CPU#5: (udev-worker)/418
[   13.486256] Modules linked in: snd_hda_codec_alc269 edac_mce_amd snd_hda_scodec_component snd_hda_codec_realtek_lib edac_core snd_hda_codec_generic snd_hda_codec_atihdmi amd_atl snd_hda_codec_hdmi amdgpu(+) kvm_amd snd_ctl_led rtsx_pci_sdmmc mmc_core snd_hda_intel drm_buddy snd_intel_dspcfg amdxcp thinkpad_acpi kvm drm_panel_backlight_quirks irqbypass sp5100_tco snd_hda_codec nvram sparse_keymap snd_hwdep aesni_intel gpu_sched snd_hda_core watchdog crypto_skcipher iwlwifi gf128mul snd_pcm aead video wmi_bmof snd_timer i2c_piix4 drm_suballoc_helper rapl pcspkr efi_pstore acpi_cpufreq k10temp i2c_smbus drm_display_helper rtsx_pci snd cfg80211 cec soundcore battery ccp ac r8169 mfd_core ucsi_acpi typec_ucsi roles i2c_scmi typec wmi button joydev psmouse serio_raw nvme nvme_core
[   13.493145] CPU: 5 UID: 0 PID: 418 Comm: (udev-worker) Not tainted 7.0.0+ #1 PREEMPT(full) 
[   13.494044] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   13.494990] RIP: 0010:dc_assert_fp_enabled+0x10/0x20 [amdgpu]
[   13.497094] Code: 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 8b 05 c9 fd 1c e2 85 c0 7e 05 e9 f0 77 f2 e0 <0f> 0b e9 e9 77 f2 e0 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   13.499024] RSP: 0018:ffffc900024b3668 EFLAGS: 00010246
[   13.499955] RAX: 0000000000000000 RBX: ffffffffa14bda80 RCX: ffff888116380000
[   13.500905] RDX: ffff88811635a800 RSI: ffffffffa14bda80 RDI: ffff888111c00000
[   13.501855] RBP: ffffc900024b36f8 R08: 0000000000016293 R09: 0000000000000000
[   13.502849] R10: 0000000000000005 R11: 0000000000000000 R12: ffff888111c00000
[   13.503820] R13: ffff888111c35c88 R14: ffff888109a70000 R15: 0000000000000005
[   13.504798] FS:  00007f874b9a9980(0000) GS:ffff888477def000(0000) knlGS:0000000000000000
[   13.505798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.506858] CR2: 00007f40cf702430 CR3: 00000001054a7000 CR4: 0000000000350ef0
[   13.507872] Call Trace:
[   13.508843]  <TASK>
[   13.509791]  dcn21_update_bw_bounding_box+0x31/0x4b0 [amdgpu]
[   13.512078]  ? srso_return_thunk+0x5/0x5f
[   13.513084]  dc_create+0x27e/0x600 [amdgpu]
[   13.515256]  amdgpu_dm_init+0x309/0x510 [amdgpu]
[   13.517385]  ? srso_return_thunk+0x5/0x5f
[   13.518346]  ? preempt_schedule_common+0x26/0x90
[   13.519354]  ? srso_return_thunk+0x5/0x5f
[   13.520287]  ? preempt_count_add+0x51/0xd0
[   13.521224]  ? srso_return_thunk+0x5/0x5f
[   13.522161]  ? __wake_up_klogd.part.0+0x56/0x80
[   13.523133]  ? srso_return_thunk+0x5/0x5f
[   13.524054]  ? vprintk_emit+0x341/0x420
[   13.525102]  dm_hw_init+0x17/0x90 [amdgpu]
[   13.527226]  amdgpu_device_init.cold+0xfcb/0x1d4a [amdgpu]
[   13.529175]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[   13.530102]  ? pci_conf1_read+0xae/0xf0
[   13.531069]  ? srso_return_thunk+0x5/0x5f
[   13.531963]  ? pci_bus_read_config_word+0x48/0x80
[   13.532879]  amdgpu_driver_load_kms+0x15/0x80 [amdgpu]
[   13.534650]  amdgpu_pci_probe+0x233/0x480 [amdgpu]
[   13.536332]  local_pci_probe+0x3e/0x90
[   13.537186]  pci_call_probe+0x53/0x2c0
[   13.538030]  ? srso_return_thunk+0x5/0x5f
[   13.538896]  ? _raw_spin_unlock+0x29/0x50
[   13.539699]  ? srso_return_thunk+0x5/0x5f
[   13.540488]  ? pci_match_device+0x15f/0x180
[   13.541264]  ? pci_assign_irq+0x24/0x150
[   13.542036]  pci_device_probe+0x91/0x170
[   13.542825]  ? srso_return_thunk+0x5/0x5f
[   13.543559]  really_probe+0xde/0x380
[   13.544269]  ? srso_return_thunk+0x5/0x5f
[   13.544965]  __driver_probe_device+0x84/0x170
[   13.545646]  driver_probe_device+0x1f/0xa0
[   13.546317]  ? __pfx___driver_attach+0x10/0x10
[   13.547013]  __driver_attach+0xcb/0x210
[   13.547647]  bus_for_each_dev+0x77/0xd0
[   13.548251]  bus_add_driver+0x117/0x200
[   13.548828]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   13.550235]  driver_register+0x71/0xe0
[   13.550868]  ? __pci_register_driver+0x5e/0x80
[   13.551432]  do_one_initcall+0x57/0x3b0
[   13.551988]  ? srso_return_thunk+0x5/0x5f
[   13.552528]  ? rcu_is_watching+0xd/0x40
[   13.553056]  ? srso_return_thunk+0x5/0x5f
[   13.553572]  ? __kmalloc_cache_noprof+0x3a2/0x580
[   13.554087]  ? __entry_text_end+0x5b46/0x1028df
[   13.554641]  do_init_module+0x62/0x250
[   13.555149]  init_module_from_file+0xd3/0xf0
[   13.555703]  idempotent_init_module+0x106/0x300
[   13.556229]  ? xen_error_entry+0x30/0x60
[   13.556744]  __x64_sys_finit_module+0x6d/0xe0
[   13.557244]  ? lockdep_hardirqs_on_prepare+0xca/0x1b0
[   13.557764]  do_syscall_64+0xc1/0x530
[   13.558258]  ? lockdep_hardirqs_on_prepare+0xca/0x1b0
[   13.558799]  ? srso_return_thunk+0x5/0x5f
[   13.559304]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   13.559809] RIP: 0033:0x7f874bb1bc29
[   13.560303] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 51 0d 00 f7 d8 64 89 01 48
[   13.561501] RSP: 002b:00007ffc84e231d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   13.562134] RAX: ffffffffffffffda RBX: 000055f9afd21c60 RCX: 00007f874bb1bc29
[   13.562797] RDX: 0000000000000000 RSI: 00007f874b13844d RDI: 000000000000001d
[   13.563427] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055f9afc2ffe0
[   13.564057] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f874b13844d
[   13.564691] R13: 0000000000020000 R14: 000055f9afd1ed00 R15: 0000000000000000
[   13.565378]  </TASK>
[   13.565971] irq event stamp: 147347
[   13.566612] hardirqs last  enabled at (147357): [<ffffffff813a58e2>] __up_console_sem+0x52/0x60
[   13.567286] hardirqs last disabled at (147364): [<ffffffff813a58c7>] __up_console_sem+0x37/0x60
[   13.567958] softirqs last  enabled at (146930): [<ffffffff81301670>] __irq_exit_rcu+0xe0/0x150
[   13.568634] softirqs last disabled at (146925): [<ffffffff81301670>] __irq_exit_rcu+0xe0/0x150
[   13.569305] ---[ end trace 0000000000000000 ]---
[   13.570428] amdgpu 0000:06:00.0: [drm] Display Core v3.2.376 initialized on DCN 2.1
[   13.571218] amdgpu 0000:06:00.0: [drm] DP-HDMI FRL PCON supported
[   13.572531] amdgpu 0000:06:00.0: [drm] DMUB hardware initialized: version=0x01010028
[   13.609768] snd_hda_intel 0000:06:00.1: bound 0000:06:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[   13.791531] amdgpu 0000:06:00.0: [drm] Using ACPI provided EDID for eDP-1
[   13.802924] amdgpu 0000:06:00.0: kiq ring mec 2 pipe 1 q 0
[   13.820519] kfd kfd: Allocated 3969056 bytes on gart
[   13.821387] kfd kfd: Total number of KFD nodes to be created: 1
[   13.824656] amdgpu: Virtual CRAT table created for GPU
[   13.829853] amdgpu: Topology: Add GPU node [0x1002:0x1636]
[   13.830723] kfd kfd: added device 1002:1636
[   13.831660] amdgpu 0000:06:00.0: SE 1, SH per SE 1, CU per SH 8, active_cu_number 7
[   13.832552] amdgpu 0000:06:00.0: ring gfx uses VM inv eng 0 on hub 0
[   13.833373] amdgpu 0000:06:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   13.834158] amdgpu 0000:06:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   13.834942] amdgpu 0000:06:00.0: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[   13.835676] amdgpu 0000:06:00.0: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[   13.836405] amdgpu 0000:06:00.0: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[   13.837162] amdgpu 0000:06:00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[   13.837888] amdgpu 0000:06:00.0: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[   13.838683] amdgpu 0000:06:00.0: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[   13.839407] amdgpu 0000:06:00.0: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
[   13.840130] amdgpu 0000:06:00.0: ring sdma0 uses VM inv eng 0 on hub 8
[   13.840853] amdgpu 0000:06:00.0: ring vcn_dec uses VM inv eng 1 on hub 8
[   13.841581] amdgpu 0000:06:00.0: ring vcn_enc0 uses VM inv eng 4 on hub 8
[   13.842307] amdgpu 0000:06:00.0: ring vcn_enc1 uses VM inv eng 5 on hub 8
[   13.843101] amdgpu 0000:06:00.0: ring jpeg_dec uses VM inv eng 6 on hub 8
[   13.851358] amdgpu 0000:06:00.0: Runtime PM not available
[   13.859799] amdgpu 0000:06:00.0: [drm] Using custom brightness curve
[   13.867974] [drm] Initialized amdgpu 3.64.0 for 0000:06:00.0 on minor 2
[   13.889650] fbcon: amdgpudrmfb (fb1) is primary device
[   13.889669] fbcon: Remapping primary device, fb1, to tty 1-63
[   13.890954] [drm] pre_validate_dsc:1667 MST_DSC dsc precompute is not needed
[   20.993437] amdgpu 0000:06:00.0: [drm] fb1: amdgpudrmfb frame buffer device

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
