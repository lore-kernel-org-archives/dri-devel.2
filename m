Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E5CDE006
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B00010ECF3;
	Tue, 23 Jun 2026 22:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eVBWeL39";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CB310E392;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1K7fKoniaOU3+g5QDc+Q+0D4tOD94D8T/lUmlA5wlPk=;
 b=eVBWeL39vvJasBv8Q0x5cZTwAi3Dg+hkEJIY5AQq7Wfc4Ft5bF1mpr4c
 r1UqoxrvM6AFKzQSlaUQ/xM15Hf4vJF6e89SM+0q/hbzW+ntZAoAH4Rqw
 I9eFCPqgwBRq9MR0SoqCPykTxfj/QairaPo4S/pzXWAxeJPSd7WgPk8/Q
 uWgevGpFhJyfqdqQZ2neZKp1S0AeArtwYN3qJrWhauDbAvjDj3kP01cf5
 hnS8t6qH8U4i6CtA+07t949G19TmFSRYSuay2vGOn+y8Zs35ZhMOM3XXx
 3Qkv8ZClYwAGjLnR8d5XSbtfjoE00iObOnjDB75pUFJpKw1gBXp7Zw63/ A==;
X-CSE-ConnectionGUID: 8n8VVBfrT7ycK1eho6GbFg==
X-CSE-MsgGUID: 08kJvLO/TFehu3tSXIervw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048828"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048828"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: CTuepE6UT3+S6Fh6bKj61Q==
X-CSE-MsgGUID: HFqwX1zaTpebYmVuMPICnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335809"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 08/12] drm/xe: Handle defrag moves in xe_bo_move()
Date: Tue, 23 Jun 2026 15:27:28 -0700
Message-Id: <20260623222732.360872-9-matthew.brost@intel.com>
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

Teach xe_bo_move() to service a defrag move, where TTM reallocates a
BO's backing at the device's beneficial order and hands the old, still
populated tt to the move via the BO's defrag_old_tt.

A defrag move always has existing contents to copy, so force
move_lacks_source false and fall through the XE_PL_TT -> XE_PL_TT no-op
shortcut so the copy path runs. The relocation is performed entirely on
the GPU via xe_migrate_copy_defrag(), reading the old pages from the
stashed tt's sg table and writing the freshly reallocated backing.

Both copy passes run in order on the same migrate queue and are captured
by the returned fence, so the teardown is pipelined via
ttm_bo_move_accel_cleanup(): the old tt is handed to a ghost object and
only unpopulated and freed once the fence signals, so the move need not
block. The VF CCS attach/detach handling is extended to treat a defrag
move (ctx->defrag) like the XE_PL_SYSTEM <-> XE_PL_TT transitions it
mirrors.

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
 drivers/gpu/drm/xe/xe_bo.c | 42 +++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 3c185200419e..04709343518c 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1084,6 +1084,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
 					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
 
+	/*
+	 * A defrag move always copies the existing contents from the stashed
+	 * old tt into the freshly (re)allocated backing.
+	 */
+	if (ttm_bo->defrag_old_tt)
+		move_lacks_source = false;
+
 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
 		(!ttm && ttm_bo->type == ttm_bo_type_device);
 
@@ -1120,9 +1127,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	/*
 	 * Failed multi-hop where the old_mem is still marked as
 	 * TTM_PL_FLAG_TEMPORARY, should just be a dummy move.
+	 *
+	 * For a defrag move the old and new tt differ, so fall through to the
+	 * copy path instead of treating it as a no-op.
 	 */
 	if (old_mem_type == XE_PL_TT &&
-	    new_mem->mem_type == XE_PL_TT) {
+	    new_mem->mem_type == XE_PL_TT && !ttm_bo->defrag_old_tt) {
 		ttm_bo_move_null(ttm_bo, new_mem);
 		goto out;
 	}
@@ -1193,6 +1203,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 			flags |= XE_MIGRATE_CLEAR_FLAG_CCS_DATA;
 
 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
+	} else if (ttm_bo->defrag_old_tt) {
+		struct xe_ttm_tt *old_xe_tt =
+			container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
+
+		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
+					       old_xe_tt->sg, handle_system_ccs);
 	} else {
 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
 					handle_system_ccs);
@@ -1202,7 +1218,23 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		xe_pm_runtime_put(xe);
 		goto out;
 	}
-	if (!move_lacks_source) {
+	if (ttm_bo->defrag_old_tt) {
+		/*
+		 * The defrag move relocates the data (and the CCS aux state for
+		 * compressed BOs) from the old backing to the new one entirely
+		 * on the GPU, all captured by @fence. Pipeline the teardown via
+		 * ttm_bo_move_accel_cleanup(): the old tt is handed to a ghost
+		 * object and only unpopulated and freed once @fence signals, so
+		 * the move need not block here.
+		 */
+		ret = ttm_bo_move_accel_cleanup(ttm_bo, fence, evict,
+						true, new_mem);
+		if (ret) {
+			dma_fence_wait(fence, false);
+			ttm_bo_move_null(ttm_bo, new_mem);
+			ret = 0;
+		}
+	} else if (!move_lacks_source) {
 		ret = ttm_bo_move_accel_cleanup(ttm_bo, fence, evict, true,
 						new_mem);
 		if (ret) {
@@ -1229,13 +1261,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	 * BBs from BO as it is no longer needed.
 	 */
 	if (IS_VF_CCS_READY(xe) && old_mem_type == XE_PL_TT &&
-	    new_mem->mem_type == XE_PL_SYSTEM)
+	    (new_mem->mem_type == XE_PL_SYSTEM || ctx->defrag))
 		xe_sriov_vf_ccs_detach_bo(bo);
 
 	if (IS_VF_CCS_READY(xe) &&
 	    ((move_lacks_source && new_mem->mem_type == XE_PL_TT) ||
-	     (old_mem_type == XE_PL_SYSTEM && new_mem->mem_type == XE_PL_TT)) &&
-	    handle_system_ccs)
+	     ((old_mem_type == XE_PL_SYSTEM || ctx->defrag) &&
+	      new_mem->mem_type == XE_PL_TT)) && handle_system_ccs)
 		ret = xe_sriov_vf_ccs_attach_bo(bo);
 
 out:
-- 
2.34.1

