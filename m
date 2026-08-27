Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81080C61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529D310EEB2;
	Thu, 27 Aug 2026 07:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qu2PGLM8";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC3710EEAE;
 Thu, 27 Aug 2026 07:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wElCUlB8h9i7W1GQlsadSMBXefGPPKNaHRwYc+pl1ByZ1ncWj7+5tmzF2kJY26sZutiBJAdbVJ+mK/sa7yXDx+v05ssyt9HVWvfxblP1Y5NtHXzxhIm38WcZa2gTNEEVwat2dzyU8PX4WvblTOrB0i/pQjBNReUPDi4e7JZ8F+y4eo5HVpzXYb/26U9DORX+3l0qz2mz+DMxv3YbwrDLLfKBvaWSE7CdvZavaaRtOgq7VVWHyMdDaQ8afJvVBs1+aU9SuOFycun6I1o4TM6E2C5EhynuM74iZXd9/tZgxNENbmnAOx0j3rH4C2NY8ylys3+7Te6lPxlmmwjYoUgegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/945j8h379PAWtHDCfwv6C/EtZyLPTb71/m+jTMOu0=;
 b=JRuoC2kvk/4pJEc6MSlBXS1tGNVz9dR9ZQ36kEnvz/fMAben1tgU0nAseC1SirVU8l9pZ6DwkN14EjFjLPpGwA/bDDTIQWmj6Iyr5/nKUSGvx/4Ld5bRZnR4FpcCQF9uc3asqc7SJtU+WyPlnzCMMPJMgQt0T0ieggwHLJOpN/U7V325Um8uucH0EEmMc66klyzqKpPcRTHgz41b1OpOu3UegbcbV063yNj4ZOhAf3U6VErbAnjzQfgASzDdFSx6XnvSvPYYkLt9iYXYJaJmMJY4b7u3S6h4CFztj/Frh5RFPQ6BJ0LqvUtt4bFNAsUsLesDMDSZOaADOzpEvF+QBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/945j8h379PAWtHDCfwv6C/EtZyLPTb71/m+jTMOu0=;
 b=qu2PGLM8O2Y3aXqIm257Y0GqjgIsM6SCnR1unVFxKgu9A5LQYRF+pksydgQC/9LD9ruS/yTtspR6EZfG19Ul53afQ/nBgqyZNZ3Y5c/kBKTkCcVnpqnxVQd/6KU48bN4D5cbC2w/iJjdTI/6iPxK4re8lUtPHy6wxVWMJQ0yD/Y=
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:15:21 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1e) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Thu, 27
 Aug 2026 07:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:15:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:15:17 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC PATCH v1 4/5] drm/gpusvm: let drm_gpusvm_get_pages() map an
 array of pages
Date: Thu, 27 Aug 2026 15:14:48 +0800
Message-ID: <20260827071449.520398-5-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc85d63-5d9e-4078-e82c-08df040af4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|6133799003|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B4xa2dWPGMtprnoDXBgbiNzj7Ls4Caovcwn0lfHkR3AQOtqJoiQoqjHAexDRQ2MTVYnwwfGCSAOW7BP23L1nP4KNzjIdpxkj5bqgCFQrFEG1QKUR6XQWA8++TpW2sdwnjpWiMkvW2YuVrjo2dmMkSfhC3RbOGDpMZMMX7biiMtCRedXn9u7U2cdcSSsCJQDONGNulVv4dVd6vgEYDKqHD9hLBvg4KPsqnKWFQY/5ZLTuNllRvLIreIGeVvfgQlvH8Q8+V8BGgWrKQPKuQkX6SDqVb57+evrol0+dMdILxPxg6DvH7Hbt/072VDOFc+Kn2pCoAKBqSZV8MwV16PeNCNuaQnime8TN38kMw6ROc7VB82KCCT5ccjPowOyb11QGIMvj0VpxfnPnGk/Ema4PvpQT6WLL/6bKQ3li7/8+O+VpbSEE8OlQnpSsqXaBA+7CHFVK5weKglWZ0Ub79hfR4D7LNDUe2qh8dGLlzZ5ucI2w8bGqb175pwI8C3LC8ReMjgAPTp8Zva4/vnYE+WDb+cbYm6zaSsP+h4B+kYmc/OmnZF49iP7Kk1ytqRyIszzDAkhc5BQmGhMtI4nJpb19BkxtaXEBiL0yo4StHpqCcuHdfW540aRCQB7X9LDYeBtfYm//NJkD+yooQRNWTtvLLYvB0uCuN1BZK8pzpV/EbhndaXucDfFADuDiM4JjZSSEdNjInN7ZwQZwMFiMJ0kOYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ObIdy8mV2fEb0pJ8IW0+PuCTe7jViVP6FjxCdjpWLEOKnBaYFA1sNmuYes4av01v0tkznsvWLRxJygVymd0SU4ShD0TX95+Ji8obgUCwu48ATsdSoO0amx5bBH8b5HkX89fNkM7pVqJghJow06aU5Z/UEyFPV+4OEnZGTAB2YXwe+P9gMfY9K7CiaxMDmp4upfvrcFBdwh5t1mQrhHSSdrlODtsVaY2VlFf6zftULUny6/JYzW20vUgbpDTBE4eQb0AidVJsa5hL6mnY8Co/Y6srfF5luZ7IPGmomi08Nx/AW0xackErVCQvFaw5CguKiW3D+vj3Ot0i+N03YiHFKlpzGcCiYS3UdrN/u7Whr1zghyX6pHrcuBCPCd5+BHuI+pRX/3qmWCin1eCo+ock5cfOcG57Q+5L0b2v9XZ1sMGB9yQ6RCpSGLd/zT4dAXVM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:15:21.1715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc85d63-5d9e-4078-e82c-08df040af4be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817
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

