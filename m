Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF91DCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 17:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3D510F9C2;
	Thu,  7 May 2026 17:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dAvJDw8K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8894610F9BB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:28:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B589E6024D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 690FDC2BCB2
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778174919;
 bh=0iTiml0R99kpsyCdugWU8zuzv6bLLmfyVL2Bm1XlzDI=;
 h=From:To:Subject:Date:From;
 b=dAvJDw8KdW25uM1W4HQztcAqpm0bWuulFXS9fKFk+UJEPqccJAnlL8i1Q74S42CLS
 oqQ7lOimjs9CykTmcKwbZyDe8GC+K3lzaF2WCGfLvcZjTe+zFr/wSJ74AW5YJcdkZ0
 syScq8rer5upOk0y+jNLBNKTrgDAw/LqH53QdFmY61FZXywkTXjQWZcwivr7qr4B4/
 h5Yq2rD5icOfHizv1C3TGtmZlGaxp+89VhSOVTOYbi4hYILHSIw7ru6DOQCGspUrsh
 KCmmDrDgv1iFN71N3jUjF5MdHWZ0IBtrBBMG5VaXu1GMAc6HH6Mo50Tp4h8+RnY8Sf
 0Nf03R4GPgeNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 601DAC41613; Thu,  7 May 2026 17:28:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221480] New: drm/nouveau: timeout and WARN in tu102_vmm_flush
 while using mpv
Date: Thu, 07 May 2026 17:28:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: info@maketopsite.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221480-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221480

            Bug ID: 221480
           Summary: drm/nouveau: timeout and WARN in tu102_vmm_flush while
                    using mpv
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: info@maketopsite.com
        Regression: No

Kernel: 6.12.86 (vanilla), compiled on Fedora 43
Plasma on Wayland.
Hardware: ASUS TUF Gaming A16 FA608WV
GPU: NVIDIA proprietary driver


part of very long log:

May 07 17:55:02 maketopsite kernel:  __x64_sys_close+0x3c/0x80
May 07 17:55:02 maketopsite kernel:  __fput+0xde/0x2a0
May 07 17:55:02 maketopsite kernel:  drm_release+0x5e/0xd0
May 07 17:55:02 maketopsite kernel:  drm_file_free+0x210/0x260
May 07 17:55:02 maketopsite kernel:  nouveau_drm_postclose+0xa1/0x150 [nouv=
eau]
May 07 17:55:02 maketopsite kernel:  nouveau_abi16_fini+0xa3/0xe0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? rcutree_enqueue+0x20/0x120
May 07 17:55:02 maketopsite kernel:  nouveau_abi16_chan_fini.isra.0+0x142/0=
x1c0
[nouveau]
May 07 17:55:02 maketopsite kernel:  nouveau_channel_del+0x8a/0x100 [nouvea=
u]
May 07 17:55:02 maketopsite kernel:  nvif_object_dtor+0x7b/0xb0 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_ioctl+0xcf/0x1e0 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_ioctl_del+0x34/0x60 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_object_fini+0x70/0x140 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_object_fini+0xb1/0x140 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_oproxy_fini+0x77/0x90 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_uchan_object_fini_1+0x34/0xa0
[nouveau]
May 07 17:55:02 maketopsite kernel:  refcount_dec_and_mutex_lock+0x12/0x80
May 07 17:55:02 maketopsite kernel:  <TASK>
May 07 17:55:02 maketopsite kernel: Call Trace:
May 07 17:55:02 maketopsite kernel: PKRU: 55555554
May 07 17:55:02 maketopsite kernel: CR2: 00007f4eb00a3fc0 CR3: 000000011901=
0000
CR4: 0000000000f50ef0
May 07 17:55:02 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 17:55:02 maketopsite kernel: FS:  00007f44cd7fa6c0(0000)
GS:ffff8b437e000000(0000) knlGS:0000000000000000
May 07 17:55:02 maketopsite kernel: R13: 0000000000000000 R14: ffff8b3c7cf4=
d9a0
R15: ffff8b3c8047d208
May 07 17:55:02 maketopsite kernel: R10: ffffffff91737c48 R11: 00000000ffff=
dfff
R12: ffff8b3c459a9250
May 07 17:55:02 maketopsite kernel: RBP: ffff8b3cba3f2c00 R08: 000000000000=
0000
R09: ffffcd9af600f8e8
May 07 17:55:02 maketopsite kernel: RDX: ffff8b437e021948 RSI: 000000000000=
0001
RDI: ffff8b437e021940
May 07 17:55:02 maketopsite kernel: RAX: 0000000000000000 RBX: ffff8b3c9992=
034c
RCX: 0000000000000027
May 07 17:55:02 maketopsite kernel: RSP: 0018:ffffcd9af600fa48 EFLAGS: 0001=
0246
May 07 17:55:02 maketopsite kernel: Code: 00 00 c3 cc cc cc cc 31 c0 c3 cc =
cc
cc cc 80 3d c0 2f 11 02 00 75 e6 48 c7 c7 50 64 e3 90 c6 05 b0 2f 11 02 01 =
e8
84 f3 80 ff <0f> >
May 07 17:55:02 maketopsite kernel: RIP: 0010:refcount_dec_not_one+0x4c/0x50
May 07 17:55:02 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:55:02 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:55:02 maketopsite kernel: CPU: 4 UID: 1000 PID: 135283 Comm: vo
Tainted: G        W          6.12.86 #2
May 07 17:55:02 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:55:02 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:55:02 maketopsite kernel: WARNING: CPU: 4 PID: 135283 at
lib/refcount.c:87 refcount_dec_not_one+0x4c/0x50
May 07 17:55:02 maketopsite kernel: refcount_t: underflow; use-after-free.
May 07 17:55:02 maketopsite kernel: ------------[ cut here ]------------
May 07 17:55:02 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 17:55:02 maketopsite kernel:  </TASK>
May 07 17:55:02 maketopsite kernel: R13: 00007f448c1387a0 R14: 00007f448c29=
b8b0
R15: 00007f448c0783a0
May 07 17:55:02 maketopsite kernel: R10: 0000000000000000 R11: 000000000000=
0246
R12: 00007f448c138760
May 07 17:55:02 maketopsite kernel: RBP: 00007f44cd7f0a90 R08: 000000000000=
0000
R09: 0000000000000000
May 07 17:55:02 maketopsite kernel: RDX: 0000000000000000 RSI: 000000000000=
0000
RDI: 000000000000000d
May 07 17:55:02 maketopsite kernel: RAX: ffffffffffffffda RBX: 00007f448c06=
daf0
RCX: 00007f44e4bcf902
May 07 17:55:02 maketopsite kernel: RSP: 002b:00007f44cd7f0a68 EFLAGS: 0000=
0246
ORIG_RAX: 0000000000000003
May 07 17:55:02 maketopsite kernel: Code: 08 0f 85 01 42 ff ff 49 89 fb 48 =
89
f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 =
5c
24 08 0f 05 <c3> >
May 07 17:55:02 maketopsite kernel: RIP: 0033:0x7f44e4bcf902

