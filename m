Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8374CC79F92
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FD010FA8F;
	Fri,  4 Sep 2026 16:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SV5PE8hp";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B3010FA55;
 Fri,  4 Sep 2026 16:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD0EZkmyG2xyPOYHMrq7llddi2OMx8jQaewo8pjavtG7aswC1muNWKSTM2aexa1hljlD84KTXSuPOUcxHzh9Iu0rPsaCWBjQ1b17x3SSCAgLJxL5YSnGF8cyXwS8C4Ju76fixJ2KZooMvboK+mL2M1AFxfno8d/alkgET5zfbPOFd3dCSZFldikJXra+k4Uornw7nwc+BZOL2zFEIy+WwVxnVLRpM6LDK4qWdw/ttxPkJYCRTCmXETFpTHNX1wu8GkVeuudvSaHiQyGyG/P91xf00soZp0ab7jOGxn7gSjF+Kvmc+2ThhQBPhuIN8vmX3oAv/dvyYVN5XWPgVmV68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/XQ5gEP63hb4twH/YjitLnAKeHgJX69NtrbTLH+IEY=;
 b=uifLDtLCXsNls1Ul2vtPirV14CPu/VXXvJz48+PuLalJ1oEwaMhTFIMuL0C5OnZnGkXeSE3NlggUi2dvWttbMk5cOiPw5dim5ZEBovAyhh/Pa9tJXIQHOWNElTjy2/JKNb0jPCumg8jzRoP/PK7PV/8Mcdru6bVwGYpALOYIWjLDxBSwRZr/swkdG5A9WD4gTYHYzEaN+Iix0UWX73N7Uti2T+xbWJcnhyVRN0WNYmv7+AICeiXcIrwRh5sah+9q1xGAsxleYOHPT+GGTroU3I1RVQLYJ0ntgZEyK035414+Wc/WV2S0DO6Egpekr5PgC0R3GrkqUZwZ4oJhrQVRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/XQ5gEP63hb4twH/YjitLnAKeHgJX69NtrbTLH+IEY=;
 b=SV5PE8hpzq5o1HJ4KoBOe/Zv8pF+Ac1wF6O9iR9UcQBcJaOsYFNE9C0FSwBKwPYhygfclhGST8QHwJcP0coo+qE0Dsv3qylXwiv3N9ARUtsRAxvXqYvgGhVW7lWWJhOxLzSGakRZ3Cqo2IhZsDRG1y1x8H+4dtoG9fqY12h/RjU=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Fri, 4 Sep
 2026 16:40:34 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::1b) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 16:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 16:40:32 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:40:27 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 5/6] drm/gpusvm: keep a single DMA mapping inline for THP
