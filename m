Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E65C624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B2210EC22;
	Tue,  1 Sep 2026 09:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oTrsqta";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4ACD10EC22;
 Tue,  1 Sep 2026 09:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA9IySfUN4wLe65ARjiGB6CSiPwaJm+gKQpLAbdC9mZBfbyYiFFnnWWHw4/bYu+IpasC35tnRZxVPv+buRTe1fuMYIpbxH0ZoJXl60am6CNSP1BeNXkmgrg2x9UMaZlbxnqnIrHVygVmIIBP8nNz9QZELGGUThZ+efFSQLq+rzyFoUSc+SQcXaGXm/sl1F/K08isJu36xpsXHWZGSGRh1y4AzZlY7+WDeHRWl3MwQhKypej+vWaWg6Kfc3XezppmpeQInbo7w2zJcfRXxiCYyfTd2sZQGd5j8bsA+gLmML4ujlyJ4+80eJG1KTzHsbzeqgqr387g/yo511QYJ7gD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRsYtgqjecHDj/gdl9GDbnaPWr39fLPG+/8OGzO06HA=;
 b=uT6jMU609w4vbZgYoKspdcp9nV4LldmPHTvPQFNtlQ+yIu1cqNUg06OxuXG3SAPQ+y9isv5aizLlRscs5j/cyem/Gk8g5il87008o6c7Qbj8/qo97bcRM8mLio7FT6lcsrx8t+/wuUbquLYVxBmA4SSM5IgAtFZztWa4iZGreRLkvRyOvg9cfdlTAo8fj7SlAHdYiDGJhARAGZamrOHK7vnF2M2yhV3SjSh2284VNOiftgYWVlpC+27a3UOYURym5/PlHrlLlft38aKa0WZ0T8WnypMGw9I8iy8VhEbmvPx5e4CBgllW4fZXxCNd6mMm+wFNCy1x1BMIhYVqgL23yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRsYtgqjecHDj/gdl9GDbnaPWr39fLPG+/8OGzO06HA=;
 b=4oTrsqta0sa4J7iVBwX6G/6Yg9JRzaoAmOoWzE8/RmUvn/674NzdFf8O1evAswJmviioo726PHN2kVpCYFGr9gKx45l299ydzBW/p1u6vSIi7LcZUTBgqPZE3ugS+2dPZ4DHLaPXI+D0HMouafzAD/NVRhQfjCjxIbAflGS8ySA=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:01:25 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8f) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:01:24 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:01:20 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 2/4] drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
Date: Tue, 1 Sep 2026 17:00:58 +0800
Message-ID: <20260901090100.2024933-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901090100.2024933-1-honghuan@amd.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 861077c5-7c10-434e-205c-08df0807999c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ywcg4xyD6s7H8kY3VdreVpBtr/KtSp/CanKsk5muA9IR7UP9568hymDKF5OetCQZdhK4znY6wV/OUKa7dTs6BiN7HSu4HXgIII+KDJ3erS7j+DA8hA5Ou9WnMP/jZF1KpYklJo1YqKPGZn2qN89FE6wBkHOCdcryMgcbajuqlUSM/17eFSDfDSDgCwcMvJrOZ7gbE+UEWTjMyynCEM+onnaB1tlwsR6K9nd7ngxBJ5u41LbdP3mcfnajSfXXyYSlHa4vQdPKbq5zBulPwK9jAddrPLzazRf5nxr4baH+sCt+fSKpW4fDMRBukUlRvZ/nTnyhIGhBnPAaGfH+4FtkKGiEgNd8Ov7FPxvOYLqGbzJ1Yz619t7baTJOGILESgnEkhmn85l7ghIPexmYm4/BPg21aepG4sEQW+gCluSL4zdoMf7A+OqXkjMgTK6V3yJJWDVSuV6duh8gp1b1yxP4gPUh9kvF86E4CU939bB+K/18WuRtoE2RghJspleIw0zXTpZOcOl5Y+JV9olr4wtXCINHyImH+/R7rpcWBMisYVDLpSfPdiqcsXkpezWdEbhkLonlMLrONYv4+jZ3K0Pv3Zy5ehcwN1wnQyTblfjn3FBrd68FXktePTHDpW+7NWsF60MH+gk9BGoqQVdHFs+OBUyPnhoFvjXmhKuiAkzD2BOv836uUD07JlV2xQsf5fqiWbkyMSP0tOm8GjOCew5PVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8CdEC5jHSez5mRibGaNeS2LNQ5hEhmP5u1x02BT+ANCKnR2uta/t+yQZs/YqyyDsC3hFcAENz8TBqsd5aw8RY8WNJBD8q0lAm+sBWmgZHdSLMF5LGJUYeO2A2uWgl2CiiSgiZV3Ln0XVnrEz8KwqEM6qw1/n42e0eSAQd1c8wO5eLLhIjt4raoAN9AOWsLWyIVFZa9G9YhqL2IkMNjfAYUTezWN0q3VjuoC+pd27RLQ3PzgLVsdjcfkn72q4xKJhdf8EtDhi4ndjSQI90Ke34AFXm9k0IxyLpkOvht9PE9UKOwc7DXhLRKksuvuyFj4b504Wr+ZF7yjZr/WsSIRb054afCAX2Mi9XJHC7XJJPq+01Et3NCjEadcwhQIYm3qMZZFuqA9C+RFXhuorwOeJqCm74U/Tgkmqy2GzLoSLeDHa95X0N+goZ+9Kq+CvAxKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:01:24.3739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861077c5-7c10-434e-205c-08df0807999c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

