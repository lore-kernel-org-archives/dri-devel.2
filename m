Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3677C44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E464D10E2B5;
	Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OvwCqvPV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D4710E1DF;
 Sat, 11 Jul 2026 02:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738586; x=1815274586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NRgxd4keTsCNSDaoZahcQVxsW0LgasNOXFRDSj6e9tM=;
 b=OvwCqvPVW58G9M5FzKz50tYskKOA/igL7l4ce9nuewC7o0dpbCTBIc+I
 PrKtX8kIzOOkxQabPcys4Mf0h2M83QY3dvexCg6dee+5FPwlmLMoKyQFQ
 vn8mnCdFF+JEtFJcGdrkRDiG1Tp9lq8rRyT3VxwfBK83T4XtgEm0a4XeD
 B21+j8p9yiMaLhrKSaMKfI3jFPwFUzNl7GzQXviuPbjqlquitcY4euKoS
 q3ZenYLD3ocwonwyaLoMb+sc8bKLmKoNI9efAZ63hHxJkrbPCy4bhcR/h
 9ObT9RF/tsq2YJYOkLoHMH75uFVYfO9MwEhefrM5Yz5Q+gxV4/PJh0Bp5 A==;
X-CSE-ConnectionGUID: b5RRN+yPQYGMlcuiEtEtpg==
X-CSE-MsgGUID: fWYdAmR/S229yK+mTd0xKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986198"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986198"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:26 -0700
X-CSE-ConnectionGUID: oNKQEzNTTo+Vm1mv6fk/gQ==
X-CSE-MsgGUID: VEDNj6x3RA+4W9rf4Wvktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987682"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 03/33] drm/ttm: Record sub-optimal page order allocations
 in ttm_tt
Date: Fri, 10 Jul 2026 19:55:49 -0700
Message-Id: <20260711025619.2540575-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

Add TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED to struct ttm_tt page_flags,
cleared at the start of every fresh allocation (in both ttm_pool_alloc()
and ttm_pool_restore_and_alloc()). Set it in __ttm_pool_alloc() when an
allocation at exactly the beneficial order fails before dropping to a
lower order.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 13 +++++++++++++
 include/drm/ttm/ttm_tt.h       | 24 +++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 5b7d7f5ae53d..e9175c0290d7 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -796,6 +796,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			    struct ttm_pool_alloc_state *alloc,
 			    struct ttm_pool_tt_restore *restore)
 {
+	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
 	enum ttm_caching page_caching;
 	gfp_t gfp_flags = GFP_USER;
 	pgoff_t caching_divide;
@@ -846,6 +847,16 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
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
+					tt->page_flags |=
+						TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
 				--order;
 				page_caching = tt->caching;
 				allow_pools = true;
@@ -910,6 +921,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
 
+	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
 	ttm_pool_alloc_state_init(tt, &alloc);
 
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
@@ -942,6 +954,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (!restore) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 
+		tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
 		ttm_pool_alloc_state_init(tt, &alloc);
 		if (ctx->gfp_retry_mayfail)
 			gfp |= __GFP_RETRY_MAYFAIL;
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 406437ad674b..ce7533677d77 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -90,6 +90,14 @@ struct ttm_tt {
 	 * TTM_TT_FLAG_BACKED_UP: TTM internal only. This is set if the
 	 * struct ttm_tt has been (possibly partially) backed up.
 	 *
+	 * TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED: Set by the TTM pool allocator
+	 * when at least one chunk that could have been allocated at the pool's
+	 * beneficial order had to fall back to a smaller order. This indicates
+	 * that a sub-optimal set of pages was chosen for this object, and can
+	 * be used by drivers to queue the buffer object for later
+	 * defragmentation. Drivers should access this via the
+	 * ttm_tt_is_beneficial_order_failed() helper.
+	 *
 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
 	 * then unset when TTM calls ttm_tt_unpopulate().
@@ -101,8 +109,9 @@ struct ttm_tt {
 #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
 #define TTM_TT_FLAG_DECRYPTED		BIT(4)
 #define TTM_TT_FLAG_BACKED_UP	        BIT(5)
+#define TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED	BIT(6)
 
-#define TTM_TT_FLAG_PRIV_POPULATED	BIT(6)
+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(7)
 	uint32_t page_flags;
 	/** @num_pages: Number of pages in the page array. */
 	uint32_t num_pages;
@@ -179,6 +188,19 @@ static inline void ttm_tt_clear_backed_up(struct ttm_tt *tt)
 	tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
 }
 
+/**
+ * ttm_tt_is_beneficial_order_failed() - Whether the tt is backed at a
+ * sub-optimal page order
+ * @tt: The struct ttm_tt.
+ *
+ * Return: true if the pool allocator had to fall back below the pool's
+ * beneficial order when backing this tt, false otherwise.
+ */
+static inline bool ttm_tt_is_beneficial_order_failed(const struct ttm_tt *tt)
+{
+	return tt->page_flags & TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
+}
+
 /**
  * ttm_tt_create
  *
-- 
2.34.1

