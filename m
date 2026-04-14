Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAFEF9D0D6
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E1E89E2A;
	Tue, 14 Apr 2026 15:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QG1W//EF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D2789E2A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uCpVefvv5ROP1tgitV0gkmnvwqRDrAl+dZVonDpY3E4=; b=QG1W//EFKWTBHZKufrnx1780WU
 vSHCCSlWfHKTYMu4GxbKaBSYtiG1wUGMEBqTugC/YdBSqnfXshcvbcBWdpFlqV6eLjGlo24Py0j3w
 77duXuQVHC0x9MkvZqNo+lxy8VaV2NN55q+15zQ0jYknMl2/p9GLrsOv1IE22p/qiGM96tPp6Y5OL
 iR/csl0bzTJRC79vbqrgYCU3b0V4JZGesarX+TtvB1Kxl+0a1s9NEp/RLWy6n/2mcQph1pSv0UzTJ
 IptPQnpWCOMR50HqI3SdBnulxG4LjYv/Z6pC7LUr7mmW3ZCc3PQTKJO0R0NcYRlUiYhPtWvVlPYNg
 FqTV8hJA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCg14-00FxmF-K3; Tue, 14 Apr 2026 17:49:30 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 1/2] dma-fence: Silence sparse warning in dma_fence_describe
Date: Tue, 14 Apr 2026 16:49:27 +0100
Message-ID: <20260414154928.32934-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
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

Sparse complains about assigning a string to a __rcu annotated local
variable:

drivers/dma-buf/dma-fence.c:1040:38: warning: incorrect type in initializer (different address spaces)
drivers/dma-buf/dma-fence.c:1040:38:    expected char const [noderef] __rcu *timeline
drivers/dma-buf/dma-fence.c:1040:38:    got char *
drivers/dma-buf/dma-fence.c:1041:36: warning: incorrect type in initializer (different address spaces)
drivers/dma-buf/dma-fence.c:1041:36:    expected char const [noderef] __rcu *driver
drivers/dma-buf/dma-fence.c:1041:36:    got char *

It is harmless but lets silence it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: ac364014fd81 ("dma-buf: cleanup dma_fence_describe v3")
Cc: Christian König <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1826ba73094c..a2aa82f4eedd 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1037,8 +1037,8 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
  */
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 {
-	const char __rcu *timeline = "";
-	const char __rcu *driver = "";
+	const char __rcu *timeline = (const char __rcu *)"";
+	const char __rcu *driver = (const char __rcu *)"";
 	const char *signaled = "";
 
 	rcu_read_lock();
-- 
2.52.0