Move the per-device DMA mapping loop of drm_gpusvm_get_pages() into a
helper drm_gpusvm_dma_map_pages(). The mapping logic is only moved, not
changed, so there is no functional change.

The helper maps the already-faulted pfns into one drm_gpusvm_pages
instance under the notifier lock and unwinds its own partial mapping on
error. The HMM fault and the notifier retry loop stay in get_pages()
common code rather than being pushed down to drivers, so no driver has
to reimplement the subtle fault and retry logic.

With the mapping isolated per instance, get_pages() can later fault once
and DMA map an array of drm_gpusvm_pages plus a count, one per owning
drm_device.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 225 ++++++++++++++++++++---------------
 1 file changed, 129 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b507de539e6..89c3061d8ef 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1442,115 +1442,41 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
 }
 
 /**
- * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
+ * drm_gpusvm_dma_map_pages() - DMA map one drm_gpusvm_pages instance
  * @gpusvm: Pointer to the GPU SVM structure
- * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
- * @mm: The mm corresponding to the CPU range
- * @notifier: The corresponding notifier for the given CPU range
- * @pages_start: Start CPU address for the pages
- * @pages_end: End CPU address for the pages (exclusive)
+ * @svm_pages: The SVM pages instance to populate with dma-addresses
+ * @pfns: The already-faulted pfn array (size @npages)
+ * @npages: Number of pages in the CPU range
  * @ctx: GPU SVM context
+ * @dma_dir: DMA data direction for the mappings
  *
- * This function gets and maps pages for CPU range and ensures they are
- * mapped for DMA access.
+ * Map the faulted @pfns into @svm_pages for DMA access through its owning
+ * drm_device. Must be called under the notifier lock. On failure this unwinds
+ * the partial mapping of this instance before returning.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
-			 struct drm_gpusvm_pages *svm_pages,
-			 struct mm_struct *mm,
-			 struct mmu_interval_notifier *notifier,
-			 unsigned long pages_start, unsigned long pages_end,
-			 const struct drm_gpusvm_ctx *ctx)
+static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
+				    struct drm_gpusvm_pages *svm_pages,
+				    unsigned long *pfns,
+				    unsigned long npages,
+				    const struct drm_gpusvm_ctx *ctx,
+				    enum dma_data_direction dma_dir)
 {
-	struct hmm_range hmm_range = {
-		.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
-			HMM_PFN_REQ_WRITE),
-		.notifier = notifier,
-		.start = pages_start,
-		.end = pages_end,
-		.dev_private_owner = ctx->device_private_page_owner,
-	};
-	void *zdd;
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-	unsigned long remaining;
+	void *zdd = NULL;
 	unsigned long i, j;
-	unsigned long npages = npages_in_range(pages_start, pages_end);
-	unsigned long num_dma_mapped;
+	unsigned long num_dma_mapped = 0;
 	unsigned int order = 0;
-	unsigned long *pfns;
 	int err = 0;
-	struct dev_pagemap *pagemap;
+	struct dev_pagemap *pagemap = NULL;
 	struct drm_pagemap *dpagemap;
 	struct drm_gpusvm_pages_flags flags;
-	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
-							   DMA_BIDIRECTIONAL;
 	struct dma_iova_state *state = &svm_pages->state;
 
-	if (!svm_pages->drm)
-		return -EINVAL;
-
-retry:
-	remaining = timeout - jiffies;
-
-	if (time_after_eq(jiffies, timeout))
-		return -EBUSY;
-
-	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
-		goto set_seqno;
-
-	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
-	if (!pfns)
-		return -ENOMEM;
-
-	if (!mmget_not_zero(mm)) {
-		err = -EFAULT;
-		goto err_free;
-	}
-
-	hmm_range.hmm_pfns = pfns;
-	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
-	mmput(mm);
-	if (err)
-		goto err_free;
-
-	if (!svm_pages->dma_addr) {
-		svm_pages->dma_addr =
-			kvzalloc_objs(*svm_pages->dma_addr, npages);
-		if (!svm_pages->dma_addr) {
-			err = -ENOMEM;
-			goto err_free;
-		}
-	}
-
-	*state = (struct dma_iova_state){};
-	svm_pages->state_offset = 0;
-
-	/*
-	 * Perform all dma mappings under the notifier lock to not
-	 * access freed pages. A notifier will either block on
-	 * the notifier lock or unmap dma.
-	 */
-	drm_gpusvm_notifier_lock(gpusvm);
+	lockdep_assert_held(&gpusvm->notifier_lock);
 
 	flags.__flags = svm_pages->flags.__flags;
