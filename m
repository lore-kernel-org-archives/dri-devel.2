Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B4C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C6A10F76B;
	Sat, 27 Jun 2026 03:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3UiGo8P";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC9110F765;
 Sat, 27 Jun 2026 03:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shvbb8gdzhD9NMWJJuyP035lJm+l4nXK9KOnom7WaPyjDk2nKOlC8FjQtRBsScGsOne8atCIIy6JC8EUQHulLxH3+IIRvb02NEO70OEUuCT0uzIVehzm67+b2chyRIUKAvto6FVLqDIqxCeYJkNYsKL3nwl+1f0YJo+K8y0SDfe4nYIc36GcpvOM0H03fla1WaSyHTk4swy6VU00AVDnn6747GOjli6QGTf/KmDiB4XyA7rbObF0Auc1uQl1xJw5xmLeHs27FTOW+B7PHE0Z3U4yANx7xAJTMkUfN5IghXPGBGW2eSEyYRTetpqZNIHVziO4uhm7dMAjrapQ4HtykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLME3IqPDUisEyIOQ8TnygnC3g9nBY+Z2CYmXTxyAvw=;
 b=MOsq8cE4LEenkVFvcOXFrpJjcfoqY83JQUubKgcqxeI0FyNoRqPtLGueQXnLyof5D/JeZ2zMwxie1zxKNpXyPZXI0LcVvV7Aq5soEHlkq3ChgDDgcCnyoxzGoh/vBPmLgdJ8qVbTvUEONFuKPEwu5oWUC5mw68x1pGss1hXYHewaME9zDCErsza5VT/0OWARSmmdhcO1MiJWFA7aFDq5yFZ37tQHgZ95oa88unIFz134uKO+WYu8YjavNEsPijPvwre+0ryD1P/vtCBP4bxQJ5e4yI23LHrxtTKSAMhoX4Cj3V/ozYWknvvKh1SpnGz42wanvgDiZgfRZQx6/IYF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLME3IqPDUisEyIOQ8TnygnC3g9nBY+Z2CYmXTxyAvw=;
 b=V3UiGo8PT42PG/GUYUFvNxtlLb0404zyU/dABYgbgVFQt/3stpvgZTxJ8dFdeUw/oisVjoYtD5Li83pCTwTli2icdixtT0XfXyU6TdBTHhkqHOlC8QylNpyCoAZHaXfTMlS1QFjvL18yULyOk2RdjWekR02DPN+GsM5Q4oZ+jAM=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Sat, 27 Jun
 2026 03:43:36 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::aa) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Sat,
 27 Jun 2026 03:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:43:36 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:43:31 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v4 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of struct
 drm_gpusvm_range
