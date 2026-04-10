Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11AAF45A0F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A77210E9CF;
	Fri, 10 Apr 2026 20:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IlUcctcI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4211C10E1C3;
 Fri, 10 Apr 2026 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775854776; x=1807390776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rqKVExBVEqpTZiI5eolBvgPol7BjL6ayz9ZnE9dxvcE=;
 b=IlUcctcIT+r/8gYkAEJdBuanlkTL+2SSSdTmq07CJFn2QM36Y+S1ysvb
 DARa9MwRYG0f+lePdxenyCGMc3q6o9kzwWmn/AovgJwuPTVXAmkDXaOy+
 fzLF+zTK7uO0BTybY/0oWAS/OYgtxeM5IAFYVmJVx7gRw1QpOjVKsTwsx
 C0ksgTEZcaUOA+VHF0Lhn5mcMmxenJRKTOgRqTZDoWiXOWBJj526BuZQp
 vGWBHS4xcVUSiQo75brA+7il+XMO5r3ON0WT0ll+TmHEXj88Huk/19TaB
 w/hv0LXmbIlLspVxjpWTMMmeHO1VVwxu/ruwpwopN7NSRAkJg61HpwOxS w==;
X-CSE-ConnectionGUID: dibr8VBPS6iSJiFep651CA==
X-CSE-MsgGUID: kmY8LU72QWGoEK4aDu/WnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76842855"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="76842855"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:59:35 -0700
X-CSE-ConnectionGUID: /CpGPM3UQDyuo8SpjGzoRA==
X-CSE-MsgGUID: dAeomxWCREarFGgleB6TvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="228343060"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:59:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v7 5/5] drm/pagemap: Fix drm_pagemap_migrate_unmap_pages
 kerneldoc
Date: Fri, 10 Apr 2026 13:59:29 -0700
Message-Id: <20260410205929.3914474-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410205929.3914474-1-matthew.brost@intel.com>
References: <20260410205929.3914474-1-matthew.brost@intel.com>
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

Replace @dma_addr with @pagemap_addr in the function documentation,
as @pagemap_addr is the actual name of the function argument.

Suggested-by: Francois Dugast <francois.dugast@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Francois Dugast <francois.dugast@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index bd2037c77c92..d82ea7ccb8da 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -397,8 +397,9 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
  * @state: DMA IOVA state for mapping.
  *
  * This function unmaps previously mapped pages of memory for GPU Shared Virtual
- * Memory (SVM). It iterates over each DMA address provided in @dma_addr, checks
- * if it's valid and not already unmapped, and unmaps the corresponding page.
+ * Memory (SVM). It iterates over each DMA address provided in @pagemap_addr,
+ * checks if it's valid and not already unmapped, and unmaps the corresponding
+ * page.
  */
 static void drm_pagemap_migrate_unmap_pages(struct device *dev,
 					    struct drm_pagemap_addr *pagemap_addr,
-- 
2.34.1

