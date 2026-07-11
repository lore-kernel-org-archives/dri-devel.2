Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A08C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CD010E6F2;
	Sat, 11 Jul 2026 02:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GInt172H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657AB10E2AD;
 Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738589; x=1815274589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dww0yEVCQagosf6H5V5oeLo+lU6pkgwQ2dn/EPyhfeg=;
 b=GInt172HzRJDHLW3Q1okU52uZoXGWY4NpeCZacWoL226sRFRINX+Q7IK
 GnIGUZfOyps+n8E4+M2WlJxSLouFYy6zzZuJ5GyogXgO3lgAP3inzEKso
 cYk6d5eRtQ+LAxYui0TbvVlAaFlXus8JTMygaf9GAgVic2S7QU68nE4/y
 15u1U9+ZUXqJhnxCys9dfnrCjafV/0NURz72WVusYkv7onkx7bJc0Y5TH
 igbW6Y+i598HQ71uumhB/nPAFHQzsJByWzsxs9i3XIlzrtoTSrzOuLML0
 W/hxFLaLJ5dzHdbWPj4pY3FCBm2DqT2Dnme0hZcAVgrgCoK5jxf3Hrhn9 g==;
X-CSE-ConnectionGUID: 14IpCb7FTpOIDHC3CIDoAA==
X-CSE-MsgGUID: 4qixP2ygQl6Cj1ZeGb6Sgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986258"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986258"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
X-CSE-ConnectionGUID: BfCQa9p3Taa4DMwsDTnghg==
X-CSE-MsgGUID: AaQ/0KMUTGWDXfmPsP8YRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987710"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 11/33] drm/gpusvm: Add a DMA-mapping accounting callback
Date: Fri, 10 Jul 2026 19:55:57 -0700
Message-Id: <20260711025619.2540575-12-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Drivers that use the GPU SVM core to DMA-map system memory for GPU
access may want to keep track of how many pages they have mapped, for
example to expose statistics or to detect leaks. Doing this accounting
in the driver around drm_gpusvm_get_pages() / drm_gpusvm_unmap_pages()
is error prone: the number, order and kind of the dma_addr[] entries can
change between map and unmap (migration, partial unmaps, the iova vs
non-iova paths), which makes symmetric accounting hard to get right.

Add an optional @dma_map_account callback to struct drm_gpusvm_ops and
invoke it once per &drm_pagemap_addr entry at the exact points where the
entry is DMA-mapped (sign == +1) in drm_gpusvm_get_pages() and unmapped
(sign == -1) in __drm_gpusvm_unmap_pages(). Since the map error path and
every unmap/free path funnel through __drm_gpusvm_unmap_pages() for the
entries that were actually mapped, the accounting is symmetric by
construction. The callback receives the full &drm_pagemap_addr so the
driver can use the order and the proto field to distinguish system
memory mappings from device interconnect mappings.

The callback must also be usable by the core drm_gpusvm_pages-only API
(mm == NULL), as used e.g. for userptr-style mappings. Relax
drm_gpusvm_init() to allow such users to pass a restricted @ops that
only implements the page-level hooks; the full-SVM hooks (@invalidate)
and the chunk configuration must still be unset in that mode.

Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 17 +++++++++++++++--
 include/drm/drm_gpusvm.h     | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index fcfe635bc195..512f52471419 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -474,8 +474,15 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
 			return -EINVAL;
 		mmgrab(mm);
 	} else {
-		/* No full SVM mode, only core drm_gpusvm_pages API. */
-		if (ops || num_chunks || mm_range || notifier_size)
+		/*
+		 * No full SVM mode, only core drm_gpusvm_pages API. A
+		 * restricted @ops that only implements the page-level hooks
+		 * (e.g. @dma_map_account) is allowed; the full-SVM hooks must
+		 * not be set.
+		 */
+		if (num_chunks || mm_range || notifier_size)
+			return -EINVAL;
+		if (ops && ops->invalidate)
 			return -EINVAL;
 	}
 
@@ -1246,6 +1253,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 			else if (dpagemap && dpagemap->ops->device_unmap)
 				dpagemap->ops->device_unmap(dpagemap,
 							    dev, addr);
+			if (gpusvm->ops && gpusvm->ops->dma_map_account)
+				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
 			i += 1 << addr->order;
 		}
 
@@ -1654,6 +1663,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 				(addr, DRM_INTERCONNECT_SYSTEM, order,
 				 dma_dir);
 		}
+		if (gpusvm->ops && gpusvm->ops->dma_map_account)
+			gpusvm->ops->dma_map_account(gpusvm,
+						     &svm_pages->dma_addr[j],
+						     1);
 		i += 1 << order;
 		num_dma_mapped = i;
 		flags.has_dma_mapping = true;
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index b7d987bf76aa..36f35816a569 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -75,6 +75,25 @@ struct drm_gpusvm_ops {
 	void (*invalidate)(struct drm_gpusvm *gpusvm,
 			   struct drm_gpusvm_notifier *notifier,
 			   const struct mmu_notifier_range *mmu_range);
+
+	/**
+	 * @dma_map_account: Account a DMA-mapping change (optional)
+	 * @gpusvm: Pointer to the GPU SVM
+	 * @addr: The address descriptor of the chunk being (un)mapped
+	 * @sign: +1 when @addr has just been DMA-mapped, -1 when it is being
+	 *        unmapped
+	 *
+	 * Called once per &drm_pagemap_addr entry, when the entry is
+	 * DMA-mapped by drm_gpusvm_get_pages() (@sign == +1) and when it is
+	 * unmapped (@sign == -1), so the driver can keep symmetric accounting
+	 * of the pages it has mapped for GPU access. The @addr->proto field
+	 * can be used to distinguish system-memory mappings from device
+	 * interconnect mappings. May be provided in both full SVM mode and the
+	 * core drm_gpusvm_pages-only mode.
+	 */
+	void (*dma_map_account)(struct drm_gpusvm *gpusvm,
+				const struct drm_pagemap_addr *addr,
+				int sign);
 };
 
 /**
-- 
2.34.1

