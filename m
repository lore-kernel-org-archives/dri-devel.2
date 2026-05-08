Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0450DCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2524810E27E;
	Fri,  8 May 2026 07:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GRvqvEft";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F1D10E27E
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:19:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F929600AE
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E82E6C2BCB0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778224783;
 bh=qZ63ndBNoZroUrX05I3CNDYWIulGPyHdRVrsFn7mAks=;
 h=From:To:Subject:Date:From;
 b=GRvqvEftDG5DKNs0UHor8+LQ2L7SRKTVdS755e7+exbXB7LZbBKSh/V4kwd94fd06
 7eaAdjPGepbpfIYOksrzvbSZqZH5N6vwrt7n+STP5jqYk/3Y0MCVE8+o7iGVNR8QmW
 oLZXqNZkHGewO2jJ50MXD0ZHSJgc1QZP52MTuVZQULxm9zWQv/0ZhemjCTGo+Xym/i
 a+Z0cvE1KYxK/yW4LiohjPSp1G7OvnlajZbeLEfNyWJr4Ajh9rN8hGvrDDukjzFywg
 LYZ6f8GpbdNZJw+yNtQm9E1XlTRQ0rHCjiMV+/BxgFhj6fM0N8gNmsbSqQGSmOrRAW
 Mb6VJ0uKfH2yA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D88FEC41613; Fri,  8 May 2026 07:19:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221487] New: Nouveau GSP timeout (r535_gsp_msgq_wait) on ASUS
 TUF Gaming A16 with NVIDIA RTX 4060 Max-Q / Mobile and kernel 6.12.86
Date: Fri, 08 May 2026 07:19:43 +0000
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
Message-ID: <bug-221487-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221487

            Bug ID: 221487
           Summary: Nouveau GSP timeout (r535_gsp_msgq_wait) on ASUS TUF
                    Gaming A16 with NVIDIA RTX 4060 Max-Q / Mobile and
                    kernel 6.12.86
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

I reported a kernel bugs
https://bugzilla.kernel.org/show_bug.cgi?id=3D221480
and
https://bugzilla.kernel.org/show_bug.cgi?id=3D221478

Then I kept using the laptop, and when I wanted to shut it down, this error
appeared.

May 07 20:22:42 maketopsite systemd[1]: user@1000.service: Consumed 4h 57min
50.519s CPU time, 11.2G memory peak.
May 07 20:22:42 maketopsite systemd[1]: Stopped user@1000.service - User
Manager for UID 1000.
May 07 20:22:42 maketopsite systemd[1]: user@1000.service: Unit process 5277
(Xwayland) remains running after unit stopped.
May 07 20:22:42 maketopsite systemd[1]: user@1000.service: Failed with resu=
lt
'timeout'.
May 07 20:22:42 maketopsite audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D4=
294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dsystemd-o=
omd
comm=3D"systemd" exe=3D>
May 07 20:22:42 maketopsite audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D4=
294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Duser@1000
comm=3D"systemd" exe=3D"/u>
May 07 20:22:42 maketopsite systemd[1]: user@1000.service: Processes still
around after final SIGKILL. Entering failed mode.
May 07 20:22:04 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 20:22:04 maketopsite kernel:  </TASK>
May 07 20:22:04 maketopsite kernel: R13: 0000000000000001 R14: 000000000000=
000f
R15: 00005556885141e0
May 07 20:22:04 maketopsite kernel: R10: 00007fc270df9350 R11: 000000000000=
0246
R12: 000000059c949e75
May 07 20:22:04 maketopsite kernel: RBP: 00007fc270df9390 R08: 000000000235=
691c
R09: 0000000000000000
May 07 20:22:04 maketopsite kernel: RDX: 000000000000000f RSI: 000000000000=
0080
RDI: 00005556885141f0
May 07 20:22:04 maketopsite kernel: RAX: fffffffffffffdfc RBX: 000000000000=
0001
RCX: 00007fc2be72830d
May 07 20:22:04 maketopsite kernel: RSP: 002b:00007fc270df9328 EFLAGS: 0000=
0246
ORIG_RAX: 00000000000000ca
May 07 20:22:04 maketopsite kernel: Code: Unable to access opcode bytes at
0x7fc2be7282e3.
May 07 20:22:04 maketopsite kernel: RIP: 0033:0x7fc2be72830d
May 07 20:22:04 maketopsite kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
May 07 20:22:04 maketopsite kernel:  ? irqentry_exit_to_user_mode+0x2c/0x1c0
May 07 20:22:04 maketopsite kernel:  ?
arch_exit_to_user_mode_prepare.isra.0+0x7e/0x90
May 07 20:22:04 maketopsite kernel:  ? do_user_addr_fault+0x188/0x640
May 07 20:22:04 maketopsite kernel:  ? __rseq_handle_notify_resume+0x9c/0x4=
f0
May 07 20:22:04 maketopsite kernel:  ? wake_up_q+0x3c/0x80
May 07 20:22:04 maketopsite kernel:  ? rwsem_mark_wake+0x204/0x2d0
May 07 20:22:04 maketopsite kernel:  ? try_to_wake_up+0x308/0x7b0
May 07 20:22:04 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 20:22:04 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 20:22:04 maketopsite kernel:  ? __task_pid_nr_ns+0x67/0x110
May 07 20:22:04 maketopsite kernel:  ? sched_clock_cpu+0xf/0x230
May 07 20:22:04 maketopsite kernel:  ? set_ptes.isra.0+0x36/0x80
May 07 20:22:04 maketopsite kernel:  ? __folio_mod_stat+0x2d/0x90
May 07 20:22:04 maketopsite kernel:  ? __lruvec_stat_mod_folio+0x85/0xd0

