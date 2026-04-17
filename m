Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9123F43687
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DC010E00C;
	Fri, 17 Apr 2026 09:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ii5+PQAR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F8E10E00C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:23:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CA9294445A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A98A9C2BCB5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776417794;
 bh=eXxVMrpjk5VSCfvyPeNfI3HhsHfZ03S5RWP8Bvcv95Q=;
 h=From:To:Subject:Date:From;
 b=ii5+PQAROLi3PM7h45iNta8OQuNHPCF2PJ8Gf248tQb3QDjT1QyfFDcUQmsR6hMJE
 k3luRBub3GlXYW1ey2OsvlrJdtg1yMXXB+KB6A4/PvPNgEBEmIvhzJHrXguv03BVep
 E5bjDM9QK4fH2idJ0AqBVgWGOJzD7sJdwtEvEzTsmWQIy3N6D91vKU1WCh81yq8uJG
 dgqSzvewBOBvJgsunbAbHTNGsCdjG7R/Nzr6nekXsM5l/3tZXCXRHfFYt6Aq80mftn
 VYsJuLMSQDkr/7Kc0j7N1QKnphZqiOtkoQ05wXUpzwhmkXK1o/od/vGDiRtRiYJpNC
 Fmr4wWq66GWIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9D9FFC4160E; Fri, 17 Apr 2026 09:23:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221376] New: AMD RADEON RX 9070 XT - modprobe amdgpu is fail.
Date: Fri, 17 Apr 2026 09:23:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: chanisorn.chitsillapavorakul@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221376-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221376

            Bug ID: 221376
           Summary: AMD RADEON RX 9070 XT - modprobe amdgpu is fail.
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: chanisorn.chitsillapavorakul@gmail.com
        Regression: No

Created attachment 309877
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309877&action=3Dedit
Hardware info, Boot log, .config, cpuinfo, pciinfo, iomem, ...

Hi / Sawasdee

I found issue about amdgpu while i run "modprobe amdgpu".
My graphic card is AMD RADEON RX 9070 XT.

Best regards
Chanisorn C.

-----------------------------------------------------------------

