Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA34C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A6B10F1B8;
	Fri, 31 Jul 2026 08:15:34 +0000 (UTC)
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com
 [209.85.167.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70FC10F1B8
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:15:33 +0000 (UTC)
Received: by mail-oi1-f206.google.com with SMTP id
 5614622812f47-4a4a7d0362eso951659b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 01:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785485733; x=1786090533;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5tH1CMhR+uKj4zjBpyik5GGXSV/ZSXI9oXDQTtL9QEM=;
 b=G2stB/lMt3/yGG+dBRAxrSaYny74NbTZ4nBvlgNPiy5E3580/6y8EAlEOwoaZB2TF6
 rVaaq7ZKHdXAKEtLrVqBBV7sliW1M/+ItBiwCkAF1+vap2wT4++r3MjyQro/R3qzmL0n
 qNgPPTp1GJDp6Dj5crXo84gbFPE77y1UpFYnjC7Eha62aNQJtQfn3zzj9ZsYaJbPtEAS
 LesWlbi5yEd4chhWTgPBg3kGzae+V/TStrradBqnsQyqYhY2g0M9vpF33r5zfM4z7QeB
 tf0TsCaI8e+AZr2w25chi7md25N8Ug7hoaa/Lj9sC7Fv26q29rv2eOWCK4oWmc+zczxt
 JHFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rry53SYw42K/WrfHVZBjEmMjUT8ITKLt92/kmAPHvp68dzTA9LbXLWwCaGzWCK0ZQagnIvWRCCAImQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAm9amEZQ8i7yREBOtiNceupauAr/aB+0cylVOfsbEKwcZ0LUV
 qJcSuyCm4/O/WPMhoS2K485jhZKOOH3+V+Ll/jMhZHt563SJyChEZtI1mfLP1ncla4nOgCV1fiG
 CpFl5SNyrdlKg9435GtuUqlqUaQg6yXsqYIIZz0+YlPsenS0299TFe97sEjA=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1c06:b0:4a3:d66b:240b with SMTP id
 5614622812f47-4ae5abaa7d3mr936989b6e.18.1785485732891; Fri, 31 Jul 2026
 01:15:32 -0700 (PDT)
Date: Fri, 31 Jul 2026 01:15:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6c59a4.77639fcc.3d4fd0.0022.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in __drm_atomic_helper_set_config
From: syzbot <syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com>
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

HEAD commit:    4235cb24ec1e Merge tag 'vfs-7.2-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1753a7b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f221a1b5d497ed15
dashboard link: https://syzkaller.appspot.com/bug?extid=ca23c8570669ead78867
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4235cb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68eef4847f46/vmlinux-4235cb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77e73df69f7f/bzImage-4235cb24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com

------------[ cut here ]------------
!set->fb
WARNING: drivers/gpu/drm/drm_atomic.c:1951 at __drm_atomic_helper_set_config+0xa45/0xee0 drivers/gpu/drm/drm_atomic.c:1951, CPU#0: syz.2.1107/9271
Modules linked in:
CPU: 0 UID: 0 PID: 9271 Comm: syz.2.1107 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__drm_atomic_helper_set_config+0xa45/0xee0 drivers/gpu/drm/drm_atomic.c:1951
Code: 84 c0 74 09 3c 03 7f 05 e8 c8 b6 bd fc 45 89 75 38 e9 0e fb ff ff e8 fa 28 4e fc 90 0f 0b 90 e9 9f f7 ff ff e8 ec 28 4e fc 90 <0f> 0b 90 e9 47 f7 ff ff 8b 6c 24 28 e8 da 28 4e fc 49 8d 7c 24 08
RSP: 0018:ffffc9000efb7950 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888029878500 RCX: ffffffff85bb7a4b
RDX: ffff88802a308000 RSI: ffffffff85bb8374 RDI: ffff88802a308000
RBP: ffff88802a874b00 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff888028f94c00 R11: 0000000000000000 R12: ffff888077d2d300
R13: ffff888028f94c00 R14: ffff8880141c1400 R15: ffff88806c029368
FS:  0000000000000000(0000) GS:ffff888096be3000(0063) knlGS:00000000571f8480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000027e6e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_client_modeset_commit_atomic+0x53d/0x7e0 drivers/gpu/drm/drm_client_modeset.c:1085
 drm_client_modeset_commit_locked+0x14d/0x580 drivers/gpu/drm/drm_client_modeset.c:1207
 drm_client_modeset_commit+0x4f/0x80 drivers/gpu/drm/drm_client_modeset.c:1233
 __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x137/0x160 drivers/gpu/drm/drm_fb_helper.c:138
 __drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:126 [inline]
 drm_fb_helper_restore_fbdev_mode_unlocked+0x93/0xc0 drivers/gpu/drm/drm_fb_helper.c:169
 drm_fbdev_client_restore+0x1b/0x30 drivers/gpu/drm/clients/drm_fbdev_client.c:45
 drm_client_dev_restore+0x205/0x2a0 drivers/gpu/drm/drm_client_event.c:118
 drm_lastclose drivers/gpu/drm/drm_file.c:408 [inline]
 drm_release+0x2c6/0x360 drivers/gpu/drm/drm_file.c:441
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x6f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 __do_fast_syscall_32+0x701/0x970 arch/x86/entry/syscall_32.c:310
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf703efec
Code: Unable to access opcode bytes at 0xf703efc2.
RSP: 002b:00000000ffb3591c EFLAGS: 00000202 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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
