Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE96CDB47C
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B9D10ECE7;
	Tue, 23 Jun 2026 22:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Veo7J1WQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271EF10ECDF;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lj4qoBK0a5cBXuICZiXJpQeezNVfUPy92L90OtW0C00=;
 b=Veo7J1WQgGIOwHL+WIV7ACigQrDQMfvQgoWF6JJb+F/DjKvvB8BezHvJ
 ddgzM0fqCUDK2wx9KKbl+b3Ihrer/KV0bsy4yY9lz4edjiJfuyxcWt2sy
 UZRJb7KQXWl0zIYIMexqQBMSF+rK/uhNURL0+YZsNcrr4DUytle+URQ4y
 CKbTelFhHifvbgMN1HCI+Z+XUPSYyfQIUPoggNDmUFO2RhfZHniFfmVsX
 tBnkBy/Lpdf7X3GmEmDBGjHKSBb9JkrX59oBevMUbZUzrgr52Ru6EUUGP
 +qR2m2E2iVGT50Rm2JztnDFA02KFCzjxDWm8dpP3fk7HcjBQMGCfH5JQS A==;
X-CSE-ConnectionGUID: aPoR4zUXQ+qCizZv/m9NAg==
X-CSE-MsgGUID: xqJ2UN+gQ3auyP1UFqUbiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048826"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048826"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: 2wwD78DIRsOJhMnCdEordQ==
X-CSE-MsgGUID: sRO7btSTRvq5b0ByC1Hkrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335806"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 06/12] drm/xe: Back off beneficial-order reclaim under
 defrag pressure
Date: Tue, 23 Jun 2026 15:27:26 -0700
Message-Id: <20260623222732.360872-7-matthew.brost@intel.com>
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

Once a meaningful number of BOs are already tracked as being backed at a
sub-optimal order, continuing to push hard for beneficial-order pages
during populate mostly wastes time in reclaim/compaction.

In xe_ttm_tt_populate(), set ctx->beneficial_reclaim_backoff when the
device defrag count reaches XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD (2)
so the TTM pool backs off and allocations make forward progress. The
deferred defrag pass is responsible for upgrading these objects to
beneficial order later.

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
 drivers/gpu/drm/xe/xe_bo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 4acacc50a28f..3c185200419e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -41,6 +41,14 @@
 #include "xe_vm.h"
 #include "xe_vram_types.h"
 
+/*
+ * Once this many BOs are tracked on the device defrag list (i.e. were backed
+ * with a sub-optimal page order), request that the TTM pool backs off from
+ * aggressive reclaim at the beneficial order during populate, so that
+ * allocations make forward progress instead of stalling.
+ */
+#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
+
 const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
 	[XE_PL_SYSTEM] = "system",
 	[XE_PL_TT] = "gtt",
@@ -552,6 +560,12 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
 		err = ttm_tt_restore(ttm_dev, tt, ctx);
 	} else {
+		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
+
+		if (atomic_read(&xe->mem.defrag.count) >=
+		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
+			ctx->beneficial_reclaim_backoff = true;
+
 		ttm_tt_clear_backed_up(tt);
 		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
 	}
-- 
2.34.1

