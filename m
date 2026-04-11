Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E7FF3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 18:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7DE10E21A;
	Sat, 11 Apr 2026 18:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GcF/nW8I";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D058A10E234
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rfR/xs54iud7qjWeo87LTD8Cmitowf/vA43TFtPNilg=; b=GcF/nW8Ix57ePYZUjwiT2qGAqq
 FGUPSxXoVtUY5rS9XjVpwYPSLrqZPUJ9MNVaLrXFN17E8LU5EbUDj15csHk/Yio31BGQ54M6WhEoI
 oHSifD9t/euCsVP9dlDWCVV0s8jPhf+h9YNbdfiCitbX0gCylkfo98AB9lOqNUdZCtGbvshsnfZKr
 U7KRlZ54x3H5ovkkl6r8gbgmn8SpAF0vIeAxvCQpMK1fr5tXimTV2In2X77fepR5OzsFDziwU+Peg
 xuQTmdivHcdKxFSldAszUCJng3iIC9gArP2CeQfVAhGeBxyLigsNR9SSABdFV5PexBPL0Dxoi0Vgg
 OS3qOyKQ==;
Received: from [189.7.87.169] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wBdXV-00Epqg-1H; Sat, 11 Apr 2026 20:58:41 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com, =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] dma-fence: Clarify external lock use case in dma_fence_init()
 docs
Date: Sat, 11 Apr 2026 15:47:33 -0300
Message-ID: <20260411185756.1887119-4-mcanal@igalia.com>
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

Hi,

While reading the documentation, I found this particular paragraph quite
hard to understand. As I understand it, locks don't enforce order, only
serialization, but the paragraph seems to communicate the other way around.
Due to that, I had the impression that the current wording can be
misleading for driver developers.

I'm proposing a new wording to better describe the use case of the
external lock based on my understanding, but it would be great to hear
the feedback and suggestions from more experienced developers who might
have more insight about these legacy use cases.

Best regards,
- Maíra

 drivers/dma-buf/dma-fence.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1826ba73094c..bdc29d1c1b5c 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1102,8 +1102,10 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
  * to check which fence is later by simply using dma_fence_later().
  *
  * It is strongly discouraged to provide an external lock because this couples
- * lock and fence life time. This is only allowed for legacy use cases when
- * multiple fences need to be prevented from signaling out of order.
+ * lock and fence lifetime. This is only allowed for legacy use cases that need
+ * a shared lock to serialize signaling and observation of fences within a
+ * context, so that observers never see a later fence signaled while an earlier
+ * one isn't.
  */
 void
 dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
@@ -1129,8 +1131,10 @@ EXPORT_SYMBOL(dma_fence_init);
  * to check which fence is later by simply using dma_fence_later().
  *
  * It is strongly discouraged to provide an external lock because this couples
- * lock and fence life time. This is only allowed for legacy use cases when
- * multiple fences need to be prevented from signaling out of order.
+ * lock and fence lifetime. This is only allowed for legacy use cases that need
+ * a shared lock to serialize signaling and observation of fences within a
+ * context, so that observers never see a later fence signaled while an earlier
+ * one isn't.
  */
 void
 dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
-- 
2.53.0

