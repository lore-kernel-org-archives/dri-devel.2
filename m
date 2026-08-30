Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF8C61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 11:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF0B10E186;
	Sun, 30 Aug 2026 11:05:32 +0000 (UTC)
Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2473410E186
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 11:05:31 +0000 (UTC)
Received: by mail-oi2-f4.google.com with SMTP id
 5614622812f47-4b3880be385so1103680b6e.0
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 04:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788087930; x=1788692730;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qttM/mbfeOt4T2qPpTH7zFfPdue3YkmkOeBj+OtO/eY=;
 b=YdOSd+XzbKmTfiMaSiPfEdMYjeo/yKTt3CE6MeoL1lGbV6NFAYpl/EBHwUStVXKEc6
 avFs4HkCQdxuvWCHydyIFLzgUTy/rUB4l2TS4GtsbB79L/k5Fgkow4RCWlEeQQ0Gyj9U
 X7GlG4rb5zaUBTvcPv7yVFkpsRaWtuixtJ2os1wFkoJzNsCbhuD1qhn1eT2vUM+Pe2we
 QKnLRNynX5XMjV4RPfQaOkoZAcNXGOoWXzXdvhmKExQlcD7Ejjb02G6IiPPzbBRoadui
 qxSRIOEKaWrCb0hAqaH7XJ3E0AZPj58YUk2iYGdtVAcVrz1WBiS4n6voFu7WpFTYH4PF
 q+XA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXUBaeSoKtoLkP97f1rZgjvOhjDwdQARJV2gttQ1QHv8ep74xzOBrx1bK0zzNWnpc3xcfVPjCkNMI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE+OxEA3qsRUzIaG8NisIZP9pNUGJx3KNg9p9Pzxo2g4wLkPB5
 btAchdj6teSh9XbNM/+7JP1VDik6pJLDXKm6ptF4dxumvi/j/68es8amS++7eBzjMguMV3qLbXs
 IOKiCL91LGzByZ8JmX2AGeVGLtsbtWxSl4qlS78wm6q9JyrnFFWgJolv778g=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:190f:b0:4b3:74d0:6ef7 with SMTP id
 5614622812f47-4b398037cdamr18008160b6e.4.1788087930233; Sun, 30 Aug 2026
 04:05:30 -0700 (PDT)
Date: Sun, 30 Aug 2026 04:05:30 -0700
In-Reply-To: <6a6c59a4.77639fcc.3d4fd0.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a940e7a.4d659fcc.734b4.0037.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in __drm_atomic_helper_set_config
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    08dbfad3f504 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13380349580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=ca23c8570669ead78867
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17392379580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17380349580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e64f94ffb05c/disk-08dbfad3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36a861364fe8/vmlinux-08dbfad3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6130bd19ca7f/bzImage-08dbfad3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca23c8570669ead78867@syzkaller.appspotmail.com

------------[ cut here ]------------
!set->fb
WARNING: drivers/gpu/drm/drm_atomic.c:2031 at __drm_atomic_helper_set_config+0xa45/0xee0 drivers/gpu/drm/drm_atomic.c:2031, CPU#1: syz-executor419/5624
Modules linked in:
CPU: 1 UID: 0 PID: 5624 Comm: syz-executor419 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__drm_atomic_helper_set_config+0xa45/0xee0 drivers/gpu/drm/drm_atomic.c:2031
Code: 84 c0 74 09 3c 03 7f 05 e8 28 6e b4 fc 45 89 75 38 e9 0e fb ff ff e8 6a 5b 41 fc 90 0f 0b 90 e9 9f f7 ff ff e8 5c 5b 41 fc 90 <0f> 0b 90 e9 47 f7 ff ff 8b 6c 24 28 e8 4a 5b 41 fc 49 8d 7c 24 08
RSP: 0018:ffffc900036d7890 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880349c1000 RCX: 0000000000000000
RDX: ffff88802f3dcb00 RSI: ffffffff85ca8bd4 RDI: ffff88802f3dcb00
RBP: ffff8880315d3800 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff888028212c00 R11: 0000000000000000 R12: ffff88801c14e400
R13: ffff888028212c00 R14: ffff888028210c00 R15: ffff8880332d5328
FS:  0000000000000000(0000) GS:ffff888123c64000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcfbaa06a8 CR3: 0000000033c3a000 CR4: 00000000003526f0
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
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1008
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1151
 __do_sys_exit_group kernel/exit.c:1162 [inline]
 __se_sys_exit_group kernel/exit.c:1160 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1160
 x64_sys_call+0x1567/0x1570 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2694f1eb65
Code: Unable to access opcode bytes at 0x7f2694f1eb3b.
RSP: 002b:00007ffcb598ab38 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f2694f1eb65
RDX: 00000000000000e7 RSI: ffffffffffffffd8 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007f2694fb7108 R14: 00007f2694fbc648 R15: 00007f2694fbc660
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