[  665.195522] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  665.200616] CPU: 12 UID: 0 PID: 348 Comm: kworker/12:1 Not tainted
6.18.22-x86_64 #1 PREEMPT(none)  32b191964ca8e3668a1a99e4763aaa24b9f95a74
[  665.213239] Hardware name: GIGABYTE MD72-HB1-00/MD72-HB1-00, BIOS F40
12/09/2025
[  665.220645] Workqueue: events work_for_cpu_fn
[  665.225018] RIP: 0010:drm_mm_init+0xc1/0xd0
[  665.229219] Code: 83 05 c2 c5 11 04 01 48 c7 83 f0 00 00 00 00 00 00 00 =
e8
a2 79 cd ff 48 83 05 b2 c5 11 04 01 5b c3 cc cc cc cc 0f 1f 40 00 90 <0f> 0=
b 66
66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
[  665.247994] RSP: 0018:ffa000000d723b60 EFLAGS: 00010246
[  665.253238] RAX: 0000000000000000 RBX: ff11004093c27400 RCX:
000000000000001c
[  665.260380] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ff11004093c27480
[  665.267522] RBP: 0000000000000003 R08: 0000000000000dc0 R09:
00000000ffffffff
[  665.274686] R10: ff11004093c27400 R11: 0000000000000100 R12:
ff1100408b60f048
[  665.281847] R13: 0000000000000000 R14: 0000000000000000 R15:
000000000000000b
[  665.288985] FS:  0000000000000000(0000) GS:ff11007ffa92d000(0000)
knlGS:0000000000000000
[  665.297080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  665.302841] CR2: 00007f15ed7d9f55 CR3: 000000000986a002 CR4:
0000000000771ef0
[  665.309987] PKRU: 55555554
[  665.312721] Call Trace:
[  665.315183]  <TASK>
[  665.317294]  ttm_range_man_init_nocheck+0x9d/0x180 [ttm
e3a55dbbe0be4b816fb72e148a49c41281811431]
[  665.326196]  amdgpu_ttm_init.cold+0x45e/0x5cc [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.336132]  ? vprintk_default+0x24/0x40
[  665.340076]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.349758]  amdgpu_bo_init.cold+0x5e/0x77 [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.358984]  gmc_v12_0_sw_init+0x470/0x6f0 [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.368144]  amdgpu_device_ip_init+0x8f/0xb43 [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.377685]  ? __pfx_drm_mode_config_init_release+0x10/0x10
[  665.383282]  ? __drmm_add_action_or_reset+0x22/0x60
[  665.388177]  amdgpu_device_init.cold+0x1495/0x1abe [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.398113]  ? pci_read_config_byte+0x51/0x60
[  665.402483]  amdgpu_driver_load_kms+0x1a/0x80 [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.411851]  amdgpu_pci_probe+0x28e/0x760 [amdgpu
48030e986eac021fd575f848f833ad5701b3f0f1]
[  665.421055]  local_pci_probe+0x51/0xc0
[  665.425013]  work_for_cpu_fn+0x1d/0x30
[  665.428929]  process_scheduled_works+0x2bc/0x680
[  665.433723]  worker_thread+0x1a6/0x4a0
[  665.437641]  ? _raw_spin_unlock_irqrestore+0x1d/0xa0
[  665.442778]  ? __pfx_worker_thread+0x10/0x10
[  665.447200]  kthread+0x1a4/0x3a0
[  665.450573]  ? __pfx_kthread+0x10/0x10
[  665.454462]  ret_from_fork+0x1f8/0x3b0
[  665.458352]  ? __pfx_kthread+0x10/0x10
[  665.462239]  ret_from_fork_asm+0x1a/0x30
[  665.466294]  </TASK>
[  665.468637] Modules linked in: amdgpu(+) amdxcp drm_ttm_helper ttm drm_e=
xec
drm_panel_backlight_quirks gpu_sched drm_suballoc_helper drm_buddy
drm_display_helper cec rc_core igb i2c_algo_bit
[  665.485989] ---[ end trace 0000000000000000 ]---
Apr 18 12:55:32 localhost kernel: kernel BUG at drivers/gpu/drm/drm_mm.c:93=
0!
[  666.125090] pstore: backend (erst) writing error (-28)
[  666.130558] RIP: 0010:drm_mm_init+0xc1/0xd0
Apr 18 12:55:33 [  666.134915] Code: 83 05 c2 c5 11 04 01 48 c7 83 f0 00 00=
 00
00 00 00 00 e8 a2 79 cd ff 48 83 05 b2 c5 11 04 01 5b c3 cc cc cc cc 0f 1f =
40
00 90 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90
localhost kernel[  666.155476] RSP: 0018:ffa000000d723b60 EFLAGS: 00010246
: pstore: backen[  666.161693] RAX: 0000000000000000 RBX: ff11004093c27400 =
RCX:
000000000000001c
d (erst) writing[  666.170211] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI:
ff11004093c27480
 error (-28)
[  666.178730] RBP: 0000000000000003 R08: 0000000000000dc0 R09:
00000000ffffffff
[  666.187155] R10: ff11004093c27400 R11: 0000000000000100 R12:
ff1100408b60f048
[  666.194550] R13: 0000000000000000 R14: 0000000000000000 R15:
000000000000000b
[  666.201840] FS:  0000000000000000(0000) GS:ff11007ffa92d000(0000)
knlGS:0000000000000000
[  666.210081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  666.215985] CR2: 00007f15ed7d9f55 CR3: 000000000986a002 CR4:
0000000000771ef0
[  666.223298] PKRU: 55555554

-----------------------------------------------------------------

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
