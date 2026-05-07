Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93C3CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377D410E23F;
	Thu,  7 May 2026 09:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hfZabrDg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EE110E23F;
 Thu,  7 May 2026 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778145376; x=1809681376;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R7Mr9l5eIXGrb+zO7NHspWcx7rMxie+B16LQ5lGm6Vk=;
 b=hfZabrDgeLyIi78vDOBU1Y5zTB0YcyHTOdRnmTyHcnNEsgu9zwI/+hJk
 J9o/rGO9NLfxLnxJOaaaNoXKT8JBGPDQjMkQ+DsWAQRM1tC8eCwNSNvFy
 Z+RhDzt3i2UWTtOSBkyadlaRaJXZLaNilzBceELc8iOmKn6oMeT0kEH2O
 KF47bVpgnGpIzGNSPmOMj5TAVfCqoOuwWzzVWYKk+iJhSIxaKbMHz+8jV
 ZNJABEaupSFD8yNYv1Ab+IY/B8jpZAYjnAKgglCaHmGM+tovB7FsPaniZ
 TDmCemj7Jr/ApKP3GClevEPm2T+MucbOjVPfGmIaOBet0uint2GsJs43n g==;
X-CSE-ConnectionGUID: OUK7EEmnQxeueCQXPk6cAw==
X-CSE-MsgGUID: IGpWvKmuSoSSlmN84+Uegw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89680166"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="89680166"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 02:16:15 -0700
X-CSE-ConnectionGUID: 2P1uR1UfTUm44tRAZMcvnQ==
X-CSE-MsgGUID: luxL0P3JTiWm2kcRN7C6cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="240400004"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.93])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 02:16:13 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH] drm: Drop HPAGE_PMD_SIZE dependency in dma_iova_try_alloc
 calls
Date: Thu,  7 May 2026 11:16:06 +0200
Message-ID: <20260507091606.1067973-1-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
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

The phys argument to dma_iova_try_alloc() is used only to compute
the sub-granule offset (phys & (granule - 1)). Since HPAGE_PMD_SIZE
is a power of two larger than any IOMMU granule, this expression
always evaluates to zero.

Replace the ternary expressions with a plain 0, which is what the
API documentation recommends for callers doing PAGE_SIZE-aligned
transfers. This also removes the dependency on HPAGE_PMD_SIZE and
thus on CONFIG_PGTABLE_HAS_HUGE_LEAVES / HAVE_ARCH_TRANSPARENT_HUGEPAGE,
fixing build failures on architectures such as arm32 that lack that
config.

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Assisted-by: GitHub Copilot:claude-sonnet-4.6 # Documentation
Link: https://lore.kernel.org/intel-xe/c36e7dfb-cf62-4d21-a3b1-f54cb43e0832@infradead.org/
---
 drivers/gpu/drm/drm_gpusvm.c  | 5 +----
 drivers/gpu/drm/drm_pagemap.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 365a9c0b522a..958cb605aedd 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1556,10 +1556,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 			if (!i)
 				dma_iova_try_alloc(gpusvm->drm->dev, state,
-						   npages * PAGE_SIZE >=
-						   HPAGE_PMD_SIZE ?
-						   HPAGE_PMD_SIZE : 0,
-						   npages * PAGE_SIZE);
+						   0, npages * PAGE_SIZE);
 
 			if (dma_use_iova(state)) {
 				err = dma_iova_link(gpusvm->drm->dev, state,
diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index d82ea7ccb8da..15c78eca180b 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -347,10 +347,7 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
 
 		if (!try_alloc) {
 			dma_iova_try_alloc(dev, &state->dma_state,
-					   (npages - i) * PAGE_SIZE >=
-					   HPAGE_PMD_SIZE ?
-					   HPAGE_PMD_SIZE : 0,
-					   npages * PAGE_SIZE);
+					   0, npages * PAGE_SIZE);
 			try_alloc = true;
 		}
 
-- 
2.43.0

