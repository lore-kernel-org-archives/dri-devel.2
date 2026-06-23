Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6130ECD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C6910EA4F;
	Tue, 23 Jun 2026 13:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="igm0Ou51";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5001E10EA4F
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:35:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C85A601F5;
 Tue, 23 Jun 2026 13:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782B21F000E9;
 Tue, 23 Jun 2026 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782221716;
 bh=e2L7pUS6THPTgQRuS5kLnP/Z6QEsPEFFQSf/IKODmiY=;
 h=From:To:Cc:Subject:Date;
 b=igm0Ou51B3RVhCU9xzhsZ5mrxW98fjLsXtdFu+r9tuLhjwEZ5VwdM89Wl5zQZ5vac
 HUvyFmAMlXJDcE0O18a2AqyN8gNcWhrdHGyhQ60FJaySzU07fc5H61gblDiv6KknFs
 dSefAkLlHxcVnk3PDugrBif9JD4UenmnkzPiK/5EHeZPTOUZE9tSGj4m1x70OrBbMH
 fvim/X7C81iYRSy4n2XVoBKO0f7miRX3pT6HO/fsq9ENh1Tv7org/glyjO/osvMC/E
 rwXsj/BPzwLP+sLRV7RrQE40urz+n7KfB2o6KgYxkt5Jw03IW9WTY5FdGA7RGNYXyF
 dnJB/E0yZTPSw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igallia.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] dma-buf/dma-fence: Set better string for
 dma_fence_driver_name()
Date: Tue, 23 Jun 2026 15:34:58 +0200
Message-ID: <20260623133457.1029880-2-phasta@kernel.org>
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

dma_fence_driver_name() reports that a driver whose fence is already
signaled is a "detached-driver". This is incorrect, the driver might
still be loaded and running.

Rename that string to something more descriptive.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Just compile-tested.
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index c7ea1e75d38a..9c3dfa7b0066 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1173,7 +1173,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 	if (!dma_fence_test_signaled_flag(fence))
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else
-		return (const char __rcu *)"detached-driver";
+		return (const char __rcu *)"driver-whose-fence-is-signaled";
 }
 EXPORT_SYMBOL(dma_fence_driver_name);
 
-- 
2.54.0

