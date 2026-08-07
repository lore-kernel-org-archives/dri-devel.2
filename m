Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB0C5AC67
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 00:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F7210F2F0;
	Fri,  7 Aug 2026 00:01:34 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com
 [209.85.160.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD5710F310
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 00:01:33 +0000 (UTC)
Received: by mail-oa1-f80.google.com with SMTP id
 586e51a60fabf-448bb8bcf38so2546887fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 17:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786060892; x=1786665692;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GfN1QcOLKkE6f4SQ8/MOLAZKM4TDMu6M26J6J6oRM+U=;
 b=EQyvesNXA64hOjrsg9uRN9bJfsUNw7hWRJht7ioUME/2Pf2lFtlG9C2zHosL9YZPah
 C8KSoNwU8XkD113pF8RSk52fav5rGZEvjUYEpAXQhDZfXcTTkZl7NSjpyFAFPCG72GRU
 ozAI9EF96XdjJ+VfQLjOLMzFyKFU3h/v9nBB7dsAyZoZKG79fHHlzyHKo+igRI2j0rDB
 Eo2isj17v/cgBBx4ds4OhCZBX2iS1Z6wxktS3b6kpQuqAjDFSRss0f99uN9ZcLPLYFcB
 pF/4i7+KWmlyuaMoxtb0YInmr+skz153C083U3HE4hDx7Zms9Vw4Sn7JxobdPWTSJ8jX
 D0Iw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSVPCXHaPo8d0crpqOPReMRP+D8iN4duedkO1SjzH9e+4ZInM8aQ2cHxnUcugz54X4VXuCoNWQV7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpErkAbthUwXNZn3jMx7GFkkKRV6YlEAv1uz9A1U44bnSo+mvR
 yPya+vBgSsFLKij8kNgWhbLMKWijoH0FQ+w5rxfFedpm3OvzoJOwHL+UFWm7LEPCKnfe95AnziL
 spzFziN9oIA9ETs+NDzNrpZZHFozdm5PFTc/bdwXdQCHZNvEjNsVapp+qBMY=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f024:b0:6af:f3a3:7f5d with SMTP id
 006d021491bc7-6aff3a486f6mr4081860eaf.26.1786060892556; Thu, 06 Aug 2026
 17:01:32 -0700 (PDT)
Date: Thu, 06 Aug 2026 17:01:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a75205c.01d0871a.3a0d52.0032.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: global-out-of-bounds Read in soft_cursor (3)
From: syzbot <syzbot+61b1db46218109869c14@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
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

HEAD commit:    c2a9495bd873 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=123f2986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a42e870a0b0ae0
dashboard link: https://syzkaller.appspot.com/bug?extid=61b1db46218109869c14
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03cd82d06e64/disk-c2a9495b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bef502845f71/vmlinux-c2a9495b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e14ed9394125/Image-c2a9495b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61b1db46218109869c14@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in soft_cursor+0x378/0x6bc drivers/video/fbdev/core/softcursor.c:70
Read of size 16 at addr ffff800086c57970 by task syz.7.609/8216

CPU: 0 UID: 0 PID: 8216 Comm: syz.7.609 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x17c/0x1ac mm/kasan/generic.c:200
 __asan_memcpy+0x3c/0x84 mm/kasan/shadow.c:105
 soft_cursor+0x378/0x6bc drivers/video/fbdev/core/softcursor.c:70
 bit_cursor+0xa90/0x1108 drivers/video/fbdev/core/bitblit.c:365
 fbcon_cursor+0x344/0x498 drivers/video/fbdev/core/fbcon.c:1427
 hide_cursor+0xdc/0x2d0 drivers/tty/vt/vt.c:883
 update_region+0x100/0x18c drivers/tty/vt/vt.c:669
 vcs_write+0x8ec/0xaf0 drivers/tty/vt/vc_screen.c:685
 do_loop_readv_writev+0x24c/0x3dc fs/read_write.c:-1
 vfs_writev+0x2c8/0x630 fs/read_write.c:1061
 do_writev+0x134/0x2a8 fs/read_write.c:1105
 __do_sys_writev fs/read_write.c:1173 [inline]
 __se_sys_writev fs/read_write.c:1170 [inline]
 __arm64_sys_writev+0x80/0x94 fs/read_write.c:1170
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

The buggy address belongs to the variable:
 fontdata_8x16+0x1010/0x1480

The buggy address belongs to a vmalloc virtual mapping
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x219857
flags: 0x5ffc00000002000(reserved|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000002000 fffffdffc76615c8 fffffdffc76615c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff800086c57800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff800086c57880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff800086c57900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
                                                             ^
 ffff800086c57980: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffff800086c57a00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


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
