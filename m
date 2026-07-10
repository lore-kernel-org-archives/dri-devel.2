Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8103C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113AB10E229;
	Fri, 10 Jul 2026 21:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fpeLPu+i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0286D10E1BD;
 Fri, 10 Jul 2026 21:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720489; x=1815256489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6PkaSldf+zBmG2z9LSxwcaK7Yyyk4K5VMohRBRvzXow=;
 b=fpeLPu+i3VwPbxjPs3drxvuzVB3QSt5Eipp01IC35lTvZdS1RXtHbbgq
 geUSuvts1vxP5NcfJ7VKUDq/1IiAqmr5vxl+kFfBWyTPhqhpjEokTJiLv
 Oo5BhwpG0anT356OFeE6jF8gsMviFeEVcyYinqBVlKRhqGMxo4p4YlhxL
 10YckrDUQD1n+Q7EP6HKoUVliZKuf8yKpjsZq9aeVtg1TERaI4JtAGpdI
 /IyNUdSSR5ugFrF9ilpHU9TbFmID952e3b2J7U7lkBlVnEe1pQSjdzhpV
 t/GtuU3VVxQLA2K2tFsK1JwhwJAZ92O4EkPtmVu3DcVY3rUyWIHMckHa2 g==;
X-CSE-ConnectionGUID: eV2SGbFzRluY6HV5LAPZ1g==
X-CSE-MsgGUID: injwoltkRvGbl24BPjFCGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543054"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:48 -0700
X-CSE-ConnectionGUID: Jlt7NKo/QfGWTizoXf/IkA==
X-CSE-MsgGUID: 1+uYg54iQqCV1XCHnWShUA==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:48 -0700
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
Subject: [PATCH v2 02/33] drm/ttm/pool: Add ttm_pool_page_order_nodma() helper
Date: Fri, 10 Jul 2026 14:54:11 -0700
Message-Id: <20260710215442.2444235-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
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
index dbe977412a81..d34592d4dbc7 100644
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

