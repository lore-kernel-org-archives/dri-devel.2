Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9955110F9972
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8770C10E1F5;
	Wed,  8 Apr 2026 20:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bcAwq6iw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD7410E0AB;
 Wed,  8 Apr 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775679345; x=1807215345;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kkYNh4+pZJ4BbCKx7nuaC6w/YYhhhfa8cB0PmhpF8tE=;
 b=bcAwq6iwVGN3wcs/InnvQBmg1HrpLs/u84yMgGNTxS8OeTzHGkQKniZn
 29QR7iams56M9QToqr5GpNT1dWPo7lSlAlsFUC0xDT+8B6SIOvnuVwQmx
 lSsVsXLa87/Qq/AHdDxhF1hWPSf6SsacGC7JqwnOxXcuphksp2xzmt8ft
 Z4nejZP0b6cYYpJy6mESgOZHW8SJs4tOV5/tmUJx0wN/8ItBRjgYKSO1z
 Kenrg5oKQRUv3h4YE7zG0uStCyrFukvJnh72ZYcNB+1+N6XrL/uXCxACt
 u3+C43hU8XFZPCIHEqdpzM8RkqQBe6cXjnCU7rXqd4CKzH8mQ1rc+rkHs Q==;
X-CSE-ConnectionGUID: n+T20mhYSKeLnOKKrGs/gw==
X-CSE-MsgGUID: 2A9j2i08QAWCPzKs3KJZhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94063728"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="94063728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
X-CSE-ConnectionGUID: CFHGIqoLReaT6Lo4vl8BTg==
X-CSE-MsgGUID: 6W7qxT08QVuhoS5xTSRD8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="228451024"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:15:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com
Subject: [PATCH v6 5/5] drm/pagemap: Fix drm_pagemap_migrate_unmap_pages
 kerneldoc
Date: Wed,  8 Apr 2026 13:15:37 -0700
Message-Id: <20260408201537.3580549-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408201537.3580549-1-matthew.brost@intel.com>
References: <20260408201537.3580549-1-matthew.brost@intel.com>
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
---
 drivers/gpu/drm/drm_pagemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index ed62866b52f6..172e8e81a71c 100644
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

