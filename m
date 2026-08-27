Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EECAC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6AB10EE9A;
	Thu, 27 Aug 2026 07:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZWd9Xyu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A80110EEAC;
 Thu, 27 Aug 2026 07:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJP7x+376ZBAKhcK7yS+nm46N0MNc2b7+7rXKkv6jYep77I7ajUkf3jgYeBgoC1JcxdZIdp2Z8ws1ckBeszg4Ig/xVA46/KemjQO2ceEvMJMqK05AypuwwSd4hY9Zpqyw+Y2SNoSNSr6m1kfQRQ4HFcDxZTFkijwJlGZhHtYG5Duhj2WK6YSUN438n+lGf/dtsY+tVBGuz85dcdClDO3yXKBAOnjbS0F8xBvoowpy5bBJ6/rs4V2iqatBv94g9jdy3iix1qEh6PdHLt6Ds+33hEP+7dwuvACYhDiaXKmgQMNsny5HdHSRUA0AuhWBPa276CRmUlLvnlIYrVDZvpq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDfAezxUu1BelHlCox1yqdeSlf8OTx+vb7opDsaNhhc=;
 b=g1w/s0hp0lUsze4ZRDOeOuPI2ekuI4ZDNJKVTmWQqYxgENyahmOGZ7lSxlaq8t4pQJb5KYWGqeoO7VdvebREEP/xpSI+MPSpNUB3k31r7P9oyzwWcp5dRcfsbmr90aUtdzckeu5p3FlobXuhmQzYgDtNL8c4HE2wC0XM/5KE0D7lhqgGzDSQQdJk9iMv21vwm1qe8BzqvVTwNJ9qh/pW2Vf/fuYL5FL/oO1xWWSfUFdkIcW7+euilCowY8W6vm2xllLcLGyKCUyyOS6jS2DQ/HevJTqryGtfCUvdsPkG/NFNS/TEaWTK8Z1rMJA940kFKf6X0PjeGZKS+pEPg91gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDfAezxUu1BelHlCox1yqdeSlf8OTx+vb7opDsaNhhc=;
 b=LZWd9XyunGkDAXOsRyLpSnY9gNmbaYnSGG7jo2CLgqP+NMgeNmqgn8sBYUAUzNaepYWSSCc/MRK3ij1oXcRdsdm6M1ncQOwkkFVslpRiX1c+j9J5dsD2guCrOWafKbiToZeuG0ZWvQUadztrTufyGE4f5Zx0BdfECvupXot8nrY=
Received: from IA4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::10)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 07:15:17 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:559:cafe::67) by IA4P221CA0005.outlook.office365.com
 (2603:10b6:208:559::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 07:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:15:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:15:13 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC PATCH v1 3/5] drm/gpusvm: extract drm_gpusvm_dma_map_pages()
 helper
Date: Thu, 27 Aug 2026 15:14:47 +0800
Message-ID: <20260827071449.520398-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827071449.520398-1-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7b800c-32db-4a05-5c4f-08df040af24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c8elqod4lLtofevLTS9FrJsdk8AixvPLuH2Nit/V3Z+F4SlwsjR2ib2Ym+8rs/q/zYrs/9xcuM+kokfD2UyMHg0CAA3gBwRKcqZ+gpNvANqUErL2qagzlfN/qiogUHMrfH6Cr5ZVPn5lE3WumuwHssZWGNeKAO4DXpdYlktSkgfcyw/ANtxfJinDpem1CHFdnk64gfwB0NtDuwhlAuko0Gpx7u009//kYIVB5pwRESv83ZCcXYkEe5un2THxw0opdDy0srnzgEaPtsj54fQHuSWwK2IlwQuL5aod8TCP8p9s0a+4b5t21M/K8ULKv65x7u7rlpsMRiw3cNEYiGYnkMBz7pkedTV+u3e2Ova5iMlEfDP5YmOpNlyGwxa5qxUNGakHZ6+GNtMZGmIqNKF1k31Ep+UH8S1DS6jG4zz7RSQW3sPJnsO6jF1gLzGlQnSDH4LHOcnbQSHf8jA22nVaYd/FNd2F9AL4b6wfU9Dkpc2r5244QEY1ODpTR3nmAQwZN7WPYCd+zvIzUBNc8JJoHyabAjMDzLnptbJ4k9/2SJVjTfrxWhgWbEwy++DkCwaEZmQLcwCyX18tXepEOnXlKhgT+F5xm1QbBq+7JyTUxxECs218IN+gyJiuaIVwLZP3GxNZbM4xEc9kya2qlaI3XglfY6FKWZtRDkStJnp5BCLAsjcG6SF9S/1o1R2e9ubQ8mTF2UdKpzNiHk9NmxUN6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hEKbE6qTJaVDWyoRg3dcaFNFJ0mOqARMnK1u2o73z2kz8fMg5Nbn3ePiLLFMGkG3iRGThYd1g4Hc1bOkyCKYPM/RuF56YyAt2T8BErRr3+5ktNgwFPWU6bibmRonE+mQZutBHp8jVolg0vVBmBULuU+XTvLz7fRrmpLM8AIvan66qZ03e9WQwZ0yqxU9UNAIWO3YmLlPzL+FfipkWLk6LwamFbwNXY17E0Qxt6nvROMVrMtS2oyM7NeMnJ3O+kpz1kOaL9s8LKseGAXuYNQ2nUWFLCBDBSgTalXdUPqN/KfJQxhLgG2csiLxl7tAS0hBCr+IOzgOoEOlPh62PtlA+5spJU/9Ws2nXnRHXWb93pURWdMLxUBGeZDlROIZd+DsKziQR/Xv4IGExla+sFsAHYtoDdOZ26Vo02yXafvyBAllW/hvkBwYZA8vKmIz2t4J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:15:17.0775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7b800c-32db-4a05-5c4f-08df040af24d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
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
 drivers/gpu/drm/drm_gpusvm.c | 205 ++++++++++++++++++++---------------
 1 file changed, 119 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 3496cb568836..753361b965cf 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1487,105 +1487,41 @@ static int drm_gpusvm_hmm_fault(struct drm_gpusvm *gpusvm,
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
-	if (time_after(jiffies, timeout))
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
-	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
-	if (err)
-		goto err_free;
-
-	if (!svm_pages->dma_addr) {
-		svm_pages->dma_addr =
-			kvmalloc_objs(*svm_pages->dma_addr, npages);
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
 
-	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
-		drm_gpusvm_notifier_unlock(gpusvm);
-		kvfree(pfns);
-		goto retry;
-	}
-
-	zdd = NULL;
-	pagemap = NULL;
-	num_dma_mapped = 0;
 	for (i = 0, j = 0; i < npages; ++j) {
 		struct page *page = hmm_pfn_to_page(pfns[i]);
 
@@ -1695,17 +1631,114 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
+	if (time_after(jiffies, timeout))
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
+	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
+	if (err)
+		goto err_free;
+
+	if (!svm_pages->dma_addr) {
+		svm_pages->dma_addr =
+			kvmalloc_objs(*svm_pages->dma_addr, npages);
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

