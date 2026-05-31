Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD94ACD5BD1
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 12:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2767112B2C;
	Sun, 31 May 2026 12:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MBi1BGY+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E808112B2C
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T19dATSGsOmgdG0JVLLDrc2KMsViQ9BcXruRIIyeRZ4=; b=MBi1BGY+47JMi27j3yCdDvUmiB
 5pJw9IwBBaH7KPa861CewrRW/WeXGX7Wpz71rimUU03gVAgEoaWHgG55aiw2nyjU6iCOyegstXxz/
 YAn6p1SyahYcCgpUnd11DzHVdi891FBwt7ra7elKPdygjQCpWng2LRYRLzVlUlAyJM46gBTY0HPcd
 H7zHXNzaKmH1uOR2jEzQn3t1+48WHl71tD6MqO9mz4gufpmynowpZ+0zIuWsyaABf4zPKPm4vhN00
 +jqy2UJLyMhDgNY3hrtVUN2KaQtgB2Whoq2ZWaTujVU2uD+CyIMrbaLdoA2Cfg0KlbXxsy1Xt9z/b
 XDfWyZHQ==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTfdV-00Aa0I-Cl; Sun, 31 May 2026 14:51:25 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com, =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v3] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
Date: Sun, 31 May 2026 09:49:59 -0300
Message-ID: <20260531125115.1136036-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
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

The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
the legacy reason to pass an external lock as a need to prevent multiple
fences "from signaling out of order". However, this wording is a bit
misleading: a shared spinlock does not (and cannot) prevent the signaler
from signaling out of order. Signaling order is the driver's responsibility
regardless of whether the lock is shared or per-fence.

Reword both comments to better describe the legacy use cases where a
shared lock was needed.

Signed-off-by: Maíra Canal <mcanal@igalia.com>

---

v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mcanal@igalia.com/

- Be more explicit about not allowing new users to use an external lock.
- De-duplicate the explanation in dma_fence_init64() by pointing to the
  dma_fence_init() documentation.

v2 -> v3: https://lore.kernel.org/dri-devel/20260419134943.54833-2-mcanal@igalia.com/T/

- Apply Christian's suggestion with small readability improvements.

---
 drivers/dma-buf/dma-fence.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index b3bfa6943a8e..c7ea1e75d38a 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1102,9 +1102,12 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
  * context and seqno are used for easy comparison between fences, allowing
  * to check which fence is later by simply using dma_fence_later().
  *
- * It is strongly discouraged to provide an external lock because this couples
- * lock and fence life time. This is only allowed for legacy use cases when
- * multiple fences need to be prevented from signaling out of order.
+ * External locks are a relic of legacy use cases that needed a shared lock
+ * to serialize signaling when no out-of-order signaling was possible through
+ * &dma_fence_ops.signaled. Drivers have abandoned this concept since the
+ * introduction of the callback, but the external lock is still around. New
+ * users MUST NOT use external locks, as they force the issuer to outlive all
+ * fences that reference the lock.
  */
 void
 dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
@@ -1129,9 +1132,8 @@ EXPORT_SYMBOL(dma_fence_init);
  * Context and seqno are used for easy comparison between fences, allowing
  * to check which fence is later by simply using dma_fence_later().
  *
- * It is strongly discouraged to provide an external lock because this couples
- * lock and fence life time. This is only allowed for legacy use cases when
- * multiple fences need to be prevented from signaling out of order.
+ * New users MUST NOT use external locks. Check the documentation in
+ * dma_fence_init() to understand the motives behind the legacy use cases.
  */
 void
 dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
-- 
2.54.0

