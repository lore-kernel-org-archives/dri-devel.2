Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA206C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA0F10EC91;
	Wed, 26 Aug 2026 10:11:41 +0000 (UTC)
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644CF10EC91
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:11:40 +0000 (UTC)
Received: by mail-oi2-f0.google.com with SMTP id
 5614622812f47-4a41b6fb855so367035b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 03:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787739099; x=1788343899;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GNnE9+FHY9grYCLAVfeJIofAqZ8q2PbidJMhK+jFRzw=;
 b=n23eLQx3tfHZ/BXJmywNTSMzLbJze4ay/oVXmxvcyaYkrGoDrPTQJkZ24KJbJZZskd
 cYC0Oc32D4cbYYiLhxMRC6mfpcdubjc2KOH3Rn+rO+8lHXJryJUAUf1JaxDEt2BLW6XV
 dkhcL2tQSP/ursSWUxlz7r/o4yWPosz+XghKPBi36TzMpVtFmDOgeZzvAbLxV7GdBxkJ
 HZpFLAFzCTZAW7GvWuhCMh1YHxkVpBeD7naPtzFcYxsmac4joOpG0fcI4k39x+OzA9SY
 SpiD409mqCNU464R7xezVkgP4bSeoGeMe0I9CViEbyRosBnAhd0ekiKL/u+gjSuXW2A7
 iRSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmjX4YGyr4G8fVajcMqKw7gxonn8fAzfx7+VRJSBDPnrVprcqjddWiT5yoYJFRS3TQ4W5g1M7v6FM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mk1s7ILEKqIyVNCtz6OgVCIZ6NHCTAioNcUJVeKYo1ATgZX8Cm
 iv/mO82By1riH6F1sFVAksvuvy87YY9/9BB4PoKHfVKkoEswV7gNMVILXFcK/uBgvh7VbEmDGjm
 ihe3eN9/HL64Hsu2mj3meqvU8eYPEpy0dMivE7/GAZ5GpzO88jzNxGF8ZxYQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5185:b0:4b2:67f1:11d7 with SMTP id
 5614622812f47-4b366b70521mr5757753b6e.17.1787739099679; Wed, 26 Aug 2026
 03:11:39 -0700 (PDT)
Date: Wed, 26 Aug 2026 03:11:39 -0700
In-Reply-To: <6a78d191.b50370da.49fe0.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8ebbdb.1d9ded08.62e62.00a1.GAE@google.com>
Subject: Re: [syzbot] [media?] [dri?] WARNING in udmabuf_create
From: syzbot <syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com>
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 kraxel@redhat.com, linaro-mm-sig-bounces@lists.linaro.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 syzkaller-bugs@googlegroups.com, vivek.kasireddy@intel.com
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

HEAD commit:    73ae59e97596 Merge tag 'erofs-for-7.3-rc1-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12dff979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d423d3e91ba4f47
dashboard link: https://syzkaller.appspot.com/bug?extid=bfeed181d1ce9ec87a8f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d50d49580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11296979580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-73ae59e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2edc303b5fba/vmlinux-73ae59e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2624d8e0a8af/bzImage-73ae59e9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com

------------[ cut here ]------------
!(flags & __GFP_NOWARN)
WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x646/0x9b0 mm/slub.c:7013, CPU#2: syz.0.17/5920
Modules linked in:
CPU: 2 UID: 0 PID: 5920 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__kvmalloc_node_noprof+0x646/0x9b0 mm/slub.c:7013
Code: c1 e8 2e 07 ff ff 4d 85 f6 0f 85 b6 fd ff ff 48 81 fb ff ff ff 7f 0f 86 4d fd ff ff 41 81 e4 00 20 00 00 0f 85 9c fd ff ff 90 <0f> 0b 90 e9 93 fd ff ff 41 be 10 00 00 00 e9 88 fd ff ff be 42 01
RSP: 0018:ffffc90003d8fb50 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000008000800018 RCX: 0000010000000000
RDX: 0000000000000000 RSI: ffffffff8c61e200 RDI: ffffffff8e6ad930
RBP: 0000000008000800 R08: 00000000000028c0 R09: 00000000ffffffff
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000028c0 R14: 0000000000000000 R15: 00000000ffffffff
FS:  0000000000000000(0000) GS:ffff888096b76000(0063) knlGS:00000000579e1480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7113140 CR3: 00000000542cb000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 init_udmabuf drivers/dma-buf/udmabuf.c:193 [inline]
 udmabuf_create+0x2e8/0x12a0 drivers/dma-buf/udmabuf.c:386
 udmabuf_ioctl_create_list drivers/dma-buf/udmabuf.c:484 [inline]
 udmabuf_ioctl+0x2b2/0x300 drivers/dma-buf/udmabuf.c:499
 __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
 __ia32_compat_sys_ioctl+0x2cf/0x360 fs/ioctl.c:638
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f03fec
Code: Unable to access opcode bytes at 0xf7f03fc2.
RSP: 002b:00000000ffe2d40c EFLAGS: 00000292 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000040087543
RDX: 0000000080000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
