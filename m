Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DA4C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D6710EFD0;
	Wed,  5 Aug 2026 19:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fNAqAF5H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CF210EFA7;
 Wed,  5 Aug 2026 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785958545; x=1817494545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QYVG22Ril2YRFp2fcAJ/FBSXr0ANtT+bhitFTakpD74=;
 b=fNAqAF5Hj8BRc3Fot49RQPvq2NA2spZkvm7mXTiCMndHbIx3wBdU5wLm
 v5oJmKmbwy9f3NSUSLpoEGYB9NIiuOtUUQ51CM1Uo9f5gewvqrBAj1SA7
 kLZTLRX86xhyGNcjtp59mD2tbUTZBPdZswzajz94RdZV8yp1WgULPBbdW
 iUoYSLo1OD8Ssl2lIZRqTcAdPloUvF7RdWfCEkjiQaX5T57jYPsPGq+oK
 lJyAh2T76VA3qZrKCu6tNjiLxYEEuAabstQphYYbngDo40RUdfSXf15Gp
 KCV0bUCuCvxE1j1dhf6BGervm/z/iDmh7ScceGv4lB2sr5RQArr35qVfi A==;
X-CSE-ConnectionGUID: 4X6zhA0OT7mqUxO6TA29EA==
X-CSE-MsgGUID: lVq4T3RZSVOwWracnCl+zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109332988"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="109332988"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:45 -0700
X-CSE-ConnectionGUID: /fGuctSQS9q21fF+FOoZZg==
X-CSE-MsgGUID: 9KQEbQ3VSVe6d7wvAWHz2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="285263536"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 12:35:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v2 5/5] drm/pagemap: Add fault injection for higher-order RAM
 folio allocation
Date: Wed,  5 Aug 2026 12:35:36 -0700
Message-Id: <20260805193536.3756457-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805193536.3756457-1-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
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

Migrating a device-private THP back to system memory has two distinct
paths in __migrate_device_pages(): the fast path where both source and
destination carry MIGRATE_PFN_COMPOUND, and the fallback path where the
destination could only be satisfied with order-0 folios and the source
THP therefore has to be split via migrate_vma_split_unmapped_folio().

The fallback path only triggers under genuine memory pressure, which
makes it both rare and awkward to reproduce, yet it is the path where
the interesting refcounting happens (the CPU fault holds an extra
reference on the device folio taken by do_huge_pmd_device_private()).

Add a fault_attr, modelled on backup_fault_inject in ttm_pool.c, that
forces the higher-order allocation in
drm_pagemap_migrate_populate_ram_pfn() to fail so the existing order-0
fallback is taken deterministically.

The attribute is exposed at /sys/kernel/debug/drm_pagemap_fault_inject
and requires CONFIG_FAULT_INJECTION_DEBUG_FS. With
CONFIG_FAULT_INJECTION disabled the helper compiles out to a constant
false and the injection has no cost.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 36 ++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 05eb7254028f..01c639da767c 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -3,6 +3,7 @@
  * Copyright © 2024-2025 Intel Corporation
  */
 
+#include <linux/debugfs.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-mapping.h>
 #include <linux/migrate.h>
@@ -12,6 +13,27 @@
 #include <drm/drm_pagemap_util.h>
 #include <drm/drm_print.h>
 
+#ifdef CONFIG_FAULT_INJECTION
+#include <linux/fault-inject.h>
+static DECLARE_FAULT_ATTR(migrate_to_ram_fault_inject);
+
+/*
+ * Force a higher-order destination folio allocation to fail in
+ * drm_pagemap_migrate_populate_ram_pfn(), exercising the order-0 fallback
+ * (and, in turn, the THP split path in __migrate_device_pages()) without
+ * having to drive the system into actual memory pressure.
+ */
+static bool drm_pagemap_fault_inject_folio(void)
+{
+	return should_fail(&migrate_to_ram_fault_inject, 1);
+}
+#else
+static bool drm_pagemap_fault_inject_folio(void)
+{
+	return false;
+}
+#endif
+
 /**
  * DOC: Overview
  *
@@ -960,7 +982,9 @@ static int drm_pagemap_migrate_populate_ram_pfn(struct vm_area_struct *vas,
 		if (order)
 			gfp |= __GFP_NOWARN;
 
-		if (vas)
+		if (order && drm_pagemap_fault_inject_folio())
+			folio = NULL;
+		else if (vas)
 			folio = vma_alloc_folio(gfp, order, vas, addr);
 		else
 			folio = folio_alloc(gfp, order);
@@ -1554,6 +1578,16 @@ void drm_pagemap_destroy(struct drm_pagemap *dpagemap, bool is_atomic_or_reclaim
 		kfree(dpagemap);
 }
 
+static int __init drm_pagemap_module_init(void)
+{
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_FAULT_INJECTION)
+	fault_create_debugfs_attr("drm_pagemap_fault_inject", NULL,
+				  &migrate_to_ram_fault_inject);
+#endif
+	return 0;
+}
+module_init(drm_pagemap_module_init);
+
 static void drm_pagemap_exit(void)
 {
 	flush_work(&drm_pagemap_work);
-- 
2.34.1

