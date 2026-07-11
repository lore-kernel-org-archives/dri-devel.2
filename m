Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D239C44507
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F162210E2C0;
	Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P0laGbag";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6027C10E1DF;
 Sat, 11 Jul 2026 02:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738586; x=1815274586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=onB5KkS8J/1ab+CzHqV5dwJxkB3nLWQwKJ7ATOEu4QU=;
 b=P0laGbag/IQGpdHRSA8BI65vT3K2ekBcfWEPXmh3maVRNEFWrqmzJO+H
 qcsCeXY7VIphHrJthttQUEME6C8FTNASeNtMOXNUkFbvyRyr8rjAyR089
 kr8kFIlMsM6XAmKvYC2uCm13ikdVOC8D/e8hIvsKu967U4TaOQpUFbqO1
 B6IJx6ILTt8TSTU6pyz03SBrQNT2/Yjh+ezn6tRu3EAXLb+OMwH3jrxzM
 pWCl3dmwBXP2Y8P58yqu17Zf7nU/V/Ey5s1seS1PCBvPA1DBt+JSJCDyU
 BLb4fzoJza4q4ffkIA3BxABTHw0KSammR3HW+50/m0mPY4RYmeoJk4wOP g==;
X-CSE-ConnectionGUID: +MxmymHJQLmkuJArphQ7mg==
X-CSE-MsgGUID: eLQoJPF5SFWWLx3q0adlTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986190"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986190"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:25 -0700
X-CSE-ConnectionGUID: YbFHngh2QMqIAfli62S5ig==
X-CSE-MsgGUID: 88q3m20uQEyTE0+aUNrHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987679"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:24 -0700
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
Subject: [PATCH v3 02/33] drm/ttm/pool: Add ttm_pool_page_order_nodma() helper
Date: Fri, 10 Jul 2026 19:55:48 -0700
Message-Id: <20260711025619.2540575-3-matthew.brost@intel.com>
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

TTM records the allocation order of a multi-order page in page->private at
allocation time. For pools that do not use dma_alloc the order is stored
directly, while dma_alloc pools store a struct ttm_pool_dma pointer there
instead. Drivers that do their own DMA mapping (e.g. Xe) need the per-page
order to walk a populated ttm_tt one chunk at a time, but cannot rely on
folio_order(): TTM allocates high-order pages with alloc_pages_node()
without __GFP_COMP, so they are not compound and folio_order() always
returns 0.

Expose ttm_pool_page_order_nodma(), a thin wrapper that returns the order
recorded in page->private. It is only valid for pages from a pool that does
not use dma_alloc; whether a TTM device uses dma_alloc is fixed at ttm
device init time, so callers know from their device configuration that this
helper applies. Use it from the existing internal ttm_pool_page_order() to
keep a single source of truth.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 25 ++++++++++++++++++++++++-
 include/drm/ttm/ttm_pool.h     |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index ab242ad4339e..5b7d7f5ae53d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -461,6 +461,29 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	return num_pages;
 }
 
+/**
+ * ttm_pool_page_order_nodma() - Allocation order of a non-dma_alloc TTM page
+ * @p: The page to query.
+ *
+ * Return the allocation order that the TTM pool allocator recorded in
+ * @p->private at allocation time. This only works for pages that were
+ * allocated from a pool which does *not* use dma_alloc (i.e. pages backed by
+ * alloc_pages_node()), where TTM stores the order directly in page->private.
+ *
+ * For dma_alloc pools, page->private instead holds a struct ttm_pool_dma
+ * pointer and this helper must not be used. Whether a TTM device uses
+ * dma_alloc is fixed at ttm device init time, so callers are expected to know
+ * from their TTM device configuration that their pages are not dma_alloc
+ * backed before using this helper.
+ *
+ * Return: The allocation order of the page.
+ */
+unsigned int ttm_pool_page_order_nodma(struct page *p)
+{
+	return p->private;
+}
+EXPORT_SYMBOL(ttm_pool_page_order_nodma);
+
 /* Return the allocation order based for a page */
 static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 {
@@ -470,7 +493,7 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 		return dma->vaddr & ~PAGE_MASK;
 	}
 
-	return p->private;
+	return ttm_pool_page_order_nodma(p);
 }
 
 /*
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..753203980e2c 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -94,6 +94,8 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
 int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			       const struct ttm_operation_ctx *ctx);
 
+unsigned int ttm_pool_page_order_nodma(struct page *p);
+
 int ttm_pool_mgr_init(unsigned long num_pages);
 void ttm_pool_mgr_fini(void);
 
-- 
2.34.1

