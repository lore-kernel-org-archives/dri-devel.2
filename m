Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E5CC79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD3510E2D2;
	Sat,  5 Sep 2026 13:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0S7UCDQ+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A0B10E2D2;
 Sat,  5 Sep 2026 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glJtvEw5+4vbuAAaEBK6m5/HiQvVWnAcqmezCK5Fpt6aT8RC1vM0Qcp3WQ14c7F7PYr11gGrCfknBZLMHB7nbYieo98GXfVMKvsA2fblQ2ob6X91Y1nVJZStWVfyiVy0pUq7hSY2nRKhVMB6qvbERw3I+MzA2hq6BAjzNzy4PBUnW9yg3LjfsxiA6wT5SIqrBwp5yJ/FWy1VZcX9gj8FT9e2GnhGvwGG9Iex/y2t0T20+vP0JVVBgaLEqv0NF4bw514t+X+bIl9D3EtIH1jk332RV5znVcSOuf3vFb2CvpTy61XAuWAVKoqRZgwK2OLUrHtjl2th1h+fE3YJfMBzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wequ0Sy2qLjpOG1HeZu8UFQUSgaasMF36l3WRj8x9+8=;
 b=HWvBk28kiKRPw2XfMleqWPbYT9RWlOdksnrW7EAYgxI+715xpYRdveLmBcVUcGMYz+ILBYjReJFotgscm5iuefcmqaP5aHZUVXHua3KS9clVAiZ7myWnjrVe8gtnZdbvaPyfSY1+/YMjPXMuqfsTt4shw6zHErRaJFGOYb7ggAySGlAL2t3X9vO5NyfeyxTtzCppwb2XhbdcW0y6jrXSygZaNOl9ddVDdRrbFmaW9iAWolBv9fuBxjbYfi10y7UbuR8ID2zR/RUQxwqh78JlHlPCa08Gyue8xWVlkBZZth3fxD1bU75h6bbkV/6PsHmg7AgcJn8koQmTR//J3cPETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wequ0Sy2qLjpOG1HeZu8UFQUSgaasMF36l3WRj8x9+8=;
 b=0S7UCDQ+KwCRKttk/26cRdwa5G2goLBFln016tVDIs+Mj8FlrnXC8txUXCNH3H9osFtMLunLYdjMo/FFwEnC0+Wd697CmOhEBUgTQWhu68D3Wn8RyCr3PiQ/1hkWT07tyAp5T01ySy2CIQBTBnZ4jWrvVnOiIGBfchYxBBYH26E=
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Sat, 5 Sep 2026
 13:32:11 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::1a) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 13:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 13:32:11 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 08:32:07 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 3/6] drm/gpusvm: let drm_gpusvm_get_pages() map an array of
 pages
