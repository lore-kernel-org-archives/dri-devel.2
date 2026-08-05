Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDF9C56205
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 22:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5091A10E08B;
	Wed,  5 Aug 2026 22:44:39 +0000 (UTC)
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com
 [209.85.161.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E96A10E244
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 22:44:38 +0000 (UTC)
Received: by mail-oo1-f77.google.com with SMTP id
 006d021491bc7-6ab4aec4a14so1025291eaf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 15:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785969877; x=1786574677;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B/VG1ElgdBBDmS7WpjZAJKdiGrWimuTWHY0fHxv6+xo=;
 b=LA6xGvvJM9TWVrV29hNhhovRJt2+H8kutjTzcFS8NUr4xGFoG9sq4bSg63cv3hhj7H
 EIWte4MDuEZ1fNSqr9uZgKE7983/Y/zz4LftF7epJSYu0+y7geZrDCzUAwrXL+LENJ7a
 nqyrTzWYYK0iyChMyP4aPtBCiHMIjNyNngBC8RDJQ0lM8b/QyQ6QYnUhSvRA0BGLxWxp
 t6e31NIj7+QJxkQyRgHYI/+vcWAan50k1pC2dPfvJFDdmzSxSltmWoFQhwTr/27Lo65B
 hFscMXTUn4kTiuIoYupIMk8vUPDdjQ0KxXDmirLSwh7SXItA8mp9R2ix9/clau3v+iKd
 9geA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCbWXTdL5YR6Sh+oMO3gz6rHOaEJZF0tVyhfzcP6m8nVwcei0RZgPS+JQB98vtbhhThynXfJMuUZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcNJZeA7sUq2PzwDU446J4vr6JIwqkYn2uWsMuaBYt3ptwW5du
 +MvfV5BrR4ySfNzKJ9H7jN2ZNtYywdCHfkjZ8XiGHzYTs4Ee5YBUvOs6uBQY/X61+IzmsWqGWZs
 43fDHnt7/LjYOHnA2Dm/0kdaFZlUSMpFvtSISN2Zm1N4AB1IrHKK7ETajQu8=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d07:b0:6ae:4959:e1c4 with SMTP id
 006d021491bc7-6ae96ed3e38mr5421908eaf.23.1785969877263; Wed, 05 Aug 2026
 15:44:37 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73bcd5.01d0871a.3a0d52.0003.GAE@google.com>
Subject: [syzbot] [intel-gfx?] general protection fault in i915_pci_probe
From: syzbot <syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com>
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, 
 joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org, 
 rodrigo.vivi@intel.com, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
 tursulin@ursulin.net
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

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13245bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=db96c5ff032f4292a8dc
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101513b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17245bb9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com

e1000e 0000:00:02.0 eth1: removed PHC
e1000e 0000:00:02.0 eth1: NIC Link is Down
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 2 UID: 0 PID: 5932 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:i915_pci_probe+0x57/0x480 drivers/gpu/drm/i915/i915_pci.c:961
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f6 03 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 6c 24 18 4c 8d 6d 1c 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 4c 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 86 03 00 00
RSP: 0018:ffffc900016bf9a0 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff888023150000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff85d8d20d RDI: ffffffff8c43a498
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c43a480
R13: 000000000000001c R14: ffffffff85d8d1f0 R15: ffff888023150130
FS:  0000555583377500(0000) GS:ffff8880d5fd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff49e597e9c CR3: 0000000023b2c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
 bind_store+0xf4/0x190 drivers/base/bus.c:267
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f246059e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe32b38f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2460825fa0 RCX: 00007f246059e019
RDX: 000000000000000d RSI: 0000200000000180 RDI: 0000000000000005
RBP: 00007f246063500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2460825fac R14: 00007f2460825fa0 R15: 00007f2460825fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:i915_pci_probe+0x57/0x480 drivers/gpu/drm/i915/i915_pci.c:961
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f6 03 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 6c 24 18 4c 8d 6d 1c 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 4c 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 86 03 00 00
RSP: 0018:ffffc900016bf9a0 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff888023150000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff85d8d20d RDI: ffffffff8c43a498
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c43a480
R13: 000000000000001c R14: ffffffff85d8d1f0 R15: ffff888023150130
FS:  0000555583377500(0000) GS:ffff8880d5fd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff49e597e9c CR3: 0000000023b2c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	89 fa                	mov    %edi,%edx
   2:	48 c1 ea 03          	shr    $0x3,%rdx
   6:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   a:	0f 85 f6 03 00 00    	jne    0x406
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	49 8b 6c 24 18       	mov    0x18(%r12),%rbp
  1f:	4c 8d 6d 1c          	lea    0x1c(%rbp),%r13
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	4c 89 ea             	mov    %r13,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 86 03 00 00    	jne    0x3c6


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
