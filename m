Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D2C79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2DD10E52D;
	Sat,  5 Sep 2026 13:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zlHq/6SX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172BA10E4CC;
 Sat,  5 Sep 2026 13:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc+rUou/9GuuxSn9gE33rYyUyIu4W9rsq3KxrB8rDtee98Ehp9jTk9hTXArYzTJYgCDrOtECfyegxRVH0A3zXOJxwPc/OoE3eaIgmNGrRx985FklwFvpO7jgNFtdkErK8uvYd2QyX1Ce06BrTskQDdDdPufZa11PoOZrE8Eb4Zy/sRza2r4kOR+1MNA6aVVjUa62bUVW7jJesWOmRlmWdY/r19B0IO5/xtpuE1uPAsBiWA7EduQCUR6KDJbdLADUu6aZm3+0Ht7ljoeuhQ1OVDYg46E7E+l6DsjuJsMn6/bnHfycgr0DXQ634Lx4/6XFLg+f6uleuSUxhuPfWX1r9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTr4bQGZXR1NoM6wnYRQjKROLsC5f4Q2UW615wM0+gA=;
 b=WoPuptgxxglnLYoD9euaTDzJXjC5J5r/j0MzmPm8qzYgcQCUEBHVh80LvwFWIYGQKUmkmzvzwdTRJeIZV90pl37vdsznuNPj26Kg0kf+sZFdSDhCIo6rjxoARIv3d+hz80OIE+zVxi1hAYhQZGahsRjwR85eou1LXvgXiNtH+A7oMCrhhXc3RGNm8QA28JiYUCLeyj663EHaWQjJLgvNFe8k8qgUbBb+V5U3GYLok/qe5Syp1sRO3ynKI7dJHtbMu67yPRO5kIJttoFuij5/OTrZ7OsJCdRlYXEodUBkFtrSn38EutOvE8o2pLZ8RiwA4SwGOsuv3tN45CmEwE99xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTr4bQGZXR1NoM6wnYRQjKROLsC5f4Q2UW615wM0+gA=;
 b=zlHq/6SXKvuJsF6WjhBXoZEHaz/JZfVnQ6+f4rUpCky4IrjLNyrX6twZS0bso1DunrMRhej0zukPuSxSUkRUbtevKup/nrDaXCKghffQ+F1QT3zz/aO0r/vpcKSlXeawDc8ccvfNmmBS68W1eXUmf0T8kPy70M69N+GrkgverMc=
Received: from CH2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:610:55::30)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 13:32:23 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::58) by CH2PR18CA0050.outlook.office365.com
 (2603:10b6:610:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 13:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 13:32:22 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 08:32:19 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 6/6] drm/gpusvm: keep an IOVA mapped range dma address
 inline
