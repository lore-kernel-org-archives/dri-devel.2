Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B5C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35C910E496;
	Fri, 28 Aug 2026 06:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lRKjqh2m";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1132D10E47C;
 Fri, 28 Aug 2026 06:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQi7tBJTN6JbxCmh0rzGKDMnM8Nb8kd3DAknkxRj/7MMJV6YofSJUgGCORdlHmBr6Yo4R9MxWViqr3S3Zc+6mdQQJTv6Ub5LP7ndH/ncIDVm+yedjjpqUwUpAoUj2ZyIA8LdINapeCW57ZBHBYukoOf+GYsmawZDafJ/CBd/5SBtE0aW+9Cei9SGhZ/qk6ss/u2NaGjrF6LFSJpWY3fAC7uoqUujqeohTJug0kDAOwVxGHRXq48xnq24/7uU4fsViZq3V0hWnU0e7uraAKHgvRXlZU6ejaNz6Jfl4tzJcRhARiSpG+NPoxFkufK7INvuwaGEAm2aDKueVFK78hwDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/uPbK4da1enkqwd4GctbRKUQZpgNAEPmbzk/YoaWJ8=;
 b=Yzdg/a/raP2jEm7963zyrkAZZhYly2kH/11aHTybDmCSg4GyS5sxvbbLZksgA2j9yvahEROPiQjTj0uU4D0wNF2WmtGyYY2Lky6gNb2untt0sTZNIj1EwThl+boeLbpbXGOYBqDm0nWS9BZpxAEx1lLSte80veeRPuSlSEa4kA3GCRYBvRr3NH7XPghLU2uUxenkFmcRmFiBJwUJk5DaAv4ajaaMmSrS5lANATmtZt+tvEvuCmZiDSILdku+ss7wiMyqK4OJRy2OfVWMi8QRTBXhb4485eS6FYULya9YHJ1fN3Faof40G0RpW0P7//aMUzmeEjnYGckQ7RSAHTSC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/uPbK4da1enkqwd4GctbRKUQZpgNAEPmbzk/YoaWJ8=;
 b=lRKjqh2mR+qU5YGSaymjZyFg6jUn0IZYCGJ+XIG9Mzw8zZZwN21Pna0DRu5HjQGfqwjeptbk6ahQs7HAnyuLPs9WzRGnjs2fMxm4OhTFDbuGV1bxmljwQeLjrzz7KPTbei+77Ubn58JPogu76AzqfoGp0GJFaHZTSACoUAHCgoA=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 06:30:43 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::88) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 06:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 06:30:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 28 Aug 2026 01:30:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/2] drm: Add common drm_user_fence helper
