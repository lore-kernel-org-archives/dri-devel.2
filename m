Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5A5C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD9F10F253;
	Fri, 18 Sep 2026 07:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5/dvi7w";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E9610F253
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiYtcVeU5YiYBXoAx33dvY9SNFWS0V70qJSm1u50Tmp6QeN0E5+pbZ9iZ7bxOJ5GRBTTbDbnGRDc8gT2xgyo5VxLvgOHYMVZcG/FnHaQ+NAbQTuCyTf55XN37fNQ9a6Xy4kBWoSJDPKmcSSsVPbrkwjm2UYpnk1j+V3ZybvZB4WZa6ubOirO4zmwKa00iU2ANVmaPUyda967CvjLJoSTUozpBvPgn15ZLaamVaw7kLCVY3EDLsF3UN59z2pnLX883NaYwhIWrP2rI7b3n91oo8Or/6+KKo/k0eiQm5gHR1G8R1aOOvRb9z05e1D7SKedm6UixBBBE7th91CuT+Og4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ij6MTI2rEWEWzzq17wibdbvykTOH6qfxQbydIk1l2SA=;
 b=lG3WctlzWH9Nf8Ikvvi/pxRLPNolhTwHhLBIDyFKr3MQJGmtqCF2A/MmqHBVYKNEofEaMm7tLTiCX1utAO+wulGCV1oO9+0SpKPqUzEAEL+m6fn4OxdVbYGEWYhU80QUvfPl3yI+2CWcl2UtlO6zD2/6E3GusEy+DkEFsnMch5wWHMRVcQ6Lkux8SzSwCSzpMt2NYm4XA0rrV9+ufUsiIpGOPozJJeVtUyA6ekba5IKma5lPkizdEsjtbu8KutenUY3UasQqlxARPijLudvyvE9+KvBMFPv4jssg+chm4LfTWxgvYVyRkHSxNgyGx4Xp3ORAPm2SAGt/dUtFGopwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij6MTI2rEWEWzzq17wibdbvykTOH6qfxQbydIk1l2SA=;
 b=c5/dvi7wQiJw1/EwhMWT0eY7id8KKWF4XrZPKdYjpxD18wYR0I51Ks6OKcpA6NhTwN/dV5yUc+Sng0FLpbYb5dxSgjYCF5Dky+QCnsqOcfFsj9dL11zTqamb6ts8uW6UZn3pEM1ne9jc1eAVFCUfzvX/vxOjN9gnUDyzp8moh5M=
Received: from SA0PR11CA0019.namprd11.prod.outlook.com (2603:10b6:806:d3::24)
 by SAWPR12MB999116.namprd12.prod.outlook.com (2603:10b6:806:4e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:56:16 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::29) by SA0PR11CA0019.outlook.office365.com
 (2603:10b6:806:d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 07:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 07:56:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 02:56:15 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 3/4] drm/virtio: implement userptr support for zero-copy
 memory access
