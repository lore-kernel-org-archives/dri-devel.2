Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52486C4450B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13AC10F9B3;
	Sat, 11 Jul 2026 02:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RFRdXYZX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2235A10E701;
 Sat, 11 Jul 2026 02:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738593; x=1815274593;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BG1PFICdpAljvWYeK8+LJvs9zXvpb2Spx/Q4HUyJTRs=;
 b=RFRdXYZXUQYH7giyEG0+dE6izh/0pxkpVcwQaCJl7xHaObY2E7kLt2fs
 lJqvUWZiv+fTERr/VdNxP8U8LoEtpICCsxg9HbX+KODQCL0tudlm1y+Dz
 8M0lmVLXuD67fj5OGOlOsb7BgN5wqxEm5NnJZq1lJf+ItlEQAugn/RYE+
 AzeSV90I+DkjxnPqHubc5MO5SVT3RFd2OBaIGeGzcawxVBxCqXY2PtYi+
 7OcUmwxuQ+Vl8tIKkkTu9D8nq56CgGJrodFHfbUo1p+INFETz2Xof5lsj
 fxszObKqdOdPXEGmUUOjViuGBowQU3egv+mX9+FLlti6nxEoOZaMFFJdH Q==;
X-CSE-ConnectionGUID: MUZtcRVzTee43R6eucKfHQ==
X-CSE-MsgGUID: kjoUNxKlSCiKTOtkWXPWjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986363"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986363"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:33 -0700
X-CSE-ConnectionGUID: bAaDsPe7QvSp/d7/LRM4wQ==
X-CSE-MsgGUID: vVLEukHbR/eyq+BeH/4A/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987786"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:32 -0700
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
Subject: [PATCH v3 27/33] drm/xe: Add IOVA-based xe_res_cursor variant
Date: Fri, 10 Jul 2026 19:56:13 -0700
Message-Id: <20260711025619.2540575-28-matthew.brost@intel.com>
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

Introduce xe_res_first_iova() to walk a buffer that was DMA mapped using
the IOVA-based DMA API (dma_iova_try_alloc() and friends). Such a mapping
is described by a struct dma_iova_state and is a single contiguous IOVA
range, so the cursor walks it as one segment.

Add an is_iova flag to struct xe_res_cursor to distinguish this case.
When set, xe_res_dma() returns the IOVA backing the current position
(state->addr + cursor offset), xe_res_next() advances within the single
contiguous segment, and xe_res_is_vram() returns false since IOVA
mappings never point to same-device VRAM.

The flag is explicitly cleared in the existing xe_res_first(),
xe_res_first_sg() and xe_res_first_dma() initializers so stale stack
values cannot leak into the new path.

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
 drivers/gpu/drm/xe/xe_res_cursor.h | 56 +++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_res_cursor.h
index 0522caafd89d..f0f1d699e16e 100644
--- a/drivers/gpu/drm/xe/xe_res_cursor.h
+++ b/drivers/gpu/drm/xe/xe_res_cursor.h
@@ -24,6 +24,7 @@
 #ifndef _XE_RES_CURSOR_H_
 #define _XE_RES_CURSOR_H_
 
+#include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 
 #include <drm/drm_pagemap.h>
@@ -67,6 +68,12 @@ struct xe_res_cursor {
 	u64 dma_start;
 	/** @dma_seg_size: Size of the current DMA segment. */
 	u64 dma_seg_size;
+	/**
+	 * @is_iova: Whether the cursor walks a single contiguous IOVA
+	 * mapping described by a struct dma_iova_state. When true, the
+	 * DMA address is @dma_start + @start and never points to VRAM.
+	 */
+	bool is_iova;
 };
 
 static struct gpu_buddy *xe_res_get_buddy(struct ttm_resource *res)
@@ -93,6 +100,7 @@ static inline void xe_res_first(struct ttm_resource *res,
 {
 	cur->sgl = NULL;
 	cur->dma_addr = NULL;
+	cur->is_iova = false;
 	if (!res)
 		goto fallback;
 
@@ -224,6 +232,7 @@ static inline void xe_res_first_sg(const struct sg_table *sg,
 	cur->dma_addr = NULL;
 	cur->sgl = sg->sgl;
 	cur->mem_type = XE_PL_TT;
+	cur->is_iova = false;
 	__xe_res_sg_next(cur);
 }
 
@@ -255,6 +264,41 @@ static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
 	__xe_res_dma_next(cur);
 	cur->sgl = NULL;
 	cur->mem_type = XE_PL_TT;
+	cur->is_iova = false;
+}
+
+/**
+ * xe_res_first_iova() - initialize a xe_res_cursor with a dma_iova_state
+ *
+ * @state: struct dma_iova_state describing a single contiguous IOVA mapping
+ * @start: Start of the range
+ * @size: Size of the range
+ * @cur: cursor object to initialize
+ *
+ * Start walking over the range of an allocation that was DMA mapped using the
+ * IOVA-based DMA API (see dma_iova_try_alloc()). Such a mapping is a single
+ * contiguous IOVA range, so the cursor walks it as one segment. Subsequent
+ * calls to xe_res_next() advance within that range and xe_res_dma() returns
+ * the IOVA backing the current position. xe_res_is_vram() always returns false
+ * for such a cursor.
+ */
+static inline void xe_res_first_iova(struct dma_iova_state *state,
+				     u64 start, u64 size,
+				     struct xe_res_cursor *cur)
+{
+	XE_WARN_ON(!state);
+	XE_WARN_ON(start + size > dma_iova_size(state));
+
+	cur->node = NULL;
+	cur->start = start;
+	cur->remaining = size;
+	cur->size = size;
+	cur->dma_addr = NULL;
+	cur->sgl = NULL;
+	cur->dma_start = state->addr;
+	cur->dma_seg_size = dma_iova_size(state);
+	cur->mem_type = XE_PL_TT;
+	cur->is_iova = true;
 }
 
 /**
@@ -283,6 +327,13 @@ static inline void xe_res_next(struct xe_res_cursor *cur, u64 size)
 		return;
 	}
 
+	if (cur->is_iova) {
+		/* Single contiguous IOVA segment. */
+		cur->start += size;
+		cur->size = cur->remaining;
+		return;
+	}
+
 	if (cur->dma_addr) {
 		cur->start += size;
 		__xe_res_dma_next(cur);
@@ -334,7 +385,7 @@ static inline void xe_res_next(struct xe_res_cursor *cur, u64 size)
  */
 static inline u64 xe_res_dma(const struct xe_res_cursor *cur)
 {
-	if (cur->dma_addr)
+	if (cur->is_iova || cur->dma_addr)
 		return cur->dma_start + cur->start;
 	else if (cur->sgl)
 		return sg_dma_address(cur->sgl) + cur->start;
@@ -351,6 +402,9 @@ static inline u64 xe_res_dma(const struct xe_res_cursor *cur)
  */
 static inline bool xe_res_is_vram(const struct xe_res_cursor *cur)
 {
+	if (cur->is_iova)
+		return false;
+
 	if (cur->dma_addr)
 		return cur->dma_addr->proto == XE_INTERCONNECT_VRAM;
 
-- 
2.34.1