With the N:1 drm_gpusvm_pages layout, one CPU range mirrored on several
drm_devices, the caller had to invoke get_pages() once per device and
repeat the HMM fault every time.

Make get_pages() take a contiguous array of drm_gpusvm_pages plus a
count: fault once through drm_gpusvm_hmm_fault(), then DMA map each
instance by drm_gpusvm_dma_map_pages() under a single read_retry gate.
xe range and userptr callers are updated.

Document the N:1 array usage in the Overview, showing how get_pages()
and drm_gpusvm_range_set_unmapped() take the whole array and its count
while the unmap and free paths stay per-instance.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 101 ++++++++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_svm.c     |   2 +-
 drivers/gpu/drm/xe/xe_userptr.c |   2 +-
 include/drm/drm_gpusvm.h        |   1 +
 4 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 753361b965cf..42e606b94681 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -89,6 +89,27 @@
  *	Each drm_gpusvm_pages must be zero-initialised and initialised with
  *	drm_gpusvm_init_pages(), called once per entry.
  *
+ *	The 1:1 examples below pass @num_pages == 1 and &drange->pages. In the
+ *	N:1 case the driver instead passes the whole array and its count, so a
+ *	single call faults the CPU range once and DMA maps it for every owning
+ *	drm_device, e.g.:
+ *
+ *	.. code-block:: c
+ *
+ *		// GPU fault handler: one fault, one DMA mapping per device
+ *		err = drm_gpusvm_get_pages(gpusvm, drange->pages,
+ *					   drange->num_pages, gpusvm->mm,
+ *					   &range->notifier->notifier,
+ *					   drm_gpusvm_range_start(range),
+ *					   drm_gpusvm_range_end(range), &ctx);
+ *
+ *		// Notifier callback: mark every instance unmapped in one call
+ *		drm_gpusvm_range_set_unmapped(range, drange->pages,
+ *					      drange->num_pages, mmu_range);
+ *
+ *	The unmap and free paths stay per-instance: iterate @num_pages and call
+ *	drm_gpusvm_unmap_pages() / drm_gpusvm_free_pages() for each entry.
+ *
  * - Operations:
  *	Define the interface for driver-specific GPU SVM operations such as
  *	range allocation, notifier allocation, and invalidations.
@@ -232,7 +253,7 @@
  *				goto retry;
  *		}
  *
- *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
+ *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages, 1,
  *					   gpusvm->mm, &range->notifier->notifier,
  *					   drm_gpusvm_range_start(range),
  *					   drm_gpusvm_range_end(range), &ctx);
@@ -1642,20 +1663,26 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
 /**
  * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
  * @gpusvm: Pointer to the GPU SVM structure
- * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
+ * @svm_pages: Array of SVM pages instances to populate with dma addresses
+ * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
  * @mm: The mm corresponding to the CPU range
  * @notifier: The corresponding notifier for the given CPU range
  * @pages_start: Start CPU address for the pages
  * @pages_end: End CPU address for the pages (exclusive)
  * @ctx: GPU SVM context
  *
- * This function gets and maps pages for CPU range and ensures they are
- * mapped for DMA access.
+ * This function gets and maps pages for a CPU range and ensures they are
+ * mapped for DMA access. The HMM fault for the CPU range is performed once
+ * by drm_gpusvm_hmm_fault(). The DMA mapping by drm_gpusvm_dma_map_pages()
+ * is then done per instance, one per owning drm_device. The retry against
+ * notifier races is kept here in common code so drivers never open code it.
+ * The common 1:1 case passes @num_pages == 1.
  *
  * Return: 0 on success, negative error code on failure.
  */
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			 struct drm_gpusvm_pages *svm_pages,
+			 unsigned int num_pages,
 			 struct mm_struct *mm,
 			 struct mmu_interval_notifier *notifier,
 			 unsigned long pages_start, unsigned long pages_end,
