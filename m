Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189B606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QiIEAhj3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E7C10ECA9;
	Mon,  2 Nov 2026 10:14:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE25410ECA0;
 Mon,  2 Nov 2026 10:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614446; x=1825150446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mp24kUpllAzxNwfow6pLPQtKQLaNqq1GBzbSFunv7UQ=;
 b=QiIEAhj3Z9TT2ZIA4X5EnGUj2XNeRmt1Z0/z2NIxNHaFudA449AMUl+2
 Ppl/F2cw/wjBTrUgjOFwkiGnAiaKj6C8kA3jusek4HFWlXh5f60gRx6Yz
 WzPEZhEq4tVHazCmDv9dF01zd0Wsc56sRQ4nIePBPGvJcu13O2h4pVbzt
 E6lD++Ubn5XI9jzWGdn2OiBLBRxtoUuVR62rSMNa//RKach0JTDB7515N
 0/BwWGegi7rxcjCbHSpgYYgBN6srEckZqTslx5wfCO98M2dkKUgilj8MZ
 i2yR77AXeh/IeWCv/F2qEdrPmJ4uvRo03fzsceDERJ1O19xDJXntnorsm g==;
X-CSE-ConnectionGUID: +3Cn8muxS+C3J6P0ieR/9g==
X-CSE-MsgGUID: IS9FLaBaTa2L9gyYaBKBrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200818"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200818"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:14:06 -0800
X-CSE-ConnectionGUID: x7mX1e8+QIe0RDPPlEy4BA==
X-CSE-MsgGUID: K2EBuyOZQwu6O+KzCEsoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002793"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:14:04 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 5/7] drm/xe/bo: Preserve the host NUMA node across backup /
 restore
Date: Mon,  2 Nov 2026 15:48:09 +0530
Message-ID: <20261102101803.455921-14-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use ttm_tt_restore_node() so a BO restored after shrinker backup comes
back on its requested node instead of the pool default.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b0760d5d6bad..fc9bfb436b8e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -676,7 +676,7 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 		return 0;
 
 	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
-		err = ttm_tt_restore(ttm_dev, tt, ctx);
+		err = ttm_tt_restore_node(ttm_dev, tt, ctx, xe_tt->numa_node);
 	} else {
 		ttm_tt_clear_backed_up(tt);
 		err = ttm_pool_alloc_node(&ttm_dev->pool, tt, ctx,
-- 
2.43.0

