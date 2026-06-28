Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E883C43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE7B10E593;
	Sun, 28 Jun 2026 06:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yoqKxIC2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D9710E591;
 Sun, 28 Jun 2026 06:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVmYrJr2yJ6WQ+6PTn3pfpHHjmSoF/Exd0pEjjBhAKkYIs2+xquFZkEZsZ5Wgio38qX6/4TZJdLVMqUXcDnVtTn7gLxWBdZj7KuN1cP8IWmcLZC/LjiDkO7ZglPiwu0RGfdVQMnAg5KhYZaiJampMIsOSHpkSS7UsGbrT4CWwzzHbfkzmP5/7rwFVQK45nA65Uuh1gvKcUKvo2ff5Vz4DznKR3E1IihHgLrDpWOpLO1jGEOx7vybBnKGJerddCjo3ynXIcJQMxC7K40cz0iAG6ADiXrwGX3Y9XLkgB/1inbK2Err8FWInWTZpG4xoClxeIXoJUJYh/an7khVHTKw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YExX3pIW9tYWb5UELdxmMArtMKMVo8BTWx0n5Q0VYE=;
 b=Kkn9htQjXggFomBXAzdevVNeoTG7z4kjCxeW/Ju/zG1E65myov76b2i9Idtfc+rJEwdLIN/6w99hZJ1MlcyHLXblweg5WnQNcfPc0pmChv/q/vp0zBdvAph1Q26Md4dMjiWs3udfeGiGM9nEA+TbKMKnoy8F8vsBjaAPvcLrC45Uj4D23u85IqT5SmD/BpTxFA2vqpE1WweC3jnOt6ok4CFfbRChyK9t2tdBR6fA4aegBPr3hlDOaBON4p8NHazrnObC31ft4AOeXKnj7kejGatw6lakUV2sSE9YmldZw1VMAmdYc6Z4GfqZujSMZsKtZCU6hFbfeZamAUmdL9/hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YExX3pIW9tYWb5UELdxmMArtMKMVo8BTWx0n5Q0VYE=;
 b=yoqKxIC2zSFEm5Apo0FM96aF8hH616QJyqAOIFFitqQq9rc5pqd5vK3Hzq3/NTJoSHf0a5XmH+giwgBCaxfmNP68CZcOg+33cW6jzkOx9xJZLrZMBBY1dMx8HG1F1P3OyS/OsoEzpE4njJ0S+5+1i9UqZ+3lBTTyhdOgTCWpBQU=
