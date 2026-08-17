Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A861AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E720A10E63B;
	Mon, 17 Aug 2026 05:22:30 +0000 (UTC)
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com
 [209.85.161.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E1910E63B
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:22:29 +0000 (UTC)
Received: by mail-oo1-f79.google.com with SMTP id
 006d021491bc7-6a0f261aeb6so3941574eaf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786944149; x=1787548949;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qnk6cwSyeEX6jno7Ve/N46AWuc9z6oV7XNaJ+fF+w3Q=;
 b=pThdu/zlDNpGCUl6iaYbmd0pdsVj/mLnB0PwOzqYsEElbKtoVn/lP1wIXPZySc1yQM
 ypu/tU/8ClP/DlpWVp+ubF8CjFIjvzgzkqeF9aowY8MnngvWFsNXWnI+Z6Fmfr+mVLkb
 PBvapJDS35k41Aig9rHOJ6nTAXX9KG+iZeNwHwxxZFZqD/r1ocHZvIUMjfxIaWe+DFGE
 SzwNjRsQ2hgjjCgYwbK1UMwOGAHC/q7q+UW795/NooJWc00YvrAqTNcsNyBJXtSJno19
 CiTz/5u6Wy21H3Z0Nc1bBXcjrstt31cIewP06BcQnDe2+fFZgFk+SJtzaKC5w/AbuW0+
 Rflw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTE08Hn2UnMkQDQQtLRlYdAAQV1TA3KU+oLPYfnCMzLKMS4ABiw5LWN6Sywe34bAmyLZMpKvJ4n6A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxS9gZ0RYeDDKX/hsmjsE3H1xeYsZOOHBPg6N45xXtleKQaWG7j
 3skgre0y6m3a2yD1XPnt77bYWaOQfWsavDxtiJY+G8vE282TUZWzwcZjf3MDEz/MlLOetlE0qpS
 n61JvcNSBAT3te2HiNVUDX52ki2o+Q7GY4WbFB0C0FlIoGm7fCpIQe3X4y18=
MIME-Version: 1.0
X-Received: by 2002:a4a:edc9:0:b0:6a3:7af2:90ef with SMTP id
 006d021491bc7-6b0d5fdc3a6mr22129152eaf.6.1786944149106; Sun, 16 Aug 2026
 22:22:29 -0700 (PDT)
Date: Sun, 16 Aug 2026 22:22:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a829a95.dbb3a75c.20434b.0043.GAE@google.com>
Subject: [syzbot] [dri?] general protection fault in drm_object_attach_property
From: syzbot <syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, rubenru09@aol.com, simona@ffwll.ch, 
 syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
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

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15432c79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a233ed2ce9a8096
dashboard link: https://syzkaller.appspot.com/bug?extid=1944765c3659f63d3777
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b78ac6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14735149580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3d6d8176.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5f85cb20f42/vmlinux-3d6d8176.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ee2de80a3a1/bzImage-3d6d8176.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com

usb 5-1: config 1 interface 0 altsetting 0 bulk endpoint 0x1 has invalid maxpacket 0
usb 5-1: config 1 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 2
usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 2 UID: 0 PID: 852 Comm: kworker/2:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:drm_object_attach_property+0x85/0x3b0 drivers/gpu/drm/drm_mode_object.c:240
Code: 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 93 02 00 00 49 8d 7c 24 60 49 63 5d 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 02 00 00 48 8d 7d 04 4d 8b 74 24 60 48 b8 00
RSP: 0000:ffffc900038f6e60 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: ffffffff86574465
RDX: 000000000000000c RSI: ffffffff85c3beb2 RDI: 0000000000000060
RBP: ffff888012bfe040 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff888012bfece4 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888012bfe228 R14: ffff888012bfece4 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888096df3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c6bdd7168 CR3: 000000005d115000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gud_connector_add_properties drivers/gpu/drm/gud/gud_connector.c:572 [inline]
 gud_connector_create drivers/gpu/drm/gud/gud_connector.c:680 [inline]
 gud_get_connectors+0x86e/0x1700 drivers/gpu/drm/gud/gud_connector.c:717
 gud_probe+0x17aa/0x1c20 drivers/gpu/drm/gud/gud_drv.c:635
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2703
 usb_new_device include/linux/workqueue.h:714 [inline]
 hub_port_connect drivers/usb/core/hub.c:5575 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event.cold+0x1e3/0xe90 drivers/usb/core/hub.c:5961
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_object_attach_property+0x85/0x3b0 drivers/gpu/drm/drm_mode_object.c:240
Code: 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 93 02 00 00 49 8d 7c 24 60 49 63 5d 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 02 00 00 48 8d 7d 04 4d 8b 74 24 60 48 b8 00
RSP: 0000:ffffc900038f6e60 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: ffffffff86574465
RDX: 000000000000000c RSI: ffffffff85c3beb2 RDI: 0000000000000060
RBP: ffff888012bfe040 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff888012bfece4 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888012bfe228 R14: ffff888012bfece4 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888096df3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c6bdd7168 CR3: 000000005d115000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 08                	je     0x10
   8:	3c 03                	cmp    $0x3,%al
   a:	0f 8e 93 02 00 00    	jle    0x2a3
  10:	49 8d 7c 24 60       	lea    0x60(%r12),%rdi
  15:	49 63 5d 00          	movslq 0x0(%r13),%rbx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 a2 02 00 00    	jne    0x2d6
  34:	48 8d 7d 04          	lea    0x4(%rbp),%rdi
  38:	4d 8b 74 24 60       	mov    0x60(%r12),%r14
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
