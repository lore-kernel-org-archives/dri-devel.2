Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65733F5A8D4
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 01:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C6A10E784;
	Tue, 21 Apr 2026 01:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CL85IRab";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385A810E0E0;
 Tue, 21 Apr 2026 01:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776734776; x=1808270776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6mVJI366d0BK3am7pMwcum5OHh+aQOcg6S9qgczD/KA=;
 b=CL85IRabSPuI7Y4AFMXIlqRn1xz/266GAhq/hhnr7IhJzkcQeVX1npsa
 uXooLpkhjQoqFVLAz/jfAWe2Os4X94zAN6SsMo088HoBJwI8ZRzn8HbXY
 rnH7Bo9vndXtbjvtBxZSeKeBLH0ZbwXcTYLQXZVe2cg94NmhczggsNL9b
 SI0IivTdbSWoQIWD/8LLVTiQYWCNK+gZO2ZURyYPZVk97QuXrG+y6ifEN
 M3jdnW1Rk+tRDzZCHhKFwRbu7lvEyXZ2GdKFkZh5TIsNEhh4erq+7Z5qZ
 kHrHBcP+kVnNK+wipvDJpu5uuffNKtFwlWeK4yAVoxq2OWTz9h63nyHmP A==;
X-CSE-ConnectionGUID: 2IRAWSOvSU+FW1eFDnm9cw==
X-CSE-MsgGUID: V6P3t/omQDWWoroXdDfQzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88280333"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="88280333"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:26:15 -0700
X-CSE-ConnectionGUID: lb832ZudTz6JUdU4fVBZ5w==
X-CSE-MsgGUID: l15pYNksQdqEjU4z9J2C/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="236872343"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:26:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 2/3] drm/xe: Set TTM device beneficial_order to 9 (2M)
Date: Mon, 20 Apr 2026 18:26:07 -0700
Message-Id: <20260421012608.1474950-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421012608.1474950-1-matthew.brost@intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
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

Set the TTM device beneficial_order to 9 (2M), which is the sweet
spot for Xe when attempting reclaim on system memory BOs, as it matches
the large GPU page size. This ensures reclaim is attempted at the most
effective order for the driver.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4b45b617a039..3f719ab08d1c 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -500,7 +500,8 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
-			      xe->drm.vma_offset_manager, 0);
+			      xe->drm.vma_offset_manager,
+			      TTM_ALLOCATION_POOL_BENEFICIAL_ORDER(get_order(SZ_2M)));
 	if (WARN_ON(err))
 		return ERR_PTR(err);
 
-- 
2.34.1

