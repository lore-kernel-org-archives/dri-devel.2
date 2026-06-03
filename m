Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11545CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D4F10E1EC;
	Wed,  3 Jun 2026 15:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mV/c52Rg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F4D10E1EC
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:05:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BED6601DF;
 Wed,  3 Jun 2026 15:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F701F00898;
 Wed,  3 Jun 2026 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780499137;
 bh=tuByf2Rdrqk1BQswNNwa7vT8xrcBSht8fdfuFOgxTbI=;
 h=From:To:Cc:Subject:Date;
 b=mV/c52RgW44mEfB9ZQbYRZOVN3+EjfTj+ds8kynO5rmAZJkqlugLFinWL+xUS7U9a
 iByrOZY7+pd5nOfxToImvO1Qpjt54Y5oo8Eao8lXnEISyH2n6szfU1Zq6nWUFZtwsW
 xB9qN9sdCpIR4nt7dTX3Ylk+2ujgzSHAJaS0ocfNVhJY0oYylF09p4R102wXTXJrMf
 1kabytbuJp/QONkClRo+37Zz1FubBw8aKIASOnDcWWuryDLUIm5u2wYu4eFtFf8TE4
 +saNvolpa1e4ihlCgVufJFbWa2XVdMVog2EZEAg0+riKSSYEgYCsJjTTJX90Meyj3f
 Jgg+4jeenxFYQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] dma-fence: Use dma_fence_set_error() internally
Date: Wed,  3 Jun 2026 17:05:32 +0200
Message-ID: <20260603150531.2217691-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

The dma_fence implementation sets a fence error in dma_fence_release()
manually.

Make the code a bit more readable by using the appropriate API function
for that.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Only compile-tested.
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c7ea1e75d38a..ae5550cda421 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -599,7 +599,7 @@ void dma_fence_release(struct kref *kref)
 		 * so that the callbacks know this signal is due to an error.
 		 */
 		dma_fence_lock_irqsave(fence, flags);
-		fence->error = -EDEADLK;
+		dma_fence_set_error(fence, -EDEADLK);
 		dma_fence_signal_locked(fence);
 		dma_fence_unlock_irqrestore(fence, flags);
 	}
-- 
2.54.0

