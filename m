Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC869EA719B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F196710E197;
	Sun, 19 Apr 2026 13:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Qgk9gHJz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5ED910E197
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CLJsyouNMejv17zbbnbx5olGhCMXQM3w350Ea2kQLNk=; b=Qgk9gHJz07/X5zIwqfXvQfpPG+
 mJJVQyYm1mIdUo7081Z2ONiSyB+s8LUcFFQNnowpX2jz5/30mdPFMCFNiuky4eAzZfVhSX/c/Vzu/
 Ahm92XqpZM49bhMrEzf6rCYX4u72E42BxWYUIbY3ZhJ0FGY5s0n5gNGyLqzsx6dhZMbiCJIkSfV/S
 xT+nXkrCmZ+vwbKWGtj3YMXd36YYxlHoQ4KNFz9JgVfDEPqqkUbJO9YZrOe8Buq2F8OXGXvuvYH4z
 DrXalxVBJkaSsKqVsLaDgc1mGgSCy8UCXATNqhyEVAKhVnpj1gzohXhg5ZWi2PhI4HiFtH2LLW7iq
 SsbtHpcA==;
Received: from [187.36.208.231] (helo=localhost.localdomain)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim) id 1wESXH-000bE6-7V; Sun, 19 Apr 2026 15:50:07 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com, =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
Date: Sun, 19 Apr 2026 10:48:58 -0300
Message-ID: <20260419134943.54833-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.53.0
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

What a shared lock actually provides is serialization of signaling and
observation across fences in a given context, so that observers never
see a later fence signaled while an earlier one is not.

Reword both comments to describe this more accurately.

Signed-off-by: Maíra Canal <mcanal@igalia.com>

---

v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mcanal@igalia.com/

- Be more explicit about not allowing new users to use an external lock.
- De-duplicate the explanation in dma_fence_init64() by pointing to the
  dma_fence_init() documentation.
---
 drivers/dma-buf/dma-fence.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1c1eaecaf1b0..63b349ba9a34 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
  * context and seqno are used for easy comparison between fences, allowing
  * to check which fence is later by simply using dma_fence_later().
  *
- * It is strongly discouraged to provide an external lock because this couples
- * lock and fence life time. This is only allowed for legacy use cases when
- * multiple fences need to be prevented from signaling out of order.
+ * External locks are a relic from legacy use cases that needed a shared lock
+ * to serialize signaling and observation of fences within a context, so that
+ * observers never see a later fence signaled while an earlier one isn't. New
+ * users MUST NOT use external locks, as they force the issuer to outlive all
+ * fences that reference the lock.
  */
 void
 dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
@@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
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
2.53.0

