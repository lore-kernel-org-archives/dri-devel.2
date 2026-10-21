Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77289606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eRulnJOs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51A710FD28;
	Wed, 21 Oct 2026 10:04:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FBC10FD28;
 Wed, 21 Oct 2026 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577052; x=1824113052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yeu9c/emxcsA9aHpSBf19RTFSqpZBBW0Z2CxcKCneGM=;
 b=eRulnJOsKqC8aqjHAhmF67azrEapLLYUz7CueMcpb+obJkigEV+XzJna
 Z9uxRCpH66KhGpjf9EELtRbTIl2cJmJ+fZ1ZxjARgQyxdCUudhUwvEm+Q
 1Ylbb5uAY9/utfdFfIOB0kjwj7xYHzcyETnWv3+uUUNsvCI1K3s3Z0ktU
 9z3NOCtkwkheXjR9DfPzG2DCzhoYsPPr3AonQNt7hmd2MphsEfi+qRZlx
 32Ro4QjB0T+PNvmhUJ6xvj9UMl/NYhuDWislLi7tg7hZ2EjE9Tz0op8L5
 gGOgzrpNt0nSe+jZiTSbo2U7ckDv9d2QYcHBUKwZucAbEWrydecqo971j A==;
X-CSE-ConnectionGUID: xJH5VOuyRY+5ONYmrPQk2Q==
X-CSE-MsgGUID: mjRTIrySRSyXD7lhAS4O2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290324"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290324"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:12 -0700
X-CSE-ConnectionGUID: 9DQHp1IlQUC8COogZ09mFg==
X-CSE-MsgGUID: MKPMWJNOQjit+17jzuwTeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382154"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:09 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 14/17] drm/xe/ttm: Reject VRAM allocations on wedged devices
Date: Wed, 21 Oct 2026 15:33:15 +0530
Message-ID: <20261021100322.1014449-15-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VRAM is no longer usable after the device is wedged. Reject observed
VRAM allocations with -ENODEV and stop placement fallback.

An allocation racing with the wedge may still complete. The wedged fault
path prevents new VRAM CPU mappings, and device teardown releases the
resource.

v2:
 - Return -ENODEV to stop placement fallback after a permanent wedge.
   (Rodrigo)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 36d47de8b11b..9d7c87c97028 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -106,6 +106,7 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 			       const struct ttm_place *place,
 			       struct ttm_resource **res)
 {
+	struct xe_device *xe = ttm_to_xe_device(tbo->bdev);
 	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
 	struct xe_ttm_vram_mgr_resource *vres;
 	struct gpu_buddy *mm = &mgr->mm;
@@ -113,6 +114,9 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 	unsigned long lpfn;
 	int err;
 
+	if (xe_device_wedged(xe))
+		return -ENODEV;
+
 	lpfn = place->lpfn;
 	if (!lpfn || lpfn > man->size >> PAGE_SHIFT)
 		lpfn = man->size >> PAGE_SHIFT;
-- 
2.43.0

