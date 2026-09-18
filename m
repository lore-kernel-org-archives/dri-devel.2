Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7FCC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1486510E3CD;
	Mon, 21 Sep 2026 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CdjGmd4c";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0142610E2FC
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:19:55 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so181436a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789719595; x=1790324395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jVdvgZ3mBIXnAi5+B7rUQd/+WHdfPalGGkadsUCWlhs=;
 b=CdjGmd4cp+ySmCaI7vzKghdlnfS7IY0yUyN8Kd8PAFAtkdNMGMJmt5Xbhtdzw2BmEt
 TJT5266klkn+pbOx3u4LvFwyjbq3fUUbqagwhVG7hVVVC1jHJq/hvD9/GgPapzO4dRXB
 82QgUZ1ud0rqsWSd+QBS8/WGFfzK4aYHl6Q99/SqjPl4gfvXnLARKp8MivzvaHk8ctjG
 PQ2jKXszKGKf59fgr385N+iJoOaZfjiyrMosJJ0mcjd0vNFMFFtd11LBp1vz2V/vXGeg
 lIzbOkVbm3r2UhpK4LBcEqFVwniEkD0qiEtDEX2oRW3bxg4j+YjhYdeZOJKJQvvQlFIw
 Z4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789719595; x=1790324395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jVdvgZ3mBIXnAi5+B7rUQd/+WHdfPalGGkadsUCWlhs=;
 b=OA4CW8/xQa7gAcvHNSS++GZaNoRHzjUcUmAVDmV15XsNyuhIKVuZYG/OynbuJruWiS
 ChXbq4G9xKuvzA+eYoX/nA0HMbdRBVBJtTmElfCTq9eNTxOlJyQzRA8VdSPbZEfo0eF3
 9VGk0KsLse4pUnhFRR+1MmgetpyufwogeTLnTGMEaQENhy0c2jB+G7jY9EWvJKR9TW6x
 qTWkREwzFGE4WjVR0VCcrdMKcdCyn37nM4V0a2Ke8qxMSh72gINQ+MX0eNEIXWXEXY9u
 ho7TJLQOuYxzEb9HKkAdlT/Vjg1YsmxHFJIlK+mklA2RJKb4OFO5+fCHQIWKeqYYIZbR
 Quag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzE7Y8vjy0risdSJ7Z9AJEOE5Nb9gbjk9DfIrzGgVv+OMK9yxhgIGufciVqVVzpbalsU6TPsPush0U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCJy0GSc9elaUEeYn44/3J9E4yeEL3sH0P2KqOE+55E4Z8bq1N
 O79z9161yktz3d3Br4ZYS+YI5kpi45UgLNiZJXgL6UbvQlhQuKnT6jBW
X-Gm-Gg: AYBFou0TNNmUggTPEJu+/wZpvajjnKr1PCRcCoOrN0TQ5nL2jMiPI+DQ+Sqy6Sjd+Y3
 8BiqZNsl4lPAarMzOK4N2lsx5g6+zFnC69lmKKjeXXC1B4WL9t8hlnMpzHbU8vjYf5rA3sbVWx/
 5avLCYOFV5AF0b8unKwQBBuUovyr9vSedXN/kMe7FuIUTupbOwXeGLNyABZ3VmCCL1Kl1M+fO7E
 lNRbaxOCuCRv+YG6XAS6vYMpGUCFouH8Ul6+148fHkkPoBapJhHm6ORFtNigpZyVRm6msKL84eb
 uKYwsyL5xTxNXHomO02Doad16Vz5QiVjc+/WB98RpqmPvrfmVT2m+y0p+d+LHAUxhLj6vkVTpS0
 iP4lO+Eyo5t+zvvZEKbOGVcupGbDDwzffsU7yiOpbx4VpK86cst9RGj3JPkrTaq0l5wWjSVnWZW
 134n0p4QB6fxnZ0JiL7rFcf4yAm5tAiqn3H85car8ucHpgGfaikkWpYpM5tHFw8/2QI3LJd8+2g
 G/NF1GXYA==
X-Received: by 2002:a17:90b:2f50:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-39e54e3c71emr7234090a91.9.1789719595407; 
 Fri, 18 Sep 2026 01:19:55 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144ce065314sm2947550c88.14.2026.09.18.01.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:19:55 -0700 (PDT)
From: Priyanka Mani <priyankamani2100@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org,
 syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com,
 Priyanka Mani <priyankamani2100@gmail.com>
Subject: [PATCH] dma-buf/udmabuf: don't warn on oversized allocation requests
Date: Fri, 18 Sep 2026 08:19:17 +0000
Message-ID: <0a3814afb3419bb1106cf0ff1734a6b7a85f9335.1789707887.git.priyankamani2100@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

udmabuf_create() derives the number of pages to allocate directly from
the size supplied by userspace, bounded only by the size_limit_mb module
parameter. Since commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size
limit by default") that parameter defaults to INT_MAX, which puts the
page count limit at roughly 5.5e11 pages, i.e. no limit in practice.

init_udmabuf() then asks kvmalloc_objs() for pgcnt * sizeof(struct page *)
bytes. __kvmalloc_node_noprof() refuses any request larger than INT_MAX
and splats WARN_ON_ONCE(!(flags & __GFP_NOWARN)) on its way out, while
kvmalloc_objs() defaults to a plain GFP_KERNEL.

A single UDMABUF_CREATE against /dev/udmabuf with a sufficiently large
size is therefore all it takes to trigger:

  ------------[ cut here ]------------
  WARNING: mm/slub.c:7022 at __kvmalloc_node_noprof+0x412/0x5a0
  Call Trace:
   udmabuf_create+0x11f/0x540
   udmabuf_ioctl+0xf1/0x190
   __x64_sys_ioctl+0x91/0xe0
   do_syscall_64+0xdd/0x4a0

The size is entirely userspace-controlled and allocation failure is
already handled by returning -ENOMEM to the caller, so this is not a
condition the kernel needs to complain about. Pass __GFP_NOWARN and let
the existing error path do its job.

Note that capping the limit instead would change the error reported to
userspace from -ENOMEM to -EINVAL and would reintroduce a fixed ceiling
that the above commit deliberately removed, so __GFP_NOWARN seems the
more faithful fix.

Reported-by: syzbot+bfeed181d1ce9ec87a8f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bfeed181d1ce9ec87a8f
Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
Signed-off-by: Priyanka Mani <priyankamani2100@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd0046242..127369e502a3 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -190,11 +190,13 @@ static void unpin_all_folios(struct udmabuf *ubuf)
 
 static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 {
-	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt);
+	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt,
+				    GFP_KERNEL | __GFP_NOWARN);
 	if (!ubuf->pages)
 		return -ENOMEM;
 
-	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt);
+	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt,
+					    GFP_KERNEL | __GFP_NOWARN);
 	if (!ubuf->pinned_folios)
 		return -ENOMEM;
 
-- 
2.43.0