Date: Sat, 5 Sep 2026 21:31:42 +0800
Message-ID: <20260905133142.3628027-7-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905133142.3628027-1-honghuan@amd.com>
References: <20260905133142.3628027-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbcc71d-0ff0-4349-5ff3-08df0b521e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /uv3bdexC+xpanEtkQ4/YjTcZRWbDdZnKr6xbak9rAfEdUVT8DqpUrOAUi/N3jHfVH9NA5k5zrZS4VedltnKzWjlt72dGH71kWLnkOx/9gDMvTQVNGHZwWMylhRKU3Z/+M36fV1ibFzWM90PZPOpXc8Yx9JvFKFB8rUle3fT2NMR9EjKS8Bhq3Cix4WL5b75Gc620RdwAxRCXDQQZt3Ln8lysb1BlFq5eDYOpbwVmdDKiP+suW+sR2aUDD7azj8qSrnMXP5Xy3NgUQM0h/x9aBDtojyzgOAZymCJ7kbnKibvniJfKhp26mHtgSLwVciJiqNer3UQzVXgTvKzJb4zpNJhQBVQ5W77iRggFfziXXRv8iEkGiG41HaiyOqx7PBK5KY5Pv1CDx40oafIJw+3wOLS7GrnMaHXd3dypqwg2u27Bg6JVYaBIzKD2J90FpWv0h7CzfWCTuz8251c54jPUUJ71DnS5Iv0AC9vLaXRQAWxaiOZwzKWHScUgweMT85DgdTbJWZ6RIscPV7DFShhHFNJnoNXPKVl7TMnIKW0O4PoqjDUTsbtP2KJ//FFBeHnpMmO7NYPMtp2PQaF/vSygvS0mRmOk7DN0V/QvrWOvBIAjyWS/4feQC/mNsDA9hvgYvz1wyLw0+I/JDRMlWEcy/QoRshRE/OIZ3jWWJBsKkfBOI9M34+14CXBA3fWP0N7z4XVUvon40BgYTXFOutg6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GBWjf8iAkC3FUMXbezRzxHFZgnU/qrmWtSbjPeVtjRcoN0k4brS0BppJ4TAAgRqE/etqm+hrRzOUP9qaXqTzuNH4IWbAYVGQsyVciKLHihkiE7BpyK9xDQfHKtLzHV8+fXbRNH4QQp1BSvsYh9kFfwA+kTlo5EV/uPKjQ3FaMKl7pvZ+hhoI7+1W3pvO78EZhbtycdGg8vcKIF/fRLUhX/+S9WXiXk/p6w6Iu8pF3oj97rwPnl5SLeFqkGBftDeT1YjMH2622tbriqhGIR6yXwAqLGJlhya+thtZ8MMFUCWyH+ASh8Vb8uyGrgJfKFg6MHrElWQglNmY4gaIVlJCbUVFsPpVrCbl8rbup9cMGUWSR2BFWVwnuIPkwP1KiJFO7v0evDRpIw9XgfZibX5hOajknB2ThSXkt798IAUJHAZsI1TneZzTPz4M5XqL1F27
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:32:22.8224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbcc71d-0ff0-4349-5ff3-08df0b521e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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

dma_iova_try_alloc() reserves one contiguous IOVA for the whole range and
links each page at the next offset, so the device addresses run
contiguously from entry 0 and one entry describes them all. A 2 MiB range
of 4 KiB pages then drops the same 8 KiB array as a THP backed one.

Fold only when state_offset covers the full range, which proves no device
page was mapped in between, and only single page entries, so the order
kept is 0 and stays true. Widening it instead would tell a consumer to use
a huge page for npages separate CPU pages, which hangs Vega20 on amdgpu.

The kept entry no longer bounds the segment, so skip the unmap walk when
it has nothing to do, keyed off dpagemap rather than the flags, which are
not published yet on the error unwind. Consumers need the same
distinction, so drm_gpusvm_pages_first_dma() returns it alongside the
array from one read of the flags; xe passes it to xe_res_first_dma().

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c       | 41 +++++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_pt.c         | 23 +++++++++++------
 drivers/gpu/drm/xe/xe_res_cursor.h |  5 ++--
 drivers/gpu/drm/xe/xe_svm.h        |  8 +++---
 include/drm/drm_gpusvm.h           | 13 +++++++++-
 5 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 2c7c4c89dc4..b6c9d3a07dc 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1242,7 +1242,7 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 			.__flags = svm_pages->flags.__flags,
 		};
 		const struct drm_pagemap_addr *addrs =
