Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324CD60820A5
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LRnpeFbf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EC810FEDC;
	Wed,  4 Nov 2026 20:14:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D63510FED6;
 Wed,  4 Nov 2026 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823246; x=1825359246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pM6WnKvjf7fDORuMQGeRpU+XmjTFFHiTF7JpT1uYCGY=;
 b=LRnpeFbfX+WizKtux9rglB7kzgtNnK7Nb8sceR2Mv17Y5Qnx/+sjhPyH
 qcv4oCcKBcqbkqcboLRR0GcdibMQNI+FtmfSImAeXKNn0Vqd8ykNIsOph
 0GGNggl8gyJm2WyiUmYNodW91vxiruqrL7ymMgcrytO4ar5LIFeuuvmOp
 t0fXZnCoDZCjnxRtuUIfFypQ2G971X4wBp2DBz0wQKSB1iqSfYToyDKAn
 XZrWXeIHDvXRYr+NHOd6rPFRxzwVrrlBHPbwTeCx9+mKYXix7pplUYPi4
 GM9wsVOvMd8zI3uxaWPHPCI3VlMtg53y8pd1xQtF3z2bpR2yxN6R4VZOu w==;
X-CSE-ConnectionGUID: XuRpsGJ2SFyll8cevwsJrw==
X-CSE-MsgGUID: 3qLjIaVzTa+o9Jetn1E0SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589067"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:05 -0800
X-CSE-ConnectionGUID: mCOWFzmEQx2nqJuyk72opg==
X-CSE-MsgGUID: YV03fT4ETWiDE/zMtCV7bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6868473"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.20])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:02 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/4] drm/xe/bo: Pass page and tt counts to the shrinker
 account helpers
Date: Wed,  4 Nov 2026 21:13:29 +0100
Message-ID: <20261104201331.2462-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
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

xe_ttm_tt_account_add() and xe_ttm_tt_account_subtract() always
account tt->num_pages and a single populated tt. Partial backup
support will need to account a subset of a tt's pages, and to keep
a partially backed-up tt counted as populated.

Add explicit page and tt count parameters. All callers pass
tt->num_pages and 1, so there is no functional change.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/tests/xe_bo.c |  6 ++++--
 drivers/gpu/drm/xe/xe_bo.c       | 28 ++++++++++++++++------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 6a17e13d58cf..472d5577e0fe 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -736,9 +736,11 @@ static int shrink_test_run_device(struct xe_device *xe)
 		 * other way around, they may not be subject to swapping...
 		 */
 		if (alloced < purgeable) {
-			xe_ttm_tt_account_subtract(xe, &xe_tt->ttm);
+			xe_ttm_tt_account_subtract(xe, &xe_tt->ttm,
+						   xe_tt->ttm.num_pages, 1);
 			xe_tt->purgeable = true;
-			xe_ttm_tt_account_add(xe, &xe_tt->ttm);
+			xe_ttm_tt_account_add(xe, &xe_tt->ttm,
+					      xe_tt->ttm.num_pages, 1);
 			bo->ttm.priority = 0;
 			spin_lock(&bo->ttm.bdev->lru_lock);
 			ttm_bo_move_to_lru_tail(&bo->ttm);
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..2afee1a6de66 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -452,24 +452,26 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
  * Account ttm pages against the device shrinker's shrinkable and
  * purgeable counts.
  */
-static void xe_ttm_tt_account_add(struct xe_device *xe, struct ttm_tt *tt)
+static void xe_ttm_tt_account_add(struct xe_device *xe, struct ttm_tt *tt,
+				  long num_pages, long tts)
 {
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
 
 	if (xe_tt->purgeable)
-		xe_shrinker_mod_pages(xe->mem.shrinker, 0, tt->num_pages, 1);
+		xe_shrinker_mod_pages(xe->mem.shrinker, 0, num_pages, tts);
 	else
-		xe_shrinker_mod_pages(xe->mem.shrinker, tt->num_pages, 0, 1);
+		xe_shrinker_mod_pages(xe->mem.shrinker, num_pages, 0, tts);
 }
 
-static void xe_ttm_tt_account_subtract(struct xe_device *xe, struct ttm_tt *tt)
+static void xe_ttm_tt_account_subtract(struct xe_device *xe, struct ttm_tt *tt,
+				       long num_pages, long tts)
 {
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
 
 	if (xe_tt->purgeable)
-		xe_shrinker_mod_pages(xe->mem.shrinker, 0, -(long)tt->num_pages, -1);
+		xe_shrinker_mod_pages(xe->mem.shrinker, 0, -num_pages, -tts);
 	else
-		xe_shrinker_mod_pages(xe->mem.shrinker, -(long)tt->num_pages, 0, -1);
+		xe_shrinker_mod_pages(xe->mem.shrinker, -num_pages, 0, -tts);
 }
 
 static bool xe_ttm_bo_is_imported(struct ttm_buffer_object *tbo)
@@ -503,7 +505,8 @@ static void xe_bo_account_pin(struct xe_bo *bo)
 
 	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
 	    !xe_ttm_bo_is_imported(&bo->ttm))
-		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
+		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm,
+					   bo->ttm.ttm->num_pages, 1);
 }
 
 /*
@@ -534,7 +537,8 @@ static void xe_bo_account_unpin(struct xe_bo *bo)
 
 	if (last_unpin && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
 	    !xe_ttm_bo_is_imported(&bo->ttm))
-		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
+		xe_ttm_tt_account_add(xe, bo->ttm.ttm, bo->ttm.ttm->num_pages,
+				      1);
 }
 
 /**
@@ -682,7 +686,7 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 		return err;
 
 	xe_tt->purgeable = false;
-	xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt);
+	xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt, tt->num_pages, 1);
 	update_global_total_pages(ttm_dev, tt->num_pages);
 
 	return 0;
@@ -699,7 +703,7 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
 	xe_tt_unmap_sg(xe, tt);
 
 	ttm_pool_free(&ttm_dev->pool, tt);
-	xe_ttm_tt_account_subtract(xe, tt);
+	xe_ttm_tt_account_subtract(xe, tt, tt->num_pages, 1);
 	update_global_total_pages(ttm_dev, -(long)tt->num_pages);
 }
 
@@ -1391,7 +1395,7 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 			      .allow_move = false});
 
 	if (lret > 0) {
-		xe_ttm_tt_account_subtract(xe, bo->ttm);
+		xe_ttm_tt_account_subtract(xe, bo->ttm, bo->ttm->num_pages, 1);
 		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
 	}
 
@@ -1483,7 +1487,7 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 		xe_pm_runtime_put(xe);
 
 	if (lret > 0) {
-		xe_ttm_tt_account_subtract(xe, tt);
+		xe_ttm_tt_account_subtract(xe, tt, tt->num_pages, 1);
 		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
 	}
 
-- 
2.56.0