Date: Sat, 5 Sep 2026 00:39:55 +0800
Message-ID: <20260904163956.3433293-6-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904163956.3433293-1-honghuan@amd.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cd506a-d2a8-46b4-1c93-08df0aa33c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ui+WMScQpDDGa3q8h8h+onKkwWCmxDMxEVXDP4BMLDH7RlJqLyGfiE7orBwMy3x10GJXWQRtFpI9PGURWBSToAomdpYDO/pE9r8VH1UMP7lFf4579LmNuV7HoVM/kZISIiXHljWrklfs/rM70pftUPykGI/jvAbko5Jg7HGs5a91iQ7Pa9rzN3y/vAXXqUFym4hmu7YyNG/pgkP6Xzz8NRQLiAXET+WeQlU7msAWKGdvUI0Iu0Ym7yBSJZbd0NDHYkISoB7hS3ibvAwmIwD3D/rzWhNZwWx/XvOHFeSQRq+EjVs7vmnhoAiVns53q0AGDRN01dl1Obg+1eavaQgfEsetCDlRfBWo/eiyzavZlRAtofrI5t/dpro9HABznR0UOL22LxWYSEDmSej5lTDsEnuHaD36J1Ta162Lui6UJWaRxdi4NSHs3BFLu/NUvnqj7H1hkdW4IEjffkYwIeDnrm1mOFCIjaeT4gOZ6bi1eFNOWBOn3DFWxajimBY9qETjhosSph3MLRnrOR89zjQ+WdCl7OUy42AFSPZUsS+qj+HNsEgx4cI+eQSV8SbTYUX4Kz9dIDwmtV94pWEw74eax1PrK4ogvT7DaRmXsVIQWRF66+B1BMHOpMT6xevNSq9O/3r1ERV0PW+uq2p2voTxEmvDCxpuOJZQw+uT+96f12wsLHWzf1moyidzRgUqw8nAHC7BloB3zv2JhvaOlGO6yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jbM32b0mi/bW6AbzO2GKmCDUYzRVrBiyCO8pQ+WqEqm99RRTJXua/FlodmfHPbkB0n9LHGJNRYMts+BNxxammJEEY94+YpIIXIXhmIeBHx0ffgDcEODvasy5qzoP7V6gBrHhemeVTAE91N05J83zYVS8OiqB2X/lJZGJuQMBDz0LIdrZKQDAzpA6ISvPQhVOcv1AS0k/GYpQa2ae+8EDfb/fWN/2wWuYo66BSjVOmSvionotBIX5epD7XDAPGvRQEzZxg6ASp1zmpTCRn6ad5VKwBisxRDfVGBvZD92OVk0aXih1LIMnO/I0+B6nrX2z8L24FeDCTp+IH04Z5IOopPKT6vLPCY2vSs5rV+eBJHGaDS7nIb6l9izpAmojtLkVLCBHbtERam63s+waoeXDCMfaAOi/i38p8yUn5lLpBCE5Bw/xOG+HdhKDmc9He62Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:40:32.0571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cd506a-d2a8-46b4-1c93-08df0aa33c82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

drm_gpusvm_get_pages() sizes the dma_addr array for one drm_pagemap_addr
per page, but the mapping loop advances by page order, so a range backed
by one huge page needs a single entry. For a 2 MiB THP that is an 8 KiB
array holding 16 bytes of address.

Union that entry with the array pointer, discriminated by a new
inline_dma_mapping flag. When drm_gpusvm_dma_map_pages() ends up with one
entry it stores it inline and frees the array, after the last error
unwind, which still walks the array form. An unchecked dma_addr read is
now type confusion rather than a compile error, so reads go through the
new drm_gpusvm_pages_first_dma() accessor, including the two
xe_pt_stage_bind() paths.

Only get_pages() and the free path write the union, never the notifier,
and both run under the driver lock that every address reader already
holds. The unlocked short circuit in drm_gpusvm_pages_valid_unlocked()
goes for the same reason: it cannot resolve the union, and every instance
it rejects has to be reset before the allocation loop reuses it.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 48 ++++++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_pt.c   |  7 ++---
 include/drm/drm_gpusvm.h     | 50 +++++++++++++++++++++++++++++++++---
 3 files changed, 91 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 7efc35507f1..2c7c4c89dc4 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1241,6 +1241,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 		struct drm_gpusvm_pages_flags flags = {
 			.__flags = svm_pages->flags.__flags,
 		};
