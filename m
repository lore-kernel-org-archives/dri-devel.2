Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803AEC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 01:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B1610E112;
	Mon, 10 Aug 2026 01:07:32 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com
 [209.85.167.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544E410E112
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 01:07:31 +0000 (UTC)
Received: by mail-oi1-f207.google.com with SMTP id
 5614622812f47-4a41e3d6fe9so1733011b6e.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 18:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786324050; x=1786928850;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=83eI8T2oiuDkGdD6dryMn21D7tV7HmHGpVwSoml6DuQ=;
 b=cJlCgmLDXWZhxuc2MLI9wj0vnEnJL79TREZ0qCqEWrqw1t9k8JNu3gP4j92I11m4q1
 otWAC2tAJ3r2OVYSop+oqXmo9LiPA5nUOBmtQLZycgv8FY639uOzhiD2rwiScBlmhwLm
 KjCEC49Hu9mq+qugbBi/xMSpafoRVvTkXJ7lVc705uWZvoTeDAG7jQ9oRKQuMlahzfqe
 LPv4jlbFw8k9y7dtlduXj/l7HP1aSOmIh9zHswOC9FuC88tggqXlLC3swlUAlhOvDzOR
 /qF+elXq729N0laI+Iqiun3l/M9UW9xq9YMgY5AiudsnqdX0g9GqVtfumVa3CmF9p6Tw
 YIcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RokFSs4LNGV+9ArdGJ1HRHXUEwsUzs77omrbQhFIHA7uYz/fz22FMfSJHgywyzrhiebl3cksySbofA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjSNGVlsf+HoxYbhhByxYmXwlrU/7SvcndgMfTa6xrLceFxdhj
 eKalJpiQLDbQLAmv7QuR/oZQxAEvNp1X9BQ+DK/lXAv1MOVo2J36PFKWs4rxuBuRmwjT/zqfly6
 ugg2tY7m5whkikJfT4giaBRwuiY5kjKofOxYCLo5XPuqmRIsf9+x3ybxn1bQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c14a:b0:486:4892:d553 with SMTP id
 5614622812f47-4afadc03178mr22397759b6e.0.1786324050514; Sun, 09 Aug 2026
 18:07:30 -0700 (PDT)
Date: Sun, 09 Aug 2026 18:07:30 -0700
In-Reply-To: <6a176ae6.d07c18fe.1069e4.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a792452.9c11d2ce.289b96.00e6.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_atomic_helper_wait_for_vblanks (6)
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    b643e495ae92 Merge tag 's390-7.2-7' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176c0079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=45bc7264de77caad91cb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cbc079580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138fa2c6580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b643e495.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9eb4fbda136d/vmlinux-b643e495.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53cbbd75c40a/bzImage-b643e495.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45bc7264de77caad91cb@syzkaller.appspotmail.com

------------[ cut here ]------------
[CRTC:39:crtc-0] vblank wait timed out
WARNING: drivers/gpu/drm/drm_atomic_helper.c:1921 at drm_atomic_helper_wait_for_vblanks.part.0+0x738/0x8a0 drivers/gpu/drm/drm_atomic_helper.c:1921, CPU#3: syz.0.17/5906
Modules linked in:
CPU: 3 UID: 0 PID: 5906 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:drm_atomic_helper_wait_for_vblanks.part.0+0x73e/0x8a0 drivers/gpu/drm/drm_atomic_helper.c:1921
Code: 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 04 01 84 c0 74 08 3c 03 0f 8e 44 01 00 00 48 8d 3d 48 de 5f 0b 8b b3 d0 00 00 00 <67> 48 0f b9 3a e9 e1 fc ff ff e8 93 10 3d fc e9 7c fe ff ff e8 99
RSP: 0018:ffffc90003847710 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888028680040 RCX: 1ffff110050d0022
RDX: ffff8880285a50e0 RSI: 0000000000000027 RDI: ffffffff912d4120
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88802e1f5000
FS:  000055557c115500(0000) GS:ffff8880d60ec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055777c801168 CR3: 000000005176b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_atomic_helper_wait_for_vblanks drivers/gpu/drm/drm_atomic_helper.c:1895 [inline]
 drm_atomic_helper_commit_tail+0xff/0x130 drivers/gpu/drm/drm_atomic_helper.c:1997
 commit_tail+0x338/0x430 drivers/gpu/drm/drm_atomic_helper.c:2074
 drm_atomic_helper_commit+0x303/0x380 drivers/gpu/drm/drm_atomic_helper.c:2312
 drm_atomic_commit+0x230/0x300 drivers/gpu/drm/drm_atomic.c:1789
 drm_atomic_helper_set_config+0x13a/0x190 drivers/gpu/drm/drm_atomic_helper.c:3523
 drm_mode_setcrtc+0xeca/0x1d50 drivers/gpu/drm/drm_crtc.c:885
 drm_ioctl_kernel+0x1f3/0x3e0 drivers/gpu/drm/drm_ioctl.c:817
 drm_ioctl+0x5e6/0xc60 drivers/gpu/drm/drm_ioctl.c:914
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d5bf9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe900c07d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6d5c225fa0 RCX: 00007f6d5bf9e0d9
RDX: 0000200000000300 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00007f6d5c035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6d5c225fac R14: 00007f6d5c225fa0 R15: 00007f6d5c225fa0
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
  1d:	48 8d 3d 48 de 5f 0b 	lea    0xb5fde48(%rip),%rdi        # 0xb5fde6c
  24:	8b b3 d0 00 00 00    	mov    0xd0(%rbx),%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 e1 fc ff ff       	jmp    0xfffffd15
  34:	e8 93 10 3d fc       	call   0xfc3d10cc
  39:	e9 7c fe ff ff       	jmp    0xfffffeba
  3e:	e8                   	.byte 0xe8
  3f:	99                   	cltd


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