May 07 20:22:04 maketopsite kernel:  ? __pte_offset_map+0x1b/0x180
May 07 20:22:04 maketopsite kernel:  ? select_task_rq_fair+0x9cb/0x2d40
May 07 20:22:04 maketopsite kernel:  ? __mod_memcg_lruvec_state+0xbd/0x250
May 07 20:22:04 maketopsite kernel:  do_syscall_64+0x89/0x170
May 07 20:22:04 maketopsite kernel:  syscall_exit_to_user_mode+0x139/0x1c0
May 07 20:22:04 maketopsite kernel:  arch_do_signal_or_restart+0x3c/0x260
May 07 20:22:04 maketopsite kernel:  get_signal+0x916/0x920
May 07 20:22:04 maketopsite kernel:  ? _raw_spin_lock_irq+0x2f/0x40
May 07 20:22:04 maketopsite kernel:  do_group_exit+0x2d/0xc0
May 07 20:22:04 maketopsite kernel:  ? timerqueue_del+0x2e/0x60
May 07 20:22:04 maketopsite kernel:  do_exit+0x304/0xab0
May 07 20:22:04 maketopsite kernel:  task_work_run+0x5a/0x90
May 07 20:22:04 maketopsite kernel:  __fput+0xde/0x2a0
May 07 20:22:04 maketopsite kernel:  drm_release+0x5e/0xd0
May 07 20:22:04 maketopsite kernel:  drm_file_free+0x210/0x260
May 07 20:22:04 maketopsite kernel:  nouveau_drm_postclose+0x109/0x150
[nouveau]
May 07 20:22:04 maketopsite kernel:  nouveau_cli_fini+0x8e/0xf0 [nouveau]
May 07 20:22:04 maketopsite kernel:  nouveau_vmm_fini+0x16/0x30 [nouveau]
May 07 20:22:04 maketopsite kernel:  nvif_object_dtor+0x7b/0xb0 [nouveau]
May 07 20:22:04 maketopsite kernel:  ? kfree+0x2e3/0x3b0
May 07 20:22:04 maketopsite kernel:  nvkm_ioctl+0xcf/0x1e0 [nouveau]
May 07 20:22:04 maketopsite kernel:  nvkm_ioctl_del+0x3e/0x60 [nouveau]
May 07 20:22:04 maketopsite kernel:  nvkm_object_del+0x30/0xd0 [nouveau]
May 07 20:22:04 maketopsite kernel:  nvkm_object_dtor+0xac/0x100 [nouveau]
May 07 20:22:04 maketopsite kernel:  nvkm_uvmm_dtor+0x16/0x20 [nouveau]
May 07 20:22:04 maketopsite kernel:  nvkm_vmm_unref+0xa8/0x2c0 [nouveau]
May 07 20:22:04 maketopsite kernel:  r535_gsp_device_dtor+0x32/0x70 [nouvea=
u]
May 07 20:22:04 maketopsite kernel:  r535_gsp_rpc_rm_free+0x7a/0xb0 [nouvea=
u]
May 07 20:22:04 maketopsite kernel:  r535_gsp_rpc_push+0x146/0x150 [nouveau]
May 07 20:22:04 maketopsite kernel:  r535_gsp_rpc_send+0x1f8/0x270 [nouveau]
May 07 20:22:04 maketopsite kernel:  r535_gsp_msg_recv+0x47/0x2c0 [nouveau]
May 07 20:22:04 maketopsite kernel:  <TASK>
May 07 20:22:04 maketopsite kernel: Call Trace:
May 07 20:22:04 maketopsite kernel: PKRU: 55555554
May 07 20:22:04 maketopsite kernel: CR2: 000055bab1103000 CR3: 000000031962=
c000
CR4: 0000000000f50ef0
May 07 20:22:04 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 07 20:22:04 maketopsite kernel: FS:  0000000000000000(0000)
GS:ffff8b437e400000(0000) knlGS:0000000000000000
May 07 20:22:04 maketopsite kernel: R13: ffffcd9aeb84f7ec R14: 000000000000=
0020
R15: ffff8b3c9d16c000
May 07 20:22:04 maketopsite kernel: R10: 000000000000000c R11: 000000000000=
0000
R12: ffffcd9aeb84f7e8
May 07 20:22:04 maketopsite kernel: RBP: 0000000000000004 R08: 000016019e09=
584d
R09: 0000000000000001
May 07 20:22:04 maketopsite kernel: RDX: 0000000000000000 RSI: 000000005555=
5554
RDI: ffffcd9aeb84f6e8
May 07 20:22:04 maketopsite kernel: RAX: 0000000000000000 RBX: 000000000000=
0001
RCX: 0000000002db32fc
May 07 20:22:04 maketopsite kernel: RSP: 0018:ffffcd9aeb84f780 EFLAGS: 0001=
0246
May 07 20:22:04 maketopsite kernel: Code: 44 24 04 31 d2 05 2f 10 00 00 0d =
ff
0f 00 00 48 c1 e8 0c 48 01 e8 48 f7 f3 0f ae f0 49 8b 87 80 08 00 00 89 10 =
e9
18 ff ff ff <
May 07 20:22:04 maketopsite kernel: RIP: 0010:r535_gsp_msgq_wait+0x19c/0x1c0
[nouveau]
May 07 20:22:04 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 20:22:04 maketopsite kernel: Tainted: [W]=3DWARN
May 07 20:22:04 maketopsite kernel: CPU: 12 UID: 1000 PID: 243448 Comm: poo=
l-44
Tainted: G        W          6.12.86 #2
May 07 20:22:04 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_am>
May 07 20:22:04 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fi>
May 07 20:22:04 maketopsite kernel: WARNING: CPU: 12 PID: 243448 at
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:114
r535_gsp_msgq_wait+0x19c/0x1c0 [nouveau]
May 07 20:22:04 maketopsite kernel: ------------[ cut here ]------------
May 07 20:21:42 maketopsite systemd[1]: user@1000.service: Killing process =
5277
(Xwayland) with signal SIGKILL.
May 07 20:21:42 maketopsite systemd[1]: user@1000.service: Killing process =
4766
(dbus-broker) with signal SIGKILL.
May 07 20:21:42 maketopsite systemd[1]: user@1000.service: Killing process =
4760
(dbus-broker-lau) with signal SIGKILL.
May 07 20:21:42 maketopsite systemd[1]: user@1000.service: Main process exi=
ted,
code=3Ddumped, status=3D6/ABRT
May 07 20:21:42 maketopsite systemd-logind[1563]: Removed session 3.
May 07 20:21:42 maketopsite systemd-coredump[243807]: Process 4740 (systemd=
) of
user 1000 terminated abnormally with signal 6/ABRT, processing...
May 07 20:21:42 maketopsite systemd[1]: user@1000.service: Killing process =
4740
(systemd) with signal SIGABRT.
May 07 20:21:42 maketopsite audit[4740]: ANOM_ABEND auid=3D1000 uid=3D1000 =
gid=3D1000
ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=3D=
4740
comm=3D"systemd" >
May 07 20:21:42 maketopsite systemd[1]: user@1000.service: State 'stop-sigt=
erm'
timed out. Aborting.
May 07 20:21:29 maketopsite systemd[4740]: plasma-kwin_wayland.service: Main
process exited, code=3Ddumped, status=3D6/ABRT
May 07 20:21:29 maketopsite systemd-coredump[243806]: Process 5147
(kwin_wayland_wr) of user 1000 terminated abnormally with signal 6/ABRT,
processing...
May 07 20:21:29 maketopsite audit[5147]: ANOM_ABEND auid=3D1000 uid=3D1000 =
gid=3D1000
ses=3D3 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=3D=
5147
comm=3D"kwin_wayl>
May 07 20:21:29 maketopsite systemd[4740]: plasma-kwin_wayland.service: Kil=
ling
process 5277 (Xwayland) with signal SIGABRT.
May 07 20:21:29 maketopsite systemd[4740]: plasma-kwin_wayland.service: Kil=
ling
process 5147 (kwin_wayland_wr) with signal SIGABRT.
May 07 20:21:29 maketopsite systemd[4740]: plasma-kwin_wayland.service: Sta=
te
'stop-sigterm' timed out. Aborting.
May 07 20:21:27 maketopsite systemd[4740]:
dbus-:1.2-org.freedesktop.PackageKit@0.service: Killing process 96856
(gnome-software) with signal SIGABRT.
May 07 20:21:27 maketopsite systemd[4740]:
dbus-:1.2-org.freedesktop.PackageKit@0.service: State 'stop-sigterm' timed =
out.
Aborting.
May 07 20:21:27 maketopsite systemd[4740]:
dbus-:1.2-org.gnome.Ptyxis@0.service: Killing process 6090 (ptyxis) with si=
gnal
SIGABRT.
May 07 20:21:27 maketopsite systemd[4740]:
dbus-:1.2-org.gnome.Ptyxis@0.service: State 'stop-sigterm' timed out. Abort=
ing.
May 07 20:21:17 maketopsite kernel: ---[ end trace 0000000000000000 ]---
May 07 20:21:17 maketopsite kernel:  </TASK>
May 07 20:21:17 maketopsite kernel: R13: 0000000000000001 R14: 000000000000=
000f
R15: 00005556885141e0
May 07 20:21:17 maketopsite kernel: R10: 00007fc270df9350 R11: 000000000000=
0246
R12: 000000059c949e75
May 07 20:21:17 maketopsite kernel: RBP: 00007fc270df9390 R08: 000000000235=
691c
R09: 0000000000000000
May 07 20:21:17 maketopsite kernel: RDX: 000000000000000f RSI: 000000000000=
0080
RDI: 00005556885141f0
May 07 20:21:17 maketopsite kernel: RAX: fffffffffffffdfc RBX: 000000000000=
0001
RCX: 00007fc2be72830d
May 07 20:21:17 maketopsite kernel: RSP: 002b:00007fc270df9328 EFLAGS: 0000=
0246
ORIG_RAX: 00000000000000ca
May 07 20:21:17 maketopsite kernel: Code: Unable to access opcode bytes at
0x7fc2be7282e3.
May 07 20:21:17 maketopsite kernel: RIP: 0033:0x7fc2be72830d
May 07 20:21:17 maketopsite kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
May 07 20:21:17 maketopsite kernel:  ? irqentry_exit_to_user_mode+0x2c/0x1c0
May 07 20:21:17 maketopsite kernel:  ?
arch_exit_to_user_mode_prepare.isra.0+0x7e/0x90
May 07 20:21:17 maketopsite kernel:  ? do_user_addr_fault+0x188/0x640
May 07 20:21:17 maketopsite kernel:  ? __rseq_handle_notify_resume+0x9c/0x4=
f0
May 07 20:21:17 maketopsite kernel:  ? wake_up_q+0x3c/0x80
May 07 20:21:17 maketopsite kernel:  ? rwsem_mark_wake+0x204/0x2d0

