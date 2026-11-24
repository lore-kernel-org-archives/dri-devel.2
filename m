Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E70606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YG2vu442
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC6610F02D;
	Tue, 24 Nov 2026 19:26:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FED10F02D;
 Tue, 24 Nov 2026 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795548369; x=1827084369;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A/Kb9OtXc9sWmShUGKKnDOfx52PCBRfWt5X5T8P/DRo=;
 b=YG2vu442p3VmlZsBB3zE4nboD9kv0hjU5L/ARD679x9kWeq9Q4aGj26O
 WYXvPMFIUGdVMlY7lE1jXA15jslwwpqKVMPSKlk4hBPQW3Vvxg+gz78y2
 ZyxQ+oqgoC8X7u86e/Nwq56ILP0465fZk6FnofhLlD51tLP/bXIt83WCB
 OKXXwd8aTcBFp+/QbkBE+MRrQecUTDr15pKbSPn//DYzoz1tOzts7pZfT
 uQWlwmbEuuYp4FdSj9fNScLUt62qq89rNc1FWkrdly4dD9VAWcDC6TL1V
 Kt1YGA7Z1ESULwMiEM4wtRY5WKQ4eVRFi5+EDE8fW084sLtbuWdVFcLJs Q==;
X-CSE-ConnectionGUID: RpN7UQumQMqLawwsrK4raA==
X-CSE-MsgGUID: gKhiGG5JQNuBLP0pNo4cvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4488661"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4488661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 11:10:18 -0800
X-CSE-ConnectionGUID: IcURFiI9Qsi7gEmd3aNJ9A==
X-CSE-MsgGUID: rg2omO0TTKeOHk6h/jH6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="12066008"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.188])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 11:10:16 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when it's
 no longer needed
Date: Tue, 24 Nov 2026 20:09:54 +0100
Message-ID: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
VRAM. In that case the bo may still carry a ttm_tt that was created
for its deferred placement, and it is left dangling on a bo whose new
resource doesn't use a ttm_tt.

Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is NULL
or its memory type manager doesn't use a ttm_tt.

ttm_bo_tt_destroy() is internal to TTM and not exported. Rather than
exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
export that instead.

Patch and commit message was drafted using an LLM.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Natalie Vock <nat@pixelcluster.dev>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 20 ++++++++++++++++++++
 include/drm/ttm/ttm_bo.h          | 15 ++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f9458a4d5a09..7f3459db596a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -202,6 +202,26 @@ int ttm_bo_move_memcpy(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_move_memcpy);
 
+/**
+ * ttm_bo_move_null() - assign memory for a buffer object.
+ * @bo: The bo to assign the memory to.
+ * @new_mem: The memory to be assigned, or NULL.
+ *
+ * Free the current resource of @bo and assign @new_mem to it. If @new_mem is
+ * NULL or its memory type manager doesn't use a &struct ttm_tt, the bo's
+ * &struct ttm_tt, if any, is unpopulated and destroyed.
+ */
+void ttm_bo_move_null(struct ttm_buffer_object *bo,
+		      struct ttm_resource *new_mem)
+{
+	if (!new_mem || !ttm_manager_type(bo->bdev, new_mem->mem_type)->use_tt)
+		ttm_bo_tt_destroy(bo);
+
+	ttm_resource_free(bo, &bo->resource);
+	ttm_bo_assign_mem(bo, new_mem);
+}
+EXPORT_SYMBOL(ttm_bo_move_null);
+
 static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
 {
 	struct ttm_transfer_obj *fbo;
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 32791c4db2a9..d525e04893ed 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -356,19 +356,8 @@ static inline void ttm_bo_assign_mem(struct ttm_buffer_object *bo,
 	bo->resource = new_mem;
 }
 
-/**
- * ttm_bo_move_null - assign memory for a buffer object.
- * @bo: The bo to assign the memory to
- * @new_mem: The memory to be assigned.
- *
- * Assign the memory from new_mem to the memory of the buffer object bo.
- */
-static inline void ttm_bo_move_null(struct ttm_buffer_object *bo,
-				    struct ttm_resource *new_mem)
-{
-	ttm_resource_free(bo, &bo->resource);
-	ttm_bo_assign_mem(bo, new_mem);
-}
+void ttm_bo_move_null(struct ttm_buffer_object *bo,
+		      struct ttm_resource *new_mem);
 
 /**
  * ttm_bo_unreserve
-- 
2.56.1

