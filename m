Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6471BC624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A51110EC25;
	Tue,  1 Sep 2026 09:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILN5/OPv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EBA10EC25;
 Tue,  1 Sep 2026 09:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHsn7g1VHJadRqzyx4UkaesiLH+P6CZMZWR3yu+yelPxH9DIH9Hmwq3TlmFa/WXV/8C9XsYNmrbyYOsJzoVtxeKi6hOX7/jnfRYiIewtHDjXuUi6hAU51v96XRm1aIvhtg04rQlugxGYCdeEsL6857N3o7cE0qmuKpy0k9O46A5eVJkKt8dgRn1zGHpGUgEyXVkKpPhRrChlGTU2owVF8Sd+rSw+QKTH/AJsU9WD5p/nzjkXv/TNYGQjFaFiXIIfkqnzbGws0CGsjmzpN9xwvNkK2ePMZvwNxuDnWt6VH6A1ZUve4RAWKor6uFN37qVaUjQIiHko9vFlilGA6QO0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6jDAJ+L5CDQVeyTHtotPpSrAH38bWoFMry8NiCl2bo=;
 b=s/D834dMq56MemtJ/vxsNvsTdgwVG0YuczT210uT+ct4a/GdeNOjomIIDxg+dbN4Ish5PsWzYXE8cn/ktcwtQy77O88hGUG8wgoDMlp6sCAJuYt1GwcTIMZXHnlTFgjvw7VWCTUY73IEDTAlmY+cE1s1WzB+ad3ya4zaTAWJ9BoaLioYXrat3Phh7dUxTpeoGShYDLciZAkGe66cs4Kq1Zc5pe1UNdW7Ctr8VaoFEmgWguHGUNrReQSwr/dcdbu4yNB5OoIX8nFGq/k4X4QG9fPCocAWAmLbHR/WPzPpObM+MUUrHOIR3NaV5EiyeLhZ/6t+KPw2eY6vn9LV3MmWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6jDAJ+L5CDQVeyTHtotPpSrAH38bWoFMry8NiCl2bo=;
 b=ILN5/OPviDZw5yDQRYqZWMyk0HAnX0e4XdPG4pL6cpPNJblnAxYlOwZy1vN1RItDX3iAPn90F1vIxufXZRme48t+QKIvhmGA1iJbW6GmFS5EV2TPvRuXaGeGcR5oRzt4usJz/lFA0brG2c5UyR0aukpskZRV42l1m9CdE8ILczY=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by CHXPR12MB999222.namprd12.prod.outlook.com (2603:10b6:610:2f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:01:29 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::82) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:01:28 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:01:24 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 3/4] drm/gpusvm: let drm_gpusvm_get_pages() map an array of
 pages
Date: Tue, 1 Sep 2026 17:00:59 +0800
Message-ID: <20260901090100.2024933-4-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|CHXPR12MB999222:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b08655-3094-43da-6077-08df08079c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|6133799003|22082099003|18002099003|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GSDcMYb07eP7sIOmfXiOg/OOfgAVe195dVboraZGZ5unZSCUKfqH2fcNtOdU8dnCVWyrQy+qZzk9uRdh2VgbILjL9015TokT7JTD3QEIfTHVJ7u/dJr4cgN6KCKjroWKJZ303NVvQ6aAK0WmKQvoZlu8Tquak/HH8M1c123i17AcbQrb1lfGuwLtnhTUtOGm04O91jr8U8sEwYvo3UBKDC2UR5ADHhhWyy790iPKe4/tK17ArRf5XWQQuyYOYkCzMD6NOxQEHKi0j8Nt+oEhS22hN+qdrPfxE8R7aejx3Dn+U1BbpJKTR+IoK7QPl6RPUhfP0+oklMqNQUkPaccOypHrWy1XldpQzCaW7bqGohciZ5PnkcjVtn7EnGvUz0vbJ3l7+EQVatgsHKoXdW3+MtpoXF0XhdEzCKS16g2ogD7y/wUTMqoUhaR2G5TQcnml/XAzayCpPV+TrHT0qt3ni8XlJrJJPhkUd32isqkvLuKT6LnUS0iLIx8/hhlAqxWpndL+2WFNPfDkAbY9uG2z/hn2Vi0LSeSuGCEerrP22MtinoMv34gVkeOLkPC+ZeRvQetzTJEkNTARo51l+v2rUeHse5rcZmWQJ3LUQdXDxmw4RNFtx+uMopTMSXSx3I/eUzDA1fLo9vhZ5GCMr+RZb6r6u5vLYhj5yXQvX074dmiozk0A7c8FYFIKcgsse8xuhnBkgWtVXiiODSC2c4f+Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qTW9HAYBe/KKEyvHxxwpeNFNOjQwwz1eUmEru0fY9ICyfYzcA7SgTPWeqeQG5ASqhtuRGPK3YqG9RhlTW5wxhFpNMZEl3M+4K9ZqVlXJW51fhVs/ISd9OS2HnzuX56pLp4AGIUoCyFjR1/WpwV5DkD0BwYQRTtCfM2mjRJCqJ0T7JVbxS+yIfWgpyRf7540nEpzd9z62yWTQrLKxqPlscqforM/KCRpKlV74e/ehjyRQFZRtBko11/RsrHkv6A2OzUBgu/dTH5fJKuvLh3oKpVXedm33HHKg9u4iPs+YTfawH6WXOKCE/XB5g5dbY1mMti75vXp4vSOHtopQVo2j0b1af6IY20aLLeKylGlPFI5MNj+qwJm3V3lWyolp4zHbypIOhpBY4uCBaRELEov8Z3O+cGsXPYOkaqAE6AN9ejBvmkWOnuBHrseSDyRAGC2I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:01:28.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b08655-3094-43da-6077-08df08079c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999222
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
count: fault once, then DMA map each instance by
drm_gpusvm_dma_map_pages() under a single read_retry gate. xe range and
userptr callers are updated.