Received: from MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::8)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 06:25:51 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::1) by MN0P222CA0005.outlook.office365.com
 (2603:10b6:208:531::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 06:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 06:25:51 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 01:25:47 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v6 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of struct
 drm_gpusvm_range
Date: Sun, 28 Jun 2026 14:25:17 +0800
Message-ID: <20260628062518.4094189-5-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628062518.4094189-1-honglei1.huang@amd.com>
References: <20260628062518.4094189-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 672240b4-3855-4065-57c5-08ded4de19a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cHLeMsXnQR1TLYz0cLI0UPD62z5vTLMeQawHP/F3ug0bHe6cPLyy3O7MoSsQM75B7xd+2Z2nHNKdPnF9qZLF1PeGESI+/MGiDZyMTCrX2FAHBv+g+8uQvkFP18QdU89hMSpswincNHm7t4U4JsO0ZkeMg4sCq1nmiHHP1HXae6uUgWiFx8/u7gWqc3nSqTpmXWvAHuTZDG2YlXJRL0SzJUWPkMgwHxzDZ18sW895ZPpU2QrS+QwH1vYnne1m0gQp3bwiV0Wxno9kq5WkydOvVC+KO1bTI92b/NzX1VRJIkOnm/DLZiKK88QoazVi79YqhPo14/YrNwYHiz7+PY51vy9o60Ly5gAZFzmD9EXlqSTW3+ZMBGox07z9TuHW03PaYaZY0j+LCEhF+1j+hWbfh1jP6VQtsTGsxYIwGHIN1FX6ynMGK7E/rblLBTTUUePOvmE+AaQ6JZQ/pdNGURPcM0DSS2IvYWHc5wVYh0KiWBFvhFNFQcHt6AI/pWv4L9FDu9/E1nIELFRb5FHVHnvpI9WuNpJkJfW6/HRhf9Fm8YL/k+QxkYFBMFGMIP7Lc5LVbsz+N7HbDggPZGZvQyUmESjpX0iRRuWFqvXLHzX8I4uzOQnqd3l8atQkS7gONoXAxFb+FTCQ0fQzebnBWsdqvfz5zJjwOdIp/Fm3UqPsVYuPYB+EoBA7gr0NOeD11PAV93s6r9DANMxtkZM93ZuE5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cP9oejSh7tdGlpheVHs0vc1AYDya8VT8UKADCn1yppsaSu0suu1z/iWBdONNYVYMfngimBLpKqEIeg4a+JM8P8cb2rjY5RzBl4M7RLHmdFXoltN9bmrxfsd7V4lTrwxxsdbP5ow1WLxFH8h9Km+wA3Vz/EJhLfZynseADau53zOFTcXZ8Z39IUgqCQQQQUjWuuzY6kMs/qceUBaSkcDhqndvbadxVqwNOCQMMDXyFquevsdgbIzlM08WXH0vUHR/q+D88G8hjToa4HwrwyXbFA/hmXI1+r5p/Y2MpygoOq4Oo+nK/HIrAunRLrozRkqOD7E4cjYb2qXgUTHXXQRhZMYmqDRXCK06EoM7PUK7eh8LfHO1DLrvrN86WNc98iZTOCX6ZLojNDN6aMKdh3T+4Ef13+smClHXVbrShSRhCjwHzSHrHgBL1Ef9N/jhaORf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 06:25:51.0914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672240b4-3855-4065-57c5-08ded4de19a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

From: Honglei Huang <honghuan@amd.com>

Since the pages the physical pages and MM VA range has been abstractly
separated. Unbinding a single form of physical page from the MM VA
range, brings flexibility to the drm gpu SVM framework, transfer the
way of management of MM and device physical pages to the driver layer.

framework's range embedded pages object and its range level wrappers
have no users left. Remove the following:

  - Drop pages in drm_gpusvm_range.
  - Drop drm_gpusvm_range_pages_valid(), drm_gpusvm_range_get_pages()
    and drm_gpusvm_range_unmap_pages(); drivers should use the
    drm_gpusvm_pages helpers (drm_gpusvm_pages_valid,
    drm_gpusvm_get_pages, drm_gpusvm_unmap_pages) directly on a
    pages object they own.
  - Drop the notifier_seq seeding in drm_gpusvm_range_alloc();
    drivers initialise notifier_seq on their own pages object.

Update the DOC: overview to match the new model: document struct
drm_gpusvm_pages and the driver owned 1:1 / N:1 layouts, and rewrite the
usage examples to operate on a driver embedded pages object by the
drm_gpusvm_pages helpers instead of the removed range level wrappers.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 169 +++++++++++++++++++----------------
 include/drm/drm_gpusvm.h     |  13 ---
 2 files changed, 90 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index ef829558a3c..5537a545f51 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -48,6 +48,47 @@
  *	event. As mentioned above, ranges are tracked in a notifier's Red-Black
  *	tree.
  *
+ * - Pages:
+ *	struct drm_gpusvm_pages holds the DMA mapping state for a range of
+ *	CPU virtual addresses: the DMA mapped device addresses,
+ *	the device private pagemap, the IOVA state, the per mapping
+ *	notifier sequence number, and the drm_device that owns the DMA
+ *	mappings.
+ *	A driver embeds one or more struct drm_gpusvm_pages alongside its
+ *	struct drm_gpusvm_range, choosing one of two layouts:
+ *
+ *	1:1 - one drm_gpusvm_pages per range (one drm_device). Simplest
+ *	layout; to mirror a VA range on several devices a driver uses a
+ *	separate range (and notifier) per device, so the HMM fault is taken
+ *	once per device.
+ *
+ *	N:1 - one drm_gpusvm_pages per drm_device, all sharing one range and
+ *	notifier; only the per-device DMA mapping differs. The instances must
+ *	sit in contiguous memory so a single drm_gpusvm_range_set_unmapped()
+ *	can mark them all. A driver can keep one instance inline for the single
+ *	device case and switch to a heap array only when more devices join,
+ *	e.g.:
+ *
+ *	.. code-block:: c
+ *
+ *		struct driver_range {
+ *			struct drm_gpusvm_range base;
+ *			unsigned int num_pages;	// 1: inline_pages, >1: pages[]
+ *			union {
+ *				struct drm_gpusvm_pages inline_pages;
+ *				struct drm_gpusvm_pages *pages;
+ *			};
+ *		};
+ *
+ *	In the N:1 case the driver allocates the pages array with a zeroing
+ *	allocator (e.g. kcalloc(num_pages, ...)), initialises each entry with
+ *	drm_gpusvm_init_pages(), and frees each entry with
+ *	drm_gpusvm_free_pages() plus the array itself, from its range free
+ *	callback. Each drm_gpusvm_pages is mapped independently by their own
+ *	drm_device.
+ *	Each drm_gpusvm_pages must be zero-initialised and initialised with
+ *	drm_gpusvm_init_pages(), called once per entry.
+ *
  * - Operations:
  *	Define the interface for driver-specific GPU SVM operations such as
  *	range allocation, notifier allocation, and invalidations.
@@ -92,7 +133,7 @@
  * range RB tree and list, as well as the range's DMA mappings and sequence
  * number. GPU SVM manages all necessary locking and unlocking operations,
  * except for the recheck range's pages being valid
- * (drm_gpusvm_range_pages_valid) when the driver is committing GPU bindings.
+ * (drm_gpusvm_pages_valid) when the driver is committing GPU bindings.
  * This lock corresponds to the ``driver->update`` lock mentioned in
  * Documentation/mm/hmm.rst. Future revisions may transition from a GPU SVM
  * global lock to a per-notifier lock if finer-grained locking is deemed
@@ -140,15 +181,20 @@
  *
  * .. code-block:: c
  *
- *	int driver_bind_range(struct drm_gpusvm *gpusvm, struct drm_gpusvm_range *range)
+ *	struct driver_range {
+ *		struct drm_gpusvm_range base;
+ *		struct drm_gpusvm_pages pages;
+ *	};
+ *
+ *	int driver_bind_range(struct drm_gpusvm *gpusvm, struct driver_range *drange)
  *	{
  *		int err = 0;
  *
- *		driver_alloc_and_setup_memory_for_bind(gpusvm, range);
+ *		driver_alloc_and_setup_memory_for_bind(gpusvm, drange);
  *
  *		drm_gpusvm_notifier_lock(gpusvm);
- *		if (drm_gpusvm_range_pages_valid(range))
- *			driver_commit_bind(gpusvm, range);
+ *		if (drm_gpusvm_pages_valid(gpusvm, &drange->pages))
+ *			driver_commit_bind(gpusvm, drange);
  *		else
  *			err = -EAGAIN;
  *		drm_gpusvm_notifier_unlock(gpusvm);
@@ -160,6 +206,8 @@
  *			     unsigned long gpuva_start, unsigned long gpuva_end)
  *	{
  *		struct drm_gpusvm_ctx ctx = {};
+ *		struct driver_range *drange;
+ *		struct drm_gpusvm_range *range;
  *		int err;
  *
  *		driver_svm_lock();
@@ -174,6 +222,7 @@
  *			err = PTR_ERR(range);
  *			goto unlock;
  *		}
+ *		drange = container_of(range, struct driver_range, base);
  *
  *		if (driver_migration_policy(range)) {
  *			err = drm_pagemap_populate_mm(driver_choose_drm_pagemap(),
@@ -183,7 +232,10 @@
  *				goto retry;
  *		}
  *
- *		err = drm_gpusvm_range_get_pages(gpusvm, range, &ctx);
+ *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
+ *					   gpusvm->mm, &range->notifier->notifier,
+ *					   drm_gpusvm_range_start(range),
+ *					   drm_gpusvm_range_end(range), &ctx);
  *		if (err == -EOPNOTSUPP || err == -EFAULT || err == -EPERM) {	// CPU mappings changed
  *			if (err == -EOPNOTSUPP)
  *				drm_gpusvm_range_evict(gpusvm, range);
@@ -192,7 +244,7 @@
  *			goto unlock;
  *		}
  *
- *		err = driver_bind_range(gpusvm, range);
+ *		err = driver_bind_range(gpusvm, drange);
  *		if (err == -EAGAIN)	// CPU mappings changed
  *			goto retry
  *
@@ -205,6 +257,21 @@
  *
  * .. code-block:: c
  *
+ *	// The driver owns the drm_gpusvm_pages lifecycle. ops->range_free is
+ *	// the final fallback: drm_gpusvm_free_pages() unmaps any
+ *	// lingering DMA mapping and a no-op if already unmapped and frees the
+ *	// dma_addr array. The normal flow is to DMA unmap before
+ *	// drm_gpusvm_range_remove() (before the range leaves the tree).
+ *	void driver_range_free(struct drm_gpusvm_range *range)
+ *	{
+ *		struct driver_range *drange =
+ *			container_of(range, struct driver_range, base);
+ *
+ *		drm_gpusvm_free_pages(range->gpusvm, &drange->pages,
+ *				      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
+ *		kfree(drange);
+ *	}
+ *
  *	void __driver_garbage_collector(struct drm_gpusvm *gpusvm,
  *					struct drm_gpusvm_range *range)
  *	{
@@ -215,6 +282,14 @@
  *			drm_gpusvm_range_evict(gpusvm, range);
  *
  *		driver_unbind_range(range);
+ *		// The pages must be DMA unmapped before drm_gpusvm_range_remove()
+ *		// , so a range is never off the MMU interval tree while still DMA
+ *		// mapped as the original drmsvm design flow. Otherwise a concurrent CPU
+ *		// munmap's notifier could miss this range and free pages still mapped
+ *		// for device DMA. This is the normal unmap point.
+ *		drm_gpusvm_unmap_pages(gpusvm, &drange->pages,
+ *				       drm_gpusvm_range_size(range) >> PAGE_SHIFT,
+ *				       &(struct drm_gpusvm_ctx){ .in_notifier = false });
  *		drm_gpusvm_range_remove(gpusvm, range);
  *	}
  *
@@ -236,17 +311,22 @@
  *	{
  *		struct drm_gpusvm_ctx ctx = { .in_notifier = true, };
  *		struct drm_gpusvm_range *range = NULL;
+ *		struct driver_range *drange;
  *
  *		driver_invalidate_device_pages(gpusvm, mmu_range->start, mmu_range->end);
  *
  *		drm_gpusvm_for_each_range(range, notifier, mmu_range->start,
  *					  mmu_range->end) {
- *			drm_gpusvm_range_unmap_pages(gpusvm, range, &ctx);
+ *			drange = container_of(range, struct driver_range, base);
+ *
+ *			drm_gpusvm_unmap_pages(gpusvm, &drange->pages,
+ *					       drm_gpusvm_range_size(range) >> PAGE_SHIFT,
+ *					       &ctx);
  *
  *			if (mmu_range->event != MMU_NOTIFY_UNMAP)
  *				continue;
  *
- *			drm_gpusvm_range_set_unmapped(range, mmu_range);
+ *			drm_gpusvm_range_set_unmapped(range, &drange->pages, 1, mmu_range);
  *			driver_garbage_collector_add(gpusvm, range);
  *		}
  *	}
@@ -640,8 +720,6 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
 	range->itree.start = ALIGN_DOWN(fault_addr, chunk_size);
 	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
 	INIT_LIST_HEAD(&range->entry);
-	range->pages.notifier_seq = LONG_MAX;
-	range->pages.drm = gpusvm->drm;
 	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
 
 	return range;
@@ -930,7 +1008,7 @@ drm_gpusvm_range_chunk_size(struct drm_gpusvm *gpusvm,
 		 * mallocs 16k but the CPU VMA is ~128k which results in 64k SVM
 		 * ranges. When migrating the SVM ranges, some processes fail in
 		 * drm_pagemap_migrate_to_devmem with 'migrate.cpages != npages'
-		 * and then upon drm_gpusvm_range_get_pages device pages from
+		 * and then upon drm_gpusvm_get_pages device pages from
 		 * other processes are collected + faulted in which creates all
 		 * sorts of problems. Unsure exactly how this happening, also
 		 * problem goes away if 'xe_exec_system_allocator --r
@@ -1337,27 +1415,6 @@ bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
 
-/**
- * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
- * @gpusvm: Pointer to the GPU SVM structure
- * @range: Pointer to the GPU SVM range structure
- *
- * This function determines if a GPU SVM range pages are valid. Expected be
- * called holding gpusvm->notifier_lock and as the last step before committing a
- * GPU binding. This is akin to a notifier seqno check in the HMM documentation
- * but due to wider notifiers (i.e., notifiers which span multiple ranges) this
- * function is required for finer grained checking (i.e., per range) if pages
- * are valid.
- *
- * Return: True if GPU SVM range has valid pages, False otherwise
- */
-bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
-				  struct drm_gpusvm_range *range)
-{
-	return drm_gpusvm_pages_valid(gpusvm, &range->pages);
-}
-EXPORT_SYMBOL_GPL(drm_gpusvm_range_pages_valid);
-
 /**
  * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
  * @gpusvm: Pointer to the GPU SVM structure
@@ -1638,29 +1695,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);
 
-/**
- * drm_gpusvm_range_get_pages() - Get pages for a GPU SVM range
- * @gpusvm: Pointer to the GPU SVM structure
- * @range: Pointer to the GPU SVM range structure
- * @ctx: GPU SVM context
- *
- * This function gets pages for a GPU SVM range and ensures they are mapped for
- * DMA access.
- *
- * Return: 0 on success, negative error code on failure.
- */
-int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
-			       struct drm_gpusvm_range *range,
-			       const struct drm_gpusvm_ctx *ctx)
-{
-	return drm_gpusvm_get_pages(gpusvm, &range->pages,
-				    gpusvm->mm,
-				    &range->notifier->notifier,
-				    drm_gpusvm_range_start(range),
-				    drm_gpusvm_range_end(range), ctx);
-}
-EXPORT_SYMBOL_GPL(drm_gpusvm_range_get_pages);
-
 /**
  * drm_gpusvm_unmap_pages() - Unmap GPU svm pages
  * @gpusvm: Pointer to the GPU SVM structure
@@ -1691,29 +1725,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_unmap_pages);
 
-/**
- * drm_gpusvm_range_unmap_pages() - Unmap pages associated with a GPU SVM range
- * @gpusvm: Pointer to the GPU SVM structure
- * @range: Pointer to the GPU SVM range structure
- * @ctx: GPU SVM context
- *
- * This function unmaps pages associated with a GPU SVM range. If @in_notifier
- * is set, it is assumed that gpusvm->notifier_lock is held in write mode; if it
- * is clear, it acquires gpusvm->notifier_lock in read mode. Must be called on
- * each GPU SVM range attached to notifier in gpusvm->ops->invalidate for IOMMU
- * security model.
- */
-void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
-				  struct drm_gpusvm_range *range,
-				  const struct drm_gpusvm_ctx *ctx)
-{
-	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
-					       drm_gpusvm_range_end(range));
-
-	return drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages, ctx);
-}
-EXPORT_SYMBOL_GPL(drm_gpusvm_range_unmap_pages);
-
 /**
  * drm_gpusvm_range_evict() - Evict GPU SVM range
  * @gpusvm: Pointer to the GPU SVM structure
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 3f38283111c..2862104aa1b 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -177,7 +177,6 @@ struct drm_gpusvm_range_flags {
  * @refcount: Reference count for the range
  * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
  * @entry: List entry to fast interval tree traversal
- * @pages: The pages for this range.
  * @flags: Flags for range see &struct drm_gpusvm_range_flags
  *
  * This structure represents a GPU SVM range used for tracking memory ranges
@@ -189,7 +188,6 @@ struct drm_gpusvm_range {
 	struct kref refcount;
 	struct interval_tree_node itree;
 	struct list_head entry;
-	struct drm_gpusvm_pages pages;
 	struct drm_gpusvm_range_flags flags;
 };
 
@@ -307,20 +305,9 @@ drm_gpusvm_range_get(struct drm_gpusvm_range *range);
 
 void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
 
-bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
-				  struct drm_gpusvm_range *range);
-
 bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
 			    struct drm_gpusvm_pages *svm_pages);
 
-int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
-			       struct drm_gpusvm_range *range,
-			       const struct drm_gpusvm_ctx *ctx);
-
-void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
-				  struct drm_gpusvm_range *range,
-				  const struct drm_gpusvm_ctx *ctx);
-
 bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,
 			    unsigned long end);
 
-- 
2.34.1

