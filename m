Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15909C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 19:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EEC10E0E7;
	Sun,  9 Aug 2026 19:14:27 +0000 (UTC)
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com
 [209.85.161.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AC110E0E7
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 19:14:25 +0000 (UTC)
Received: by mail-oo1-f79.google.com with SMTP id
 006d021491bc7-6ae4622d842so1013593eaf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 12:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786302865; x=1786907665;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GidNn0OMKrjDQ21kBazeerlBT2Ktqq4wU0/ri2a78Bk=;
 b=NpXk1NeeHWpDQYTh0ax7Agu10w2R/EEewPlonMgMK1xvFD5kVdQeKa/QvQCzhkNuAp
 uUiuDtt0gF8jBlXjs9/urE9b+mxcLmIAvT0NZGEDAW7sEl9ZcYsxK9VzaQVkpULl0ry1
 RLLdNwhNaHnJecVn+KDq4i+mM94PutjnUOBB3I3wIE0c4jg4p4vigbMLB9BDV4KPDFHT
 x+9NwKJuhckq6aPMxkhGblhklKoXUPZE8dx4HbSgQqUW2pGBxU42o4yTlk1MOR5e+knx
 OdTBo2xBeHqTkcez3BrMsGB1Uw4nIMQ5aiYQpVmhJP1u2q4Fk2ocjtUt0lfeYEm/MzJd
 J6Jw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBxfBOEUpTJMtTcQSspLZmDxKaH/O9TZcxPniG5Bjn2QXMAXZ8zZQtPqXhwGuPpv3N7pvEKfd8oM4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT98BYQ0Zu9z62H+QTEgNPMej6D0tqWN6/OVmFqOup49YhucWZ
 Iwu3zfl0OFqsOugBDyzfbMmZFS8q0bEmmnu1wghkF2t369c0J4ineO1lP3OBdYhxXnHquTyzQ1f
 KI8qAiApj07vSHSWC7brgGomsq9p1LsvlrUxdjD23eZ1cBN3zWIUmaPuoWaE=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1990:b0:6ae:84e6:2de0 with SMTP id
 006d021491bc7-6b042143dd7mr7749464eaf.26.1786302865071; Sun, 09 Aug 2026
 12:14:25 -0700 (PDT)
Date: Sun, 09 Aug 2026 12:14:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a78d191.b50370da.49fe0.0041.GAE@google.com>
Subject: [syzbot] [media?] [dri?] WARNING in udmabuf_create
From: syzbot <syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com>
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 kraxel@redhat.com, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com, 
 vivek.kasireddy@intel.com
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

HEAD commit:    6b8c8af514d7 Add linux-next specific files for 20260807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b34149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d343b54cc50df0f
dashboard link: https://syzkaller.appspot.com/bug?extid=bfeed181d1ce9ec87a8f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e8c079580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ff4edcb608/disk-6b8c8af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f5fa331d8f2/vmlinux-6b8c8af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f993558ec63b/bzImage-6b8c8af5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com

------------[ cut here ]------------
!(flags & __GFP_NOWARN)
WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x792/0x820 mm/slub.c:7013, CPU#1: syz.0.17/5840
Modules linked in:
CPU: 1 UID: 0 PID: 5840 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__kvmalloc_node_noprof+0x792/0x820 mm/slub.c:7013
Code: ff 48 c7 c7 70 f7 c8 8e 48 89 de e8 a8 3d eb 02 e9 1f fc ff ff 48 c7 c7 b0 f7 c8 8e 48 89 de e8 94 3d eb 02 e9 50 fc ff ff 90 <0f> 0b 90 31 db e9 08 fe ff ff 90 0f 0b 90 e9 57 ff ff ff 49 83 7f
RSP: 0018:ffffc900044ffae0 EFLAGS: 00010246
RAX: 0000000000000100 RBX: 0000000000000000 RCX: 0000000080000001
RDX: 0000008000000000 RSI: ffffffff8c4c7660 RDI: ffffffff8c4c7620
RBP: 00000000ffffffff R08: 00000000000028c0 R09: 00000000ffffffff
R10: 0000000000000006 R11: 0000000000000000 R12: 0000008000000000
R13: 00000000000028c0 R14: 0000001000000000 R15: ffffffff865110fc
FS:  0000555557138500(0000) GS:ffff88812500c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb692c70000 CR3: 0000000079676000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 init_udmabuf drivers/dma-buf/udmabuf.c:193 [inline]
 udmabuf_create+0x2dc/0xf50 drivers/dma-buf/udmabuf.c:386
 udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:465 [inline]
 udmabuf_ioctl+0x1f3/0x300 drivers/dma-buf/udmabuf.c:496
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb692d9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7e6eab08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb693025fa0 RCX: 00007fb692d9e0d9
RDX: 0000200000000200 RSI: 0000000040187542 RDI: 0000000000000003
RBP: 00007fb692e35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb693025fac R14: 00007fb693025fa0 R15: 00007fb693025fa0
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
