Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1188F5A8CE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A186310E203;
	Mon, 20 Apr 2026 23:13:35 +0000 (UTC)
X-Greylist: delayed 361 seconds by postgrey-1.36 at gabe;
 Mon, 20 Apr 2026 23:13:34 UTC
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C9B10E203
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:13:34 +0000 (UTC)
Received: by vps.thesusis.net (Postfix, from userid 1000)
 id 61345DB4B3; Mon, 20 Apr 2026 19:07:32 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Regression from: drm/amd/display: Move FPU Guards From DML To DC -
 Part 1
Date: Mon, 20 Apr 2026 19:07:32 -0400
Message-ID: <87cxztkz7v.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
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

This commit:

commit 3539437f354bd24c98928a80d4db3a23fa2a7b19 (HEAD)
Author: Rafal Ostrowski <rafal.ostrowski@amd.com>
Date:   Tue Feb 24 15:36:09 2026 +0100

    drm/amd/display: Move FPU Guards From DML To DC - Part 1
    
    [Why]
    FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
    can manipulates floats. To do this properly, the FPU guards must be used
    in a file that is not compiled as a FPU unit. If the guards are used in
    a file that is a FPU unit, other sections in the file that aren't guarded
    may be end up being compiled to use FPU operations.
    
    [How]
    Added DC_FP_START and DC_FP_END to DC functions that call DML functions
    using FPU.
    
    Reviewed-by: Dillon Varone <dillon.varone@amd.com>
    Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
    Signed-off-by: Alex Hung <alex.hung@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Started causing this warning for me on every boot:

------------[ cut here ]------------
WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58 at dc_assert_fp_enabled+0x14/0x20 [amdgpu], CPU#13: (udev-worker)/267
Modules linked in: hid_generic usbhid hid amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks gpu_sched drm_ttm_helper sr_mod ttm drm_client_lib cdrom sd_mod drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper xhci_pci dm_mod sp5100_tco r8169 >
CPU: 13 UID: 0 PID: 267 Comm: (udev-worker) Not tainted 7.0.0-rc4+ #142 PREEMPTLAZY 
Hardware name: ASRock B650E Taichi Lite/B650E Taichi Lite, BIOS 3.06 07/26/2024
RIP: 0010:dc_assert_fp_enabled+0x14/0x20 [amdgpu]
Code: 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 65 8b 05 0d b9 88 ea 85 c0 7e 05 c3 cc cc cc cc <0f> 0b c3 cc cc cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffae440099b5f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff922168000000 RCX: 0000000000000000
RDX: ffff9221617c4c00 RSI: ffffffffc12acee0 RDI: ffff922168000000
RBP: ffffae440099b618 R08: 000000001faa2800 R09: 000000000000000d
R10: ffff92215d6b0108 R11: ffff9221429d7a40 R12: ffffffffc12acee0
R13: ffff92214fcaa800 R14: ffff922161600010 R15: ffff922161600000
FS:  00007f3485b309c0(0000) GS:ffff922ca2d3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b1d93d8000 CR3: 0000000117541000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 dcn315_update_bw_bounding_box+0x1f/0x210 [amdgpu]
 dc_create+0x286/0x620 [amdgpu]
 amdgpu_dm_init+0x2d8/0x4e0 [amdgpu]
 ? prb_read_valid+0x1b/0x30
 ? console_unlock+0xa3/0x140
 ? preempt_count_add+0x4b/0xa0
 ? __wake_up_klogd.part.0+0x56/0x80
 ? vprintk_emit+0x273/0x330
 dm_hw_init+0x1b/0x90 [amdgpu]
 amdgpu_device_init.cold+0xfe0/0x1d89 [amdgpu]
 ? _raw_spin_lock_irqsave+0x1b/0x50
 ? pci_conf1_read+0xb3/0x100
 ? pci_bus_read_config_word+0x4c/0x80
 amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
 amdgpu_pci_probe+0x215/0x430 [amdgpu]
 local_pci_probe+0x41/0x90
 pci_device_probe+0xd7/0x2a0
 ? sysfs_do_create_link_sd+0x6e/0xe0
 really_probe+0xde/0x380
 ? _raw_spin_unlock_irq+0x17/0x40
 ? __pfx___driver_attach+0x10/0x10
 __driver_probe_device+0x78/0x120
 driver_probe_device+0x1f/0xa0
 __driver_attach+0xba/0x1f0
 bus_for_each_dev+0x7d/0xd0
 bus_add_driver+0x11f/0x200
 driver_register+0x72/0xd0
 ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
 do_one_initcall+0x47/0x310
 ? __kmalloc_cache_noprof+0x142/0x470
 do_init_module+0x60/0x240
 init_module_from_file+0xce/0xf0
 idempotent_init_module+0xff/0x2f0
 __x64_sys_finit_module+0x71/0xe0
 do_syscall_64+0x127/0x650
 ? __check_object_size+0x1b6/0x250
 ? kmem_cache_free+0x16c/0x3f0
 ? do_sys_openat2+0x83/0xd0
 ? fpregs_assert_state_consistent+0x34/0x60
 ? do_syscall_64+0x160/0x650
 ? irqentry_exit+0x97/0x560
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f348668d7b9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd1436add8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b1d93acd90 RCX: 00007f348668d7b9
RDX: 0000000000000000 RSI: 00007f3484e0c44d RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000000 R09: 000055b1d9389cb0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3484e0c44d
R13: 0000000000020000 R14: 000055b1d93ac6f0 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---