-			drm_gpusvm_pages_first_dma(svm_pages);
+			drm_gpusvm_pages_first_dma(svm_pages, NULL);
 		bool use_iova = dma_use_iova(&svm_pages->state);
 
 		/*
@@ -1259,7 +1259,15 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 			dma_iova_free(dev, &svm_pages->state);
 		}
 
-		for (i = 0, j = 0; i < npages; j++) {
+		/*
+		 * With IOVA and no device page the unlink above tore every
+		 * entry down, and that is also when the range may be folded
+		 * to one entry, which must not be walked per entry. dpagemap
+		 * is set before the first device_map(), so it is also right
+		 * on the error path, where the flags are not published yet.
+		 */
+		for (i = 0, j = 0;
+		     (!use_iova || dpagemap) && i < npages; j++) {
 			const struct drm_pagemap_addr *addr = &addrs[j];
 
 			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
@@ -1491,17 +1499,32 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
 
 /**
  * drm_gpusvm_pages_inlinable() - Whether the dma address can be inlined
+ * @svm_pages: The SVM pages instance that was just mapped
  * @nentries: Number of entries the mapping loop produced
+ * @npages: Number of pages in the CPU range
  *
- * A THP maps as one huge page, so the whole range needs a single device
- * address: the dma_addr array can be freed and the address kept inline,
- * which is where the memory saving comes from.
+ * A THP maps as one huge page, and an IOVA reservation links every page of
+ * the range at the next offset, so the device addresses run contiguously from
+ * entry 0. Either way one entry describes the whole range, so the dma_addr
+ * array can be freed and the address kept inline.
+ *
+ * state_offset advances only on the IOVA branch, so reaching the full range
+ * length proves no device page was mapped in between. Only single page
+ * entries fold, so the order kept is 0 and describes the range truthfully.
+ * Larger chunks, several huge pages among them, stay an array that is
+ * already short and that a consumer places with one PTE each.
  *
  * Return: True if the mapping fits in a single drm_pagemap_addr.
  */
-static bool drm_gpusvm_pages_inlinable(unsigned long nentries)
+static bool drm_gpusvm_pages_inlinable(struct drm_gpusvm_pages *svm_pages,
+				       unsigned long nentries,
+				       unsigned long npages)
 {
-	return nentries == 1;
+	if (nentries == 1)
+		return true;
+
+	return nentries == npages && dma_use_iova(&svm_pages->state) &&
+	       svm_pages->state_offset == npages * PAGE_SIZE;
 }
 
 /**
@@ -1656,7 +1679,7 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
 	if (pagemap)
 		flags.has_devmem_pages = true;
 
-	if (drm_gpusvm_pages_inlinable(j)) {
+	if (drm_gpusvm_pages_inlinable(svm_pages, j, npages)) {
 		struct drm_pagemap_addr addr = svm_pages->dma_addr[0];
 
 		kvfree(svm_pages->dma_addr);
@@ -1772,7 +1795,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 	if (map_dma) {
 		for (p = 0; p < num_pages; ++p) {
-			if (drm_gpusvm_pages_first_dma(&svm_pages[p]))
+			if (drm_gpusvm_pages_first_dma(&svm_pages[p], NULL))
 				continue;
 			svm_pages[p].dma_addr =
 				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index fa4b29da0b6..7fb2fe1f826 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -831,9 +831,12 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 			return -EAGAIN;
 		}
 		if (xe_svm_range_has_dma_mapping(range)) {
-			xe_res_first_dma(xe_svm_range_first_dma(range), 0,
-					 xe_svm_range_size(range),
-					 &curs);
+			const struct drm_pagemap_addr *addr;
+			bool contiguous;
+
+			addr = xe_svm_range_first_dma(range, &contiguous);
+			xe_res_first_dma(addr, 0, xe_svm_range_size(range),
+					 contiguous, &curs);
 			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
 		} else {
 			xe_assert(xe, false);
@@ -865,11 +868,15 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 		xe_bo_assert_held(bo);
 
 	if (!xe_vma_is_null(vma) && !range && !is_purged) {
-		if (xe_vma_is_userptr(vma))
-			xe_res_first_dma(drm_gpusvm_pages_first_dma
-					 (&to_userptr_vma(vma)->userptr.pages),
-					 0, xe_vma_size(vma), &curs);
-		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
+		if (xe_vma_is_userptr(vma)) {
+			const struct drm_pagemap_addr *addr;
+			bool contiguous;
+
+			addr = drm_gpusvm_pages_first_dma(&to_userptr_vma(vma)->userptr.pages,
+							  &contiguous);
+			xe_res_first_dma(addr, 0, xe_vma_size(vma), contiguous,
+					 &curs);
+		} else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
 			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
 				     xe_vma_size(vma), &curs);
 		else
diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_res_cursor.h
index 0522caafd89..c3a037e5f34 100644
--- a/drivers/gpu/drm/xe/xe_res_cursor.h
+++ b/drivers/gpu/drm/xe/xe_res_cursor.h
@@ -233,12 +233,13 @@ static inline void xe_res_first_sg(const struct sg_table *sg,
  * @dma_addr: struct drm_pagemap_addr array to walk
  * @start: Start of the range
  * @size: Size of the range
+ * @contiguous: Whether one entry describes the whole range
  * @cur: cursor object to initialize
  *
  * Start walking over the range of allocations between @start and @size.
  */
 static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
-				    u64 start, u64 size,
+				    u64 start, u64 size, bool contiguous,
 				    struct xe_res_cursor *cur)
 {
 	XE_WARN_ON(!dma_addr);
@@ -248,7 +249,7 @@ static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
 	cur->node = NULL;
 	cur->start = start;
 	cur->remaining = size;
-	cur->dma_seg_size = PAGE_SIZE << dma_addr->order;
+	cur->dma_seg_size = contiguous ? start + size : PAGE_SIZE << dma_addr->order;
 	cur->dma_start = 0;
 	cur->size = 0;
 	cur->dma_addr = dma_addr;
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index 7eb80d4d6db..2ef4ef026cc 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -223,13 +223,14 @@ static inline unsigned long xe_svm_range_size(struct xe_svm_range *range)
 /**
  * xe_svm_range_first_dma() - Resolve the device address array of a SVM range
  * @range: SVM range
+ * @contiguous: Where to store whether one entry spans the whole range
  *
  * Return: Pointer to the first device address, NULL if none is populated.
  */
 static inline const struct drm_pagemap_addr *
-xe_svm_range_first_dma(struct xe_svm_range *range)
+xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
 {
-	return drm_gpusvm_pages_first_dma(&range->pages);
+	return drm_gpusvm_pages_first_dma(&range->pages, contiguous);
 }
 
 void xe_svm_flush(struct xe_vm *vm);
@@ -449,8 +450,9 @@ static inline bool xe_svm_range_is_removed(struct xe_svm_range *range)
 }
 
 static inline const struct drm_pagemap_addr *
