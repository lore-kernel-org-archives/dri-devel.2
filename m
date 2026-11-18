Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8840606A338
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egqQAmIn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0573910FD7A;
	Wed, 18 Nov 2026 14:52:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613D410FD56
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:51:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B9B161B5C;
 Wed, 18 Nov 2026 14:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4631E1F000C8;
 Wed, 18 Nov 2026 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795013481;
 bh=XNfcKxtjE3WyApHOpNrRRQwr1Y2c1MZAzNhEcwdN+qo=;
 h=From:To:Cc:Subject:Date;
 b=egqQAmIn0hLtgYrwMl0jV2JGZCG0rFiJWz6fvECPwSIcn4tcBeyTKI76TjVPgyAht
 YYAh7T5iXLt+6vdhHgukEblEmUisyPuBYv6+bhDJMynhpk6D8DtpHXVWSRffsh31SA
 4DD4DLCuxgDNo1C9U5JO9J/59+CnZ3KKuCKnJi4NIMUf0xb3uwNt40qWoE9us/vMh4
 irG9ZVyMKmlB9zPT6YLp2MU6g9pO45HxgkUkNvgrBZ5ZI/QWXRqRenGXIpVx8Ow9Ww
 tSvmYXAmXkyO4wrkK/EdetTZpDqBGGuhMpZqy1uPWePuWVKQ28T+oqR6csmvlMvLO3
 kiswOlWCnbx3g==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf/dma-fence: Remove dma_fence_later()
Date: Wed, 18 Nov 2026 15:50:27 +0100
Message-ID: <20261118145026.1755441-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_fence_later() does not have any in-tree users anymore.
dma_fence_is_later() is available as an alternative.

Remove the surplus function.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
No idea why we have two such functions.

dma_fence_later() seems to be older, coming from a big-bang commit in
2014. Yet Christian added dma_fence_is_later() in 2015.

*shrug*
---
 drivers/dma-buf/dma-fence.c |  6 ------
 include/linux/dma-fence.h   | 26 --------------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..2f805b788f8f 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1099,9 +1099,6 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
  * refcount after committing with this fence, but it will need to hold a
  * refcount again if &dma_fence_ops.enable_signaling gets called.
  *
- * context and seqno are used for easy comparison between fences, allowing
- * to check which fence is later by simply using dma_fence_later().
- *
  * External locks are a relic of legacy use cases that needed a shared lock
  * to serialize signaling when no out-of-order signaling was possible through
  * &dma_fence_ops.signaled. Drivers have abandoned this concept since the
@@ -1129,9 +1126,6 @@ EXPORT_SYMBOL(dma_fence_init);
  * refcount after committing with this fence, but it will need to hold a
  * refcount again if &dma_fence_ops.enable_signaling gets called.
  *
- * Context and seqno are used for easy comparison between fences, allowing
- * to check which fence is later by simply using dma_fence_later().
- *
  * New users MUST NOT use external locks. Check the documentation in
  * dma_fence_init() to understand the motives behind the legacy use cases.
  */
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index a3fa1341765e..e11e65b916f1 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -633,32 +633,6 @@ static inline bool dma_fence_is_later_or_same(struct dma_fence *f1,
 	return f1 == f2 || dma_fence_is_later(f1, f2);
 }
 
-/**
- * dma_fence_later - return the chronologically later fence
- * @f1:	the first fence from the same context
- * @f2:	the second fence from the same context
- *
- * Returns NULL if both fences are signaled, otherwise the fence that would be
- * signaled last. Both fences must be from the same context, since a seqno is
- * not re-used across contexts.
- */
-static inline struct dma_fence *dma_fence_later(struct dma_fence *f1,
-						struct dma_fence *f2)
-{
-	if (WARN_ON(f1->context != f2->context))
-		return NULL;
-
-	/*
-	 * Can't check just DMA_FENCE_FLAG_SIGNALED_BIT here, it may never
-	 * have been set if enable_signaling wasn't called, and enabling that
-	 * here is overkill.
-	 */
-	if (dma_fence_is_later(f1, f2))
-		return dma_fence_is_signaled(f1) ? NULL : f1;
-	else
-		return dma_fence_is_signaled(f2) ? NULL : f2;
-}
-
 /**
  * dma_fence_get_status_locked - returns the status upon completion
  * @fence: the dma_fence to query
-- 
2.56.0