Date: Fri, 18 Sep 2026 15:55:59 +0800
Message-ID: <20260918075600.2197253-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918075600.2197253-1-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SAWPR12MB999116:EE_
X-MS-Office365-Filtering-Correlation-Id: c2424183-e93d-4ce2-49f7-08df155a515a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|11063799006|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: e1wS0ZE8BQnFiNvks7rLVaigf2sh3FLCyRuL+CTv/y8R91aHuS5ecC9wID3YKRdpzFQmzgf2lVvG6qJ5iB30Sh7f8aGyHRWK1ocwyzMGQEjNpIOe565Hk1s6V0qEwnctzIGToArgzn96z5JO8yM+2ZgL0/FBUz0EuOkaqYLqvDRCrDpP4NVaTLdrMo9dIF5WWJkqlf6a90bEVmIoozdA2LijcYq69ndnYk5gs8kmIs2SbfWb3BoOaQWQVgrMsjQzoASDHzbbjCerHZVR+XAxqR2eaEZMjQ26BzDRmkyxSOAl9KsLl7itFLRboRSQOREIiygVx3Vy2QbfTJIyWcedByZhVKXgl4m8J520zoYvq6VDu4d5F7JAvr/uhUmmugOq/mm5LgApBcBBL915Qz+pT91h+er32LsIljpeLM5Ozzh3T0JF7w+dUv9f5HjFn1WABedIGYjnifpWUTdnNbhZcqYeWjSKfpuJ5l/1eRunSBRyHekEVJ/Mc6hs8wGXDTxapR8/z4RHI06wLhQzoOSD1uKy5HEaFkx5NXqU+WaAdKSAXB0ZO7un3SypvA/6Rh1TE4f2RSxFdKCB153B4TJMdBCl+UQOHgnOuccgqfxDu8oM5RvCXYlwktpQSnTW11nTMbqGFOtWuLc+KBFTJlPndNGdVSrBB49+hBjFdRpx3prv6WSCJ5vqovOMziC8swFiZMc1zQ3Habk+g9wUaQ1IBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HyCeTo6wmwYU6EdmWGoNkN7fdIoq8juvphdVec1+UBSVpaSkPCUG3u33mK/QkXl8ky+/GBM2Gtv+F/J0NMsD4aTcwBkz9X3L4l4RZ7QTAa+4EbYYc+TbAFN//BfYM6zPohu4358xL2vyK0DhDBh3cYWe47HMpFth0D9c/Sh2rprZVpVab43MkB3uwTfw3AosGpM9GkNs0ZlBDP8/XW/PkQdTRrjdThBKgJ5kJ+agnE7ImyMjMEh3Zrdv863Yc5AmzPQPCinlgdlfXToSxOvm1W5FOXHUSjFGtQPMDY6Py4bjINkb1l06SovyTHgMyvqq8ZlJnDP4dtsp+AMmH2c5h1+fhpUf9DD9ej6461NVhSCOR9sa8W7RcvcRVGk3j6cJOyoJEyZBsRfpa3jzstUmNYlF3VbZGRugBRIM1327WwLT0gDQ2nG+WaQffbicWuwz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:56:16.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2424183-e93d-4ce2-49f7-08df155a515a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999116
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

Add userptr blob objects so the guest kernel can pin an existing
userspace mapping and advertise it as CREATE_BLOB backing entries.

- New virtio_gpu_object_userptr type for userptr resources
- Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
- Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
- Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
- DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
  required; use DMA_TO_DEVICE for USE_READONLY blobs
- Sync userptr SG for the device on TRANSFER_TO_HOST
- Mark writable pages dirty when unpinning
- Keep pages pinned until RESOURCE_UNREF is queued; drop them from
  cleanup_object() on the unref response or on create failure
- Clear userptr->pages on pin failure to avoid double-free on cleanup
- Reject unaligned or overflowing userptr ranges at create time
- Disallow PRIME export of userptr objects

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  39 +++
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 330 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 ++-
 5 files changed, 405 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index d2e1788a82..fe7332a621 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -6,6 +6,7 @@
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
 	virtgpu_display.o virtgpu_vq.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
-	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o
+	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o \
+	virtgpu_userptr.o
 
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9df4c71173..df1dad4ea1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -105,6 +105,7 @@ struct virtio_gpu_object_params {
 	uint32_t blob_flags;
 	uint64_t blob_id;
 	uint32_t blob_hints;
+	uint64_t userptr;
 };
 
 struct virtio_gpu_object {
@@ -138,12 +139,42 @@ struct virtio_gpu_object_vram {
 	struct drm_mm_node vram_node;
 };
 
+struct virtio_gpu_object_userptr;
+
+struct virtio_gpu_object_userptr_ops {
+	int (*get_pages)(struct virtio_gpu_object_userptr *userptr);
+	void (*put_pages)(struct virtio_gpu_object_userptr *userptr);
+};
+
+struct virtio_gpu_object_userptr {
+	struct virtio_gpu_object base;
+	const struct virtio_gpu_object_userptr_ops *ops;
+	/* Protects pages and sgt. */
+	struct mutex lock;
+
+	uint64_t start;
+	uint32_t npages;
+	uint32_t bo_handle;
+	uint32_t flags;
+
+	struct virtio_gpu_device *vgdev;
+	struct drm_file *file;
+	struct page **pages;
+	struct sg_table *sgt;
+	bool dma_mapped;
+	enum dma_data_direction dma_dir;
+	struct mm_struct *mm;
+};
+
 #define to_virtio_gpu_shmem(virtio_gpu_object) \
 	container_of((virtio_gpu_object), struct virtio_gpu_object_shmem, base)
 
 #define to_virtio_gpu_vram(virtio_gpu_object) \
 	container_of((virtio_gpu_object), struct virtio_gpu_object_vram, base)
 
+#define to_virtio_gpu_userptr(virtio_gpu_object) \
+	container_of((virtio_gpu_object), struct virtio_gpu_object_userptr, base)
+
 struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
 	struct list_head next;
@@ -284,6 +315,7 @@ struct virtio_gpu_device {
 	bool has_host_visible;
 	bool has_context_init;
 	bool has_blob_alignment;
+	bool has_blob_readonly;
 	bool hibernated;
 	struct virtio_shm_region host_visible_region;
 	struct drm_mm host_visible_mm;
@@ -562,4 +594,11 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file);
 
+/* virtgpu_userptr.c */
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr);
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
+void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object *bo);
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 49899485be..5c40f5a034 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -91,6 +91,16 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 		drm_gem_free_mmap_offset(&vram->base.base.base);
 		drm_gem_object_release(&vram->base.base.base);
 		kfree(vram);