May 07 17:55:02 maketopsite kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
May 07 17:55:02 maketopsite kernel:  ? irqentry_exit_to_user_mode+0x2c/0x1c0
May 07 17:55:02 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:55:02 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:55:02 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:55:02 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:55:02 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:55:02 maketopsite kernel:  ? __x64_sys_ioctl+0xac/0xd0
May 07 17:55:02 maketopsite kernel:  ? nouveau_drm_ioctl+0x7a/0xb0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? __pm_runtime_suspend+0x48/0xd0
May 07 17:55:02 maketopsite kernel:  ? __pm_runtime_suspend+0x48/0xd0
May 07 17:55:02 maketopsite kernel:  ?
ioctl_has_perm.constprop.0.isra.0+0xc2/0x120
May 07 17:55:02 maketopsite kernel:  ? rpm_suspend+0x3c/0x5f0
May 07 17:55:02 maketopsite kernel:  do_syscall_64+0x7d/0x170
May 07 17:55:02 maketopsite kernel:  __x64_sys_close+0x3c/0x80
May 07 17:55:02 maketopsite kernel:  __fput+0xde/0x2a0
May 07 17:55:02 maketopsite kernel:  drm_release+0x5e/0xd0
May 07 17:55:02 maketopsite kernel:  drm_file_free+0x210/0x260
May 07 17:55:02 maketopsite kernel:  nouveau_drm_postclose+0xa1/0x150 [nouv=
eau]
May 07 17:55:02 maketopsite kernel:  nouveau_abi16_fini+0xa3/0xe0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? rcutree_enqueue+0x20/0x120
May 07 17:55:02 maketopsite kernel:  nouveau_abi16_chan_fini.isra.0+0x1ab/0=
x1c0
[nouveau]
May 07 17:55:02 maketopsite kernel:  <TASK>
May 07 17:55:02 maketopsite kernel: Call Trace:
May 07 17:55:02 maketopsite kernel: PKRU: 55555554
May 07 17:55:02 maketopsite kernel: CR2: 00007f4eb00ef000 CR3: 000000011901=
0000
CR4: 0000000000f50ef0
May 07 17:55:02 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 17:55:02 maketopsite kernel: FS:  00007f44cd7fa6c0(0000)
GS:ffff8b437df80000(0000) knlGS:0000000000000000
May 07 17:55:02 maketopsite kernel: R13: dead000000000122 R14: dead00000000=
0100
R15: ffff8b3c459a9250
May 07 17:55:02 maketopsite kernel: R10: ffff8b3c410e8d40 R11: fffff8fe0404=
3a00
R12: ffff8b3c459a9250
May 07 17:55:02 maketopsite kernel: RBP: ffff8b3c4406a800 R08: ffff8b3c99ac=
d430
R09: 000000008040002f
May 07 17:55:02 maketopsite kernel: RDX: ffffffff8fc204d6 RSI: 000000000000=
0202
RDI: ffff8b3c42c571bc
May 07 17:55:02 maketopsite kernel: RAX: 00000000ffffffea RBX: ffff8b3c42c5=
70c8
RCX: ffff8b3c99acd400
May 07 17:55:02 maketopsite kernel: RSP: 0018:ffffcd9af600fbc0 EFLAGS: 0001=
0283
May 07 17:55:02 maketopsite kernel: Code: 79 05 83 f8 f3 75 23 48 89 ef e8 =
c5
ef af fd e8 b0 02 81 cc 48 89 df be 0d 00 00 00 48 89 83 e8 01 00 00 5b 5d =
e9
6a c3 22 cd <0f> >
May 07 17:55:02 maketopsite kernel: RIP: 0010:nouveau_gem_object_del+0x56/0=
x70
[nouveau]
May 07 17:55:02 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:55:02 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:55:02 maketopsite kernel: CPU: 3 UID: 1000 PID: 135283 Comm: vo
Tainted: G        W          6.12.86 #2
May 07 17:55:02 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:55:02 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:55:02 maketopsite kernel: WARNING: CPU: 3 PID: 135283 at
drivers/gpu/drm/nouveau/nouveau_gem.c:85 nouveau_gem_object_del+0x56/0x70
[nouveau]
May 07 17:55:02 maketopsite kernel: ------------[ cut here ]------------
May 07 17:55:02 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 17:55:02 maketopsite kernel:  </TASK>
May 07 17:55:02 maketopsite kernel: R13: 00007f448c1387a0 R14: 00007f448c29=
b8b0
R15: 00007f448c0783a0
May 07 17:55:02 maketopsite kernel: R10: 0000000000000000 R11: 000000000000=
0246
R12: 00007f448c138760
May 07 17:55:02 maketopsite kernel: RBP: 00007f44cd7f0a90 R08: 000000000000=
0000
R09: 0000000000000000
May 07 17:55:02 maketopsite kernel: RDX: 0000000000000000 RSI: 000000000000=
0000
RDI: 000000000000000d

