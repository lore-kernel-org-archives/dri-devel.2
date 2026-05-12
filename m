Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C2CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6680510EC09;
	Tue, 12 May 2026 19:56:35 +0000 (UTC)
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com
 [209.85.210.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E49E10EC13
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:56:34 +0000 (UTC)
Received: by mail-ot1-f77.google.com with SMTP id
 46e09a7af769-7dccbd50e3fso13219366a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778615794; x=1779220594;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9MV+Cq9aE5IyHX3nuiOoVBxs9Adg3uGO5ZqfquEzdyM=;
 b=CuC+qTb/F80d+vw+wxYBV5pHhxnZAcve2tNAQ5pI9ezL0DGWCmP5d375kGtvRhZD4b
 Vf4S4zjOMFG3v8RBu+XfqhGTDzsbMbWXIzB3sGVB2wnuoq+L5BwZCgV9df3De7bRrTKQ
 I8IkeJ1/4YrEvtcynGwTYPLrgClKGc21xewB9QweCsAAM4wI5gB79irzhStc/sKgdz2m
 LQAwV4FsAv1/BpiFr6wBssfCyyxDS6AYUO9hOGqxrdjUaSlV7Kf6GHwciayNmbnCHnZr
 FO9JO2oqoQ7yhISiBxMeMwp9b1SD39Glw7pamszZ02lFqLBxmhfB15s41qjOoDzBFxUI
 OVgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QWgBxHhwy8r7ugk0WrxvADvtKG/hHelBhuc+LBDON0VULHvSzXiemLeplbVylJuGHGlr6gosokCw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjvcxYlZ/PkO+t5FFTw25z5FDhWmNMsAgnw+IRcqY84YCca03/
 qHJvqnFSGBXTq/XhP47pNhIHPYmwxlUTdGzoBohW+dBoxiRXvMPneqDd3bzj/3I+5CSBWD5LV2F
 GlhVwV0cdIiQ5in/p50Zh0/J9eAMvQtSz5UVLvPXThzSMPXW+Vf3ej1pHhVc=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81c8:b0:67e:eb4:238f with SMTP id
 006d021491bc7-69b78d016d2mr170190eaf.18.1778615793784; Tue, 12 May 2026
 12:56:33 -0700 (PDT)
Date: Tue, 12 May 2026 12:56:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0385f1.a00a0220.3890a0.0002.GAE@google.com>
Subject: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (3)
From: syzbot <syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com>
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

HEAD commit:    81d6f7807536 Merge tag 'v7.1-rc3-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159b10c8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c9eed171647e421013
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12332a73980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a3dba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61f8711360b2/disk-81d6f780.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ddb7a0f311fa/vmlinux-81d6f780.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c64e3d1de5c/bzImage-81d6f780.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com

------------[ cut here ]------------
!RB_EMPTY_ROOT(&prime_fpriv->dmabufs)
WARNING: drivers/gpu/drm/drm_prime.c:224 at drm_prime_destroy_file_private+0x48/0x60 drivers/gpu/drm/drm_prime.c:224, CPU#0: syz.0.17/5833
Modules linked in:
CPU: 0 UID: 0 PID: 5833 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:drm_prime_destroy_file_private+0x48/0x60 drivers/gpu/drm/drm_prime.c:224
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 75 2b 48 8b 83 88 00 00 00 48 85 c0 75 0b e8 84 dd 65 fc 5b e9 7e d5 ea 05 e8 79 dd 65 fc 90 <0f> 0b 90 e8 70 dd 65 fc 5b c3 cc cc cc cc e8 85 95 d3 fc eb ce 0f
RSP: 0018:ffffc90003487ca0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807e729328 RCX: ffffffff8b8bb2bd
RDX: ffff888030b68000 RSI: ffffffff85a2b5a7 RDI: ffff88807e7293b0
RBP: ffff88807e729000 R08: 0000000000000001 R09: fffff52000690f74
R10: ffffc90003487ba7 R11: ffffffff82761cc4 R12: ffff8880276dc000
R13: ffff88807e729260 R14: 0000000000000000 R15: ffff88807e729288
FS:  000055555c7ad500(0000) GS:ffff888124373000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5c5586400 CR3: 0000000072cb9000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 drm_file_free.part.0+0x7e6/0xcc0 drivers/gpu/drm/drm_file.c:269
 drm_file_free drivers/gpu/drm/drm_file.c:237 [inline]
 drm_close_helper.isra.0+0x186/0x200 drivers/gpu/drm/drm_file.c:290
 drm_release+0x1ab/0x360 drivers/gpu/drm/drm_file.c:438
 __fput+0x3ff/0xb50 fs/file_table.c:510
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x100/0x4a0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x706/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5c559cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7c1af318 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffd7c1af400 RCX: 00007fe5c559cdd9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00000000000117cd R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b33020000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe5c5815fac R14: 00007fe5c5815fa8 R15: 00007fe5c5815fa0
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
