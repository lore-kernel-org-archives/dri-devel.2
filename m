Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A4DCD3445
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B046B10F2DF;
	Thu,  7 May 2026 23:35:23 +0000 (UTC)
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com
 [209.85.161.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EEE10F2DF
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:35:22 +0000 (UTC)
Received: by mail-oo1-f79.google.com with SMTP id
 006d021491bc7-696906ddd6eso1973264eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 16:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778196922; x=1778801722;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTkF5cAciGoUUa9iLMmC3lX7goyt44Nm5xF/oDm9lMk=;
 b=D4VQv6ja5nN2g+nWYWFtIsn1paVF+PczgsnzpwyeWCtvxvteTVNnjc4PzFGMZZ9gNv
 UkBRfheMS1yTDyfyCBrp9W8B35XiD8kBd+/Y6G7e4m0YToxMXsEk2Gh+P9mkL/wqtQSq
 uSHo/05rIpuEXq79rJt28Q7LEcxi2p/jmupEOtRnxLit9ZXCoBhL39ElVy3fxMs49157
 pRgz8E80/AY56Kug1BN/cCfRNd/a69AYYRUDcWD5F27fvy8BuUzkGU2jN/NuDJffX9rR
 T0gLtui14K0Q4qN0oxsb7obHOxVKh82wOBKcKiMtuqB79ZG1AhBG26SLx0+Ga8Rjt7mC
 D4mQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wUmSFTw9R4UdoCHqTotkxbpSm63xftL5lLmm66E6phgUebWgP6lQfB62ZOdGGOK9Ouf59dlzkx6w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGZLKVZeQIuvhkxweMa7reTmh7iLBcf9YOXEqvy5MPUSf/3lVz
 f2M4JDDl0tMtHEDd4KZKMN1QgxRhlvZOB5+6F74FqF6eCjKFZrhibjpu/Z4fJUG+TrMxBLJLIuQ
 GsaUFBXnlrzjqE9tZTZNx3xJmyPk1uQuDBNiQfvTU6x1p5irGo59ZR+PBLSY=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d05:b0:696:7d51:79dd with SMTP id
 006d021491bc7-69998d175eamr5444927eaf.28.1778196921815; Thu, 07 May 2026
 16:35:21 -0700 (PDT)
Date: Thu, 07 May 2026 16:35:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69fd21b9.050a0220.3cf765.0360.GAE@google.com>
Subject: [syzbot] [dri?] [media?] WARNING in dma_resv_add_fence
From: syzbot <syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com>
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 syzkaller-bugs@googlegroups.com
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

HEAD commit:    fcee7d82f27d Merge tag 'net-7.1-rc3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1107ddba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dfca73980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1599bb26580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fcee7d82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5dee9aef2ac/vmlinux-fcee7d82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b1a8dd09a15/bzImage-fcee7d82.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com

R13: 00007f7755215fac R14: 00007f7755215fa0 R15: 00007f7755215fa0
 </TASK>
------------[ cut here ]------------
debug_locks && !(lock_is_held(&(&(obj)->lock.base)->dep_map) != 0)
WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840 drivers/dma-buf/dma-resv.c:296, CPU#2: syz.0.17/5919
Modules linked in:
CPU: 2 UID: 0 PID: 5919 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dma_resv_add_fence+0x71e/0x840 drivers/dma-buf/dma-resv.c:296
Code: 44 24 08 be ff ff ff ff 48 8d 78 60 e8 db 3b 33 05 31 ff 89 c3 89 c6 e8 e0 58 b1 fb 85 db 0f 85 26 fa ff ff e8 23 5e b1 fb 90 <0f> 0b 90 e9 18 fa ff ff e8 15 5e b1 fb be 03 00 00 00 4c 89 e7 e8
RSP: 0018:ffffc9000448f168 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff865734f0
RDX: ffff8880261ea500 RSI: ffffffff865734fd RDI: ffff8880261ea500
RBP: ffff88802d439f70 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802d439f00
R13: ffff88802d439f00 R14: 1ffff92000891e39 R15: ffff88802853e800
FS:  00005555690ac500(0000) GS:ffff8880d6572000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32a63fff CR3: 000000003fb78000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 virtio_gpu_array_add_fence+0xcd/0x140 drivers/gpu/drm/virtio/virtgpu_gem.c:257
 virtio_gpu_queue_ctrl_sgs drivers/gpu/drm/virtio/virtgpu_vq.c:410 [inline]
 virtio_gpu_queue_fenced_ctrl_buffer+0x578/0xfb0 drivers/gpu/drm/virtio/virtgpu_vq.c:500
 virtio_gpu_cursor_plane_update+0x411/0xbc0 drivers/gpu/drm/virtio/virtgpu_plane.c:463
 drm_atomic_helper_commit_planes+0x497/0xf10 drivers/gpu/drm/drm_atomic_helper.c:3038
 drm_atomic_helper_commit_tail+0x7f/0x130 drivers/gpu/drm/drm_atomic_helper.c:1989
 commit_tail+0x338/0x430 drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0x303/0x380 drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x230/0x300 drivers/gpu/drm/drm_atomic.c:1789
 drm_atomic_helper_update_plane+0x314/0x400 drivers/gpu/drm/drm_atomic_helper.c:3438
 __setplane_atomic+0x22d/0x350 drivers/gpu/drm/drm_plane.c:1101
 drm_mode_cursor_universal+0x5e9/0xe20 drivers/gpu/drm/drm_plane.c:1256
 drm_mode_cursor_common+0x308/0x970 drivers/gpu/drm/drm_plane.c:1315
 drm_mode_cursor_ioctl+0xd4/0x110 drivers/gpu/drm/drm_plane.c:1365
 drm_ioctl_kernel+0x1f3/0x3e0 drivers/gpu/drm/drm_ioctl.c:804
 drm_ioctl+0x5e6/0xc60 drivers/gpu/drm/drm_ioctl.c:901
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7754f9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0c03a0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7755215fa0 RCX: 00007f7754f9cdd9
RDX: 0000200000000100 RSI: 00000000c01c64a3 RDI: 0000000000000003
RBP: 00007ffd0c03a120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f7755215fac R14: 00007f7755215fa0 R15: 00007f7755215fa0
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
