Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C256C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 06:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBE910E265;
	Sun, 16 Aug 2026 06:30:36 +0000 (UTC)
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com
 [209.85.161.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F8D10E265
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 06:30:34 +0000 (UTC)
Received: by mail-oo1-f78.google.com with SMTP id
 006d021491bc7-6b026a31fcdso2735817eaf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 23:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786861834; x=1787466634;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OBMVM7oET/AJDxhjvOwrNwzBlMN8pZF5DLVEQQT80Hw=;
 b=SZ6SliaqbQKHN3+PxcZaZncoSfEvFKYYm0LxHRwMbWLZ8YNCT4+eFJ8kFJeTFFn1xW
 i8Fc490DqYXVxrfwzcYoGGh8L0+sjPQMbyNBm9sRGnMUYyl3sqmrDpZcOt5PGF6yNR0L
 3k7ekTSErhVZ0dzYHBC5DrW1+ev30IdxxNPw5bQe34Ai1oAIZ4SgJeI5gDn4hKetN9Ck
 rz5/Q1Pr/h/0uYNpionTFWn+sIfd3KzxET2Z4WzBnxwSCJ8HYAIg8EGZIl/AL+EpQFB8
 2XZYQgOF18Ln/dAf/f9Iz3YbQZNzGWN/rFoMtsj2o+HAqlb61cKsDU8+F3ESXzLnfHfh
 FKuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR9S1WE4DZacxfnYge2KA54kdBkE3RosTsj2bRJF1WNpoMYDCi5lZJPC0kE4EUX7Z2WQZvGnae2ho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytxMZfjd1v1jGMNovFXuy8tTKajkMC2wxL4q/pAWDBqocgqUiC
 FCRIR/OZMKIEiyAe6Q86QojVagpFvgynEDf69yHKjE4wMT/tniIhUJ9SdN5EG9Fa2HTvt7jX6K2
 n/Hwc+s5t5ChanMtfiTq7pBo72dkO4XEaPbP9pfYfEKSX8509fvqVSXUlKbY=
MIME-Version: 1.0
X-Received: by 2002:a4a:e841:0:b0:6ac:c22f:608 with SMTP id
 006d021491bc7-6b0d67524edmr14928586eaf.19.1786861834077; Sat, 15 Aug 2026
 23:30:34 -0700 (PDT)
Date: Sat, 15 Aug 2026 23:30:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a81590a.dbb3a75c.20434b.002a.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in drm_property_add_enum
From: syzbot <syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com>
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

HEAD commit:    f5bbbfec59b4 Merge tag 'probes-fixes-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132db479580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a233ed2ce9a8096
dashboard link: https://syzkaller.appspot.com/bug?extid=916c888ba5f1a54c9526
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105c4c79580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a91149580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f5bbbfec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48f3b996e46b/vmlinux-f5bbbfec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/523783d7181e/bzImage-f5bbbfec.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com

usb 5-1: config 1 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 2
usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
------------[ cut here ]------------
strlen(name) >= DRM_PROP_NAME_LEN
WARNING: drivers/gpu/drm/drm_property.c:396 at drm_property_add_enum+0x4ac/0x590 drivers/gpu/drm/drm_property.c:396, CPU#2: kworker/2:3/5894
Modules linked in:
CPU: 2 UID: 0 PID: 5894 Comm: kworker/2:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:drm_property_add_enum+0x4ac/0x590 drivers/gpu/drm/drm_property.c:396
Code: 03 80 3c 02 00 0f 85 89 00 00 00 49 89 2c 24 31 db e9 fc fc ff ff e8 f3 e9 43 fc 90 0f 0b 90 e9 e9 fc ff ff e8 e5 e9 43 fc 90 <0f> 0b 90 e9 db fc ff ff e8 87 7e b3 fc e9 b3 fb ff ff e8 cd e9 43
RSP: 0000:ffffc90002fd6cf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000050 RCX: ffffffff85c5e14d
RDX: ffff888027ba0000 RSI: ffffffff85c5e5bb RDI: ffff888027ba0000
RBP: 0000000000000000 R08: 0000000000000007 R09: 000000000000001f
R10: 0000000000000050 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000005 R14: ffff88802a8e4100 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888096df3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d682c98168 CR3: 000000004ce67000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_mode_create_tv_properties_legacy+0x3e9/0x4c0 drivers/gpu/drm/drm_connector.c:2216
 gud_connector_add_tv_mode+0x1d7/0x2b0 drivers/gpu/drm/gud/gud_connector.c:402
 gud_connector_add_properties drivers/gpu/drm/gud/gud_connector.c:525 [inline]
 gud_connector_create drivers/gpu/drm/gud/gud_connector.c:680 [inline]
 gud_get_connectors+0xbd9/0x1700 drivers/gpu/drm/gud/gud_connector.c:717
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