May 07 20:21:17 maketopsite kernel:  ? try_to_wake_up+0x308/0x7b0
May 07 20:21:17 maketopsite kernel:  ? do_syscall_64+0x89/0x170
May 07 20:21:17 maketopsite kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
May 07 20:21:17 maketopsite kernel:  ? __task_pid_nr_ns+0x67/0x110
May 07 20:21:17 maketopsite kernel:  ? sched_clock_cpu+0xf/0x230
May 07 20:21:17 maketopsite kernel:  ? set_ptes.isra.0+0x36/0x80
May 07 20:21:17 maketopsite kernel:  ? __folio_mod_stat+0x2d/0x90
May 07 20:21:17 maketopsite kernel:  ? __lruvec_stat_mod_folio+0x85/0xd0
May 07 20:21:17 maketopsite kernel:  ? __pte_offset_map+0x1b/0x180
May 07 20:21:17 maketopsite kernel:  ? select_task_rq_fair+0x9cb/0x2d40
May 07 20:21:17 maketopsite kernel:  ? __mod_memcg_lruvec_state+0xbd/0x250
May 07 20:21:17 maketopsite kernel:  do_syscall_64+0x89/0x170
May 07 20:21:17 maketopsite kernel:  syscall_exit_to_user_mode+0x139/0x1c0
May 07 20:21:17 maketopsite kernel:  arch_do_signal_or_restart+0x3c/0x260
May 07 20:21:17 maketopsite kernel:  get_signal+0x916/0x920
May 07 20:21:17 maketopsite kernel:  ? _raw_spin_lock_irq+0x2f/0x40
May 07 20:21:17 maketopsite kernel:  do_group_exit+0x2d/0xc0
May 07 20:21:17 maketopsite kernel:  ? timerqueue_del+0x2e/0x60
May 07 20:21:17 maketopsite kernel:  do_exit+0x304/0xab0
May 07 20:21:17 maketopsite kernel:  task_work_run+0x5a/0x90
May 07 20:21:17 maketopsite kernel:  __fput+0xde/0x2a0
May 07 20:21:17 maketopsite kernel:  drm_release+0x5e/0xd0
May 07 20:21:17 maketopsite kernel:  drm_file_free+0x210/0x260
May 07 20:21:17 maketopsite kernel:  nouveau_drm_postclose+0x109/0x150
[nouveau]
May 07 20:21:17 maketopsite kernel:  nouveau_cli_fini+0x8e/0xf0 [nouveau]
May 07 20:21:17 maketopsite kernel:  nouveau_vmm_fini+0x16/0x30 [nouveau]
May 07 20:21:17 maketopsite kernel:  nvif_object_dtor+0x7b/0xb0 [nouveau]
May 07 20:21:17 maketopsite kernel:  ? kfree+0x2e3/0x3b0
May 07 20:21:17 maketopsite kernel:  nvkm_ioctl+0xcf/0x1e0 [nouveau]
May 07 20:21:17 maketopsite kernel:  nvkm_ioctl_del+0x3e/0x60 [nouveau]
May 07 20:21:17 maketopsite kernel:  nvkm_object_del+0x30/0xd0 [nouveau]
May 07 20:21:17 maketopsite kernel:  nvkm_object_dtor+0xac/0x100 [nouveau]
May 07 20:21:17 maketopsite kernel:  nvkm_uvmm_dtor+0x16/0x20 [nouveau]
May 07 20:21:17 maketopsite kernel:  nvkm_vmm_unref+0x81/0x2c0 [nouveau]
May 07 20:21:17 maketopsite kernel:  r535_gsp_rpc_rm_free+0x7a/0xb0 [nouvea=
u]
May 07 20:21:17 maketopsite kernel:  r535_gsp_rpc_push+0x146/0x150 [nouveau]
May 07 20:21:17 maketopsite kernel:  r535_gsp_rpc_send+0x1f8/0x270 [nouveau]
May 07 20:21:17 maketopsite kernel:  ? __slab_free+0xe4/0x2e0
May 07 20:21:17 maketopsite kernel:  r535_gsp_msg_recv+0x47/0x2c0 [nouveau]
May 07 20:21:17 maketopsite kernel:  <TASK>
May 07 20:21:17 maketopsite kernel: Call Trace:
May 07 20:21:17 maketopsite kernel: PKRU: 55555554
May 07 20:21:17 maketopsite kernel: CR2: 00005636c2c5110c CR3: 000000031962=
c000
CR4: 0000000000f50ef0
May 07 20:21:17 maketopsite kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033