Date: Fri, 28 Aug 2026 11:59:16 +0530
Message-ID: <20260828062917.4106569-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828062917.4106569-1-srinivasan.shanmugam@amd.com>
References: <20260828062917.4106569-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 58895ea1-831d-442d-78db-08df04cde2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: t/K8/6z9M21a3sLo47vwfixgwpRvcNgEZwUomFa1Rui/Cb/q/5L6I5u+AwGLOGrN9gECoZBxpo+fOiQKif4vsAG7+MPyqdkenvRIoKpcNFCzps1znmzeI2zdh/Y7pBDzipJR+1pU93fcSaZHVyr+4oJWSx5xKX3MX2FhVxdDrQhhNqkUhvxumB0hNo5EuyZWBEDZeA28xrjFmz+RT4khUI2wG2ij1zsY1KvpX1KWh8U9ZXE9+QDQNagvdmiWEvOHUuIESiQgdOFUSmOctcGoB4oqF2Z/Z/qziou8tWzixvBboxlBpPnxLT3Ikq3Gzz6aGiEQ3nPTg+2NcefrtgID5c3UF7wtFU1omfEx9zw+1PzaM+NsHMIelh8yD9dKl8hv9XeCwvBIOuj8gHxw3Mw22mioyH7qtMnLfeyUg2Xm0cXFKclKknQouJavElKoJ9SaEylAFsUdc4+7Q9otiS2C0Y16TEzMV4ctJrPWzKsoFuhOF64n3yJ7+ZRlIMpUYWz5solr1XE6KZmkopZv5onqFBaJ2zDXTju3/R3+FwJ5DT95E0DHICSy42/SEqhGEdK0LEllsZhmy8uEfEZWu1Yjl1aCD21MslVr/XgeY38LfkhrFllzipvKAQPAu1nQfbs/KYaysbFgH+DCrCwdH3MNISX2zdUvFc4jQr8zTA7/E/s1yd1Z8vTCL0lupboVhC7xln7SgRaTsTNNEbXhhNBhAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yaWqcBPIwHdyBQ8haamjv5wm2STW+4YhMNFxAfQl3RLU/4ffkovDZE2KL2DjmKdQH123fM4IGGZMPhbqW+WOcT9xqUL7Sc/6WBMq0YSuBEKnU/AJQYan6prwh5vdtO6S01CUeWp8rbx5QrRRJW9JCStpaLheHxamDZ/qNVgakvCMu7NNDwGqQ+Tgh6xTiU82R95kD91nnQr7r4EZ0UxfxR4oS3kxEGUD++24tUYMIzYjgyNgeG4kVrA3dBS3X245wCcFcsTDRd7SA0XzpLY5llsCRZch2PcVU3QEzCa1TW2goItbhHlefdxSmCc9oIEw2cDq33tcvwd/TUi/qPzh630SHWr2eDzg1yIpPQIM6YvjXaf19TWO3PbSpymWW7bRv1GN4zSLRQwojpJILZamK1YZABGEjK1+hQPq0G0FFLnqMIDhHtFTswADsfn+ZYjy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:30:43.1387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58895ea1-831d-442d-78db-08df04cde2f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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
v4:
 - Check cancel_work_sync() return value in drm_user_fence_cancel_sync()
   and call drm_user_fence_put() if work was dequeued, fixing a memory
   leak of the drm_user_fence, mm_struct and stored dma_fence when a
   pending work item is cancelled. (Sashiko review)

 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_user_fence.c | 223 +++++++++++++++++++++++++++++++
 include/drm/drm_user_fence.h     |  76 +++++++++++
 3 files changed, 300 insertions(+)
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
index 000000000000..cdc47d092cbb
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,223 @@
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
+	/* Release the extra reference stored for cancel() */
+	if (ufence->fence)
+		dma_fence_put(ufence->fence);
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
+	queue_work(ufence->wq, &ufence->work);
+	/*
+	 * Put the transferred reference from add_callback. The stored
+	 * reference in ufence->fence is released in drm_user_fence_destroy().
+	 */
+	dma_fence_put(fence);
+}
+
+/**
+ * drm_user_fence_init - Initialize a user fence
+ * @ufence: user fence to initialize
+ * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
+ * @ops: driver operations
+ *
+ * Must be called from process context with a valid current->mm.
+ * Grabs a reference to current->mm via mmgrab().
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
+	ufence->fence = NULL;
+	INIT_WORK(&ufence->work, drm_user_fence_work);
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_init);
+
+/**
+ * drm_user_fence_add_callback - Attach a user fence to a dma-fence
+ * @ufence: user fence
+ * @fence: dma-fence to watch; ownership of this reference is transferred
+ *         to the callback — caller must NOT put it afterward.
+ *
+ * When @fence signals, a work item is queued that calls ops->worker() with
+ * the process MM active. If @fence has already signaled the work item is
+ * queued immediately.
+ *
+ * An additional reference to @fence is stored internally in @ufence to
+ * allow drm_user_fence_cancel() to be called safely without the caller
+ * needing to hold a separate fence reference.
+ *
+ * On any return value the caller's fence reference is consumed.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int drm_user_fence_add_callback(struct drm_user_fence *ufence,
+				struct dma_fence *fence)
+{
+	int err;
+
+	drm_user_fence_get(ufence);
+
+	/* Extra ref stored for cancel() — lives until drm_user_fence_destroy() */
+	ufence->fence = dma_fence_get(fence);
+
+	err = dma_fence_add_callback(fence, &ufence->cb, drm_user_fence_cb);
+	if (err == -ENOENT) {
+		/* fence already signaled — queue work and release transferred ref */
+		queue_work(ufence->wq, &ufence->work);
+		dma_fence_put(fence);
+		err = 0;
+	} else if (err) {
+		dma_fence_put(ufence->fence);
+		ufence->fence = NULL;
+		drm_user_fence_put(ufence);
+		dma_fence_put(fence);
+	}
+	/* on success: transferred ref goes to drm_user_fence_cb */
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_add_callback);
+
+/**
+ * drm_user_fence_cancel - Cancel a pending user fence callback
+ * @ufence: user fence
+ *
+ * Attempts to remove the pending callback before driver context teardown.
+ * Must be called before the driver tears down its workqueue or ops.
+ * The caller must hold a reference to @ufence across this call.
+ *
+ * If the callback has already fired this returns false and no additional
+ * action is needed — the callback handles its own reference.
+ *
+ * If removal succeeds the callback reference is released internally.
+ * The caller must still release its own separate reference via
+ * drm_user_fence_put() when done with the object.
+ *
+ * This function is safe to call from atomic context as it only acquires
+ * the dma-fence spinlock internally. If the caller also needs to wait
+ * for the worker to finish, use drm_user_fence_cancel_sync() instead,
+ * which may sleep.
+ *
+ * Return: true if callback was removed, false if it had already fired.
+ */
+bool drm_user_fence_cancel(struct drm_user_fence *ufence)
+{
+	struct dma_fence *fence = ufence->fence;
+
+	if (!fence)
+		return false;
+
+	if (dma_fence_remove_callback(fence, &ufence->cb)) {
+		/*
+		 * Callback will not fire — release the transferred reference
+		 * that would have been put by drm_user_fence_cb(). The stored
+		 * reference in ufence->fence is released in destroy().
+		 */
+		dma_fence_put(fence);
+		drm_user_fence_put(ufence);
+		return true;
+	}
+
+	/* Callback already fired — it handled its own cleanup */
+	return false;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_cancel);
+
+/**
+ * drm_user_fence_cancel_sync - Cancel callback and wait for worker to finish
+ * @ufence: user fence
+ *
+ * Calls drm_user_fence_cancel() then cancel_work_sync() to guarantee
+ * the worker has fully completed before returning.
+ *
+ * This function may sleep. Must not be called from atomic or interrupt
+ * context. Use drm_user_fence_cancel() instead when sleeping is not
+ * allowed.
+ *
+ * Drivers must call this during teardown before freeing any resources
+ * accessed by ops->worker().
+ */
+void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
+{
+	drm_user_fence_cancel(ufence);
+	if (cancel_work_sync(&ufence->work))
+		drm_user_fence_put(ufence);
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_cancel_sync);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
new file mode 100644
index 000000000000..02a02266ab93
--- /dev/null
+++ b/include/drm/drm_user_fence.h
@@ -0,0 +1,75 @@
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
+ * Call drm_user_fence_cancel_sync() before driver teardown.
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
+	/**
+	 * @fence: Extra reference held for safe cancel(). Set during
+	 * add_callback, released in destroy().
+	 */
+	struct dma_fence *fence;
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
+bool drm_user_fence_cancel(struct drm_user_fence *ufence);
+void drm_user_fence_cancel_sync(struct drm_user_fence *ufence);
+
+#endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

