Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD92C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CADA10F046;
	Thu, 20 Aug 2026 13:39:35 +0000 (UTC)
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com
 [74.125.231.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D7010F046
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:39:34 +0000 (UTC)
Received: by mail-oi2-f10.google.com with SMTP id
 006d021491bc7-6b140f2448fso289396eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787233174; x=1787837974;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c6LkNuunz6xWwpy6Vq1vH+cXiP/yQYPzdHegzr2L3/g=;
 b=SM6S0AeEFxK+9Lpio+dcHBgVli5ral4DijMydEg72/gu82tk4XIHH+LwqpIbMF6I00
 TofwJViFYhiOVHnxiiPXTuop9vDa4Nb7Gk3GkYyPUNuQbuzUycXV4U4Usr1ImfSKrS94
 Jm746bJMRiizY5xH04FhwMCSvAzzCrcHQAVtQQniT4hIPOYwq61lMz4IwnvJoQYNfbo2
 4fGvz+zaauzoRQSkhI+uuwnBgek0IUCQ1ycdqsaagBC0CR+wnP/EOswTBpPBF6TcUSl4
 dBS496QGkHELPb3w+hnEKqU1hqEJRrIJJwippLIhppPcVTg+wdqGqUs8SbH7yuWUHW6X
 oiYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5nHTZPqY4fjpZIL/LtBF1scCSpOxJA9qo7y0eUhrfa580Ce3XP9MMQxmP4JKl3N/Ij9rBOj2MNNI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB5a4tDXXkVnHQr50yvS5EnVQs2BjBuoP0bS48VgmtfPxYfaDe
 3wKZaqlmFKYx57I6dVPjFO/rs9iPQ4fvKLKw0ajK6FWE/TB2F6XaY2a6zRr2+YegB7nyQZ4eitD
 0i8CfXyVnrXCzj+oyvmZAaWgyOgDP4UO8ERKVkP3nGD8zcLDPGABefcJ9V68=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1988:b0:6a1:80a7:2c8d with SMTP id
 006d021491bc7-6b13c611146mr12149628eaf.32.1787233173881; Thu, 20 Aug 2026
 06:39:33 -0700 (PDT)
Date: Thu, 20 Aug 2026 06:39:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a870395.ae6ddae5.3da009.001b.GAE@google.com>
Subject: [syzbot] [dri?] [usb?] WARNING in drm_plane_create_rotation_property
From: syzbot <syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, rubenru09@aol.com, 
 simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
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

HEAD commit:    bdab5605259b usb: gadget: uvc: fix dangling pointers in uv..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11595a79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bdeea7ee6735f91
dashboard link: https://syzkaller.appspot.com/bug?extid=efe2810681f1b065d3a8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1278c679580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12496a25580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cb2fdbdd7b7/disk-bdab5605.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f801d31c2001/vmlinux-bdab5605.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9002a6e0ae14/bzImage-bdab5605.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com

usb 4-1: config 1 interface 0 altsetting 0 bulk endpoint 0x1 has invalid maxpacket 0
usb 4-1: config 1 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 2
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
------------[ cut here ]------------
rotation & ~supported_rotations
WARNING: drivers/gpu/drm/drm_blend.c:309 at drm_plane_create_rotation_property+0x1aa/0x1f0 drivers/gpu/drm/drm_blend.c:309, CPU#1: kworker/1:1/28
Modules linked in:
CPU: 1 UID: 0 PID: 28 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:drm_plane_create_rotation_property+0x1aa/0x1f0 drivers/gpu/drm/drm_blend.c:309
Code: 5d 41 5e c3 cc cc cc cc e8 93 16 74 fe 90 0f 0b 90 e9 a1 fe ff ff e8 85 16 74 fe 90 0f 0b 90 e9 ba fe ff ff e8 77 16 74 fe 90 <0f> 0b 90 e9 cd fe ff ff e8 49 85 dc fe eb 87 bb f4 ff ff ff eb b0
RSP: 0018:ffffc900001e6eb0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888118438d60 RCX: ffffffff833ffcd6
RDX: ffff8881026f1e00 RSI: ffffffff833ffe09 RDI: ffff8881026f1e00
RBP: 0000000000000034 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888118438000
FS:  0000000000000000(0000) GS:ffff888268733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba2f8fd2d8 CR3: 0000000117c22000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 gud_plane_add_properties drivers/gpu/drm/gud/gud_drv.c:292 [inline]
 gud_probe+0x11a5/0x1c20 drivers/gpu/drm/gud/gud_drv.c:622
 usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
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
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
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
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2708
 usb_new_device drivers/usb/core/hub.c:5833 [inline]
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5966
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