-xe_svm_range_first_dma(struct xe_svm_range *range)
+xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
 {
+	*contiguous = false;
 	return NULL;
 }
 
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index aaad5c9b510..9e35584812f 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -380,12 +380,19 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
 /**
  * drm_gpusvm_pages_first_dma() - Resolve the device address array
  * @svm_pages: Pointer to the drm_gpusvm_pages.
+ * @contiguous: Where to store whether one entry spans the whole range, or NULL
  *
  * drm_gpusvm_pages use unions to optimize the storage of DMA addresses,
  * this function abstracts the access to the first device address. The driver
  * should use this helper instead of reading dma_addr directly to prevent
  * array out of bounds access.
  *
+ * @contiguous comes from the same read of the flags as the array itself, so a
+ * caller cannot see the two disagree and walk past that single entry into the
+ * fields behind it. When it is set the length comes from the range rather than
+ * from the order. The order still states what one PTE may cover: the range
+ * length for a huge page, PAGE_SIZE for an IOVA mapped range of single pages.
+ *
  * Only get_pages() and the free path switch between the two union members.
  * Both hold the notifier lock for read, so taking that lock does not stop
  * them; callers need the driver lock that does, which every reader of the
@@ -396,13 +403,17 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
  * Return: Pointer to the first device address, NULL if none is populated.
  */
 static inline const struct drm_pagemap_addr *
-drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages)
+drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages,
+			   bool *contiguous)
 {
 	struct drm_gpusvm_pages_flags flags = {
 		/* READ_ONCE pairs with the WRITE_ONCE of the flag writers */
 		.__flags = READ_ONCE(svm_pages->flags.__flags),
 	};
 
+	if (contiguous)
+		*contiguous = flags.inline_dma_mapping;
+
 	if (flags.inline_dma_mapping)
 		return &svm_pages->inline_addr;
 
-- 
2.34.1

