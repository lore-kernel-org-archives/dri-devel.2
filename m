Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548FECD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B957210E244;
	Thu, 30 Apr 2026 19:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I0eWKewa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837AA10E244;
 Thu, 30 Apr 2026 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777576171; x=1809112171;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Li4Br/ck8mA/qGQwfI+fkvtTjhzz7x5LFe+xj/eewj4=;
 b=I0eWKewaLoJoPRUIrnDSaUnIAMf808QFqabKI83LVusrjlGSjAkKK9Pr
 nHpciFvOh5gTcKUX+/UCrsBMHmzfcSRMbJuohGsPVeWFJ5u0TBxAiZeCj
 tgPlDFa0eAvH4ww+lozxvk9tLIMmtS3+NbkFwt5gXV/FvyIPfj+k/qG+R
 Vyl+Gf/D1jIprTg8YLJzJOwUJ+d9duJDvCwCutn9cGgmjzG2EvAOhJFP6
 BaGHjeEprxHLRdvTIO4gowcEOMux63NvD4gISAvVSYMrGa6fcLfThyDb8
 GSowYn78wEELh7ihVSYcsI3g1U9LlAu8N9GOUd9Bz+lkgklAh/CFCrEEf g==;
X-CSE-ConnectionGUID: CQ/3/MWeRNW1gXrhycmq7Q==
X-CSE-MsgGUID: 17pbZR74R6+DGtNrwhchCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89917863"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="89917863"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:09:29 -0700
X-CSE-ConnectionGUID: iBCc3LgzRKORPN/ZGhEz+A==
X-CSE-MsgGUID: 232ycsuaQha1aDLMIg4zcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="230071120"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:09:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe: Do not blindly copy system CCS pages when shrinking
Date: Thu, 30 Apr 2026 12:09:23 -0700
Message-Id: <20260430190923.2141506-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

If the PAT index for a BO is configured without compression, copying CCS
pages during BO shrinking provides no value. Skip CCS copies for BOs that
have never been configured with compressed PAT indexes.

Once a BO is configured with a compressed PAT index, this becomes a
one-way transition that enables CCS copies. This heuristic is imprecise,
but simple and functional.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

When running 10x tabs webgl aquarium, it was observed a ratio of ~6.5 to
1 of BOs that can possible enable compression (xe_bo_needs_ccs_pages
returns true) actually enable compression in the PAT index and overall
CCS copies are reduced by roughly 1/2 when the shrinker is triggered.
---
 drivers/gpu/drm/xe/xe_bo.c       | 2 ++
 drivers/gpu/drm/xe/xe_bo_types.h | 3 +++
 drivers/gpu/drm/xe/xe_vm.c       | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5ce60d161e09..3fbb82ece4de 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1105,6 +1105,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 			flags |= XE_MIGRATE_CLEAR_FLAG_CCS_DATA;
 
 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
+	} else if (handle_system_ccs && !bo->ccs_used) {
+		fence = dma_fence_get_stub();
 	} else {
 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
 					handle_system_ccs);
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 9c199badd9b2..76f73a3bf2ca 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -88,6 +88,9 @@ struct xe_bo {
 	/** @ccs_cleared: true means that CCS region of BO is already cleared */
 	bool ccs_cleared;
 
+	/** @ccs_used: true means that CCS region of BO is used */
+	bool ccs_used;
+
 	/** @bb_ccs: BB instructions of CCS read/write. Valid only for VF */
 	struct xe_mem_pool_node *bb_ccs[XE_SRIOV_VF_CCS_CTX_COUNT];
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c3836f6eab35..638037e71e2d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3054,6 +3054,9 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 
 		if (flags.request_decompress)
 			err = xe_bo_decompress(bo);
+
+		if (xe_pat_index_get_comp_en(vm->xe, vma->attr.pat_index))
+			bo->ccs_used = true;
 	}
 
 	return err;
-- 
2.34.1