+	} else if (virtio_gpu_is_userptr(bo)) {
+		struct virtio_gpu_object_userptr *userptr =
+			to_virtio_gpu_userptr(bo);
+
+		mutex_lock(&userptr->lock);
+		userptr->ops->put_pages(userptr);
+		mutex_unlock(&userptr->lock);
+		mutex_destroy(&userptr->lock);
+		drm_gem_object_release(&userptr->base.base.base);
+		kfree(userptr);
 	} else {
 		drm_gem_object_release(&bo->base.base);
 		kfree(bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/virtio/virtgpu_userptr.c
new file mode 100644
index 0000000000..2f86a95ad2
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/limits.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
+#include <linux/pid.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/vmalloc.h>
+
+#include "virtgpu_drv.h"
+#include <drm/drm_gem.h>
+
+static void virtio_gpu_userptr_free(struct drm_gem_object *obj)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+
+	/*
+	 * Keep pages pinned until RESOURCE_UNREF completes. The response
+	 * callback calls virtio_gpu_cleanup_object(), which drops them.
+	 */
+	if (bo->created) {
+		virtio_gpu_remove_from_restore_list(bo);
+		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
+		virtio_gpu_notify(vgdev);
+		return;
+	}
+
+	virtio_gpu_cleanup_object(bo);
+}
+
+static struct dma_buf *
+virtio_gpu_userptr_prime_export(struct drm_gem_object *obj, int flags)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
+	.open = virtio_gpu_gem_object_open,
+	.close = virtio_gpu_gem_object_close,
+	.free = virtio_gpu_userptr_free,
+	.export = virtio_gpu_userptr_prime_export,
+};
+
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo)
+{
+	return bo->base.base.funcs == &virtio_gpu_userptr_funcs;
+}
+
+void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object *bo)
+{
+	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+	struct device *dev;
+
+	if (!userptr->dma_mapped)
+		return;
+
+	dev = drm_dev_dma_dev(userptr->base.base.base.dev);
+	dma_sync_sgtable_for_device(dev, userptr->sgt, DMA_TO_DEVICE);
+}
+
+static int
+virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
+{
+	unsigned int flag = FOLL_LONGTERM;
+	unsigned int num_pages, pinned = 0;
+	int ret = 0;
+
+	if (userptr->pages)
+		return 0;
+
+	userptr->pages = kvmalloc_array(userptr->npages, sizeof(struct page *),
+					GFP_KERNEL);
+	if (!userptr->pages)
+		return -ENOMEM;
+
+	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY))
+		flag |= FOLL_WRITE;
+
+	do {
+		num_pages = userptr->npages - pinned;
+
+		ret = pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
+					  num_pages, flag,
+					  userptr->pages + pinned);
+
+		if (ret < 0) {
+			if (pinned)
+				unpin_user_pages(userptr->pages, pinned);
+			kvfree(userptr->pages);
+			userptr->pages = NULL;
+			return ret;
+		}
+
+		pinned += ret;
+
+	} while (pinned < userptr->npages);
+
+	return 0;
+}
+
+static void
+virtio_gpu_userptr_unaccount(struct virtio_gpu_object_userptr *userptr)
+{
+	if (!userptr->mm)
+		return;
+
+	atomic64_sub(userptr->npages, &userptr->mm->pinned_vm);
+	mmdrop(userptr->mm);
+	userptr->mm = NULL;
+}
+
+static void
+virtio_gpu_userptr_put_pages(struct virtio_gpu_object_userptr *userptr)
+{
+	struct drm_device *dev = userptr->base.base.base.dev;
+
+	if (userptr->sgt) {
+		if (userptr->dma_mapped)
+			dma_unmap_sgtable(drm_dev_dma_dev(dev), userptr->sgt,
+					  userptr->dma_dir, 0);
+		userptr->dma_mapped = false;
+		sg_free_table(userptr->sgt);
+		kfree(userptr->sgt);
+		userptr->sgt = NULL;
+	}
+
+	if (userptr->pages) {
+		bool dirty = !(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY);
+
+		unpin_user_pages_dirty_lock(userptr->pages, userptr->npages,
+					    dirty);
+		kvfree(userptr->pages);
+		userptr->pages = NULL;
+	}
+
+	virtio_gpu_userptr_unaccount(userptr);
+}
+
+static int
+virtio_gpu_userptr_get_entries(struct virtio_gpu_device *vgdev,
+			       struct virtio_gpu_object_userptr *userptr,
+			       struct virtio_gpu_mem_entry **ents,
+			       unsigned int *nents)
+{
+	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
+	struct scatterlist *sg;
+	unsigned int count;
+	int si;
+
+	count = use_dma_api ? userptr->sgt->nents : userptr->sgt->orig_nents;
+	if (!count)
+		return -EINVAL;
+
+	*ents = kvmalloc_array(count, sizeof(**ents), GFP_KERNEL);
+	if (!*ents)
+		return -ENOMEM;
+
+	if (use_dma_api) {
+		for_each_sgtable_dma_sg(userptr->sgt, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
+			(*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
+			(*ents)[si].padding = 0;
+		}
+	} else {
+		for_each_sgtable_sg(userptr->sgt, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_phys(sg));
+			(*ents)[si].length = cpu_to_le32(sg->length);
+			(*ents)[si].padding = 0;
+		}
+	}
+
+	*nents = count;
+	return 0;
+}
+
+static int
+virtio_gpu_userptr_init(struct drm_device *dev, struct drm_file *file,
+			struct virtio_gpu_object_userptr *userptr,
+			struct virtio_gpu_object_params *params,
+			const struct virtio_gpu_object_userptr_ops *ops)
+{
+	struct drm_gem_object *obj;
+	int ret;
+
+	userptr->start = params->userptr;
+	userptr->npages = params->size >> PAGE_SHIFT;
+	userptr->flags = params->blob_flags;
+
+	mutex_init(&userptr->lock);
+	userptr->vgdev = dev->dev_private;
+	userptr->file = file;
+	userptr->ops = ops;
+
+	/*
+	 * Allocate the resource id before GEM init so a failure here can
+	 * unwind with a plain kfree and does not need a special id=0 guard
+	 * in the shared resource_id_put helper.
+	 */
+	ret = virtio_gpu_resource_id_get(userptr->vgdev,
+					 &userptr->base.hw_res_handle);
+	if (ret) {
+		mutex_destroy(&userptr->lock);
+		return ret;
+	}
+
+	obj = &userptr->base.base.base;
+	obj->funcs = &virtio_gpu_userptr_funcs;
+
+	drm_gem_private_object_init(dev, obj, params->size);
+	INIT_LIST_HEAD(&userptr->base.restore_node);
+
+	return 0;
+}
+
+static const struct virtio_gpu_object_userptr_ops virtio_gpu_userptr_ops = {
+	.get_pages = virtio_gpu_userptr_get_pages,
+	.put_pages = virtio_gpu_userptr_put_pages,
+};
+
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr)
+{
+	struct virtio_gpu_object_userptr *userptr;
+	struct virtio_gpu_mem_entry *ents = NULL;
+	struct sg_table *sgt;
+	struct mm_struct *mm;
+	unsigned long lock_limit;
+	unsigned long start;
+	unsigned long end;
+	s64 new_pinned;
+	unsigned int nents;
+	int ret;
+
+	*bo_ptr = NULL;
+
+	if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
+	    params->userptr != (unsigned long)params->userptr)
+		return -EINVAL;
+
+	start = params->userptr;
+	if (!IS_ALIGNED(start, PAGE_SIZE) ||
+	    check_add_overflow(start, (unsigned long)params->size, &end))
+		return -EINVAL;
+
+	if (!can_do_mlock())
+		return -EPERM;
+
+	if (params->size >> PAGE_SHIFT > INT_MAX)
+		return -E2BIG;
+
+	if (!access_ok((void __user *)start, params->size))
+		return -EFAULT;
+
+	userptr = kzalloc_obj(*userptr);
+	if (!userptr)
+		return -ENOMEM;
+
+	ret = virtio_gpu_userptr_init(vgdev->ddev, file, userptr, params,
+				      &virtio_gpu_userptr_ops);
+	if (ret) {
+		kfree(userptr);
+		return ret;
+	}
+
+	mm = current->mm;
+	mmgrab(mm);
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
+	if (new_pinned < 0 ||
+	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
+		atomic64_sub(userptr->npages, &mm->pinned_vm);
+		mmdrop(mm);
+		ret = new_pinned < 0 ? -EOVERFLOW : -ENOMEM;
+		goto err_cleanup;
+	}
+	userptr->mm = mm;
+
+	mutex_lock(&userptr->lock);
+	ret = userptr->ops->get_pages(userptr);
+	mutex_unlock(&userptr->lock);
+	if (ret)
+		goto err_cleanup;
+
+	sgt = drm_prime_pages_to_sg(vgdev->ddev, userptr->pages,
+				    userptr->npages);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto err_cleanup;
+	}
+
+	userptr->sgt = sgt;
+
+	/*
+	 * Match shmem blobs: only DMA-map when the virtio DMA API is in
+	 * use. Mapping unconditionally can create SWIOTLB bounce buffers
+	 * that get copied back over guest pages on unmap even though the
+	 * host was given sg_phys() addresses.
+	 */
+	if (virtio_gpu_use_dma_api(vgdev->vdev)) {
+		enum dma_data_direction dir =
+			(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
+			DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
+		ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
+				      dir, 0);
+		if (ret)
+			goto err_cleanup;
+
+		userptr->dma_dir = dir;
+		userptr->dma_mapped = true;
+	}
+
+	ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, &nents);
+	if (ret)
+		goto err_cleanup;
+
+	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
+					    nents);
+
+	*bo_ptr = &userptr->base;
+	return 0;
+
+err_cleanup:
+	virtio_gpu_cleanup_object(&userptr->base);
+	return ret;
+}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d..dcbd7bb7a6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -781,9 +781,14 @@ int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
-	if (virtio_gpu_is_shmem(bo) && use_dma_api)
-		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
-					    bo->base.sgt, DMA_TO_DEVICE);
+	if (use_dma_api) {
+		if (virtio_gpu_is_shmem(bo))
+			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+						    bo->base.sgt,
+						    DMA_TO_DEVICE);
+		else if (virtio_gpu_is_userptr(bo))
+			virtio_gpu_userptr_dma_sync_for_device(bo);
+	}
 
 	cmd_p = virtio_gpu_panic_alloc_cmd_resp(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -812,9 +817,14 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
-	if (virtio_gpu_is_shmem(bo) && use_dma_api)
-		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
-					    bo->base.sgt, DMA_TO_DEVICE);
+	if (use_dma_api) {
+		if (virtio_gpu_is_shmem(bo))
+			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+						    bo->base.sgt,
+						    DMA_TO_DEVICE);
+		else if (virtio_gpu_is_userptr(bo))
+			virtio_gpu_userptr_dma_sync_for_device(bo);
+	}
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1245,9 +1255,14 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
-	if (virtio_gpu_is_shmem(bo) && use_dma_api)
-		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
-					    bo->base.sgt, DMA_TO_DEVICE);
+	if (use_dma_api) {
+		if (virtio_gpu_is_shmem(bo))
+			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+						    bo->base.sgt,
+						    DMA_TO_DEVICE);
+		else if (virtio_gpu_is_userptr(bo))
+			virtio_gpu_userptr_dma_sync_for_device(bo);
+	}
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
-- 
2.34.1

