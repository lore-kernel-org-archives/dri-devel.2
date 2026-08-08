Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F20C5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DD710E067;
	Sat,  8 Aug 2026 20:11:29 +0000 (UTC)
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com
 [209.85.161.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D741B10E072
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:11:27 +0000 (UTC)
Received: by mail-oo1-f78.google.com with SMTP id
 006d021491bc7-6ab0def53fcso518258eaf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786219887; x=1786824687;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PgBLCiFvaDCfPbmVvLQfWAlNQsylrX8C81QgfBuh/0s=;
 b=oRndrvXZaRrCBvtwz70jAPagvMeV7cqG7/Z7bOOPPnHtfv3FLq+Lr7ZEr1Pn9lChLM
 4suWoIclNaTPTAn8jepZ7DsVw1N3P2kD+xAg6IiIbKxrjwJvth/wxipHU8xp7Sx/f3kZ
 G4ftII0gEfEnXzDc47hzPnpk+orNsRqLUH1E7bBdiFMhXRw1YeNzma5rTviGGfkz7Ruu
 j3NowYNmKPFO9ZD2rgU+Hz3mF+4DfRGyVpE7mllY9M5cGWjPxkjllfB91CCQ6/DS561J
 2VfskUZz+WvFhqo4HEwouZmzW+no7NSG2+BS8FozffcXwTBTLItAOr6kjr8iRZGS75yo
 KZHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7tLBNhARJYddTPh2zs9NxA6M9STbVpYEeXSsdGMEqYnCbQob/xizVs3W9YhXfcNZovW8D109RS2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyo/PkXXlE7gToBcAS614bBokKzF52kI/FhPxGqmGGpHp5+wZ7P
 oz0Fzg207HihJP5vcBsQQ2AnTGRHZyYQ5U4IeYnQzYlHlupPZDBUOIZ7SY28SMGp+Az8W+CRjNZ
 nD1+pTFCvbq6UW9SKTxkZE8vbf/GKN4H1V0XPOtk/iBFY2BUfvbx23b+Zetg=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca8:b0:6ac:a175:fe7e with SMTP id
 006d021491bc7-6b0421148f2mr3828322eaf.25.1786219886988; Sat, 08 Aug 2026
 13:11:26 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:11:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778d6e.9c11d2ce.289b96.00ba.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in drm_fbdev_shmem_helper_fb_dirty
From: syzbot <syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com>
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

HEAD commit:    a59f57e2aa12 Merge tag 'watchdog-for-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1328c2c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a59830cba91a1981
dashboard link: https://syzkaller.appspot.com/bug?extid=369ee6a6e9d0bbf14b37
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a59f57e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b0b58b842b2/vmlinux-a59f57e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48759b65e153/bzImage-a59f57e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 100, space 0, times 1
CPU: 0 UID: 0 PID: 805 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x40c/0x560 lib/fault-inject.c:174
 should_failslab+0xa8/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4539 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __kmalloc_cache_noprof+0xa8/0x660 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 drm_atomic_commit_alloc+0xa9/0x100 drivers/gpu/drm/drm_atomic.c:178
 drm_atomic_helper_dirtyfb+0x129/0xfd0 drivers/gpu/drm/drm_damage_helper.c:128
 drm_fbdev_shmem_helper_fb_dirty+0x160/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:339 [inline]
 drm_fb_helper_damage_work+0x84c/0xf20 drivers/gpu/drm/drm_fb_helper.c:365
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
------------[ cut here ]------------
virtio-pci 0000:00:01.0: [drm] Dirty helper failed: ret=-12
WARNING: drivers/gpu/drm/drm_fbdev_shmem.c:118 at drm_fbdev_shmem_helper_fb_dirty+0x1e1/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:118, CPU#0: kworker/0:2/805
Modules linked in:
CPU: 0 UID: 0 PID: 805 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_fbdev_shmem_helper_fb_dirty+0x288/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:118
Code: 35 fc 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 da 5b a4 fc 4d 8b 27 48 89 df 4c 89 f6 4c 89 e2 8b 5c 24 04 89 d9 <67> 48 0f b9 3a 89 d8 e9 f7 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f
RSP: 0018:ffffc90003ebf8b8 EFLAGS: 00010246
RAX: 1ffff11003f0801a RBX: 00000000fffffff4 RCX: 00000000fffffff4
RDX: ffff88801f64ce40 RSI: ffffffff8c57c700 RDI: ffffffff90638ce0
RBP: ffff88801d350008 R08: 0000000000000dc0 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff1d94963 R12: ffff88801f64ce40
R13: dffffc0000000000 R14: ffffffff8c57c700 R15: ffff88801f8400d0
FS:  0000000000000000(0000) GS:ffff88808c549000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ef6a77218 CR3: 0000000033b08000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:339 [inline]
 drm_fb_helper_damage_work+0x84c/0xf20 drivers/gpu/drm/drm_fb_helper.c:365
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	35 fc 4c 89 f8       	xor    $0xf8894cfc,%eax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   e:	74 08                	je     0x18
  10:	4c 89 ff             	mov    %r15,%rdi
  13:	e8 da 5b a4 fc       	call   0xfca45bf2
  18:	4d 8b 27             	mov    (%r15),%r12
  1b:	48 89 df             	mov    %rbx,%rdi
  1e:	4c 89 f6             	mov    %r14,%rsi
  21:	4c 89 e2             	mov    %r12,%rdx
  24:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
  28:	89 d9                	mov    %ebx,%ecx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	89 d8                	mov    %ebx,%eax
  31:	e9 f7 fe ff ff       	jmp    0xffffff2d
  36:	89 d9                	mov    %ebx,%ecx
  38:	80 e1 07             	and    $0x7,%cl
  3b:	fe c1                	inc    %cl
  3d:	38 c1                	cmp    %al,%cl
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