May 07 20:21:17 maketopsite kernel: FS:  0000000000000000(0000)
GS:ffff8b437de80000(0000) knlGS:0000000000000000
May 07 20:21:17 maketopsite kernel: R13: ffffcd9aeb84f7fc R14: 000000000000=
0020
R15: ffff8b3c9d16c000
May 07 20:21:17 maketopsite kernel: R10: 0000000000000001 R11: 000000000000=
0000
R12: ffffcd9aeb84f7f8
May 07 20:21:17 maketopsite kernel: RBP: 0000000000000004 R08: 000015f6ba56=
dfcf
R09: 0000000000000001
May 07 20:21:17 maketopsite kernel: RDX: 0000000000000000 RSI: 000000005555=
5554
RDI: ffffcd9aeb84f6f8
May 07 20:21:17 maketopsite kernel: RAX: 0000000000000000 RBX: 000000000000=
0001
RCX: 0000000002b0c134
May 07 20:21:17 maketopsite kernel: RSP: 0018:ffffcd9aeb84f790 EFLAGS: 0001=
0246
May 07 20:21:17 maketopsite kernel: Code: 44 24 04 31 d2 05 2f 10 00 00 0d =
ff
0f 00 00 48 c1 e8 0c 48 01 e8 48 f7 f3 0f ae f0 49 8b 87 80 08 00 00 89 10 =
e9
18 ff ff ff <>
May 07 20:21:17 maketopsite kernel: RIP: 0010:r535_gsp_msgq_wait+0x19c/0x1c0
[nouveau]
May 07 20:21:17 maketopsite kernel: Hardware name: ASUSTeK COMPUTER INC. AS=
US
TUF Gaming A16 FA608WV_FA608WV/FA608WV, BIOS FA608WV.304 10/29/2024
May 07 20:21:17 maketopsite kernel: Tainted: [W]=3DWARN
May 07 20:21:17 maketopsite kernel: CPU: 1 UID: 1000 PID: 243448 Comm: pool=
-44
Tainted: G        W          6.12.86 #2
May 07 20:21:17 maketopsite kernel:  snd_pci_acp6x snd_pci_acp5x
snd_hda_codec_generic snd_rn_pci_acp3x snd_hda_scodec_component snd_acp_con=
fig
snd_hda_codec_hdmi kvm_am>
May 07 20:21:17 maketopsite kernel: Modules linked in: overlay uinput rfcomm
snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fi>
May 07 20:21:17 maketopsite kernel: WARNING: CPU: 1 PID: 243448 at
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:114
r535_gsp_msgq_wait+0x19c/0x1c0 [nouveau]
May 07 20:21:17 maketopsite kernel: ------------[ cut here ]------------
May 07 20:21:13 maketopsite kwin_wayland_wrapper[5147]: QProcess: Destroyed
while process ("kwin_wayland") is still running.
May 07 20:20:48 maketopsite kwin_wayland[5154]: QProcess: Destroyed while
process ("/usr/bin/Xwayland") is still running.
May 07 20:20:43 maketopsite systemd[4740]: Stopping plasma-kwin_wayland.ser=
vice
- KDE Wayland Compositor...
May 07 20:20:43 maketopsite systemd[4740]: Stopped plasma-ksmserver.service=
 -