-	if (flags.unmapped) {
-		drm_gpusvm_notifier_unlock(gpusvm);
-		err = -EFAULT;
-		goto err_free;
-	}
-
-	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
-		drm_gpusvm_notifier_unlock(gpusvm);
-		kvfree(pfns);
-		goto retry;
-	}
 
-	zdd = NULL;
-	pagemap = NULL;
-	num_dma_mapped = 0;
 	for (i = 0, j = 0; i < npages; ++j) {
 		struct page *page = hmm_pfn_to_page(pfns[i]);
 
@@ -1666,17 +1592,124 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
 	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
 
+	return 0;
+
+err_unmap:
+	svm_pages->flags.has_dma_mapping = true;
+	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
+	return err;
+}
+
+/**
+ * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
+ * @gpusvm: Pointer to the GPU SVM structure
+ * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
+ * @mm: The mm corresponding to the CPU range
+ * @notifier: The corresponding notifier for the given CPU range
+ * @pages_start: Start CPU address for the pages
+ * @pages_end: End CPU address for the pages (exclusive)
+ * @ctx: GPU SVM context
+ *
+ * This function gets and maps pages for CPU range and ensures they are
+ * mapped for DMA access.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
+			 struct drm_gpusvm_pages *svm_pages,
+			 struct mm_struct *mm,
+			 struct mmu_interval_notifier *notifier,
+			 unsigned long pages_start, unsigned long pages_end,
+			 const struct drm_gpusvm_ctx *ctx)
+{
+	struct hmm_range hmm_range = {
+		.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
+			HMM_PFN_REQ_WRITE),
+		.notifier = notifier,
+		.start = pages_start,
+		.end = pages_end,
+		.dev_private_owner = ctx->device_private_page_owner,
+	};
+	unsigned long timeout =
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long remaining;
+	unsigned long npages = npages_in_range(pages_start, pages_end);
+	unsigned long *pfns;
+	int err = 0;
+	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
+							   DMA_BIDIRECTIONAL;
+
+	if (!svm_pages->drm)
+		return -EINVAL;
+
+retry:
+	remaining = timeout - jiffies;
+
+	if (time_after_eq(jiffies, timeout))
+		return -EBUSY;
+
+	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
+	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
+		goto set_seqno;
+
+	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	if (!pfns)
+		return -ENOMEM;
+
+	if (!mmget_not_zero(mm)) {
+		err = -EFAULT;
+		goto err_free;
+	}
+
+	hmm_range.hmm_pfns = pfns;
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
+	mmput(mm);
+	if (err)
+		goto err_free;
+
+	if (!svm_pages->dma_addr) {
+		svm_pages->dma_addr =
+			kvzalloc_objs(*svm_pages->dma_addr, npages);
+		if (!svm_pages->dma_addr) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	svm_pages->state = (struct dma_iova_state){};
+	svm_pages->state_offset = 0;
+
+	/*
+	 * Perform all dma mappings under the notifier lock to not
+	 * access freed pages. A notifier will either block on
+	 * the notifier lock or unmap dma.
+	 */
+	drm_gpusvm_notifier_lock(gpusvm);
+
+	if (svm_pages->flags.unmapped) {
+		drm_gpusvm_notifier_unlock(gpusvm);
+		err = -EFAULT;
+		goto err_free;
+	}
+
+	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
+		drm_gpusvm_notifier_unlock(gpusvm);
+		kvfree(pfns);
+		goto retry;
+	}
+
+	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
+				       dma_dir);
 	drm_gpusvm_notifier_unlock(gpusvm);
+	if (err)
+		goto err_free;
+
 	kvfree(pfns);
 set_seqno:
 	svm_pages->notifier_seq = hmm_range.notifier_seq;
 
 	return 0;
 
-err_unmap:
-	svm_pages->flags.has_dma_mapping = true;
-	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
-	drm_gpusvm_notifier_unlock(gpusvm);
 err_free:
 	kvfree(pfns);
 	if (err == -EAGAIN)
-- 
2.34.1