+		const struct drm_pagemap_addr *addrs =
+			drm_gpusvm_pages_first_dma(svm_pages);
 		bool use_iova = dma_use_iova(&svm_pages->state);
 
 		/*
@@ -1253,12 +1255,12 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 			if (svm_pages->state_offset)
 				dma_iova_unlink(dev, &svm_pages->state, 0,
 						svm_pages->state_offset,
-						svm_pages->dma_addr[0].dir, 0);
+						addrs[0].dir, 0);
 			dma_iova_free(dev, &svm_pages->state);
 		}
 
 		for (i = 0, j = 0; i < npages; j++) {
-			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
+			const struct drm_pagemap_addr *addr = &addrs[j];
 
 			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
 				/*
@@ -1299,6 +1301,18 @@ static void __drm_gpusvm_free_pages(struct drm_gpusvm *gpusvm,
 {
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
+	if (svm_pages->flags.inline_dma_mapping) {
+		struct drm_gpusvm_pages_flags flags = {
+			.__flags = svm_pages->flags.__flags,
+		};
+
+		svm_pages->inline_addr = (struct drm_pagemap_addr){};
+		flags.inline_dma_mapping = false;
+		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
+		WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
+		return;
+	}
+
 	if (svm_pages->dma_addr) {
 		kvfree(svm_pages->dma_addr);
 		svm_pages->dma_addr = NULL;
@@ -1463,11 +1477,6 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
 	bool pages_valid = true;
 	unsigned int p;
 
-	for (p = 0; p < num_pages; ++p) {
-		if (!svm_pages[p].dma_addr)
-			return false;
-	}
-
 	drm_gpusvm_notifier_lock(gpusvm);
 	for (p = 0; p < num_pages; ++p) {
 		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
@@ -1480,6 +1489,21 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
 	return pages_valid;
 }
 
+/**
+ * drm_gpusvm_pages_inlinable() - Whether the dma address can be inlined
+ * @nentries: Number of entries the mapping loop produced
+ *
+ * A THP maps as one huge page, so the whole range needs a single device
+ * address: the dma_addr array can be freed and the address kept inline,
+ * which is where the memory saving comes from.
+ *
+ * Return: True if the mapping fits in a single drm_pagemap_addr.
+ */
+static bool drm_gpusvm_pages_inlinable(unsigned long nentries)
+{
+	return nentries == 1;
+}
+
 /**
  * drm_gpusvm_dma_map_pages() - DMA map one drm_gpusvm_pages instance
  * @gpusvm: Pointer to the GPU SVM structure
@@ -1632,6 +1656,14 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
 	if (pagemap)
 		flags.has_devmem_pages = true;
 
+	if (drm_gpusvm_pages_inlinable(j)) {
+		struct drm_pagemap_addr addr = svm_pages->dma_addr[0];
+
+		kvfree(svm_pages->dma_addr);
+		svm_pages->inline_addr = addr;
+		flags.inline_dma_mapping = true;
+	}
+
 	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
 	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
 
@@ -1740,7 +1772,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 	if (map_dma) {
 		for (p = 0; p < num_pages; ++p) {
-			if (svm_pages[p].dma_addr)
+			if (drm_gpusvm_pages_first_dma(&svm_pages[p]))
 				continue;
 			svm_pages[p].dma_addr =
 				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 5d990c1c374..96ea9735f34 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -831,7 +831,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 			return -EAGAIN;
 		}
 		if (xe_svm_range_has_dma_mapping(range)) {
-			xe_res_first_dma(range->pages.dma_addr, 0,
+			xe_res_first_dma(drm_gpusvm_pages_first_dma(&range->pages), 0,
 					 xe_svm_range_size(range),
 					 &curs);
 			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
@@ -866,8 +866,9 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 
 	if (!xe_vma_is_null(vma) && !range && !is_purged) {
 		if (xe_vma_is_userptr(vma))
-			xe_res_first_dma(to_userptr_vma(vma)->userptr.pages.dma_addr, 0,
-					 xe_vma_size(vma), &curs);
+			xe_res_first_dma(drm_gpusvm_pages_first_dma
+					 (&to_userptr_vma(vma)->userptr.pages),
+					 0, xe_vma_size(vma), &curs);
 		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
 			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
 				     xe_vma_size(vma), &curs);
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index ec7b81957b1..aaad5c9b510 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -10,6 +10,7 @@
 #include <linux/kref.h>
 #include <linux/interval_tree.h>
 #include <linux/mmu_notifier.h>
+#include <drm/drm_pagemap.h>
 
 struct dev_pagemap_ops;
 struct drm_device;
@@ -18,7 +19,6 @@ struct drm_gpusvm_notifier;
 struct drm_gpusvm_ops;
 struct drm_gpusvm_range;
 struct drm_pagemap;
-struct drm_pagemap_addr;
 
 /**
  * struct drm_gpusvm_ops - Operations structure for GPU SVM
@@ -112,6 +112,7 @@ struct drm_gpusvm_notifier {
  * @unmapped: Flag indicating if the pages has been unmapped
  * @has_devmem_pages: Flag indicating if the pages has devmem pages
  * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
+ * @inline_dma_mapping: Flag indicating if the pages have an inline DMA mapping
  * @__flags: Flags for pages in u16 form (used for READ_ONCE)
  */
 struct drm_gpusvm_pages_flags {
@@ -121,6 +122,7 @@ struct drm_gpusvm_pages_flags {
 			u16 unmapped : 1;
 			u16 has_devmem_pages : 1;
 			u16 has_dma_mapping : 1;
+			u16 inline_dma_mapping : 1;
 		};
 		u16 __flags;
 	};
