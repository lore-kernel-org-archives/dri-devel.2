Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18B9C79F88
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DDD10FA5E;
	Fri,  4 Sep 2026 16:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qUnKxUJy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA4C10FA3E;
 Fri,  4 Sep 2026 16:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5ybAMXbyZTu+uogEhmv35Fjao2VcowjTq7+GZc9lDY4tJuBLfwwfHBvhknomtxfOWzUWjvE8BRvO65rdBl/h+W24CI+8qq7xD6HWa4308QgPvAbkKLeeVCH/tcaAif/kK+PQskcFBdu/pHzkwCtRQO13pkH9ZwYH70cZLp7ykV9+2BLkvCOmrczrIRl8rpWUfZDa0GIteSWJIy+FoeH++0u+Of+vKDIP/aJJ0FSJs9GteNhLvL9vxb71rbNH160hTXd7rAdveaJkykkH+NWhhK9ArzNbpo2J/tAjhHL28NmJHFdttR1+FZUh3Xw1zvL3eY9Ymz8HwXW/TUxe6UQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDeLBJJ6wpVtGqaT+pDHgYhRdOm24LXPi+r9zw61Dbw=;
 b=YrFsoyRtoFJqoNQ8FUC8uuC0LP6rkC3Vly6bcrbhoiuq5ne/LlwK//5giV0JlN4cfnr7DjhgBgOyRMCQ2Zed8Fv+sYbdYjXA3yRyVBIfOfhEW+PTZPU8nw6o0uAQJPqbpDBlFAw7cyoMblB1/mDVBGNZ6/0Vlq1j+uDBsSaH00rieTOsv3G2unmvpMGNigl6S/qW6Rmz1Z4sHfO9gS4PKPQn8jgj67zyHQY0SpWwJRETNFImB/jsSdzjRnZJA4MeB1P7S1947iiIe7J3ie4dqwkKrZevUGkQn2Dl+sWr3weYUmPxnT5rFxL40tfEslalWTezcGkWolHL0HKlvL537g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDeLBJJ6wpVtGqaT+pDHgYhRdOm24LXPi+r9zw61Dbw=;
 b=qUnKxUJyiFd7RwE/LwujlXXVmWAGif/tP5p8uAhSOC7j7PGtYMbqAGMAUB2StUSifiDKvtHF4XafwfUi+LNI8Vj8H/ihlA4he/Xu/z+XNotjd46x0ttihCguqgcRUjJ7+R4kb2AoZM+kkLfaIJP+R/u0hG67HuR/zQXNLNopaJs=
Received: from CH0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:610:b3::15)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 4 Sep 2026
 16:40:19 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::34) by CH0PR03CA0040.outlook.office365.com
 (2603:10b6:610:b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 16:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 16:40:19 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 11:40:15 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 2/6] drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
Date: Sat, 5 Sep 2026 00:39:52 +0800
Message-ID: <20260904163956.3433293-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 819f2eaf-958d-45db-ef62-08df0aa334fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5NHjtERb8svP2ZUfEBWDwAuV3vhSaSlGf+/Yzmoeh1VRs70otYeCLDa0Z93DxFtID8h+wXDQ4PMqJHkDq2onY/PHWyK46wSYE2IF8ucjwgmHW9rDN+O0ImEnbCwAnwkZZXzZiaGX3sEzs8b+V/N/E7vbMaAVBqFjZJ3N0xDlQB/MAbcmKa+MWUndGNWC3D6aX021/EVtW1Z8O9/zO+lpRvzRJulUk8hzso9hNxuKdPtPCR5xJt2kDex1rHfeLXVZUTRkl+AAiYA7k0iXfe/W4DqWKCBoDURl02nkdMlbLXGaRmpcvQ2JbySTV2cEr0GfVBRkWKRq8TPvnFtb296JAdiamHF+kCbBQ9H0ASSmMVAnGlMljneP+KtA8CtYsSS/5krTwTz4evI/F8f8u7gZjQeSfV/AXpcMon07AJKIyhniddKwmFlGxXWuY+xUjVohG2aiK/tKpYS6oKIk899QcIazLFygjnqL2r+AmonUl4kd7cINQkvk63GhWXObuLc0N11+4GN1t7/y8k5xR3es0CUm8w9KFkisftTPWiddRf7a2qX7iNUtWKFbCpoCUMctb2djj4bXPFzapiLJIRmo1b0GE6T08bhJi09958CujaFBTfsrz0RxwXO+ZoMO0eDMRUM0IRoh7ipwe1KJmbU0THtDL+FVQq8gl5Zkn5//WPrUfKqFD5B1rJNqdtuRC7lWCIIjoaX0O1d/FeNP8pV31w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WxhKtF5JRH+ojrJV+s8RqcqbuaXLDnI7TqW1nHaLL9yAlBeQ89VOFHY0OJIywdvgUq2jtr/ybu9RoODciEJsSDLnvUn+klsZrYJilcUHhsEs9wsaVRXuiLsoio4ByZGACTzD1UAe+jnylv35vRmd0bRFoa4400kFlUpUarj2RTbgqislLTN3gfP8J2vaghxyjhPDWSKBfLwiHJHclyVZD1LO9uXleZyowx7d9n+C6KGuxpoRkM7XR633ZamVvw5lfAnGxCTEG3I5F5nOwX33qd2cwPyYYJc41Yuc4PDpWX1S1BiidGpjUd0CFqvXFBzBHxV7ci9nI/RrgXoWuGfSiM84gMXYgdX1wUKbKfyoNWloV1pGSxl5O/oM+lS+Lxte2JWiugZvcWbR96wZbUjptxfT9Cke1Y0nudCDXbkL2/BgGxM1L9ObGFDmxr6IxSLF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:40:19.4395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819f2eaf-958d-45db-ef62-08df0aa334fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
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