Date: Sat, 5 Sep 2026 21:31:39 +0800
Message-ID: <20260905133142.3628027-4-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fc8a64-54be-4f5a-ef8f-08df0b521712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|11063799006|56012099006|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZCRPWP/AIKbwMURc3LJj60mL7JXJe9iPHP2u0pmIxhMyjj7vJGjwlAl04mf0Ucm6pnBjoSwLwVvCdaJ0K9Su8nY3CKC6mP2M16PJT5SbOuRPgvtotBFkPUEntqBDq9goHxcwJQv7NTs7CEo0oQzCT8MKmJVyCBzYtdoFVcYP54tofuGlgDP7jLhL46rd7GN2u4nSTdOvTVR8ZJT05HrL6DdoMfcv6y8ZUIJ1CiItK5ydZpKJSJFcLviWrRqJm4fOEsGqzgF3n5Skkpc+3Z9UG+BXGv7Pd882gDH1PkdkixTLctdg5RZdWFcYR8Xbv7Ex+6R4IoMvOluHkIB6ADa83MPhnowS3qE6T+Mu/5YUbPGROmVxb3/w3oZL4uCEKGxwwGvYroAEhjmF7U5Au3I7byNL2aR4s/DjioBmHhqXdXYmhqwzDlypAEusm1motLk6cnfrrjVF81WfkohGR18I+pxH7s/geV7B01t0Md2wTMFnOsfbfgNrtwONJcnqPrIZGapm7QrYLuCacNREYfQFpglPKsflRAuT/iko1swBMI0zEXosoOmyiSD372t5z5XMhCy9eAbYbxrl9G6zhVXCpTwmCGKV58SYF1dVKmuZIpUe/18iJanXRG3h+oexhMMLb2obogGjqzS0GcglKTgEYWKBP2AkiuyvUdAvKKRD5pl+PJqiWgQe9ghlzl0pCIYrPaFN0mXClj3NQs2VGlrXAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VyFQ70G9c6HH4Ku48ZM1x5m0oaZR1j1KHFYjizwT3eTVy41x0tzGQEAp9fGbm+92L3oLf8apDRg7c8jd134LKUyQmrvCQJwltPC0+Uf0p/b434GNXtWZ5v39RcMHKOUxjQMMYuv6ScHxgWIWejLl7l5GqQj0FI6Rrhnpv0GjAw6JZxrYLOBUweDqCQfq95G/6UdY9ERkzUUB6PtgPYf9jqAmVwX8tpemYLlFuZFKPW2P6nfHmZhn5YbFvL6/bhOypHotjaLHnnje9ZCYAMylmCG0yV/HyNwIRytd47HzYWZiFLyBS46Vk7WVy2VgsENEmEKPWAJsIVD6PW6x82bUD78bBtR83rfxFtn0j9DCdvTAyhzI8ajAMW2Dng8rhxvol9HXTnr/Ue21WxQVFgMLPP0BH3TNC7KuV2NDBk9IJ045Rc0HmF0lUWgOiyAS+loh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:32:11.1941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fc8a64-54be-4f5a-ef8f-08df0b521712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 140 ++++++++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_svm.c     |   2 +-
 drivers/gpu/drm/xe/xe_userptr.c |   2 +-
 include/drm/drm_gpusvm.h        |   1 +
 4 files changed, 110 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 89c3061d8ef..d8ee0e5f2ae 100644
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
@@ -1417,25 +1446,35 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
 /**
  * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
  * @gpusvm: Pointer to the GPU SVM structure
- * @svm_pages: Pointer to the GPU SVM pages structure
+ * @svm_pages: Array of GPU SVM pages structures
+ * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
  *
- * This function determines if a GPU SVM pages are valid. Expected be called
- * without holding gpusvm->notifier_lock.
+ * This function determines if every GPU SVM pages instance is valid, resetting
+ * every instance which is not so that get_pages() maps it afresh. It therefore
+ * has to walk them all. Expected be called without holding
+ * gpusvm->notifier_lock.
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
@@ -1451,8 +1490,9 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
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
@@ -1475,6 +1515,9 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
 
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
+	*state = (struct dma_iova_state){};
+	svm_pages->state_offset = 0;
+
 	flags.__flags = svm_pages->flags.__flags;
 
 	for (i = 0, j = 0; i < npages; ++j) {
@@ -1603,20 +1646,28 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
 /**
  * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
  * @gpusvm: Pointer to the GPU SVM structure
- * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
+ * @svm_pages: Array of SVM pages instances to populate with dma addresses
+ * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages, must not be 0
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
@@ -1638,10 +1689,15 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	int err = 0;
 	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
 							   DMA_BIDIRECTIONAL;
+	unsigned int p;
 
-	if (!svm_pages->drm)
+	if (!num_pages)
 		return -EINVAL;
 
+	for (p = 0; p < num_pages; ++p)
+		if (!svm_pages[p].drm)
+			return -EINVAL;
+
 retry:
 	remaining = timeout - jiffies;
 
@@ -1649,7 +1705,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		return -EBUSY;
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
+
+	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
 		goto set_seqno;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
@@ -1667,18 +1724,17 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
@@ -1686,7 +1742,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	 */
 	drm_gpusvm_notifier_lock(gpusvm);
 
-	if (svm_pages->flags.unmapped) {
+	/*
+	 * drm_gpusvm_range_set_unmapped() flags the whole array in one go under
+	 * the write lock, so any instance answers for all of them here.
+	 */
+	if (svm_pages[0].flags.unmapped) {
 		drm_gpusvm_notifier_unlock(gpusvm);
 		err = -EFAULT;
 		goto err_free;
@@ -1698,15 +1758,29 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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

