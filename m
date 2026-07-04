Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5255DC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B62710E058;
	Sat,  4 Jul 2026 14:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qum4Bo6T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB1A10E058
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 14:49:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92F50406A5
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 14:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74BBDC2BCC9
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783176548;
 bh=mtPQne6qdnj2FtByQfnYivDJmRgrnhwrszIwhR0k9Zg=;
 h=From:To:Subject:Date:From;
 b=Qum4Bo6TGFxoxwOr5GTL8AIexGAh3m48QoVEXRABkXb5rhEle/a/dagTOvPCgzYAE
 QZU6+v0rKIoFl0WvtCBnLsx3rWAR+daLFD67qdq05JX74ocB97vkvj1W7WFEfu4LWV
 THspjxveegsW7p6COvGb2kte+vuUeK8a0m+rxQ1DR9kM8IJAP2rC6ZTRlbqf7VwDPJ
 n0wpXcsim9eh6IjnCn71/Y4+q4qBrXX/F6peG5rvDGLZMeuARbCRw9U5y82kWxtLGc
 0kQqKghuPZ08XCxGPNTif13EIiNLe7lmj8P5+r3Rsjgs/AJCpxLTxePurCe8dXQBCt
 X/3fbS87F+SnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 578D3C41614; Sat,  4 Jul 2026 14:49:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221719] New: kernel crash after resuming from hibernate -
 amdgpu_vm_move_to_lru_tail+0x29/0x40 - 100% reproducible
Date: Sat, 04 Jul 2026 14:49:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: geogeim@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221719-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221719

            Bug ID: 221719
           Summary: kernel crash after resuming from hibernate -
                    amdgpu_vm_move_to_lru_tail+0x29/0x40 - 100%
                    reproducible
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: geogeim@proton.me
        Regression: No

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0=20
Oops: Oops: 0002 [#1] SMP NOPTI
CPU: 5 UID: 1000 PID: 8529 Comm: brave Not tainted 7.1-amd64 #1 PREEMPT(laz=
y)=20
Debian 7.1.2-1~exp1=20
Hardware name: LENOVO 21K5001JUS/21K5001JUS, BIOS R2FET67W (1.47 ) 11/28/20=
25
RIP: 0010:ttm_lru_bulk_move_tail+0x192/0x330 [ttm]
Code: 84 dd d8 00 00 00 4c 8d 62 40 49 8d 6a 40 48 83 f8 05 0f 83 2c 01 00 =
00
48 8b 7a 48 49 8b 72 40 48 c1 e0 04 4c 01 c0 4d 01 d8 <48> 89 37 48 8b 7a 4=
8 48
8>
RSP: 0018:ffffcc21e0e67870 EFLAGS: 00010206
RAX: 0000000000000020 RBX: 0000000000000000 RCX: 0000000000000002
RDX: ffff8ba407d4c720 RSI: ffff8ba2e160ee38 RDI: 0000000000000000
RBP: ffff8ba196612540 R08: 0000000000000088 R09: ffff8ba142aa1960
R10: ffff8ba196612500 R11: 0000000000000088 R12: ffff8ba407d4c760
R13: ffff8ba142aa1940 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f1018f6c400(0000) GS:ffff8baee2ab5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001c106c000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __queue_work+0x113/0x4d0
 amdgpu_vm_move_to_lru_tail+0x29/0x40 [amdgpu]
 amdgpu_cs_ioctl+0x1d56/0x2140 [amdgpu]
 ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
 drm_ioctl_kernel+0xae/0x100 [drm]
 drm_ioctl+0x2a8/0x550 [drm]
 ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
 amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
 __x64_sys_ioctl+0x97/0xe0
 do_syscall_64+0xe1/0x640
 ? amdgpu_gem_fault+0xdc/0x100 [amdgpu]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __do_fault+0x34/0x170
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_fault+0xcc/0x580
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pte_offset_map+0x1b/0x100
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __handle_mm_fault+0x960/0xf60
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? count_memcg_events+0xe5/0x220
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? handle_mm_fault+0x1e5/0x2f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_user_addr_fault+0x1d9/0x7b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? irqentry_exit+0x43/0x6b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0x98/0x640
 ? exc_page_fault+0x82/0x1d0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f101a180c3b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 =
24
08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff f=
f 77
1>
RSP: 002b:00007ffcc2e72c20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcc2e72e28 RCX: 00007f101a180c3b
RDX: 00007ffcc2e72cb0 RSI: 00000000c0186444 RDI: 0000000000000016
RBP: 00007ffcc2e72cf0 R08: 000000b4019648e0 R09: 00007ffcc2e72c80
R10: 0000000000000000 R11: 0000000000000246 R12: 000000b401964890
R13: 0000000000000016 R14: 0000010816e4c9a4 R15: 000000b4000d3200
 </TASK>
Modules linked in: ath11k_pci(+) ath11k qmi_helpers mhi sd_mod scsi_mod
scsi_common snd_seq_dummy rfcomm snd_hrtimer snd_seq snd_seq_device algif_h=
ash
algif_sk>
 wmi_bmof firmware_attributes_class snd_acp_legacy_common snd_intel_sdw_acpi
pcspkr amd_pmf snd_pci_acp6x snd_hwdep snd_pcm thinkpad_acpi spd5118 amdtee
snd_pc>
 nvme_auth i2c_smbus usb_common wmi fan button [last unloaded: qmi_helpers]
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---



Scenario:
Open brave/chromium
Go to youtube.com
Play a video
In a terminal do systemctl hibernate
Wait for hibernation to finish
Power on the machine
Computer freezes at the login screen


  Type: Laptop System: LENOVO product: 21K5001JUS v: ThinkPad P14s Gen 4
CPU:
  Info: model: AMD Ryzen 7 PRO 7840U w/ Radeon 780M Graphics socket: FP8
Graphics:
  Device-1: Advanced Micro Devices [AMD/ATI] Phoenix1 vendor: Lenovo
    driver: amdgpu v: kernel arch: RDNA-3 code: Phoenix process: TSMC n4 (4=
nm)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