Date: Sat, 27 Jun 2026 11:43:02 +0800
Message-ID: <20260627034303.3795627-5-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627034303.3795627-1-honglei1.huang@amd.com>
References: <20260627034303.3795627-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: e85ac878-8741-4e8c-5641-08ded3fe44f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: F6YNJBtiCOy6Gzfg+Je/X6nO2vyi4QB+Co2vUWc94YuJZ0feZ9DbN8L53qhXJTKprFgL83e9RGACZcBrPTrj+9cNzazlgJdNeW6zz8WxVeugpe5rDk82rLK5jLeg0iONTJWtmaVt0gPNdKsJMTe73XVLLddg9KrwunZYW3VxWO9CG84xYWE1sSf780fN++ak6FxXGLu9bkiWpcOHNExFQyegFl0kHvLYv+w0i4JC8AcogtwmH/Xodoh9mNm5NjDMwluCrQYyxq3I5+nAbDUJwUBnGUEHDTmnjD5XL1Voxu3Bs0J+eS676qSlvOfb9ImtTGacGUYqs2yV90IVIymMl8L4YSD3DXwX/wzHt67g77hAj6wnBP+7LwL/8l87vGrgBXtHaHwkHRcEH8XCb4K/LLY6lRKA91My5ERg+ZSrrA9GKSCNhh6ryZhge/C8zlmVFFHQJbAH1gjV6DReQCYtX76Ce4WmYejkSJdWbC89Qc50fDzsfKYjbuiLWs14TpZt80mlVVm4rraD65XcO6D6iSPhCc2ncnqORo7CUxa00yg1ZCqpbXpnQ2jkqIf6lKYHkuPGRQgMMjuC1eDklCt7t7YSIE164Xv3i5328jfIIE9a/alvpgWGtXvX36TxFztsRyv+Xm5Y6xtPnzk4hl40eXdGblX3yDUQxAWiGlm6vT2zB5sIRpA6me1s3uud8LFC3OqkyLEVbZKrxlcQmbKDvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CnOb0koqzrZXmktMQcB2AlQrhMMB85/dwuV8BAKoip4MmRauwIkM0VjAIROas9AYUOeng6mhGnIt4bCHIR3oWo6M0tlQanTrtGoLV1wx0HSa5o9YZn2seDHqV3nxvk/3I6huMZl9EBT7wpq+kT1/Mb79Prm1r44jV7NvnSBe80lAH3qA5hAEfq2hm7U3HKGqL1EZLHSrKVY00a5MxvSK0YuBDZFYrwdjUv1UtglodQYybJXFvgchE1vB8jS4ox6Os47BukSqIYzqvB5GkHpvQjOoTkPM0M+AUccl9/1Qeqc5HHlRy61RlO0yJEjfQTkBJsv59DQnME3TNVDlQWxaqymHEbqkkUYodHOeYgDKbzx6w3PNdPU99zkcHzbadHArFfuF7fgwbC4IP3GW3PnGxObnBWSuEoqIO+izA+ZQu163VHt9bHBHu+4RtScr5831
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:43:36.4131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85ac878-8741-4e8c-5641-08ded3fe44f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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
 drivers/gpu/drm/drm_gpusvm.c | 163 ++++++++++++++++++-----------------
 include/drm/drm_gpusvm.h     |  13 ---
 2 files changed, 84 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 85fbadc9716..6b79aecb22d 100644
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
@@ -205,6 +257,22 @@
  *
  * .. code-block:: c
  *
+ *	// The driver owns the drm_gpusvm_pages lifecycle. The natural place
+ *	// to release it is the ops->range_free callback, which the framework
+ *	// invokes when the range refcount drops to zero inside
+ *	// drm_gpusvm_range_remove(). drm_gpusvm_free_pages() unmaps any
+ *	// lingering DMA mapping and a no-op if already unmapped and frees the
+ *	// dma_addr array.
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
@@ -215,6 +283,7 @@
  *			drm_gpusvm_range_evict(gpusvm, range);
  *
  *		driver_unbind_range(range);
+ *		// Pages are released by driver_range_free() (ops->range_free).
  *		drm_gpusvm_range_remove(gpusvm, range);
  *	}
  *
@@ -236,17 +305,22 @@
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
@@ -640,8 +714,6 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
 	range->itree.start = ALIGN_DOWN(fault_addr, chunk_size);
 	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
 	INIT_LIST_HEAD(&range->entry);
-	range->pages.notifier_seq = LONG_MAX;
-	range->pages.drm = gpusvm->drm;
 	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
 
 	return range;
@@ -930,7 +1002,7 @@ drm_gpusvm_range_chunk_size(struct drm_gpusvm *gpusvm,
 		 * mallocs 16k but the CPU VMA is ~128k which results in 64k SVM
 		 * ranges. When migrating the SVM ranges, some processes fail in
 		 * drm_pagemap_migrate_to_devmem with 'migrate.cpages != npages'
-		 * and then upon drm_gpusvm_range_get_pages device pages from
+		 * and then upon drm_gpusvm_get_pages device pages from
 		 * other processes are collected + faulted in which creates all
 		 * sorts of problems. Unsure exactly how this happening, also
 		 * problem goes away if 'xe_exec_system_allocator --r
@@ -1335,27 +1407,6 @@ bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
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
@@ -1636,29 +1687,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
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
@@ -1689,29 +1717,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
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