May 07 17:55:02 maketopsite kernel: RAX: ffffffffffffffda RBX: 00007f448c06=
daf0
RCX: 00007f44e4bcf902
May 07 17:55:02 maketopsite kernel: RSP: 002b:00007f44cd7f0a68 EFLAGS: 0000=
0246
ORIG_RAX: 0000000000000003
May 07 17:55:02 maketopsite kernel: Code: 08 0f 85 01 42 ff ff 49 89 fb 48 =
89
f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 =
5c
24 08 0f 05 <c3> >
May 07 17:55:02 maketopsite kernel: RIP: 0033:0x7f44e4bcf902
May 07 17:55:02 maketopsite kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
May 07 17:55:02 maketopsite kernel:  ? irqentry_exit_to_user_mode+0x2c/0x1c0
May 07 17:55:02 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:55:02 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:55:02 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:55:02 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:55:02 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:55:02 maketopsite kernel:  ? __x64_sys_ioctl+0xac/0xd0
May 07 17:55:02 maketopsite kernel:  ? nouveau_drm_ioctl+0x7a/0xb0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? __pm_runtime_suspend+0x48/0xd0
May 07 17:55:02 maketopsite kernel:  ? __pm_runtime_suspend+0x48/0xd0
May 07 17:55:02 maketopsite kernel:  ?
ioctl_has_perm.constprop.0.isra.0+0xc2/0x120
May 07 17:55:02 maketopsite kernel:  ? rpm_suspend+0x3c/0x5f0
May 07 17:55:02 maketopsite kernel:  do_syscall_64+0x7d/0x170
May 07 17:55:02 maketopsite kernel:  __x64_sys_close+0x3c/0x80
May 07 17:55:02 maketopsite kernel:  __fput+0xde/0x2a0
May 07 17:55:02 maketopsite kernel:  drm_release+0x5e/0xd0
May 07 17:55:02 maketopsite kernel:  drm_file_free+0x210/0x260
May 07 17:55:02 maketopsite kernel:  nouveau_drm_postclose+0xa1/0x150 [nouv=
eau]
May 07 17:55:02 maketopsite kernel:  nouveau_abi16_fini+0xa3/0xe0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? rcutree_enqueue+0x20/0x120
May 07 17:55:02 maketopsite kernel:  nouveau_abi16_chan_fini.isra.0+0xf3/0x=
1c0
[nouveau]
May 07 17:55:02 maketopsite kernel:  nouveau_vma_del+0x86/0xe0 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvif_vmm_put+0x66/0x90 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? __put_partials+0xd5/0x120
May 07 17:55:02 maketopsite kernel:  nvif_object_mthd+0xcd/0x1b0 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_ioctl+0xcf/0x1e0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? nvkm_ioctl+0xcf/0x1e0 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? update_load_avg+0x7a/0x7b0
May 07 17:55:02 maketopsite kernel:  ? psi_group_change+0x185/0x440
May 07 17:55:02 maketopsite kernel:  ? __irq_work_queue_local+0x2b/0xb0
May 07 17:55:02 maketopsite kernel:  ? console_unlock+0x8d/0x130
May 07 17:55:02 maketopsite kernel:  ? prb_read_valid+0x1b/0x30
May 07 17:55:02 maketopsite kernel:  nvkm_uvmm_mthd+0xee7/0xf70 [nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_vmm_put_locked+0x234/0x2c0 [nouve=
au]
May 07 17:55:02 maketopsite kernel:  nvkm_vmm_ptes_unmap_put+0x32/0xc0
[nouveau]
May 07 17:55:02 maketopsite kernel:  ? __pfx_gf100_vmm_pgt_unmap+0x10/0x10
[nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_vmm_ptes_unmap+0x66/0x90 [nouveau]
May 07 17:55:02 maketopsite kernel:  ? __pfx_gf100_vmm_pgt_unmap+0x10/0x10
[nouveau]
May 07 17:55:02 maketopsite kernel:  nvkm_vmm_iter.isra.0+0x425/0xae0 [nouv=
eau]
May 07 17:55:02 maketopsite kernel:  <TASK>
May 07 17:55:02 maketopsite kernel: Call Trace:
May 07 17:55:02 maketopsite kernel: PKRU: 55555554
May 07 17:55:02 maketopsite kernel: CR2: 00007f4eb00ef000 CR3: 000000011901=
0000
CR4: 0000000000f50ef0
May 07 17:55:02 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033

May 07 17:55:02 maketopsite kernel: FS:  00007f44cd7fa6c0(0000)
GS:ffff8b437df80000(0000) knlGS:0000000000000000
May 07 17:55:02 maketopsite kernel: R13: 000000000000002e R14: 000000000000=
0000
R15: 0000000000000000
May 07 17:55:02 maketopsite kernel: R10: ffffffff91737c48 R11: 00000000ffff=
dfff
R12: 0000000080000001
May 07 17:55:02 maketopsite kernel: RBP: ffff8b3c93769800 R08: 000000000000=
0000
R09: ffffcd9af600f5b8
May 07 17:55:02 maketopsite kernel: RDX: ffff8b437dfa1948 RSI: 000000000000=
0001
RDI: ffff8b437dfa1940
May 07 17:55:02 maketopsite kernel: RAX: 0000000000000000 RBX: ffff8b3c42be=
2780
RCX: 0000000000000027
May 07 17:55:02 maketopsite kernel: RSP: 0018:ffffcd9af600f718 EFLAGS: 0001=
0246
May 07 17:55:02 maketopsite kernel: Code: 8b 40 10 48 8b 78 10 48 8b 5f 50 =
48
85 db 75 03 48 8b 1f e8 cf db 28 cd 48 89 da 48 c7 c7 cf 95 bf c2 48 89 c6 =
e8
4d 37 78 cc <0f> >
May 07 17:55:02 maketopsite kernel: RIP: 0010:tu102_vmm_flush+0x163/0x170
[nouveau]
May 07 17:55:02 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:55:02 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:55:02 maketopsite kernel: CPU: 3 UID: 1000 PID: 135283 Comm: vo
Tainted: G        W          6.12.86 #2
May 07 17:55:02 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:55:02 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:55:02 maketopsite kernel: WARNING: CPU: 3 PID: 135283 at
drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c:45
tu102_vmm_flush+0x163/0x170 [nouveau]
May 07 17:55:02 maketopsite kernel: nouveau 0000:64:00.0: timeout
May 07 17:55:02 maketopsite kernel: ------------[ cut here ]------------
May 07 17:55:02 maketopsite kernel: nouveau 0000:64:00.0: timer: stalled at
ffffffffffffffff
May 07 17:55:02 maketopsite kernel: nouveau 0000:64:00.0: vo[135269]: faile=
d to
idle channel 40 [vo[135269]]
May 07 17:54:49 maketopsite abrt-dump-journal-oops[1790]: Reported 1 kernel
oopses to Abrt
May 07 17:54:48 maketopsite abrt-server[135710]: Deleting problem directory
'/var/spool/abrt/oops-2026-05-07-17:54:48-1790-0'
May 07 17:54:48 maketopsite abrt-server[135710]: 'post-create' on
'/var/spool/abrt/oops-2026-05-07-17:54:48-1790-0' exited with 1
May 07 17:54:48 maketopsite abrt-server[135710]: Can't find kernel package
corresponding to '6.12.86'
May 07 17:54:48 maketopsite abrt-dump-journal-oops[1790]:
abrt-dump-journal-oops: Creating problem directories
May 07 17:54:48 maketopsite abrt-dump-journal-oops[1790]:
abrt-dump-journal-oops: Found oopses: 1
May 07 17:54:47 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 17:54:47 maketopsite kernel:  </TASK>
May 07 17:54:47 maketopsite kernel: R13: 00007f448c1387a0 R14: 00007f448c29=
b8b0
R15: 00007f448c0783a0
May 07 17:54:47 maketopsite kernel: R10: 0000000000000000 R11: 000000000000=
0246
R12: 00007f448c138760
May 07 17:54:47 maketopsite kernel: RBP: 00007f44cd7f0a90 R08: 000000000000=
0000
R09: 0000000000000000
May 07 17:54:47 maketopsite kernel: RDX: 0000000000000000 RSI: 000000000000=
0000
RDI: 000000000000000d
May 07 17:54:47 maketopsite kernel: RAX: ffffffffffffffda RBX: 00007f448c06=
daf0
RCX: 00007f44e4bcf902
May 07 17:54:47 maketopsite kernel: RSP: 002b:00007f44cd7f0a68 EFLAGS: 0000=
0246
ORIG_RAX: 0000000000000003
May 07 17:54:47 maketopsite kernel: Code: 08 0f 85 01 42 ff ff 49 89 fb 48 =
89
f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 =
5c
24 08 0f 05 <c3> >
May 07 17:54:47 maketopsite kernel: RIP: 0033:0x7f44e4bcf902
May 07 17:54:47 maketopsite kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
May 07 17:54:47 maketopsite kernel:  ? irqentry_exit_to_user_mode+0x2c/0x1c0
May 07 17:54:47 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:47 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:47 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:54:47 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:47 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:54:47 maketopsite kernel:  ? __x64_sys_ioctl+0xac/0xd0
May 07 17:54:47 maketopsite kernel:  ? nouveau_drm_ioctl+0x7a/0xb0 [nouveau]
May 07 17:54:47 maketopsite kernel:  ? __pm_runtime_suspend+0x48/0xd0
May 07 17:54:47 maketopsite kernel:  ? __pm_runtime_suspend+0x48/0xd0
May 07 17:54:47 maketopsite kernel:  ?
ioctl_has_perm.constprop.0.isra.0+0xc2/0x120
May 07 17:54:47 maketopsite kernel:  ? rpm_suspend+0x3c/0x5f0
May 07 17:54:47 maketopsite kernel:  do_syscall_64+0x7d/0x170

May 07 17:54:47 maketopsite kernel:  __x64_sys_close+0x3c/0x80
May 07 17:54:47 maketopsite kernel:  __fput+0xde/0x2a0
May 07 17:54:47 maketopsite kernel:  drm_release+0x5e/0xd0
May 07 17:54:47 maketopsite kernel:  drm_file_free+0x1f0/0x260
May 07 17:54:47 maketopsite kernel:  drm_gem_release+0x20/0x30
May 07 17:54:47 maketopsite kernel:  idr_for_each+0x6b/0xf0
May 07 17:54:47 maketopsite kernel:  ?
__pfx_drm_gem_object_release_handle+0x10/0x10
May 07 17:54:47 maketopsite kernel:  drm_gem_object_release_handle+0x59/0xb0
May 07 17:54:47 maketopsite kernel:  <TASK>
May 07 17:54:47 maketopsite kernel: Call Trace:
May 07 17:54:47 maketopsite kernel: PKRU: 55555554
May 07 17:54:47 maketopsite kernel: CR2: 00007f44e05cd000 CR3: 000000011901=
0000
CR4: 0000000000f50ef0
May 07 17:54:47 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 17:54:47 maketopsite kernel: FS:  00007f44cd7fa6c0(0000)
GS:ffff8b437e500000(0000) knlGS:0000000000000000
May 07 17:54:47 maketopsite kernel: R13: ffff8b3c8234fe50 R14: ffff8b3f76d9=
8b90
R15: 0000000000000000
May 07 17:54:47 maketopsite kernel: R10: ffff8b3c756aec80 R11: fffff8fe04d5=
ab80
R12: 0000000000000001
May 07 17:54:47 maketopsite kernel: RBP: ffff8b3c9280e400 R08: ffff8b3c756a=
ec80
R09: 0000000080400039
May 07 17:54:47 maketopsite kernel: RDX: ffffffff8fc204d6 RSI: 000000000000=
0202
RDI: ffff8b3c42c571bc
May 07 17:54:47 maketopsite kernel: RAX: 00000000ffffffea RBX: ffff8b3c42c5=
70c8
RCX: 0000000080400039
May 07 17:54:47 maketopsite kernel: RSP: 0018:ffffcd9af600fbf0 EFLAGS: 0001=
0283
May 07 17:54:47 maketopsite kernel: Code: 79 05 83 f8 f3 75 23 48 89 ef e8 =
c5
ef af fd e8 b0 02 81 cc 48 89 df be 0d 00 00 00 48 89 83 e8 01 00 00 5b 5d =
e9
6a c3 22 cd <0f> >
May 07 17:54:47 maketopsite kernel: RIP: 0010:nouveau_gem_object_del+0x56/0=
x70
[nouveau]
May 07 17:54:47 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:54:47 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:54:47 maketopsite kernel: CPU: 14 UID: 1000 PID: 135283 Comm: vo
Tainted: G        W          6.12.86 #2
May 07 17:54:47 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:54:47 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:54:47 maketopsite kernel: WARNING: CPU: 14 PID: 135283 at
drivers/gpu/drm/nouveau/nouveau_gem.c:85 nouveau_gem_object_del+0x56/0x70
[nouveau]
May 07 17:54:47 maketopsite kernel: ------------[ cut here ]------------
May 07 17:54:09 maketopsite abrt-dump-journal-oops[1790]: Reported 1 kernel
oopses to Abrt
May 07 17:54:08 maketopsite abrt-server[135515]: Deleting problem directory
'/var/spool/abrt/oops-2026-05-07-17:54:08-1790-0'
May 07 17:54:08 maketopsite abrt-server[135515]: 'post-create' on
'/var/spool/abrt/oops-2026-05-07-17:54:08-1790-0' exited with 1
May 07 17:54:08 maketopsite abrt-server[135515]: Can't find kernel package
corresponding to '6.12.86'
May 07 17:54:08 maketopsite abrt-dump-journal-oops[1790]:
abrt-dump-journal-oops: Creating problem directories
May 07 17:54:08 maketopsite abrt-dump-journal-oops[1790]:
abrt-dump-journal-oops: Found oopses: 1
May 07 17:54:06 maketopsite kernel: nouveau 0000:64:00.0: drm: resume failed
with: -5
May 07 17:54:06 maketopsite kernel: nouveau 0000:64:00.0: drm: Client resume
failed with error: -5
May 07 17:54:06 maketopsite kernel: nouveau: drm:00000000:00000000: init fa=
iled
with -5
May 07 17:54:06 maketopsite kernel: nouveau: drm:00000000:00000080: init fa=
iled
with -5
May 07 17:54:06 maketopsite kernel: nouveau 0000:64:00.0: init failed with =
-5
May 07 17:54:06 maketopsite kernel: nouveau 0000:64:00.0: gsp: init failed,=
 -5
May 07 17:54:06 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 17:54:06 maketopsite kernel:  </TASK>
May 07 17:54:06 maketopsite kernel: R13: 00000000c01864cb R14: 000000000000=
000d
R15: 0000000000000008
May 07 17:54:06 maketopsite kernel: R10: 0000000000000000 R11: 000000000000=
0246
R12: 00007f44cd7f05c0
May 07 17:54:06 maketopsite kernel: RBP: 00007f44cd7f0580 R08: 000000000000=
0000
R09: 00007f44cd7f0700
May 07 17:54:06 maketopsite kernel: RDX: 00007f44cd7f05c0 RSI: 00000000c018=
64cb
RDI: 000000000000000d
May 07 17:54:06 maketopsite kernel: RAX: ffffffffffffffda RBX: 00007f44cd7f=
0810
RCX: 00007f44e4c4632d
May 07 17:54:06 maketopsite kernel: RSP: 002b:00007f44cd7f0530 EFLAGS: 0000=
0246
ORIG_RAX: 0000000000000010

May 07 17:54:06 maketopsite kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 =
c0
48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 =
00
00 00 0f 05 <89> >
May 07 17:54:06 maketopsite kernel: RIP: 0033:0x7f44e4c4632d
May 07 17:54:06 maketopsite kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
May 07 17:54:06 maketopsite kernel:  ? irqentry_exit_to_user_mode+0x2c/0x1c0
May 07 17:54:06 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:06 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:54:06 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:06 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:54:06 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:06 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:06 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:54:06 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 17:54:06 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 17:54:06 maketopsite kernel:  ?
arch_exit_to_user_mode_prepare.isra.0+0x7e/0x90
May 07 17:54:06 maketopsite kernel:  ? switch_fpu_return+0x4e/0xd0
May 07 17:54:06 maketopsite kernel:  do_syscall_64+0x7d/0x170
May 07 17:54:06 maketopsite kernel:  __x64_sys_ioctl+0x91/0xd0
May 07 17:54:06 maketopsite kernel:  nouveau_drm_ioctl+0x36/0xb0 [nouveau]
May 07 17:54:06 maketopsite kernel:  __pm_runtime_resume+0x52/0x90
May 07 17:54:06 maketopsite kernel:  ?
ioctl_has_perm.constprop.0.isra.0+0xc2/0x120
May 07 17:54:06 maketopsite kernel:  rpm_resume+0x4b1/0x6d0
May 07 17:54:06 maketopsite kernel:  rpm_callback+0x63/0x70
May 07 17:54:06 maketopsite kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
May 07 17:54:06 maketopsite kernel:  __rpm_callback+0x41/0x160
May 07 17:54:06 maketopsite kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
May 07 17:54:06 maketopsite kernel:  nouveau_pmops_runtime_resume+0x74/0x110
[nouveau]
May 07 17:54:06 maketopsite kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
May 07 17:54:06 maketopsite kernel:  nouveau_do_resume+0x2e/0xb0 [nouveau]
May 07 17:54:06 maketopsite kernel:  ? __pfx_pci_pm_runtime_resume+0x10/0x10
May 07 17:54:06 maketopsite kernel:  nvkm_object_init+0x77/0x120 [nouveau]
May 07 17:54:06 maketopsite kernel:  nvkm_object_init+0x3f/0x120 [nouveau]
May 07 17:54:06 maketopsite kernel:  nvkm_udevice_init+0x45/0x70 [nouveau]
May 07 17:54:06 maketopsite kernel:  nvkm_device_init+0x163/0x1e0 [nouveau]
May 07 17:54:06 maketopsite kernel:  nvkm_subdev_init+0x46/0x60 [nouveau]
May 07 17:54:06 maketopsite kernel:  ? nvkm_intr_rearm+0xc1/0x1c0 [nouveau]
May 07 17:54:06 maketopsite kernel:  nvkm_subdev_init_+0x4a/0xa0 [nouveau]
May 07 17:54:06 maketopsite kernel:  ? nvkm_mc_reset+0x1f/0x70 [nouveau]
May 07 17:54:06 maketopsite kernel:  ? ktime_get+0x3e/0xf0
May 07 17:54:06 maketopsite kernel:  <TASK>
May 07 17:54:06 maketopsite kernel: Call Trace:
May 07 17:54:06 maketopsite kernel: PKRU: 55555554
May 07 17:54:06 maketopsite kernel: CR2: 00007f62a0008000 CR3: 000000011901=
0000
CR4: 0000000000f50ef0
May 07 17:54:06 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 17:54:06 maketopsite kernel: FS:  00007f44cd7fa6c0(0000)
GS:ffff8b437e480000(0000) knlGS:0000000000000000
May 07 17:54:06 maketopsite kernel: R13: ffff8b3c99e95c00 R14: 00000dee8034=
5c2d
R15: 00000dee8034453e
May 07 17:54:06 maketopsite kernel: R10: 000000000000000d R11: 000000000000=
0000
R12: 00000000fffffffb
May 07 17:54:06 maketopsite kernel: RBP: ffff8b3c9d16c000 R08: 000000000000=
0000
R09: 0000000000000001
May 07 17:54:06 maketopsite kernel: RDX: 0000000000000000 RSI: 000000005555=
5554
RDI: ffff8b3c97c710e8
May 07 17:54:06 maketopsite kernel: RAX: 00000000fffffffb RBX: ffff8b3c9d16=
c008
RCX: 0000000000000002

May 07 17:54:06 maketopsite kernel: RSP: 0018:ffffcd9af600faa0 EFLAGS: 0001=
0282
May 07 17:54:06 maketopsite kernel: Code: 08 89 44 24 3c 48 8d bd b0 04 00 =
00
ba 01 00 00 00 6a 00 4c 8d 44 24 48 e8 f3 a6 fa ff 41 58 41 89 c4 85 c0 0f =
84
90 00 00 00 <0f> >
May 07 17:54:06 maketopsite kernel: RIP: 0010:r535_gsp_init+0x8a/0xc90
[nouveau]
May 07 17:54:06 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:54:06 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:54:06 maketopsite kernel: CPU: 13 UID: 1000 PID: 135283 Comm: vo
Tainted: G        W          6.12.86 #2
May 07 17:54:06 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:54:06 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:54:06 maketopsite kernel: WARNING: CPU: 13 PID: 135283 at
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:2417 r535_gsp_init+0x8a/0xc90
[nouveau]
May 07 17:54:06 maketopsite kernel: ------------[ cut here ]------------
May 07 17:54:06 maketopsite kernel: nouveau 0000:64:00.0:
sec2(gsp):booter-load: boot failed: -5
May 07 17:54:06 maketopsite kernel: nouveau 0000:64:00.0: sec2(gsp): mbox
00000098 00000000
May 07 17:52:54 maketopsite audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D4=
294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"syst>
May 07 17:52:54 maketopsite systemd[1]: NetworkManager-dispatcher.service:
Deactivated successfully.
May 07 17:52:44 maketopsite audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D=
4294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"sys>
May 07 17:52:44 maketopsite systemd[1]: Started
NetworkManager-dispatcher.service - Network Manager Script Dispatcher Servi=
ce.
May 07 17:52:44 maketopsite systemd[1]: Starting
NetworkManager-dispatcher.service - Network Manager Script Dispatcher
Service...
May 07 17:52:33 maketopsite abrt-dump-journal-oops[1790]: Reported 2 kernel
oopses to Abrt
May 07 17:52:32 maketopsite abrt-server[135341]: Deleting problem directory
'/var/spool/abrt/oops-2026-05-07-17:52:31-1790-1'
May 07 17:52:32 maketopsite abrt-server[135341]: 'post-create' on
'/var/spool/abrt/oops-2026-05-07-17:52:31-1790-1' exited with 1
May 07 17:52:32 maketopsite abrt-server[135341]: Can't find kernel package
corresponding to '6.12.86'
May 07 17:52:31 maketopsite abrt-server[135337]: Deleting problem directory
'/var/spool/abrt/oops-2026-05-07-17:52:31-1790-0'
May 07 17:52:31 maketopsite abrt-server[135337]: 'post-create' on
'/var/spool/abrt/oops-2026-05-07-17:52:31-1790-0' exited with 1
May 07 17:52:31 maketopsite abrt-server[135337]: Can't find kernel package
corresponding to '6.12.86'
May 07 17:52:31 maketopsite abrt-dump-journal-oops[1790]:
abrt-dump-journal-oops: Creating problem directories
May 07 17:52:31 maketopsite abrt-dump-journal-oops[1790]:
abrt-dump-journal-oops: Found oopses: 2
May 07 17:52:30 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 17:52:30 maketopsite kernel:  </TASK>
May 07 17:52:30 maketopsite kernel:  ret_from_fork_asm+0x1a/0x30
May 07 17:52:30 maketopsite kernel:  ? __pfx_kthread+0x10/0x10
May 07 17:52:30 maketopsite kernel:  ret_from_fork+0x31/0x50
May 07 17:52:30 maketopsite kernel:  ? __pfx_kthread+0x10/0x10
May 07 17:52:30 maketopsite kernel:  kthread+0xcf/0x100
May 07 17:52:30 maketopsite kernel:  ? __pfx_worker_thread+0x10/0x10
May 07 17:52:30 maketopsite kernel:  worker_thread+0x191/0x2f0
May 07 17:52:30 maketopsite kernel:  process_one_work+0x17b/0x340
May 07 17:52:30 maketopsite kernel:  pm_runtime_work+0x98/0xb0
May 07 17:52:30 maketopsite kernel:  ? folio_batch_move_lru+0xd0/0x150
May 07 17:52:30 maketopsite kernel:  rpm_suspend+0xe6/0x5f0
May 07 17:52:30 maketopsite kernel:  rpm_callback+0x63/0x70
May 07 17:52:30 maketopsite kernel:  ? __pfx_pci_pm_runtime_suspend+0x10/0x=
10
May 07 17:52:30 maketopsite kernel:  __rpm_callback+0x41/0x160
May 07 17:52:30 maketopsite kernel:  ? __pfx_pci_pm_runtime_suspend+0x10/0x=
10
May 07 17:52:30 maketopsite kernel:  ? __pfx_pci_pm_runtime_suspend+0x10/0x=
10
May 07 17:52:30 maketopsite kernel:  pci_pm_runtime_suspend+0x67/0x1a0
May 07 17:52:30 maketopsite kernel:  nouveau_pmops_runtime_suspend+0x3e/0xb0
[nouveau]
May 07 17:52:30 maketopsite kernel:  nouveau_do_suspend+0xe4/0x170 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_object_fini+0x70/0x140 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_object_fini+0xb1/0x140 [nouveau]

May 07 17:52:30 maketopsite kernel:  nvkm_udevice_fini+0x50/0x70 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_device_fini+0x94/0x140 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_subdev_fini+0x67/0xc0 [nouveau]
May 07 17:52:30 maketopsite kernel:  <TASK>
May 07 17:52:30 maketopsite kernel: Call Trace:
May 07 17:52:30 maketopsite kernel: PKRU: 55555554
May 07 17:52:30 maketopsite kernel: CR2: 00007f4e82429004 CR3: 000000031962=
c000
CR4: 0000000000f50ef0
May 07 17:52:30 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 17:52:30 maketopsite kernel: FS:  0000000000000000(0000)
GS:ffff8b437e180000(0000) knlGS:0000000000000000
May 07 17:52:30 maketopsite kernel: R13: ffff8b3c99e95c00 R14: 000000000000=
0000
R15: 0000000029c74000
May 07 17:52:30 maketopsite kernel: R10: ffff8b3c99e95c00 R11: 00000000ffff=
dfff
R12: ffffffffc2bf3dcd
May 07 17:52:30 maketopsite kernel: RBP: 0000000000000001 R08: 000000000000=
0000
R09: ffffcd9aef57f8d8
May 07 17:52:30 maketopsite kernel: RDX: 0000000000000000 RSI: ffff8b3c9d16=
c008
RDI: ffff8b3c97c710e8
May 07 17:52:30 maketopsite kernel: RAX: 00000000fffffffb RBX: ffff8b3c9d16=
c000
RCX: 0000000000000027
May 07 17:52:30 maketopsite kernel: RSP: 0018:ffffcd9aef57fb80 EFLAGS: 0001=
0282
May 07 17:52:30 maketopsite kernel: Code: 24 20 e8 20 a8 fa ff 5a 4c 8b 14 =
24
85 c0 75 7e 49 8b 7a 78 48 81 c7 28 a8 1f 00 e8 47 40 fa cc 85 c0 0f 84 d8 =
fe
ff ff 0f 0b <0f> >
May 07 17:52:30 maketopsite kernel: RIP: 0010:r535_gsp_fini+0x2e3/0x360
[nouveau]
May 07 17:52:30 maketopsite kernel: Workqueue: pm pm_runtime_work
May 07 17:52:30 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:52:30 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:52:30 maketopsite kernel: CPU: 7 UID: 0 PID: 133362 Comm: kworker=
/7:1
Tainted: G        W          6.12.86 #2
May 07 17:52:30 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:52:30 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:52:30 maketopsite kernel: WARNING: CPU: 7 PID: 133362 at
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:2393 r535_gsp_fini+0x2e3/0x3=
60
[nouveau]
May 07 17:52:30 maketopsite kernel: ------------[ cut here ]------------
May 07 17:52:30 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 17:52:30 maketopsite kernel:  </TASK>
May 07 17:52:30 maketopsite kernel:  ret_from_fork_asm+0x1a/0x30
May 07 17:52:30 maketopsite kernel:  ? __pfx_kthread+0x10/0x10
May 07 17:52:30 maketopsite kernel:  ret_from_fork+0x31/0x50
May 07 17:52:30 maketopsite kernel:  ? __pfx_kthread+0x10/0x10
May 07 17:52:30 maketopsite kernel:  kthread+0xcf/0x100
May 07 17:52:30 maketopsite kernel:  ? __pfx_worker_thread+0x10/0x10
May 07 17:52:30 maketopsite kernel:  worker_thread+0x191/0x2f0
May 07 17:52:30 maketopsite kernel:  process_one_work+0x17b/0x340
May 07 17:52:30 maketopsite kernel:  pm_runtime_work+0x98/0xb0
May 07 17:52:30 maketopsite kernel:  ? folio_batch_move_lru+0xd0/0x150
May 07 17:52:30 maketopsite kernel:  rpm_suspend+0xe6/0x5f0
May 07 17:52:30 maketopsite kernel:  rpm_callback+0x63/0x70
May 07 17:52:30 maketopsite kernel:  ? __pfx_pci_pm_runtime_suspend+0x10/0x=
10
May 07 17:52:30 maketopsite kernel:  __rpm_callback+0x41/0x160
May 07 17:52:30 maketopsite kernel:  ? __pfx_pci_pm_runtime_suspend+0x10/0x=
10
May 07 17:52:30 maketopsite kernel:  ? __pfx_pci_pm_runtime_suspend+0x10/0x=
10
May 07 17:52:30 maketopsite kernel:  pci_pm_runtime_suspend+0x67/0x1a0
May 07 17:52:30 maketopsite kernel:  nouveau_pmops_runtime_suspend+0x3e/0xb0
[nouveau]
May 07 17:52:30 maketopsite kernel:  nouveau_do_suspend+0xe4/0x170 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_object_fini+0x70/0x140 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_object_fini+0xb1/0x140 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_udevice_fini+0x50/0x70 [nouveau]

May 07 17:52:30 maketopsite kernel:  nvkm_device_fini+0x94/0x140 [nouveau]
May 07 17:52:30 maketopsite kernel:  nvkm_subdev_fini+0x67/0xc0 [nouveau]
May 07 17:52:30 maketopsite kernel:  <TASK>
May 07 17:52:30 maketopsite kernel: Call Trace:
May 07 17:52:30 maketopsite kernel: PKRU: 55555554
May 07 17:52:30 maketopsite kernel: CR2: 00007f4e82429004 CR3: 000000031962=
c000
CR4: 0000000000f50ef0
May 07 17:52:30 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 17:52:30 maketopsite kernel: FS:  0000000000000000(0000)
GS:ffff8b437e180000(0000) knlGS:0000000000000000
May 07 17:52:30 maketopsite kernel: R13: ffff8b3c99e95c00 R14: 000000000000=
0000
R15: 0000000029c74000
May 07 17:52:30 maketopsite kernel: R10: ffff8b3c99e95c00 R11: 00000000ffff=
dfff
R12: ffffffffc2bf3dcd
May 07 17:52:30 maketopsite kernel: RBP: 0000000000000001 R08: 000000000000=
0000
R09: ffffcd9aef57f8d8
May 07 17:52:30 maketopsite kernel: RDX: 0000000000000000 RSI: ffff8b3c9d16=
c008
RDI: ffff8b3c97c710e8
May 07 17:52:30 maketopsite kernel: RAX: 00000000fffffffb RBX: ffff8b3c9d16=
c000
RCX: 0000000000000027
May 07 17:52:30 maketopsite kernel: RSP: 0018:ffffcd9aef57fb80 EFLAGS: 0001=
0282
May 07 17:52:30 maketopsite kernel: Code: c7 c7 af 80 bf c2 48 89 c6 e8 95 =
1d
7a cc 0f 0b 48 8b 4c 24 08 e9 32 fe ff ff 89 f0 0f 0b e9 24 fd ff ff 0f 0b =
e9
3a fe ff ff <0f> >
May 07 17:52:30 maketopsite kernel: RIP: 0010:r535_gsp_fini+0x347/0x360
[nouveau]
May 07 17:52:30 maketopsite kernel: Workqueue: pm pm_runtime_work
May 07 17:52:30 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 17:52:30 maketopsite kernel: Tainted: [W]=3DWARN
May 07 17:52:30 maketopsite kernel: CPU: 7 UID: 0 PID: 133362 Comm: kworker=
/7:1
Tainted: G        W          6.12.86 #2
May 07 17:52:30 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_amd sn>
May 07 17:52:30 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ip>
May 07 17:52:30 maketopsite kernel: WARNING: CPU: 7 PID: 133362 at
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1907 r535_gsp_fini+0x347/0x3=
60
[nouveau]
May 07 17:52:30 maketopsite kernel: ------------[ cut here ]------------
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0:
sec2(gsp):booter-unload: boot failed: -5
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: sec2(gsp): mbox
0000009f 00000000
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60900 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60800 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60700 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60600 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60500 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60400 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60300 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60200 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60100 flags=3D0x0000]
May 07 17:52:30 maketopsite kernel: nouveau 0000:64:00.0: AMD-Vi: Event log=
ged
[IO_PAGE_FAULT domain=3D0x0013 address=3D0xffdff60000 flags=3D0x0000]
May 07 17:52:14 maketopsite /usr/libexec/xdg-desktop-portal[5179]: Realtime
error: Could not get pidns for pid 135269: Could not fstatat ns/pid: Not a
directory
May 07 17:52:05 maketopsite systemd[4740]:
app-mpv@28c0ca82f16442f995ceeaa8b2d4674b.service: Consumed 13.919s CPU time,
120.7M memory peak.
May 07 17:51:55 maketopsite /usr/libexec/xdg-desktop-portal[5179]: Realtime
error: Could not get pidns for pid 135173: Could not fstatat ns/pid: Not a
directory
May 07 17:51:54 maketopsite audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D4=
294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"syst>
May 07 17:51:54 maketopsite systemd[1]: NetworkManager-dispatcher.service:
Deactivated successfully.
May 07 17:51:53 maketopsite systemd[4740]: Started
app-mpv@28c0ca82f16442f995ceeaa8b2d4674b.service - mpv Media Player -
Multimedia player.
May 07 17:51:47 maketopsite kernel: nouveau 0000:64:00.0: Using 47-bit DMA
addresses
May 07 17:51:44 maketopsite audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D=
4294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"sys>
May 07 17:51:44 maketopsite systemd[1]: Started
NetworkManager-dispatcher.service - Network Manager Script Dispatcher Servi=
ce.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