KDE Session Management Server.
May 07 20:20:43 maketopsite systemd[4740]: Stopping plasma-ksmserver.servic=
e -
KDE Session Management Server...
May 07 20:20:43 maketopsite systemd[4740]: plasma-plasmashell.service: Cons=
umed
3min 19.023s CPU time, 298.7M memory peak.
May 07 20:20:43 maketopsite systemd[4740]: Stopped plasma-plasmashell.servi=
ce -
KDE Plasma Workspace.
May 07 20:20:43 maketopsite plasmashell[5401]:
qrc:/qt/qml/plasma/applet/org/kde/plasma/notifications/global/Globals.qml:2=
64:
TypeError: Cannot read property 'plasmoid' >
May 07 20:20:43 maketopsite plasmashell[5401]:
qrc:/qt/qml/plasma/applet/org/kde/plasma/notifications/global/Globals.qml:1=
34:
TypeError: Cannot read property 'screenGeom>
May 07 20:20:43 maketopsite plasmashell[5401]: PipeWire remote error:  -32
connection error
May 07 20:20:43 maketopsite plasmashell[5401]: QWaylandDataOffer: error rea=
ding
data for mimeType text/plain
May 07 20:20:43 maketopsite plasmashell[5401]: QWaylandDataOffer: timeout
reading from pipe
May 07 20:20:42 maketopsite plasmashell[5401]: QWaylandDataOffer: error rea=
ding
data for mimeType text/plain;charset=3Dutf-8
May 07 20:20:42 maketopsite plasmashell[5401]: QWaylandDataOffer: timeout
reading from pipe
May 07 20:20:42 maketopsite systemd[1]: dnf5daemon-server.service: Consumed
3.555s CPU time, 655M memory peak.
May 07 20:20:42 maketopsite audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D4=
294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Ddnf5daemo=
n-server
comm=3D"systemd">
May 07 20:20:42 maketopsite systemd[1]: Stopped dnf5daemon-server.service -=
 DNF
