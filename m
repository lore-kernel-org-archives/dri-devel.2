Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC7CDE007
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B24210ECF0;
	Tue, 23 Jun 2026 22:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wxd8BvNP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4ACC10E197;
 Tue, 23 Jun 2026 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lm/Bb7nmtHczumcSk0tMl4LTf8dsHLkA9TM4MwYFy/U=;
 b=Wxd8BvNPzeHzupcJwZcHmwsv0ePtKAOS26cQkVwaPOYiCMPBga+YMIC5
 4nS5+CYzFwziosV9vEF6Sv91kIAPIa2TVZeGcRWr5wWkbvzon+CcvLDFR
 6+Ek78QZd8A9MrrQJrgqtbS1QSMt4/8yn1PK+U8PBEPOKmIksWZ74P2gF
 87cZSQgweo8q/XtoRR9RQCmnlQKdd348DbVVBBDujGfTg3q8hXJ0kTLjx
 mcRTZ7qbtzi60f5z7qhzyq5zphF6nWwikH+y+qu7i7E6S6maheN2mbfBh
 TFLDTE0uQc3Bgh8+h89bDuKLy8LT1VP9MA6yxeu56cD90YEMtmsAfJchE w==;
X-CSE-ConnectionGUID: dylhNwL0TwCol65ZOKcVug==
X-CSE-MsgGUID: LdKqsixuTJKEhQQySLKk9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048821"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048821"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: 9lLdUeDcSuinxVHCjoZDfw==
X-CSE-MsgGUID: MsTnkqbZTC6fSreJDakbqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335801"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 02/12] drm/ttm: Record sub-optimal page order allocations
 in ttm_tt
Date: Tue, 23 Jun 2026 15:27:22 -0700
Message-Id: <20260623222732.360872-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623222732.360872-1-matthew.brost@intel.com>
References: <20260623222732.360872-1-matthew.brost@intel.com>
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

When __ttm_pool_alloc() fails to allocate a chunk at the device's
beneficial order and falls back to a smaller order, the object ends up
backed by a sub-optimal set of pages. Nothing currently records this, so
a driver has no way to know an object would benefit from being re-backed
with beneficial-order pages later.

Add a bool beneficial_order_failed to struct ttm_tt, initialised to
false in ttm_tt_init_fields() and reset at the start of each fresh
ttm_pool_alloc(). Set it in __ttm_pool_alloc() when an allocation at
exactly the beneficial order fails before dropping to a lower order.

Drivers can use this hint to queue the buffer object for later
defragmentation.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +++++++++++
 drivers/gpu/drm/ttm/ttm_tt.c   |  1 +
 include/drm/ttm/ttm_tt.h       |  8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 5b95f8f938f7..a1a74ccfcbf0 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -773,6 +773,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			    struct ttm_pool_alloc_state *alloc,
 			    struct ttm_pool_tt_restore *restore)
 {
+	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
 	enum ttm_caching page_caching;
 	gfp_t gfp_flags = GFP_USER;
 	pgoff_t caching_divide;
@@ -823,6 +824,15 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		/* If that fails, lower the order if possible and retry. */
 		if (!p) {
 			if (order) {
+				/*
+				 * Failing to allocate at the device's beneficial
+				 * order means we are about to back this object
+				 * with a sub-optimal (smaller order) set of
+				 * pages. Record it so the driver can later try to
+				 * defragment the object back to beneficial order.
+				 */
+				if (beneficial_order && order == beneficial_order)
+					tt->beneficial_order_failed = true;
 				--order;
 				page_caching = tt->caching;
 				allow_pools = true;
@@ -887,6 +897,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
+	tt->beneficial_order_failed = false;
 	ttm_pool_alloc_state_init(tt, &alloc);
 
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index b645a1818184..27e09a58cf03 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -164,6 +164,7 @@ static void ttm_tt_init_fields(struct ttm_tt *ttm,
 	ttm->caching = caching;
 	ttm->restore = NULL;
 	ttm->backup = NULL;
+	ttm->beneficial_order_failed = false;
 }
 
 int ttm_tt_init(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 406437ad674b..55202362987a 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -126,6 +126,14 @@ struct ttm_tt {
 	enum ttm_caching caching;
 	/** @restore: Partial restoration from backup state. TTM private */
 	struct ttm_pool_tt_restore *restore;
+	/**
+	 * @beneficial_order_failed: Set by the TTM pool allocator when at least
+	 * one chunk that could have been allocated at the pool's beneficial
+	 * order had to fall back to a smaller order. This indicates that a
+	 * sub-optimal set of pages was chosen for this object, and can be used
+	 * by drivers to queue the buffer object for later defragmentation.
+	 */
+	bool beneficial_order_failed;
 };
 
 /**
-- 
2.34.1