Document the N:1 array usage in the Overview, showing how get_pages()
and drm_gpusvm_range_set_unmapped() take the whole array and its count
while the unmap and free paths stay per-instance.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 141 ++++++++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_svm.c     |   2 +-
 drivers/gpu/drm/xe/xe_userptr.c |   2 +-
 include/drm/drm_gpusvm.h        |   1 +
 4 files changed, 108 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 89c3061d8ef..810f801a9f7 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -80,6 +80,13 @@
  *			};
  *		};
  *
+ *		static struct drm_gpusvm_pages *
+ *		driver_pages(struct driver_range *drange)
+ *		{
+ *			return drange->num_pages == 1 ? &drange->inline_pages :
+ *							drange->pages;
+ *		}
+ *
  *	In the N:1 case the driver allocates the pages array with a zeroing
  *	allocator (e.g. kcalloc(num_pages, ...)), initialises each entry with
  *	drm_gpusvm_init_pages(), and frees each entry with
@@ -89,6 +96,28 @@
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
+ *		err = drm_gpusvm_get_pages(gpusvm, driver_pages(drange),
+ *					   drange->num_pages, gpusvm->mm,
+ *					   &range->notifier->notifier,
+ *					   drm_gpusvm_range_start(range),
+ *					   drm_gpusvm_range_end(range), &ctx);
+ *
+ *		// Notifier callback: mark every instance unmapped in one call
+ *		drm_gpusvm_range_set_unmapped(range, driver_pages(drange),
+ *					      drange->num_pages, mmu_range);
+ *
+ *	The unmap and free paths stay per-instance: iterate @num_pages over
+ *	driver_pages(drange) and call drm_gpusvm_unmap_pages() /
+ *	drm_gpusvm_free_pages() for each entry.
+ *
  * - Operations:
  *	Define the interface for driver-specific GPU SVM operations such as
  *	range allocation, notifier allocation, and invalidations.
@@ -232,7 +261,7 @@
  *				goto retry;
  *		}
  *
- *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
+ *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages, 1,
  *					   gpusvm->mm, &range->notifier->notifier,
  *					   drm_gpusvm_range_start(range),
  *					   drm_gpusvm_range_end(range), &ctx);
@@ -1417,25 +1446,34 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
 /**
  * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
  * @gpusvm: Pointer to the GPU SVM structure
- * @svm_pages: Pointer to the GPU SVM pages structure
+ * @svm_pages: Array of GPU SVM pages structures
+ * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
  *
- * This function determines if a GPU SVM pages are valid. Expected be called
+ * This function determines if every GPU SVM pages instance is valid, dropping
+ * the stale dma_addr array of any instance which is not. Expected be called
  * without holding gpusvm->notifier_lock.
  *
- * Return: True if GPU SVM pages are valid, False otherwise
+ * Return: True if all GPU SVM pages are valid, False otherwise
  */
 static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