@@ -130,17 +132,27 @@ struct drm_gpusvm_pages_flags {
  * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
  *
  * @drm: The DRM device that owns the dma mappings
- * @dma_addr: Device address array
+ * @dma_addr: Device address array, valid while @flags.inline_dma_mapping is
+ *            not set
+ * @inline_addr: Device address inline address, valid while
+ *               @flags.inline_dma_mapping is set
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
  * @state: DMA IOVA state for mapping.
  * @state_offset: DMA IOVA offset for mapping.
  * @notifier_seq: Notifier sequence number of the range's pages
  * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
+ *
+ * @dma_addr and @inline_addr share storage, discriminated by
+ * @flags.inline_dma_mapping. Driver should use drm_gpusvm_pages_first_dma()
+ * to access the correct DMA address.
  */
 struct drm_gpusvm_pages {
 	struct drm_device *drm;
-	struct drm_pagemap_addr *dma_addr;
+	union {
+		struct drm_pagemap_addr *dma_addr;
+		struct drm_pagemap_addr inline_addr;
+	};
 	struct drm_pagemap *dpagemap;
 	struct dma_iova_state state;
 	unsigned long state_offset;
@@ -365,6 +377,38 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
 	svm_pages->notifier_seq = LONG_MAX;
 }
 
+/**
+ * drm_gpusvm_pages_first_dma() - Resolve the device address array
+ * @svm_pages: Pointer to the drm_gpusvm_pages.
+ *
+ * drm_gpusvm_pages use unions to optimize the storage of DMA addresses,
+ * this function abstracts the access to the first device address. The driver
+ * should use this helper instead of reading dma_addr directly to prevent
+ * array out of bounds access.
+ *
+ * Only get_pages() and the free path switch between the two union members.
+ * Both hold the notifier lock for read, so taking that lock does not stop
+ * them; callers need the driver lock that does, which every reader of the
+ * addresses holds anyway. The notifier never touches the union, so the
+ * pointer returned here stays good and can then be used under the notifier
+ * lock.
+ *
+ * Return: Pointer to the first device address, NULL if none is populated.
+ */
+static inline const struct drm_pagemap_addr *
+drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages)
+{
+	struct drm_gpusvm_pages_flags flags = {
+		/* READ_ONCE pairs with the WRITE_ONCE of the flag writers */
+		.__flags = READ_ONCE(svm_pages->flags.__flags),
+	};
+
+	if (flags.inline_dma_mapping)
+		return &svm_pages->inline_addr;
+
+	return READ_ONCE(svm_pages->dma_addr);
+}
+
 /**
  * enum drm_gpusvm_scan_result - Scan result from the drm_gpusvm_scan_mm() function.
  * @DRM_GPUSVM_SCAN_UNPOPULATED: At least one page was not present or inaccessible.
-- 
2.34.1

