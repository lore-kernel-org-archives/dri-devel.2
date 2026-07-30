Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9FEC53200
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 00:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F39310E03E;
	Thu, 30 Jul 2026 00:09:26 +0000 (UTC)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com
 [209.85.160.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2822110E0C0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 00:09:25 +0000 (UTC)
Received: by mail-oa1-f79.google.com with SMTP id
 586e51a60fabf-448bb8bcf38so932298fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 17:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785370164; x=1785974964;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VHEqQhQNko68j/7DYTKu26LNRfja1lRL5AnJzb8MKGA=;
 b=b+n+WMz9hkgJHU0lJCYYEJN+SbDHtKJB9XM4bA1jkzFFJPo0RiET8guPwqWftsMVUA
 xvS8HHmCkRD5acYuyObsxpbJ7WXz7jZFwRk5tL2hz+nSSMUDiAtyTcYuCxC1unNa32BB
 h4zsm9GFzTj9bYySHIuf6QKo6KTTUVmM7j2C1gFXOl7bi82JN6HGZGTaHh+ZkwC3ZpNs
 j10qQ8ycmbxptArVpAkmy4ysjNdQQAPZNryUDEyOf7+99w48VXViyCwKWstd6+h1INwp
 5lxfmoBDBcA7hA/4zln/1xkEuwZKeoHgWLz+bkaiz7+De9AxNbFpVQEWcowP7L4IrrQm
 U0QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq20vz11JxxBqe6ocpbnp6AG25yxfYTwEoFdWmqPrLtiM2YENZRTp6m87Yrr0c9u4At0FUbnISGbrg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHOF0IZuUhILb3xXM8PIkq7ORr4NSESr9m0xQE6R8SFeQkZFJJ
 hwQ80YmtlZFD2H2VAxXwhKEjmb6MdNm9K40VHdPr2bNuyvselO5l0TTtN+evEgvBvA2siZMj4TC
 nnB/PyGipaRbcsGe91z9Je+xn+1IOSoRmJLNLvTr5ejtwM6bDq92qjDKXU20=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:222a:b0:496:b7c:274b with SMTP id
 5614622812f47-4ad877bc3fbmr421332b6e.19.1785370164271; Wed, 29 Jul 2026
 17:09:24 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6a9634.57649fcc.360844.000a.GAE@google.com>
Subject: [syzbot] [virt?] [dri?] WARNING in virtio_gpu_alloc_vbufs
From: syzbot <syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com>
To: airlied@redhat.com, dmitry.osipenko@collabora.com, 
 dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
 kraxel@redhat.com, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
 simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de, 
 virtualization@lists.linux.dev
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

HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171d103e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fc02acf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eca05900a79c/vmlinux-fc02acf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e655b72e0b5f/bzImage-fc02acf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com

[drm] features: -virgl +edid -resource_blob -host_visible
[drm] features: -context_init -blob_alignment
------------[ cut here ]------------
kmem_cache of name 'virtio-gpu-vbufs' already exists
WARNING: mm/slab_common.c:111 at kmem_cache_sanity_check mm/slab_common.c:111 [inline], CPU#2: syz.4.468/7600
WARNING: mm/slab_common.c:111 at __kmem_cache_create_args+0xa6/0x420 mm/slab_common.c:352, CPU#2: syz.4.468/7600
Modules linked in:
CPU: 2 UID: 0 PID: 7600 Comm: syz.4.468 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:111 [inline]
RIP: 0010:__kmem_cache_create_args+0xa9/0x420 mm/slab_common.c:352
Code: 48 8b 43 60 48 8d 58 a0 48 3d 30 82 d8 8e 74 1f 48 8b 7b 58 48 89 ee e8 a5 a3 5d 09 85 c0 75 e0 48 8d 3d fa 2d ce 0e 48 89 ee <67> 48 0f b9 3a be 20 00 00 00 48 89 ef e8 25 a5 5d 09 48 85 c0 0f
RSP: 0018:ffffc9000c80ef58 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888026364500 RCX: fffff52001901dc6
RDX: 0000000000000000 RSI: ffffffff8c6f7ae0 RDI: ffffffff912750c0
RBP: ffffffff8c6f7ae0 R08: 0000000000000000 R09: fffffbfff2244f3a
R10: ffffc9000c80ef58 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000c80efc8 R14: 00000000000000d8 R15: 0000000000000000
FS:  00007f71682e66c0(0000) GS:ffff8880d5fdc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8a775556c8 CR3: 000000005c66a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kmem_cache_create include/linux/slab.h:399 [inline]
 virtio_gpu_alloc_vbufs+0xc2/0x150 drivers/gpu/drm/virtio/virtgpu_vq.c:75
 virtio_gpu_init.cold+0x51c/0x126e drivers/gpu/drm/virtio/virtgpu_kms.c:228
 virtio_gpu_probe+0x21c/0x360 drivers/gpu/drm/virtio/virtgpu_drv.c:103
 virtio_dev_probe+0x6a2/0xbe0 drivers/virtio/virtio.c:347
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
 register_virtio_device+0x4f0/0x5d0 drivers/virtio/virtio.c:568
 virtio_pci_probe+0x255/0x410 drivers/virtio/virtio_pci_common.c:722
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 pci_bus_add_device+0xc5/0x100 drivers/pci/bus.c:373
 pci_bus_add_devices+0x9a/0x1f0 drivers/pci/bus.c:394
 pci_rescan_bus+0x2a/0x40 drivers/pci/probe.c:3500
 rescan_store+0xfb/0x130 drivers/pci/pci-sysfs.c:473
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f716739df99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f71682e6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7167626090 RCX: 00007f716739df99
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000006
RBP: 00007f7167434ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7167626128 R14: 00007f7167626090 R15: 00007ffd459912c8
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 8b 43 60          	mov    0x60(%rbx),%rax
   4:	48 8d 58 a0          	lea    -0x60(%rax),%rbx
   8:	48 3d 30 82 d8 8e    	cmp    $0xffffffff8ed88230,%rax
   e:	74 1f                	je     0x2f
  10:	48 8b 7b 58          	mov    0x58(%rbx),%rdi
  14:	48 89 ee             	mov    %rbp,%rsi
  17:	e8 a5 a3 5d 09       	call   0x95da3c1
  1c:	85 c0                	test   %eax,%eax
  1e:	75 e0                	jne    0x0
  20:	48 8d 3d fa 2d ce 0e 	lea    0xece2dfa(%rip),%rdi        # 0xece2e21
  27:	48 89 ee             	mov    %rbp,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	be 20 00 00 00       	mov    $0x20,%esi
  34:	48 89 ef             	mov    %rbp,%rdi
  37:	e8 25 a5 5d 09       	call   0x95da561
  3c:	48 85 c0             	test   %rax,%rax
  3f:	0f                   	.byte 0xf


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
