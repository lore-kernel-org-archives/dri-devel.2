Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84749CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 09:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C899610EBC8;
	Sat, 10 Oct 2026 09:42:13 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13AC10EBBA
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 09:42:12 +0000 (UTC)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-45ecb9dd589so574840fac.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791625332; x=1792230132;
 h=content-type:cc:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8LzDxcHIFLOailu9VoDSBmcQuYWWLTYeM5cdlcmR5HQ=;
 b=2Jmfh/yuBYG31U1+us88Xnouu3DvMcNfo/PfaFvG/Cj0kYCw15TsXXAOjq5qsCEedC
 Eno0Duihe0cMvGkaT3VPDzCEADvpkYkhgIb/qArTbQEHAeO6MWjTa5Ys+1ulugP7Au4o
 0F8rdtLaMnBKSrRHl39JZ+iy+IJUCDHf3sgy9w7aTCGXs4kYVuwoZUPnMUBUBxfW21oz
 RhTWNpaCJXkbTrKBq9m2xYdsuogjDlFSMlOL8HXQJcjmu5FWK7hWHpmxUZD7NyP2pJK3
 uiCjF674nYatkIk7DhE0cUxcV2a6Ue3Kom37EGHLuPQFDqxq4CkIAvFultjePRWNB+a+
 oPng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwff4ekk6KecJ+bfk6D+Pu9sVC4YpxkK/Y2pCuhvkicvGkuN5oxQAt9ebprFlzk0Xcwiba3/fzYhuI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLuJr+c9oGZC8Hxl68TjytnYOov1dcFMOhsu12K7mgFE1fn6dpj
 klaQT504fNMXKXCXdmThlDxqfy4GAgVC2TwpyY41OYBxIs24gJ5G1O1i/nDKovu1A+1+j9bcmHj
 Z+R+zF8Nr8BYYusksJhKsf3Qvt36o7gw2l4umlizKWIfQuIQLLtztOsu5RM0=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:138e:b0:4f4:73a9:f838 with SMTP id
 5614622812f47-50c4ed3dc0dmr3742553b6e.22.1791625331782; Sat, 10 Oct 2026
 02:42:11 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:42:11 -0700
In-Reply-To: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aca0873.70ed5d86.2ac85.00ac.GAE@google.com>
Subject: [syzbot ci] Re: Extend drm_ras for qaic telemetry
From: syzbot ci <syzbot+ci0a77ef6c47a86cbc@syzkaller.appspotmail.com>
To: airlied@gmail.com, aravind.iddamsetty@linux.intel.com, 
 carl.vanderlip@oss.qualcomm.com, dri-devel@lists.freedesktop.org, 
 jeff.hugo@oss.qualcomm.com, karol.wachowski@linux.intel.com, kuba@kernel.org, 
 lizhi.hou@amd.com, netdev@vger.kernel.org, ogabbay@kernel.org, 
 raag.jadav@intel.com, riana.tauro@intel.com, rodrigo.vivi@intel.com, 
 simona.vetter@ffwll.ch, troy.hanson@oss.qualcomm.com, 
 youssef.abdulrahman@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
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

syzbot ci has tested the following series

[v1] Extend drm_ras for qaic telemetry
https://lore.kernel.org/all/20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com
* [PATCH 1/3] drm/drm_ras: Remove admin-perm flag from list-nodes operation
* [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
* [PATCH 3/3] accel/qaic: Add callbacks for DRM RAS netlink telemetry

and found the following issue:
general protection fault in drm_ras_nl_pre_telemetry

Full report is available here:
https://ci.syzbot.org/series/6915fb7c-08cd-48b4-b8a4-3834f3e60de5

***

general protection fault in drm_ras_nl_pre_telemetry

tree:      drm-next
URL:       https://gitlab.freedesktop.org/drm/kernel.git
base:      f2bf20011b95401f63e573d54134544c452c4117
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/d48f7944-a0fb-4983-a3c6-c037c81dd832/config
syz repro: https://ci.syzbot.org/findings/c2ca90ba-3f79-4e56-94d4-b1ddc64056e5/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5808 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:nla_get_u32 include/net/netlink.h:1734 [inline]
RIP: 0010:drm_ras_nl_pre_telemetry+0x60/0xe0 drivers/gpu/drm/drm_ras.c:656
Code: 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 3e 3c 9a fc 48 8b 1b 48 83 c3 04 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 5b 8b 33 48 c7 c7 80 d3 6f 90 e8 c9 8c 49
RSP: 0018:ffffc9000379f420 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000004 RCX: ffff8881bf17bc00
RDX: 0000000000000000 RSI: ffff8881bf38d380 RDI: ffffc9000379f600
RBP: ffffc9000379f588 R08: ffffc9000379f4ff R09: 0000000000000000
R10: ffffc9000379f4d0 R11: ffffffff859eb380 R12: ffffc9000379f600
R13: dffffc0000000000 R14: ffff8881bf38d380 R15: dffffc0000000000
FS:  00007f2c256e36c0(0000) GS:ffff8882a7cb6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000100 CR3: 000000016e7ee000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 genl_family_rcv_msg_doit+0x1db/0x340 net/netlink/genetlink.c:1109
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c2479e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c256e3028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2c24a25fa0 RCX: 00007f2c2479e1d9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007f2c24835888 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2c24a26038 R14: 00007f2c24a25fa0 R15: 00007ffc88247b58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nla_get_u32 include/net/netlink.h:1734 [inline]
RIP: 0010:drm_ras_nl_pre_telemetry+0x60/0xe0 drivers/gpu/drm/drm_ras.c:656
Code: 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 3e 3c 9a fc 48 8b 1b 48 83 c3 04 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 5b 8b 33 48 c7 c7 80 d3 6f 90 e8 c9 8c 49
RSP: 0018:ffffc9000379f420 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000004 RCX: ffff8881bf17bc00
RDX: 0000000000000000 RSI: ffff8881bf38d380 RDI: ffffc9000379f600
RBP: ffffc9000379f588 R08: ffffc9000379f4ff R09: 0000000000000000
R10: ffffc9000379f4d0 R11: ffffffff859eb380 R12: ffffc9000379f600
R13: dffffc0000000000 R14: ffff8881bf38d380 R15: dffffc0000000000
FS:  00007f2c256e36c0(0000) GS:ffff8882a7cb6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c247eb8c0 CR3: 000000016e7ee000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	8b 1b                	mov    (%rbx),%ebx
   2:	48 83 c3 08          	add    $0x8,%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 3e 3c 9a fc       	call   0xfc9a3c5a
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 04          	add    $0x4,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 5b                	jne    0x8e
  33:	8b 33                	mov    (%rbx),%esi
  35:	48 c7 c7 80 d3 6f 90 	mov    $0xffffffff906fd380,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	c9                   	leave
  3e:	8c                   	.byte 0x8c
  3f:	49                   	rex.WB


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