@@ -1676,16 +1703,24 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	unsigned int p;
+	bool all_valid;
 
-	if (!svm_pages->drm)
-		return -EINVAL;
+	for (p = 0; p < num_pages; ++p)
+		if (!svm_pages[p].drm)
+			return -EINVAL;
 
 retry:
 	if (time_after(jiffies, timeout))
 		return -EBUSY;
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
+
+	all_valid = true;
+	for (p = 0; p < num_pages; ++p)
+		if (!drm_gpusvm_pages_valid_unlocked(gpusvm, &svm_pages[p]))
+			all_valid = false;
+	if (all_valid)
 		goto set_seqno;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
@@ -1696,18 +1731,19 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
-	if (!svm_pages->dma_addr) {
-		svm_pages->dma_addr =
-			kvmalloc_objs(*svm_pages->dma_addr, npages);
-		if (!svm_pages->dma_addr) {
+	for (p = 0; p < num_pages; ++p) {
+		if (svm_pages[p].dma_addr)
+			continue;
+		svm_pages[p].dma_addr =
+			kvmalloc_objs(*svm_pages[p].dma_addr, npages);
+		if (!svm_pages[p].dma_addr) {
 			err = -ENOMEM;
 			goto err_free;
 		}
+		svm_pages[p].state = (struct dma_iova_state){};
+		svm_pages[p].state_offset = 0;
 	}
 
-	svm_pages->state = (struct dma_iova_state){};
-	svm_pages->state_offset = 0;
-
 	/*
 	 * Perform all dma mappings under the notifier lock to not
 	 * access freed pages. A notifier will either block on
@@ -1715,10 +1751,12 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	 */
 	drm_gpusvm_notifier_lock(gpusvm);
 
-	if (svm_pages->flags.unmapped) {
-		drm_gpusvm_notifier_unlock(gpusvm);
-		err = -EFAULT;
-		goto err_free;
+	for (p = 0; p < num_pages; ++p) {
+		if (svm_pages[p].flags.unmapped) {
+			drm_gpusvm_notifier_unlock(gpusvm);
+			err = -EFAULT;
+			goto err_free;
+		}
 	}
 
 	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
@@ -1727,15 +1765,30 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
-	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
-				       dma_dir);
-	drm_gpusvm_notifier_unlock(gpusvm);
-	if (err)
-		goto err_free;
+	for (p = 0; p < num_pages; ++p) {
+		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
+			continue;
+
+		err = drm_gpusvm_dma_map_pages(gpusvm, &svm_pages[p], pfns,
+					       npages, ctx, dma_dir);
+		if (err) {
+			/*
+			 * drm_gpusvm_dma_map_pages() already cleaned up the
+			 * instance that failed. Leave the earlier ones mapped:
+			 * on -EAGAIN the retry reuses them, on other errors the
+			 * driver frees them with the range. They may also be
+			 * used by other drm_devices, so do not unmap them here.
+			 */
+			drm_gpusvm_notifier_unlock(gpusvm);
+			goto err_free;
+		}
+	}
 
+	drm_gpusvm_notifier_unlock(gpusvm);
 	kvfree(pfns);
 set_seqno:
-	svm_pages->notifier_seq = hmm_range.notifier_seq;
+	for (p = 0; p < num_pages; ++p)
+		svm_pages[p].notifier_seq = hmm_range.notifier_seq;
 
 	return 0;
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 627a741293d5..1c7793d8caa8 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -1598,7 +1598,7 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
 
 	lockdep_assert_held(&range->lock);
 
-	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
+	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages, 1,
 				   vm->svm.gpusvm.mm,
 				   &range->base.notifier->notifier,
 				   drm_gpusvm_range_start(&range->base),
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 90ac141fc12d..9c1dac0fce6f 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -91,7 +91,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
 	if (vma->gpuva.flags & XE_VMA_DESTROYED)
 		return 0;
 
-	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
+	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages, 1,
 				    uvma->userptr.notifier.mm,
 				    &uvma->userptr.notifier,
 				    xe_vma_userptr(vma),
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index b7d987bf76aa..d2b6f3d2b842 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -324,6 +324,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
 
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			 struct drm_gpusvm_pages *svm_pages,
+			 unsigned int num_pages,
 			 struct mm_struct *mm,
 			 struct mmu_interval_notifier *notifier,
 			 unsigned long pages_start, unsigned long pages_end,
-- 
2.34.1

