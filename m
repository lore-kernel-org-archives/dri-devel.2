Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB82C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60BC10EE7B;
	Thu, 27 Aug 2026 06:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jfWaby/L";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2127810EE12;
 Thu, 27 Aug 2026 06:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwXD7eMbdIBYQtvhG3sX0kRYWDiYhSrV2IO3oO43wrteVkbkuJoS6t9fje2qPRpgUrexQHYqpdJnoX/50sQHk6cypv6/qhl2bFrOa1jgOVLzmUNut0Z5vhHorZCVvOxeN8u+eH2QZ/ChGYB3+S1I9OsPXJKCipEnP/ri3chJ7J8bNobkaA98Gyt55vjZK7UPpMBAPAmnds3j1Th6mM6X9BgvfV8ZZXl97Nh84tuLuDbeLYu7uDiCNkmNSB+G33868Qg3NA8YifLk/wVU7/f0xbXN8fIPF8UeX1F3g/clnYwgF69fiZjz6Scwpzf7SDim5DhkAvMpiw3uHYYU5f6x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5KyNvgJnWRa1SKjbGiMjSXI0HHvg2n7iF0u+QtJhPw=;
 b=QNxmCqLktdtABIXUgBzmaAJw4sWnRVf6NzpDQJ2DICRdBvt6h17vAxigCADe3lpiWKHpiFtneh/RJoob5vH+eYKrUayPrxT59fnvINLZxBzE6CkyLAZC2LupONXDsRmG3RmpQGZ8awuwLDORDuqehKJAG30W6LefbVEK2q5Oy2rn4Si2qRLKGc0k0kl39wW08m2Cv9yfT9gyylyNP0ZHDNprPeCj7N2I7ax8svrROVmvlXu0kpa5EgcxVJV4pLSymhDuvEk/b1xePnvPHIj5tRjPvGK3YDWyjKTmdLxI87KZpUA3QvzJutCYhpm0uQzot3TTPbNtb4YVtIGo7242YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5KyNvgJnWRa1SKjbGiMjSXI0HHvg2n7iF0u+QtJhPw=;
 b=jfWaby/LDxHj7Rs+99q7yjFfG+RMcRSmSAe1gjcukZ1DT8h+Fkmx8zY2Cq58O4KPuNcElB/tyPIeCt/PbVIOK3eS+l3hSmLxouiI89ZHOPE+PaSylIs6427kQHre9C2G2Sm75P8UsbDkpMGmYMFWNNTeILtFWbOZgYWRSVjbhIE=
Received: from BN9PR03CA0390.namprd03.prod.outlook.com (2603:10b6:408:f7::35)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:22:10 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::4) by BN9PR03CA0390.outlook.office365.com
 (2603:10b6:408:f7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Thu, 27
 Aug 2026 06:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 06:22:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 01:22:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Matthew Brost <matthew.brost@intel.com>, =?UTF-8?q?Thomas=20Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] drm: Add common drm_user_fence helper
Date: Thu, 27 Aug 2026 11:51:41 +0530
Message-ID: <20260827062142.4038272-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d5333a-2f5d-4324-7d3f-08df0403871d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SplyiW5dOtQGWhFvajXfI4tP81Uooc/D3mbkxXEYQSv6H5IDYndz7uJg3GEgWjsl1J8bF7F07vmF/C5zlpGNQ/3gq/nEVPKXRLCa6EkKDaiUbFz4To5OmfQrrtVwmUHnHwjX7TnwSyVJsCzx1a1zlyW9QdTapcVR3MGk0RgoBK039fIGh7aF/zklPtSV1qf4w5+NDbHkpamnWI7wUrcmsbON3k6jgZFyuVsnqbWl4qYk94ZsCLTFgAE4usq6IbUY59p7wKwfA+Ufzt/O7pIv1cSHcsmegJLklxqsCKZvHudpWoRjl6Vstp6tG2bwqBciCRlfxeXsMmrbpbE7Cd0dsQj9mNhDgLfyEaMmJToSK1rUJepmzQ3Kqh8hWi69EfpPo41sRUIjUDuB2eaHDBad9y/ZKWfeRb+5i2N8Kg5O2n/aHNfJMuyN7NIZY/5F6spacXDHOcMIeLalO9OyNicbsn8ae6pod+qZ8FsQcIzuCWePfTwjMZXm9szlMxUXgIf3PxDc+ZPUWbPTA4zeS/0/RoxZrgZQ2GvAViKP0NER4ois4mDgiydOxOA7VB5AnV1D/6FNeV8c4IiWlLYijK9ght27mMXKd6WZxo0mVHgRkht/s7OlXKv1+Dv7IFp4IvJeOAUmi6gjmkmJCwBl6NMrQLO+IqBbiK/LEBgF54nXvyyGg7ipvMgwc+EBttuqvY1lzOU276vWEDFDG2n0fFdHeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R4VY3W+zOYXHKLFQxHLIPU2B6ZvyNyYZ+92emq4ysyY0bqLKwwrs0rFeTyIPY6fXWJsVFq8Dll/DiJ9A6UdyxvrjqL6Dn5ytMIt0e6LK4PJ6QZlTKrziYmAKzlRqUipmTMDSGkxClhAdj86mbbH/h+C8o3DyFo8kU0ypkQva9HumJlHzKwgo79LiWr2NhHBYUGSPhf3UwsUFk6li+YJYlalEWFaiENQNjpWMyvtz14HUpaTW7dfiPpS86W5j3dlJLPfdPDAzTIOS/lpGv35WJQCIcZOkkCxktT1vLrC5qACNaQXFuI4EthUctbdhYaaj1MAbODjaER961Hf93c5CjC7/mdp4lK+sPbgjEviWwXuwP8lUzW+hJM62id3i+s3qelx0br61btZ9ejhmvYhir8jYbGTElfxQpndIyuJRw48kGKF0ygXEgzXzuFo1x9od
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:22:10.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d5333a-2f5d-4324-7d3f-08df0403871d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523
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

