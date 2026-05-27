Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5507DCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 22:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9794510EA4C;
	Wed, 27 May 2026 22:06:32 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com
 [209.85.160.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A0710EA48
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:06:31 +0000 (UTC)
Received: by mail-oa1-f80.google.com with SMTP id
 586e51a60fabf-43b469c6e24so5300992fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779919590; x=1780524390;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NA5/KnErm1XNnMMMcMghiPaIGjepl4VXf+uvQWVvmZ4=;
 b=SdRghfoKIXYPZgNXAusa8Sb4BL/NB9RH7QeK6bomwP30Ha4muz5AFYuMzHbPJ8U4qS
 AJp7/LIOL11a53GKo9t+KUVfWOOfKggLhxp/D9ezyeR+2eLIF8VvUfDi7c990BFRANFd
 7YSqHm12RmSeI3sZjFiEcJlKdH1SF+hhwqMAzAHB3Op2VhOsoo5HYiuCcr+Jv1HdSh7M
 drCOuvCcTbEUE7dMlRGRfnn/G3C2RNnVvx6B46CeSVHTGjvpfGpOzU6JtUGOpofd6gqm
 Ixt8i083N0vvBqHZBO5DRzkOwS4i5QAkNjPz+MeVth55wnxpHZX/PBAJBDcMovmvjxVw
 I7Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91bytK4/GeqFDnn8KsEkza9p+gTUPA1gq0r4xysFF4BPHzVsfnhfVwG32tFnCCdiO6W+O4lDMqjro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRXU8U7mHSXhQB+94wCxgc+PT1u8H9E0JzwQdHkntJAjCJodDV
 y45DsKkdwHxSP94lfeQuCV8mGQmonbTKt/GEZEo+wsiverskdP4u878zwVQKoDXzU+8L9ZGCKPU
 vebHHsjrB9Fkb01CR3T3QqWPf3pefvWU1vS23FeFnQ8Vo8DYBdGJRSHpsPbc=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:621:b0:69d:8cc2:332f with SMTP id
 006d021491bc7-69d8cc23537mr11608142eaf.57.1779919590333; Wed, 27 May 2026
 15:06:30 -0700 (PDT)
Date: Wed, 27 May 2026 15:06:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a176ae6.d07c18fe.1069e4.0016.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in drm_atomic_helper_wait_for_vblanks (6)
From: syzbot <syzbot+45bc7264de77caad91cb@syzkaller.appspotmail.com>
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

HEAD commit:    79bd2dded182 Merge tag 'sched_ext-for-7.1-rc4-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12282ac8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e327ee9a867dd6b9
dashboard link: https://syzkaller.appspot.com/bug?extid=45bc7264de77caad91cb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-79bd2dde.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/334fd806b634/vmlinux-79bd2dde.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc1d1c63d028/bzImage-79bd2dde.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45bc7264de77caad91cb@syzkaller.appspotmail.com

------------[ cut here ]------------
[CRTC:39:crtc-0] vblank wait timed out
WARNING: drivers/gpu/drm/drm_atomic_helper.c:1921 at drm_atomic_helper_wait_for_vblanks.part.0+0x738/0x8a0 drivers/gpu/drm/drm_atomic_helper.c:1921, CPU#1: kworker/1:1/54
Modules linked in:
CPU: 1 UID: 0 PID: 54 Comm: kworker/1:1 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_atomic_helper_wait_for_vblanks.part.0+0x73e/0x8a0 drivers/gpu/drm/drm_atomic_helper.c:1921
Code: 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 04 01 84 c0 74 08 3c 03 0f 8e 44 01 00 00 48 8d 3d e8 b2 3a 0b 8b b3 d0 00 00 00 <67> 48 0f b9 3a e9 e1 fc ff ff e8 43 4e 60 fc e9 7c fe ff ff e8 e9
RSP: 0018:ffffc90000a7f6e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888100fa0040 RCX: 1ffff110201f4022
RDX: ffff888025b8c780 RSI: 0000000000000027 RDI: ffffffff90e31630
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88802a6c0200
FS:  0000000000000000(0000) GS:ffff8880d646a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea94fea540 CR3: 000000002e244000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_atomic_helper_wait_for_vblanks drivers/gpu/drm/drm_atomic_helper.c:1895 [inline]
 drm_atomic_helper_commit_tail+0xff/0x130 drivers/gpu/drm/drm_atomic_helper.c:1997
 commit_tail+0x338/0x430 drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0x303/0x380 drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x230/0x300 drivers/gpu/drm/drm_atomic.c:1789
 drm_atomic_helper_dirtyfb+0x603/0x790 drivers/gpu/drm/drm_damage_helper.c:183
 drm_fbdev_shmem_helper_fb_dirty+0x1cc/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:117
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:249 [inline]
 drm_fb_helper_damage_work+0x348/0x640 drivers/gpu/drm/drm_fb_helper.c:275
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 fc                	add    %bh,%ah
   4:	ff                   	lcall  (bad)
   5:	df 48 89             	fisttps -0x77(%rax)
   8:	f9                   	stc
   9:	48 c1 e9 03          	shr    $0x3,%rcx
   d:	0f b6 04 01          	movzbl (%rcx,%rax,1),%eax
  11:	84 c0                	test   %al,%al
  13:	74 08                	je     0x1d
  15:	3c 03                	cmp    $0x3,%al
  17:	0f 8e 44 01 00 00    	jle    0x161
  1d:	48 8d 3d e8 b2 3a 0b 	lea    0xb3ab2e8(%rip),%rdi        # 0xb3ab30c
  24:	8b b3 d0 00 00 00    	mov    0xd0(%rbx),%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 e1 fc ff ff       	jmp    0xfffffd15
  34:	e8 43 4e 60 fc       	call   0xfc604e7c
  39:	e9 7c fe ff ff       	jmp    0xfffffeba
  3e:	e8                   	.byte 0xe8
  3f:	e9                   	.byte 0xe9


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
