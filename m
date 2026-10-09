Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34A9CA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E5C10EB60;
	Fri,  9 Oct 2026 21:55:33 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6455510EB60
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:55:31 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b37620eb73so550648b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791582930; x=1792187730;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EJZ9bPUGIIFLQOn9K1GH3elZiy2JfD5gZkP/Geb2G1U=;
 b=u7jHKsw0+ThjM3BkPulhtMjXrUgpnA8TuhyGaG+i7mwq09XalsOZkVtGylQrPXtHIm
 CP2Ksn9mCo8fkbk2vGrfRaKm1YWkt4JCuQSW2QjMdf3E2+grVSmfCcNGm8C78EliH7K/
 o9NLuenf8isS/x4d0yMhbfAaiMBmKOVB/TTFPT9JiczKTB8B11aeg++QFJtcWmCZ5LVD
 LWATrvLQ8M+/uwjvNxfbR2fGyDh+t7yz7RFZ2E84zUTB6dCWoej+fQuff8BUt3hHgA9q
 gl+oC1/IPp9ItD3zlBxhEQxgGZ2UsYEi2GCDhLTWTwchA1uBUekqnRowEv+7HhLziZkW
 WdMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTWhC0nA02tcuz5+PLepuOowNjwkji1/Tn7Gqy4ZIiBxulZOB07L3xFMxkKNVzuqN5BpJtp/HFPUQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nS+4djGQV3Rd29SHvcNPWKBAS1gpKHRfhxQJgduZDeYBUc30jo
 PA6BXxgLACwFezOopiKFq7pI/FM/diIGH7eMOAM97tTjyFe+AEH6se6AUvueFHzqcKWh8uxNbp1
 lstYWfqGa7e3kDMpnMx8K3+7ucP1gzoPf6VOpcHQQfz4Tv9oMIu9nls14/FM=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f65:b0:4e5:c2b4:33b0 with SMTP id
 5614622812f47-50c59399b92mr2796870b6e.43.1791582930733; Fri, 09 Oct 2026
 14:55:30 -0700 (PDT)
Date: Fri, 09 Oct 2026 14:55:30 -0700
In-Reply-To: <6a778d6e.9c11d2ce.289b96.00ba.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac962d2.bbc4c7f9.15faa7.003c.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_fbdev_shmem_helper_fb_dirty
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    af32da41b032 Merge tag 'net-7.3-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b540a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
dashboard link: https://syzkaller.appspot.com/bug?extid=369ee6a6e9d0bbf14b37
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c2fa8e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1268e0a5580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-af32da41.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a43965520a9/vmlinux-af32da41.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c79ed41c72d4/bzImage-af32da41.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com

------------[ cut here ]------------
virtio-pci 0000:00:01.0: [drm] Dirty helper failed: ret=-12
WARNING: drivers/gpu/drm/drm_fbdev_shmem.c:118 at drm_fbdev_shmem_helper_fb_dirty+0x1e1/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:118, CPU#0: kworker/0:0/9
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:drm_fbdev_shmem_helper_fb_dirty+0x288/0x310 drivers/gpu/drm/drm_fbdev_shmem.c:118
Code: 27 fc 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 3a 1a 9a fc 4d 8b 27 48 89 df 4c 89 f6 4c 89 e2 8b 5c 24 04 89 d9 <67> 48 0f b9 3a 89 d8 e9 f7 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f
RSP: 0018:ffffc9000022f898 EFLAGS: 00010246
RAX: 1ffff1100004481a RBX: 00000000fffffff4 RCX: 00000000fffffff4
RDX: ffff888000b33d00 RSI: ffffffff8c79f2a0 RDI: ffffffff91867840
RBP: ffff8880322ca008 R08: ffffc9000022f5e7 R09: 1ffff92000045ebc
R10: dffffc0000000000 R11: fffff52000045ebd R12: ffff888000b33d00
R13: dffffc0000000000 R14: ffffffff8c79f2a0 R15: ffff8880002240d0
FS:  0000000000000000(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76a6223b50 CR3: 0000000038789000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:339 [inline]
 drm_fb_helper_damage_work+0x84c/0xf20 drivers/gpu/drm/drm_fb_helper.c:365
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	fc                   	cld
   1:	4c 89 f8             	mov    %r15,%rax
   4:	48 c1 e8 03          	shr    $0x3,%rax
   8:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   d:	74 08                	je     0x17
   f:	4c 89 ff             	mov    %r15,%rdi
  12:	e8 3a 1a 9a fc       	call   0xfc9a1a51
  17:	4d 8b 27             	mov    (%r15),%r12
  1a:	48 89 df             	mov    %rbx,%rdi
  1d:	4c 89 f6             	mov    %r14,%rsi
  20:	4c 89 e2             	mov    %r12,%rdx
  23:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
  27:	89 d9                	mov    %ebx,%ecx
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	89 d8                	mov    %ebx,%eax
  30:	e9 f7 fe ff ff       	jmp    0xffffff2c
  35:	89 d9                	mov    %ebx,%ecx
  37:	80 e1 07             	and    $0x7,%cl
  3a:	fe c1                	inc    %cl
  3c:	38 c1                	cmp    %al,%cl
  3e:	0f                   	.byte 0xf


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