-					    struct drm_gpusvm_pages *svm_pages)
+					    struct drm_gpusvm_pages *svm_pages,
+					    unsigned int num_pages)
 {
-	bool pages_valid;
+	bool pages_valid = true;
+	unsigned int p;
 
-	if (!svm_pages->dma_addr)
-		return false;
+	for (p = 0; p < num_pages; ++p) {
+		if (!svm_pages[p].dma_addr)
+			return false;
+	}
 
 	drm_gpusvm_notifier_lock(gpusvm);
-	pages_valid = drm_gpusvm_pages_valid(gpusvm, svm_pages);
-	if (!pages_valid)
-		__drm_gpusvm_free_pages(gpusvm, svm_pages);
+	for (p = 0; p < num_pages; ++p) {
+		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
+			continue;
+		__drm_gpusvm_free_pages(gpusvm, &svm_pages[p]);
+		pages_valid = false;
+	}
 	drm_gpusvm_notifier_unlock(gpusvm);
 
 	return pages_valid;
@@ -1451,8 +1489,9 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
  * @dma_dir: DMA data direction for the mappings
  *
  * Map the faulted @pfns into @svm_pages for DMA access through its owning
- * drm_device. Must be called under the notifier lock. On failure this unwinds
- * the partial mapping of this instance before returning.
+ * drm_device. Must be called under the notifier lock and only for an instance
+ * without a live mapping. On failure this unwinds the partial mapping of this
+ * instance before returning.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -1475,6 +1514,9 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
 
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
+	*state = (struct dma_iova_state){};
+	svm_pages->state_offset = 0;
+
 	flags.__flags = svm_pages->flags.__flags;
 
 	for (i = 0, j = 0; i < npages; ++j) {
@@ -1603,20 +1645,29 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
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
+ * mapped for DMA access. The HMM fault for the CPU range is performed once,
+ * the DMA mapping by drm_gpusvm_dma_map_pages() is then done per instance,
+ * one per owning drm_device. The retry against notifier races is kept here
+ * in common code so drivers never open code it.
+ * The common 1:1 case passes @num_pages == 1.
+ *
+ * On error the instances mapped before the failing one stay mapped, so the
+ * caller must unmap and free every instance regardless of the return value.
  *
  * Return: 0 on success, negative error code on failure.
  */
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			 struct drm_gpusvm_pages *svm_pages,
+			 unsigned int num_pages,
 			 struct mm_struct *mm,
 			 struct mmu_interval_notifier *notifier,
 			 unsigned long pages_start, unsigned long pages_end,
@@ -1638,9 +1689,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	unsigned int p;
 
-	if (!svm_pages->drm)
-		return -EINVAL;
+	for (p = 0; p < num_pages; ++p)
+		if (!svm_pages[p].drm)
+			return -EINVAL;
 
 retry:
 	remaining = timeout - jiffies;
@@ -1649,7 +1702,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		return -EBUSY;
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
+
+	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
 		goto set_seqno;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
@@ -1667,18 +1721,17 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
-	if (!svm_pages->dma_addr) {
-		svm_pages->dma_addr =
-			kvzalloc_objs(*svm_pages->dma_addr, npages);
-		if (!svm_pages->dma_addr) {
+	for (p = 0; p < num_pages; ++p) {
+		if (svm_pages[p].dma_addr)
+			continue;
+		svm_pages[p].dma_addr =
+			kvzalloc_objs(*svm_pages[p].dma_addr, npages);
+		if (!svm_pages[p].dma_addr) {
 			err = -ENOMEM;
 			goto err_free;
 		}
 	}
 
-	svm_pages->state = (struct dma_iova_state){};
-	svm_pages->state_offset = 0;
-
 	/*
 	 * Perform all dma mappings under the notifier lock to not
 	 * access freed pages. A notifier will either block on
@@ -1686,10 +1739,12 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
@@ -1698,15 +1753,29 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
 
+		err = drm_gpusvm_dma_map_pages(gpusvm, &svm_pages[p], pfns,
+					       npages, ctx, dma_dir);
+		if (err) {
+			/*
+			 * The failing instance was unwound by the helper. Keep
+			 * the ones mapped earlier: the -EAGAIN retry reuses
+			 * them, and the driver unmaps every instance with the
+			 * range on the other error paths.
+			 */
+			drm_gpusvm_notifier_unlock(gpusvm);
+			goto err_free;
+		}
+	}
+
+	drm_gpusvm_notifier_unlock(gpusvm);
 	kvfree(pfns);
 set_seqno:
-	svm_pages->notifier_seq = hmm_range.notifier_seq;
+	for (p = 0; p < num_pages; ++p)
+		svm_pages[p].notifier_seq = hmm_range.notifier_seq;
 
 	return 0;
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 627a741293d..1c7793d8caa 100644
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
index 90ac141fc12..9c1dac0fce6 100644
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
index b7d987bf76a..d2b6f3d2b84 100644
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

