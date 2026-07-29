Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5993DC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9F688697;
	Wed, 29 Jul 2026 02:08:31 +0000 (UTC)
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com
 [209.85.167.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE9888697
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:08:30 +0000 (UTC)
Received: by mail-oi1-f206.google.com with SMTP id
 5614622812f47-4ab4f652f9bso291630b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785290910; x=1785895710;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x1UOuKToWgt3LDEteYnVrTu190EMWkx8OgDd09ZNj7A=;
 b=munwaudZSibPv6fg6Zwx0Sa6tKUih0YSVfHbJIN26zBIljCVWoeOWBqniHKYjBQYjV
 aypG/tAOJVKtNqgV+tERZkrg5A/cXgw4bbsIhfmdgK/erzugyZPkmb+g8zlzapxy8yY8
 x3AuBCEb1S59bnvjWrCG21UMadBu++uZd/bhlqfwK3H5YZmYHkAiWKa7yv7C2hrjnXKX
 i+skXU1uTpmgfF59XctfvSKxpszz7g2Q+E5epGEnpDvyHa9vL5CDPflMmpI3ZfpeXyPN
 q3rPWBgeB56nUTMlIn9zXRW7ZGsmlEnord//W7yAm6Re7PtGtbwK2LBoV4pP8SmtSmYD
 NOGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqonCBlABSsK82uO1o8VWtKQeAJ0LMEjOP64wh5eKuPXTw/VKvUWgTchlI0/bzfGykFswj9ZeAiNYU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5eyDYp14Mt+Aq7W36MEKz8voNAs4B3+NoF+xuPWd212QHL9Kz
 7zAtD7fB1MsrsHbAkKyOTMkAaoGd63VURjgoPmFcxAb2t/yRCgg2yl/s0HKdhW9lwRPnpsDnXM6
 eTioS0H/4c4pw9GBdHbs+y2Hg/R3dn9COH1hYyaArBqChqAhSsHswVaw04Ac=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1587:b0:495:f15d:58ee with SMTP id
 5614622812f47-4ad5bb1c0bdmr3033249b6e.28.1785290910009; Tue, 28 Jul 2026
 19:08:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 19:08:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a69609d.d9e86bb5.297b12.004a.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in drm_mm_takedown
From: syzbot <syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
 tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
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

Hello,

syzbot found the following issue on:

HEAD commit:    62cc90241548 Merge tag 'mm-hotfixes-stable-2026-07-27-14-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121f9632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=d93b9064fe5f74af3aa3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-62cc9024.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b10a9ae7e3d1/vmlinux-62cc9024.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b89124d39495/bzImage-62cc9024.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com

------------[ cut here ]------------
Memory manager not clean during takedown.
WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown+0x62/0x280 drivers/gpu/drm/drm_mm.c:965, CPU#3: syz.1.134/6649
Modules linked in:
CPU: 3 UID: 0 PID: 6649 Comm: syz.1.134 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:drm_mm_takedown+0x62/0x280 drivers/gpu/drm/drm_mm.c:965
Code: 8b 43 38 48 39 c5 75 16 e8 2b c6 44 fc 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc e8 15 c6 44 fc 48 8d 3d ce 75 68 0b <67> 48 0f b9 3a 48 c7 c0 e0 e3 46 8e 48 ba 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000383f858 EFLAGS: 00010283
RAX: 0000000000021ab5 RBX: ffff888027c40c68 RCX: ffffc90007884000
RDX: 0000000000080000 RSI: ffffffff85c59a2b RDI: ffffffff912e1000
RBP: ffff888027c40ca0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880277dbd80
R13: ffff8880277dbd98 R14: ffffffff85c47730 R15: 0000000000000000
FS:  00007fd2ebde36c0(0000) GS:ffff8880d60dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa5b75eb580 CR3: 0000000025294000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_managed_release+0x1bb/0x540 drivers/gpu/drm/drm_managed.c:75
 drm_dev_release drivers/gpu/drm/drm_drv.c:914 [inline]
 kref_put include/linux/kref.h:65 [inline]
 drm_dev_put.part.0+0xca/0x140 drivers/gpu/drm/drm_drv.c:948
 drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
 virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 device_unregister+0x1d/0xe0 drivers/base/core.c:4002
 unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd2eaf9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2ebde3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd2eb225fa0 RCX: 00007fd2eaf9de99
RDX: 000000000000000d RSI: 0000200000000280 RDI: 0000000000000008
RBP: 00007fd2eb033eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd2eb226038 R14: 00007fd2eb225fa0 R15: 00007ffd8ff0ecc8
 </TASK>
----------------
Code disassembly (best guess):
   0:	8b 43 38             	mov    0x38(%rbx),%eax
   3:	48 39 c5             	cmp    %rax,%rbp
   6:	75 16                	jne    0x1e
   8:	e8 2b c6 44 fc       	call   0xfc44c638
   d:	48 83 c4 08          	add    $0x8,%rsp
  11:	5b                   	pop    %rbx
  12:	5d                   	pop    %rbp
  13:	41 5c                	pop    %r12
  15:	41 5d                	pop    %r13
  17:	41 5e                	pop    %r14
  19:	c3                   	ret
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	cc                   	int3
  1e:	e8 15 c6 44 fc       	call   0xfc44c638
  23:	48 8d 3d ce 75 68 0b 	lea    0xb6875ce(%rip),%rdi        # 0xb6875f8
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 c7 c0 e0 e3 46 8e 	mov    $0xffffffff8e46e3e0,%rax
  36:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  3d:	fc ff df


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
