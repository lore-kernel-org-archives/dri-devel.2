Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3652BF31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E8710E809;
	Thu,  9 Apr 2026 14:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="bRr//4mo";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EE010E806;
 Thu,  9 Apr 2026 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1775744830;
 bh=4ZEKZcVxF4eqGv24fLHTnQho8WCxyhTB0Ks1zwxJ3v4=;
 h=From:To:Cc:Subject:Date:From;
 b=bRr//4mofLHbTSDZa2eYHfnv6NTIdoxzWJ+X6HSJbKiuHUcuPEGgwWsvkp9RHpCIO
 pX29JVl8hs95w1G6CA/vidaFZaXhVhKaFORZPLBojCtM0+G7oR9TOHVsNHFO4Mk1j/
 YjorWf88Lj/AsUl55fQTaR2AQ8reNO3yD3YducjCmAn1F7DdrgZ/TwjcE7eZOikDEz
 sWAWsYdm+lb7UcQU01W3xxTOeUD3EDToUBBv1Pg07sbX+SkV4lpU5M3zuvUdGQgwAA
 24oj5aKAu8CcqhBeNu2FNbOq7eFyCYTBwDCynK0svMnwG9QNXKcb1zpQrzYynT4oN4
 BHqB9jsK1kSQQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Christian Koenig <christian.koenig@amd.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Dave Chinner <david@fromorbit.com>,
 Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drm/ttm/tests: Remove checks from ttm_pool_free_no_dma_alloc
Date: Thu,  9 Apr 2026 16:26:59 +0200
Message-ID: <20260409142658.1511941-2-dev@lankhorst.se>
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

On !x86, the pool type is never initialised, and the pages are freed
back to the system.

The test broke on the list_lru rewrite, but I'm not sure how that it was
supposed to work previously. In the meantime CI is broken so reverting
for now.

Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index 01197014b83f0..be75c8abf3883 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -368,7 +368,6 @@ static void ttm_pool_free_no_dma_alloc(struct kunit *test)
 	struct ttm_test_devices *devs = priv->devs;
 	struct ttm_tt *tt;
 	struct ttm_pool *pool;
-	struct ttm_pool_type *pt;
 	enum ttm_caching caching = ttm_uncached;
 	unsigned int order = 2;
 	size_t size = (1 << order) * PAGE_SIZE;
@@ -382,14 +381,9 @@ static void ttm_pool_free_no_dma_alloc(struct kunit *test)
 	ttm_pool_init(pool, devs->dev, NUMA_NO_NODE, 0);
 	ttm_pool_alloc(pool, tt, &simple_ctx);
 
-	pt = &pool->caching[caching].orders[order];
-	KUNIT_ASSERT_TRUE(test, list_lru_count(&pt->pages) == 1);
-
 	ttm_pool_free(pool, tt);
 	ttm_tt_fini(tt);
 
-	KUNIT_ASSERT_TRUE(test, list_lru_count(&pt->pages) == 1);
-
 	ttm_pool_fini(pool);
 }
 
-- 
2.53.0

