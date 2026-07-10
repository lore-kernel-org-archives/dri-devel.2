Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3FDC4450E
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6423910F999;
	Fri, 10 Jul 2026 21:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CVFOs+Ap";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3350210E4B2;
 Fri, 10 Jul 2026 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720493; x=1815256493;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RU2m66qHxawEY+yc3BVQ7M+UAP7WYB/UvwO4LeO/dqA=;
 b=CVFOs+Ap3A2ABgXFAzOFQs4VsM6kM9wgbIlcsUNhm+O9JLRHVfFZfEQb
 3v7eJhVUuaxcXghwLQeoNCxmCD3GxT9XY8W7g3q/86A4K8vKRkdfbM3Jt
 dwdGXUuKqVX3k+SHVnTEGMg3Ev4cNda53KrA0cW6IvCIihNk0eiVR5ruV
 R4wrYJhfheh0YAzWKwP+viJ3fDb4kgoVyTknPib21TDus8nmKADNFiga5
 F2LKXz5c7twwdKMg7LZ2eB5yGQPWjnASA1xcpsLu0jt0H4/Kngl2N/0jt
 vLAXKjicRQ3/H6+yfDZW230VGuNd5xv6DhJk9eN1qqewgp6qfsnPdPrDR g==;
X-CSE-ConnectionGUID: s6v88XtGRFC9CPfqD1Hglw==
X-CSE-MsgGUID: sakOvNbwSDyKGzKWDXkXPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543165"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543165"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:53 -0700
X-CSE-ConnectionGUID: r/GHF95USf6QFmhhhWJArA==
X-CSE-MsgGUID: 7BHpNNixSIKbcEhbXK93EA==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:53 -0700
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
Subject: [PATCH v2 18/33] drm/xe: Handle defrag moves in xe_bo_move()
Date: Fri, 10 Jul 2026 14:54:27 -0700
Message-Id: <20260710215442.2444235-19-matthew.brost@intel.com>
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
 drivers/gpu/drm/xe/xe_bo.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 21d087170ef3..8e9fc8b3dffa 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1164,6 +1164,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
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
 
@@ -1200,9 +1207,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	/*
 	 * Failed multi-hop where the old_mem is still marked as
 	 * TTM_PL_FLAG_TEMPORARY, should just be a dummy move.
+	 *
+	 * For a defrag move the old and new tt differ, so fallthrough to the
+	 * copy path instead of treating it as a no-op.
 	 */
 	if (old_mem_type == XE_PL_TT &&
-	    new_mem->mem_type == XE_PL_TT) {
+	    new_mem->mem_type == XE_PL_TT && !ttm_bo->defrag_old_tt) {
 		ttm_bo_move_null(ttm_bo, new_mem);
 		goto out;
 	}
@@ -1273,6 +1283,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
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
@@ -1309,13 +1325,13 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
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