Introduce a common DRM user fence helper providing the kref-managed,
MM-borrowing dma-fence-callback-to-workqueue pattern used by drivers
that must access userspace memory from a kthread context when a GPU
fence signals.

XE uses this pattern (xe_sync.c) to write a fence completion value
to a userspace VA. AMDGPU will use the same pattern to signal a
per-queue eventfd from a user-queue EOP fence callback.

The helper provides:
 - struct drm_user_fence: embeddable base structure
 - struct drm_user_fence_ops: worker/destroy callbacks
 - drm_user_fence_init(): initialize and grab the process MM
 - drm_user_fence_get/put(): reference counting
 - drm_user_fence_add_callback(): attach to a dma-fence

The worker callback receives a bool indicating whether the process
MM was successfully obtained, allowing drivers to handle the
unavailable-MM case (log, skip the userspace write, etc.) without
duplicating the mmget/kthread_use_mm/mmput boilerplate.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_user_fence.c | 130 +++++++++++++++++++++++++++++++
 include/drm/drm_user_fence.h     |  68 ++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 include/drm/drm_user_fence.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..52de1f474535 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -69,6 +69,7 @@ drm-y := \
 	drm_syncobj.o \
 	drm_sysfs.o \
 	drm_trace_points.o \
+	drm_user_fence.o \
 	drm_vblank.o \
 	drm_vblank_work.o \
 	drm_vma_manager.o \
diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_fence.c
new file mode 100644
index 000000000000..bd76e3d03120
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2024 The Linux Foundation
+ *
+ * Common DRM user fence helper.
+ *
+ * When a GPU dma-fence signals, drivers often need to write a value to a
+ * userspace VA or notify userspace via an eventfd. Both operations require
+ * a valid process MM, which is not available in IRQ context.
+ *
+ * This helper queues a work item on fence signal. The work item borrows the
+ * process MM via kthread_use_mm() and calls ops->worker(), which the driver
+ * implements to perform the actual userspace access.
+ */
+
+#include <linux/kthread.h>
+#include <linux/sched/mm.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_user_fence.h>
+
+static void drm_user_fence_destroy(struct kref *kref)
+{
+	struct drm_user_fence *ufence =
+		container_of(kref, struct drm_user_fence, refcount);
+
+	mmdrop(ufence->mm);
+	ufence->ops->destroy(ufence);
+}
+
+/**
+ * drm_user_fence_get - Acquire a reference to a user fence
+ * @ufence: user fence
+ */
+void drm_user_fence_get(struct drm_user_fence *ufence)
+{
+	kref_get(&ufence->refcount);
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_get);
+
+/**
+ * drm_user_fence_put - Release a reference to a user fence
+ * @ufence: user fence
+ */
+void drm_user_fence_put(struct drm_user_fence *ufence)
+{
+	kref_put(&ufence->refcount, drm_user_fence_destroy);
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_put);
+
+static void drm_user_fence_work(struct work_struct *w)
+{
+	struct drm_user_fence *ufence =
+		container_of(w, struct drm_user_fence, work);
+	bool mm_ok = false;
+
+	if (mmget_not_zero(ufence->mm)) {
+		kthread_use_mm(ufence->mm);
+		mm_ok = true;
+	}
+
+	ufence->ops->worker(ufence, mm_ok);
+
+	if (mm_ok) {
+		kthread_unuse_mm(ufence->mm);
+		mmput(ufence->mm);
+	}
+
+	drm_user_fence_put(ufence);
+}
+
+static void drm_user_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
+{
+	struct drm_user_fence *ufence =
+		container_of(cb, struct drm_user_fence, cb);
+
+	INIT_WORK(&ufence->work, drm_user_fence_work);
+	queue_work(ufence->wq, &ufence->work);
+}
+
+/**
+ * drm_user_fence_init - Initialize a user fence
+ * @ufence: user fence to initialize
+ * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
+ * @ops: driver operations
+ *
+ * Must be called from process context. Grabs a reference to current->mm.
+ */
+void drm_user_fence_init(struct drm_user_fence *ufence,
+			 struct workqueue_struct *wq,
+			 const struct drm_user_fence_ops *ops)
+{
+	kref_init(&ufence->refcount);
+	ufence->mm = current->mm;
+	mmgrab(ufence->mm);
+	ufence->wq = wq;
+	ufence->ops = ops;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_init);
+
+/**
+ * drm_user_fence_add_callback - Attach a user fence to a dma-fence
+ * @ufence: user fence
+ * @fence: dma-fence to watch; caller retains ownership of this reference
+ *
+ * When @fence signals, a work item is queued that calls ops->worker() with
+ * the process MM active. If @fence has already signaled the work item is
+ * queued immediately.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int drm_user_fence_add_callback(struct drm_user_fence *ufence,
+				struct dma_fence *fence)
+{
+	int err;
+
+	drm_user_fence_get(ufence);
+	err = dma_fence_add_callback(fence, &ufence->cb, drm_user_fence_cb);
+	if (err == -ENOENT) {
+		/* fence already signaled — queue work immediately */
+		INIT_WORK(&ufence->work, drm_user_fence_work);
+		queue_work(ufence->wq, &ufence->work);
+		err = 0;
+	} else if (err) {
+		drm_user_fence_put(ufence);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_add_callback);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
new file mode 100644
index 000000000000..de8e3f47be18
--- /dev/null
+++ b/include/drm/drm_user_fence.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2024 The Linux Foundation
+ */
+
+#ifndef __DRM_USER_FENCE_H__
+#define __DRM_USER_FENCE_H__
+
+#include <linux/dma-fence.h>
+#include <linux/kref.h>
+#include <linux/workqueue.h>
+
+struct drm_user_fence;
+
+/**
+ * struct drm_user_fence_ops - driver callbacks for a DRM user fence
+ */
+struct drm_user_fence_ops {
+	/**
+	 * @worker: Called from workqueue context.
+	 *
+	 * If @mm_ok is true, kthread_use_mm() is active and userspace memory
+	 * (copy_to_user, eventfd_signal, etc.) may be accessed safely.
+	 * If @mm_ok is false, the process MM was already gone; the driver
+	 * should log a warning and skip the userspace write.
+	 *
+	 * wake_up() or other post-signal housekeeping should also happen here.
+	 */
+	void (*worker)(struct drm_user_fence *ufence, bool mm_ok);
+
+	/**
+	 * @destroy: Called when the last reference is dropped.
+	 * Free the containing structure here.
+	 */
+	void (*destroy)(struct drm_user_fence *ufence);
+};
+
+/**
+ * struct drm_user_fence - embeddable DRM user fence
+ *
+ * Drivers embed this in their own structure and implement
+ * &drm_user_fence_ops. Call drm_user_fence_init() at creation and
+ * drm_user_fence_add_callback() to arm on a dma-fence.
+ */
+struct drm_user_fence {
+	/** @refcount: Reference count. */
+	struct kref refcount;
+	/** @mm: Process MM grabbed at init time. */
+	struct mm_struct *mm;
+	/** @work: Work item queued when the dma-fence signals. */
+	struct work_struct work;
+	/** @cb: dma-fence callback. */
+	struct dma_fence_cb cb;
+	/** @wq: Workqueue to run @work on. */
+	struct workqueue_struct *wq;
+	/** @ops: Driver operations. */
+	const struct drm_user_fence_ops *ops;
+};
+
+void drm_user_fence_init(struct drm_user_fence *ufence,
+			 struct workqueue_struct *wq,
+			 const struct drm_user_fence_ops *ops);
+void drm_user_fence_get(struct drm_user_fence *ufence);
+void drm_user_fence_put(struct drm_user_fence *ufence);
+int drm_user_fence_add_callback(struct drm_user_fence *ufence,
+				struct dma_fence *fence);
+
+#endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