daemon.
May 07 20:20:42 maketopsite systemd[1]: dnf5daemon-server.service: Deactiva=
ted
successfully.
May 07 20:20:42 maketopsite systemd[1]: plymouth-switch-root-initramfs.serv=
ice
- Tell Plymouth To Jump To initramfs skipped, no trigger condition checks w=
ere
met.
May 07 20:20:42 maketopsite audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D=
4294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dplymouth-=
poweroff
comm=3D"systemd>
May 07 20:20:42 maketopsite systemd[1]: Started plymouth-poweroff.service -
Show Plymouth Power Off Screen.
May 07 20:20:42 maketopsite audit: BPF prog-id=3D132 op=3DUNLOAD
May 07 20:20:42 maketopsite audit: BPF prog-id=3D133 op=3DUNLOAD
May 07 20:20:42 maketopsite audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D4=
294967295
ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Davahi-dae=
mon
comm=3D"systemd" exe=3D>
May 07 20:20:42 maketopsite systemd[1]: Stopped avahi-daemon.service - Avahi
mDNS/DNS-SD Stack.


root@maketopsite:/home/maketopsite# lspci -k | grep -A 3 -i nvidia
pcilib: Error reading /sys/bus/pci/devices/0000:00:08.3/label: Operation not
permitted
64:00.0 VGA compatible controller: NVIDIA Corporation AD107M [GeForce RTX 4=
060
Max-Q / Mobile] (rev a1)
        Subsystem: ASUSTeK Computer Inc. Device 3818
        Kernel driver in use: nouveau
        Kernel modules: nouveau
64:00.1 Audio device: NVIDIA Corporation AD107 High Definition Audio Contro=
ller
(rev a1)
        Subsystem: ASUSTeK Computer Inc. Device 3818
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel
root@maketopsite:/home/maketopsite#

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
