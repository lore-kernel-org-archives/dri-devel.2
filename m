Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2A0C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55DE10E603;
	Mon, 31 Aug 2026 06:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cxdnQ0Yr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABE010E5FD
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788156181; x=1819692181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q2t0FBL9S4JY3n1XwGQnh0xJ68/B9/WZMu0WCg3y2/Q=;
 b=cxdnQ0YrIw/P4h1WipS7IF7G0qRjTbtNsGGIomON0HIjwGugVaCxpN/o
 v3WYyXBVDeEQRco9L9vd9WEehhAYddhQUtEvR7ndqwxzwBX3HM2jHwfwn
 U3DZ6efvOM/PJ9lLG/dYKW2cY3BGeXOdotTwxFsqxcily8yR82Jj8SVCB
 nAPRB5y+L/Q17X+Qg571KjqbqiS/vUxrhtPqwhdQ2jNeGcBCHfSNjwhIq
 0VwaM5BdL2NAD61Z4NdxqP352cE9ykHst2txPYSHBuZqsoMvdPXSKSvQZ
 n1vq/xIW5CML8n+35uojgF+bWcFy+vmSs5OOd5njBoS7xDA8WFt7au9CS w==;
X-CSE-ConnectionGUID: TrvMiuBbT3G0V/qZVsmU+w==
X-CSE-MsgGUID: m7gQxsHCT/uGfunwUc+Tcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88677636"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88677636"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:03:00 -0700
X-CSE-ConnectionGUID: qe95+LQGRBmP09osl9K85w==
X-CSE-MsgGUID: 3Oi93ck2QhyluI25rWA1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="265467735"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:02:59 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf pages/folios
Date: Sun, 30 Aug 2026 23:00:31 -0700
Message-ID: <20260831060210.1713177-3-vivek.kasireddy@intel.com>
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

Since udmabuf allows users to pin pages in memory, which is a vital
resource, we need to ensure that unprivileged users cannot abuse
this feature to exhaust system memory. To address this, introduce
mlock accounting for udmabuf pages/folios. This change ensures that
the number of pages/folios pinned by udmabuf is tracked and limited
based on the user's mlock limits.

If an unprivileged user/process exceeds their mlock limit, no pages
are pinned and EPERM is returned to the user. Note that, privileged
users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
allowing them to pin pages without any restriction.

Earlier, there was a 64 MB default limit on the size of udmabuf
allocations, but it was removed in commit 44e9eb5a7621
("dma-buf/udmabuf: Disable the size limit by default") which left
open the possibility that unpriviledged users could pin unbounded
amount of memory. This change makes the limit dynamic, by invoking
user_shm_lock() to check the mlock limit for unprivileged users.

Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Robert Mader <robert.mader@collabora.com>
Cc: Xaver Hugl <xaver.hugl@kde.org>
Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
---
 drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 7c4339130eff..e78947f01656 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -203,9 +203,10 @@ static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 	return 0;
 }
 
-static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
+static __always_inline void deinit_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 {
 	unpin_all_folios(ubuf);
+	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
 	kvfree(ubuf->pages);
 }
 
@@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf *buf)
 	if (ubuf->sg)
 		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
 
-	deinit_udmabuf(ubuf);
+	deinit_udmabuf(ubuf, ubuf->pagecount);
 	kfree(ubuf);
 }
 
@@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice *device,
 	if (!pgcnt)
 		goto err_noinit;
 
+	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
+		pr_warn_once("%s: User not permitted to pin more than %lu KB "
+			     "of memory, either increase ulimits -l, or "
+			     "obtain CAP_IPC_LOCK capability\n", current->comm,
+			     rlimit(RLIMIT_MEMLOCK) >> 10);
+		ret = -EPERM;
+		goto err_noinit;
+	}
+
 	ret = init_udmabuf(ubuf, pgcnt);
 	if (ret)
 		goto err;
@@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice *device,
 	return ret;
 
 err:
-	deinit_udmabuf(ubuf);
+	deinit_udmabuf(ubuf, pgcnt);
 err_noinit:
 	kfree(ubuf);
 	kvfree(folios);
-- 
2.53.0

