Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612ECC79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C47810E2BF;
	Sat,  5 Sep 2026 13:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B1+d9YJg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEE510E2A1;
 Sat,  5 Sep 2026 13:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0vqwSNQHKhI0dE13foEcGRVbTN7ZvIRNoP+LGDjM6o1wjzNYQVt0ysG5laVuZpLHtkafIk5DnaVV/2037CVQcp2JqsWcWBuKgF7POlg5iDlvIYWyDJlIs/4N9TtL49sPVoXn8tBbSzOIkTFFvOWFdwW7x6xGYrPc2//NFaRVs1dzgGjwxlZ7Hg/w7C2FGFryMqi2DADl3f/1coimrIZF00qRzvSnOBouIlGtoKXvXRkWON/d3MphYiuj8x1JZxbdkcrXtVQVdoBkWTdf8Mh1WHf7GVKj1TwWyh9PnAm9ka50A1+c/oNHZklJTmrYHsOpXD6A06EW5i55kxRjkr0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDeLBJJ6wpVtGqaT+pDHgYhRdOm24LXPi+r9zw61Dbw=;
 b=y0fjO1kq91DucDdeg0R61OJ6AB5ZVoZZ+dzgG17VPImUkSVBF4MfwnuC/wzID5pGQGt4Rf0OMpQz2+RQhN+fCTKz8ahxQXXu/Vw/NDXexAEY+0tetdkW5tillzBUbr+faeaMOTN4yboD8Azs2hdw2qWpn4/HpSlQIBKFDNVW9hnkn55Am8o3zAn79L0TTusYMxO9q7zxAgxhrGwp1uLKDC5jVgYhBiMjM3tmkmNQIM7xMMoS7+CmdyPvaPni1rOfIw7/EpfsiMIACcmVcMGozTEjC5E14oqeCNkgDsRHThg3F9s5cppMYkSK4uMklfEwu2j0yDCHixnoXUTdNBq0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDeLBJJ6wpVtGqaT+pDHgYhRdOm24LXPi+r9zw61Dbw=;
 b=B1+d9YJgg1ASpwP8r2Yqs61injF+WvFvEVzSNX1u/t32cTdboxgsHhrhDUfkCC3qxPg4FHSPEz6w56AB+a5iN7e42jURiqAElz8kzAeZ9O6THY2tb6rh6tQoZiXaUosgz8J2RJLI4vYfrvp3aV90jLBcmJeaAppZ7qYBFQM1OW8=
Received: from CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 13:32:07 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::ab) by CH0PR04CA0010.outlook.office365.com
 (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 13:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 13:32:07 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 08:32:03 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 2/6] drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
Date: Sat, 5 Sep 2026 21:31:38 +0800
Message-ID: <20260905133142.3628027-3-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 967c1040-9cc5-4ced-7cdf-08df0b5214fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|7416014|36860700016|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Y8X3uI2cDRaWWPLtiPvStp5Ahw3VdUzpbv2WV25H1fvRsw9P1f7EnsTj6f96W5OEiOGaPTe7M15PS5bSbPowTKynWZQ1DqAF7/5NJyT0MKvZ+y1+g1wrQExVJcFVQbmOuPRq7wGmGdcUIFhvGbLSHe7FcCI0Qhc+sQITaMt0L1fTw0ahlUZPCdyaw6zww3/4msZwL+I4bG1oTsks7X0bmj1tGCIezp1I+CQMaIysjyPJVQrbduzZ3fKjK0U63XU3inJuDd3ubrLKqXGwt49UAA/j/iL0vc3sSl5APyHZxxUATSBL6NWdsO5MFHMeINXLAz4MVVmzkE+Z4bs84QRHIHJhUQcHxWWIUi7TGbK3/3NapaQjii+iJpYUBS0psV+uT4bxbadf3gexw7xqZ8iUErxhJ1lnVRGOU0qOoIF0pHtwF9Q/33qnbSdpqJzG4aWmnhOy5kvhu6gvgQfjbqkbsrRc2EI1ZrUS/Pxt58xt81Gm75meqHI37cQC8y2iNwFnCuDvcDqeF+tVdUPFqkM/7+dVKjKvSXuADbvxxdt8+A1bWu/7/8P1+MRNya7w8wn2ddfF44BtIsooQfOMExzf4agC1CxlQvhF1ojf2EzaLnmIBeH1rnE/0zMZko9XWOhzjhc1e4knRyYEOM0SPlcevqXrcr0Z+UKM0ypIA8XKSNHeY9mMmmIB+WtT6UeX8va6XYoLhMtQhxf6d32CL0SglQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MXkDiTnIncKAyFrhcL8t9nyUkb7be9dYZhQcNYMDSCPTzmamMTNO3CLEGv5adf3h2Cuek1DJC+Tm2BTIR/hPI9hyStQiOtnnT0iAo9L9xh49HeMogObw6sVk1Y4uQxwCOF8bakue/8VaePGnSvyXWEqJtKDJqKDTrrAPSRUqZYV/anrqz7/XCisECgyM6xN4J0utb+0+D/4Rtg9j7KGzXejkdBZzhspx19rEtGB/DanjfKZznPtZHUvOKDrgsMCLhx32KJFs+b03/ehdltEAQudn9DekdS0h1guSYB8X7rDHrAmBdMOotG4oOqKB9bNbIuL6rU7FJguhNe4+b4V6QyL18s0KhqfaWp5rs5Wzoo4Znl5gz+EdPOLMH3mpu9UAYf8Od73dvmhuQB9f3pQq5f7saV2ETu5iNv/9kPorkDBWbxSwlxTc+ESZNQrP0XCB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:32:07.6806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967c1040-9cc5-4ced-7cdf-08df0b5214fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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

