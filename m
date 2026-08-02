Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A590C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 10:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBF410E2B6;
	Sun,  2 Aug 2026 10:22:35 +0000 (UTC)
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com
 [209.85.167.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4966110E2B6
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 10:22:34 +0000 (UTC)
Received: by mail-oi1-f205.google.com with SMTP id
 5614622812f47-48576b535b6so1425798b6e.2
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 03:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785666153; x=1786270953;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DhOzp+4ao+2WjuM5XUiRiiEbbew1BWqOp8B2qmzYztI=;
 b=cAT5boqQ7Z5dpEtgxa/OfbWAAfw9y58LSfOCbfX0FRMzPjAxJZXjiwUtY/DiYKdi1K
 foFrMjLLJuSo5Tp7xwicgHAXCPL+qUMdR3blOIMgE4WkVw7qre8IrrsqjgGaZ6UejwWM
 YJKC4LFagfjdDzAHDl6WNJWBMV5tqw0r7W3BiJshc/5BNJxIao7TSlpfAS97HMO0Glp/
 aCXJD47Ys+8quNEykP/v/siHaiymOO5ZuTQ1bXR7tm3Gjgg2yBs4VIkX4macj19HngUC
 o0vzIuRJJ5eAw0i4ej5sKU6eInOgzJX60QNdsQTxGoV7wBow518nIikx6GIQpqlVQ9re
 Ji6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR+S/BQdenvgzHu81A0QfuuOd6ZOjfo7m05SyE9fnJN1SU4mp36UPnuPDZlbSHEzt/pClTtqQFyWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfTwPjhVU2iXG+QJxZHUo8rm9yen7mEQzra3U6fE7gGwc0JWo5
 QGdomY8B2tXx1QcfzruhtkwmqcJb+gdosg4Psd+QRKoykIwSM/0k+lC3GKX0wBQQ5hK9SK5zkt0
 RNtwHJhT/pwVAs6zoDsGUCO+JZmwrryqZHmP+pUcHVkSbBLaMQPwsTpP9zDc=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1e8:b0:497:d371:21c8 with SMTP id
 5614622812f47-4af5e2cd936mr10075081b6e.19.1785666153520; Sun, 02 Aug 2026
 03:22:33 -0700 (PDT)
Date: Sun, 02 Aug 2026 03:22:33 -0700
In-Reply-To: <6a6a9634.57649fcc.360844.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6f1a69.1aa927e4.17d4bf.0017.GAE@google.com>
Subject: Re: [syzbot] [virt?] [dri?] WARNING in virtio_gpu_alloc_vbufs
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    2d2338c93da7 Merge tag 'i2c-fixes-7.2-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f3edb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173115b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1782f4c6580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2d2338c9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/89fdd9cdbdc2/vmlinux-2d2338c9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7930b1db6cb/bzImage-2d2338c9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com

[drm] features: -virgl +edid -resource_blob -host_visible
[drm] features: -context_init -blob_alignment
------------[ cut here ]------------
kmem_cache of name 'virtio-gpu-vbufs' already exists
WARNING: mm/slab_common.c:111 at kmem_cache_sanity_check mm/slab_common.c:111 [inline], CPU#0: syz.0.17/5926
WARNING: mm/slab_common.c:111 at __kmem_cache_create_args+0xa6/0x420 mm/slab_common.c:352, CPU#0: syz.0.17/5926
Modules linked in:
CPU: 0 UID: 0 PID: 5926 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:111 [inline]
RIP: 0010:__kmem_cache_create_args+0xa9/0x420 mm/slab_common.c:352
Code: 48 8b 43 60 48 8d 58 a0 48 3d b0 82 d8 8e 74 1f 48 8b 7b 58 48 89 ee e8 c5 50 5e 09 85 c0 75 e0 48 8d 3d 1a 39 ce 0e 48 89 ee <67> 48 0f b9 3a be 20 00 00 00 48 89 ef e8 45 52 5e 09 48 85 c0 0f
RSP: 0018:ffffc9000388ef58 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8881012c77c0 RCX: fffff52000711dc6
RDX: 0000000000000000 RSI: ffffffff8c6f8d40 RDI: ffffffff91275ec0
RBP: ffffffff8c6f8d40 R08: 0000000000000000 R09: fffffbfff22450fa
R10: ffffc9000388ef58 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000388efc8 R14: 00000000000000d8 R15: 0000000000000000
FS:  000055557ecab500(0000) GS:ffff8880d5dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33324008 CR3: 000000002ad27000 CR4: 0000000000352ef0
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
RIP: 0033:0x7fba4739e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb190b8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fba47625fa0 RCX: 00007fba4739e019
RDX: 0000000000000001 RSI: 0000200000000a00 RDI: 0000000000000005
RBP: 00007fba4743500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fba47625fac R14: 00007fba47625fa0 R15: 00007fba47625fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 8b 43 60          	mov    0x60(%rbx),%rax
   4:	48 8d 58 a0          	lea    -0x60(%rax),%rbx
   8:	48 3d b0 82 d8 8e    	cmp    $0xffffffff8ed882b0,%rax
   e:	74 1f                	je     0x2f
  10:	48 8b 7b 58          	mov    0x58(%rbx),%rdi
  14:	48 89 ee             	mov    %rbp,%rsi
  17:	e8 c5 50 5e 09       	call   0x95e50e1
  1c:	85 c0                	test   %eax,%eax
  1e:	75 e0                	jne    0x0
  20:	48 8d 3d 1a 39 ce 0e 	lea    0xece391a(%rip),%rdi        # 0xece3941
  27:	48 89 ee             	mov    %rbp,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	be 20 00 00 00       	mov    $0x20,%esi
  34:	48 89 ef             	mov    %rbp,%rdi
  37:	e8 45 52 5e 09       	call   0x95e5281
  3c:	48 85 c0             	test   %rax,%rax
  3f:	0f                   	.byte 0xf


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
