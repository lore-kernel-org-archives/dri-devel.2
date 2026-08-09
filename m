Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16986C5AD55
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7081A10E13E;
	Sun,  9 Aug 2026 20:57:31 +0000 (UTC)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com
 [209.85.160.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEA310E13E
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:57:30 +0000 (UTC)
Received: by mail-oa1-f78.google.com with SMTP id
 586e51a60fabf-45952ce9ee0so1505868fac.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 13:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786309049; x=1786913849;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=atwEu8HESbm0J0ZZc0329Or+Bt8/+trpH9BPhYs3H60=;
 b=hpkhE0b/frQetvCoAJCxYWPepU1JS2pTFdexK8UD0uuS4nQpQRFRWqZaAJ2rtCjBKs
 u3pIEOHg10MAnl6ByUOLtcpbiWrb7yB7m8u96caLQDgxIXvfch735sNi/l5hy5KpaywU
 BUKgahddr9RlnPwA12OjjtaC/Gyb0gPzwOfCuITntWdwgfi4VjcClsQ1XXBZ1x7BF56n
 vMZiV+YA7RXGpH5OmtQXyoEp38ufEghjTDbRnrUFGe1CbFlQBql8oEVs3iA7RfbBODHl
 jKjeuieq9SSSKFGbq883l/4YDzZdMfOzXLYbSVVk1P+sDW+xLWEvlzxWjpkO6xZN3aGv
 VxKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+sIj48n3MePXOio9tQiQ1omVggLFeVECt6J0a6SsMaUta5RhjRxlfanIkqIZWyWcOGb2P7pRq2e4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/5d3upMHwVyyyGMbsWwObGsYrA6+pkV8E2pDaQXqMayVTD1KD
 m0UdyOu2dMEERs6fc35KsWOE3hpCnglAjLog4VYy/bBzuW0hLC0KZj2I4Zlb/9Os8SYfLiPSFyJ
 0A1lPgHRhxOsrgAMH/iNkhc1ocslhzgB4ncBjLeRbSW/bbg0hGG/kGMrUrJU=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:987:b0:6aa:e573:9ce0 with SMTP id
 006d021491bc7-6ae96d0b246mr21753340eaf.16.1786309049629; Sun, 09 Aug 2026
 13:57:29 -0700 (PDT)
Date: Sun, 09 Aug 2026 13:57:29 -0700
In-Reply-To: <6a69609d.d9e86bb5.297b12.004a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a78e9b9.01d0871a.3a0d52.0094.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_mm_takedown
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    b643e495ae92 Merge tag 's390-7.2-7' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1531a2c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=d93b9064fe5f74af3aa3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138cdfb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1373ffb9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b643e495.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9eb4fbda136d/vmlinux-b643e495.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53cbbd75c40a/bzImage-b643e495.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com

Console: switching to colour dummy device 80x25
------------[ cut here ]------------
Memory manager not clean during takedown.
WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown+0x62/0x280 drivers/gpu/drm/drm_mm.c:965, CPU#0: syz.0.28/5943
Modules linked in:
CPU: 0 UID: 0 PID: 5943 Comm: syz.0.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:drm_mm_takedown+0x62/0x280 drivers/gpu/drm/drm_mm.c:965
Code: 8b 43 38 48 39 c5 75 16 e8 3b 0e 45 fc 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e e9 0a 9f f8 05 e8 25 0e 45 fc 48 8d 3d 2e cb 67 0b <67> 48 0f b9 3a 48 c7 c0 e0 13 47 8e 48 ba 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90003aff790 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802b8a0c68 RCX: ffffffff85c5509b
RDX: ffff888030942540 RSI: ffffffff85c5655b RDI: ffffffff912d3090
RBP: ffff88802b8a0ca0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888029bdb900
R13: ffff888029bdb918 R14: ffffffff85c44260 R15: 0000000000000000
FS:  000055557bc5c500(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00001c245591d000 CR3: 0000000038e44000 CR4: 0000000000352ef0
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
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0x120/0x160 drivers/pci/remove.c:93
 pci_stop_and_remove_bus_device+0x58/0xa0 drivers/pci/remove.c:128
 pci_stop_and_remove_bus_device_locked+0x1a/0x20 drivers/pci/remove.c:136
 remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:523
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa232f9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4f8ff7c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa233225fa0 RCX: 00007fa232f9e0d9
RDX: 0000000000000001 RSI: 00002000000000c0 RDI: 0000000000000003
RBP: 00007fa233035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa233225fac R14: 00007fa233225fa0 R15: 00007fa233225fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	8b 43 38             	mov    0x38(%rbx),%eax
   3:	48 39 c5             	cmp    %rax,%rbp
   6:	75 16                	jne    0x1e
   8:	e8 3b 0e 45 fc       	call   0xfc450e48
   d:	48 83 c4 08          	add    $0x8,%rsp
  11:	5b                   	pop    %rbx
  12:	5d                   	pop    %rbp
  13:	41 5c                	pop    %r12
  15:	41 5d                	pop    %r13
  17:	41 5e                	pop    %r14
  19:	e9 0a 9f f8 05       	jmp    0x5f89f28
  1e:	e8 25 0e 45 fc       	call   0xfc450e48
  23:	48 8d 3d 2e cb 67 0b 	lea    0xb67cb2e(%rip),%rdi        # 0xb67cb58
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 c7 c0 e0 13 47 8e 	mov    $0xffffffff8e4713e0,%rax
  36:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  3d:	fc ff df


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
