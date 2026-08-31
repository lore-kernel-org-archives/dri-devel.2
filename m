Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19610C61DE8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2966210E5FD;
	Mon, 31 Aug 2026 06:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="avsNAXYY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F20710E5FD
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788156180; x=1819692180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=elDOBsWMxf4fGrhfANpbUh9SxtqQTI60hJLdFDR6D88=;
 b=avsNAXYYjAoIWhAEyHvOk9lc588782M4kag7H+MQOU2mr4dW5jZM0rrX
 sLK1M8F9SAP0CW87IjyA2Z9frKlxvEQvLbVpiNL27vt9OElEftDKhJWgk
 y/JcfCwImdoB7iSyQAASLUmtTnZJTc+JVnw92L5EarMYyz/2h5eGVRfyZ
 38HzErUAsM9nUPj7prhCigf3iPTzAUJ4hMA4554xVeodRMk3FnHJ6IozL
 VnvttzRMdRjWR+/mhcslSy5wTreUqDzoCyIy1+tjhmx3XsKVPzlcfb9il
 9s69u+6F7IvWA6d1iNSDQ+FgEyngzDHbSJS9ujg7cQUIGl7MnSqvIpzbm w==;
X-CSE-ConnectionGUID: r4nuWTFdQw+hzkpqDnnu/g==
X-CSE-MsgGUID: oDYvPgLgTWmAXF5QG6hTmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88677631"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88677631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:03:00 -0700
X-CSE-ConnectionGUID: 20sCiIFBTZmJ+TkDz9Wshw==
X-CSE-MsgGUID: T2c+xq2eTbeiDf/rW74Jgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="265467732"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:02:59 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH v1 1/2] udmabuf: Do not warn when pages/folios array
 allocation fails
Date: Sun, 30 Aug 2026 23:00:30 -0700
Message-ID: <20260831060210.1713177-2-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When the user is trying to create an extremely large udmabuf, the
allocation of pages/folios arrays may fail. In that case, there is
no need to print any warning trace in the log because such a trace,
although expected, could be considered as evidence of a serious
problem by some users or tools/fuzzers.

This warning trace started showing up after commit 44e9eb5a7621
("dma-buf/udmabuf: Disable the size limit by default") was merged
as this commit changed the maximum size limit for udmabuf to be
INT_MAX by default instead of 64 MB. So, fix this issue by passing
in __GFP_NOWARN flag when allocating pages/folios arrays.

Syzbot was the first to report this issue by triggering the following
warning trace:
	!(flags & __GFP_NOWARN)
	WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x646/0x9b0
	mm/slub.c:7013, CPU#2: syz.0.17/5920
	Modules linked in:
	CPU: 2 UID: 0 PID: 5920 Comm: syz.0.17 Not tainted syzkaller #0
	PREEMPT(full)
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
	1.16.3-debian-1.16.3-2 04/01/2014
	RIP: 0010:__kvmalloc_node_noprof+0x646/0x9b0 mm/slub.c:7013
	Code: c1 e8 2e 07 ff ff 4d 85 f6 0f 85 b6 fd ff ff 48 81 fb ff
	ff ff 7f 0f 86 4d fd ff ff 41 81 e4 00 20 00 00 0f 85 9c fd ff
	ff 90 <0f> 0b 90 e9 93 fd ff ff 41 be 10 00 00 00 e9 88 fd ff ff
	be 42 01
	RSP: 0018:ffffc90003d8fb50 EFLAGS: 00010246
	RAX: 0000000000000001 RBX: 0000008000800018 RCX:
	0000010000000000
	RDX: 0000000000000000 RSI: ffffffff8c61e200 RDI:
	ffffffff8e6ad930
	RBP: 0000000008000800 R08: 00000000000028c0 R09:
	00000000ffffffff
	R10: 0000000000000001 R11: 0000000000000000 R12:
	0000000000000000
	R13: 00000000000028c0 R14: 0000000000000000 R15:
	00000000ffffffff
	FS:  0000000000000000(0000) GS:ffff888096b76000(0063)
	knlGS:00000000579e1480
	CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
	CR2: 00000000f7113140 CR3: 00000000542cb000 CR4:
	0000000000352ef0
	Call Trace:
	 <TASK>
	  init_udmabuf drivers/dma-buf/udmabuf.c:193 [inline]
	  udmabuf_create+0x2e8/0x12a0 drivers/dma-buf/udmabuf.c:386
	  udmabuf_ioctl_create_list drivers/dma-buf/udmabuf.c:484
	  [inline]
	  udmabuf_ioctl+0x2b2/0x300 drivers/dma-buf/udmabuf.c:499
	  __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
	  __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
	  __ia32_compat_sys_ioctl+0x2cf/0x360 fs/ioctl.c:638
	  do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79
	  [inline]
	  __do_fast_syscall_32+0x13a/0x8b0
	  arch/x86/entry/syscall_32.c:291
	  do_fast_syscall_32+0x32/0x70
	  arch/x86/entry/syscall_32.c:316
	  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
	  RIP: 0023:0xf7f03fec
	  Code: Unable to access opcode bytes at 0xf7f03fc2.
	  RSP: 002b:00000000ffe2d40c EFLAGS: 00000292
	  ORIG_RAX: 0000000000000036
	  RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
	  0000000040087543
	  RDX: 0000000080000100 RSI: 0000000000000000 RDI:
	  0000000000000000
	  RBP: 0000000000000000 R08: 0000000000000000 R09:
	  0000000000000000
	  R10: 0000000000000000 R11: 0000000000000246 R12:
	  0000000000000000
	  R13: 0000000000000000 R14: 0000000000000000 R15:
	  0000000000000000
	 </TASK>

Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reported-by: syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Robert Mader <robert.mader@collabora.com>
Cc: Xaver Hugl <xaver.hugl@kde.org>
Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
---
 drivers/dma-buf/udmabuf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 4a9ab5822ffc..7c4339130eff 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -190,11 +190,13 @@ static void unpin_all_folios(struct udmabuf *ubuf)
 
 static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 {
-	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt);
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
+
+	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt, gfp);
 	if (!ubuf->pages)
 		return -ENOMEM;
 
-	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt);
+	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt, gfp);
 	if (!ubuf->pinned_folios)
 		return -ENOMEM;
 
-- 
2.53.0

