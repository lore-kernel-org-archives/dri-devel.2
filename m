Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7FFC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D79410E90A;
	Tue,  8 Sep 2026 08:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="msVGFRLc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E64010E90A;
 Tue,  8 Sep 2026 08:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL9PWsM6FUG9xlQmwW/dOh7FsSCzIKVN9gGYHscvWaIH16HZ0YesL0WZEKFFDfzyUnEHxhXdKcR2X77ni1/XboaejXW+aqx3qIkjqhm1i2drigzjFVz0Dd7boayHpoA4sjw08yHf/vV801zhCBJKdat9rUuCNqaHiFAjDECl6TcVzzznMs+iyNQSW+dkgOjI3F2iiSrrnvmsIelx4yqD8MbAIlVph1VRXN4fpNXDCcz7kj8It+Mvb4NG6o+Bzu3OsplBrSvp2WP4RR2daUJRzIX88NZdbGjCuPf5qhZc82lnlwSzIla+KfB0v8noh+p+5h1uHXNaK2NTNRoL2Msjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuIgKs2Lswpg8dncwr0aba/pjcoj98qpyPuiTCXQGX4=;
 b=epDJPMzvt1wsYDZkxQNZvP7Zz857g9RxWg9VBSGDdcJWJ4H2L/WK7l9scw7RN/n4jRkPc/RWlP47Lwi5Z2tpJJrJ2E9YD+GlzBmuoF/u1g49lTPgQ1CuyPj8Kdmbm3YbCKu0zIUm150y21KMaG/172tnv9YVTCaeYJiWgSWKn47BRTaTs50+3CegetA2XIbSgXTxuvMTr1yTzObXG/EtoK+0XzIC9jf0SLoqw4BxPnh2YPzGlGUa57M7C/Y9AnWUnvU9RWCrh6dN7s4Rb4FApi9Un2TYV5Dz8y4UW5EP59z8K+N3KkC7Nf5eiOMA3pmOS1ugBqH89fhMrn6UWc92AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuIgKs2Lswpg8dncwr0aba/pjcoj98qpyPuiTCXQGX4=;
 b=msVGFRLcrMRIBiOZNkljFsGFlyGP0Frjc7+NK2HfHo5xTAo9a9z6q+qkvIa2bvnlRUwJox1oDPMjiVSKl/3jiFtVPEQPkPOsu2yLmPfR0ISp8yGvjDSbmNSirqc64K61+JyfmZht8BWyoNjZ/EBxNAe5pflikwl572lKTrrwPZU=
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 08:46:47 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::f) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 08:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 08:46:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 03:46:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v8 1/3] drm: Add drm_work_fence helper
Date: Tue, 8 Sep 2026 14:16:25 +0530
Message-ID: <20260908084627.352535-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eba83a-a12c-4249-b929-08df0d85b783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k9FmgwmB0+9XsaNRfn0BsL1KUCgWCwf1onAUL2OqWDzg+tpW3p5p7z+H8LlvWYNYcifNTh+SeJVz3Ezq7cH3vzgQZWyxQdtTj9VjwgzW7QWB198hGXN+G1rUMHxr3yYhObyCrubE0bZZsZbbgWQfOtgIQ4/iugOaYNpIDzu3/3tKuUNfiyyswsTNzRRNZDFw9iBoBTFWEpDHLZY4IUNaoOfvVxSXrKneIGbt0g8Ffr1CoUSZRzz94H2LSf4C6tZZlvRIS6cDmvDipcm3hHsI92p7LA1+WaQlEwJY5m8DUv62Ugh8s9suBNM8HXZyt3NNk52DbCshwW/KokLcj59+p9zhVI1z1zw4aT84uhf++1igaIi0lGhPwwrEjgoATzUgfhc/KXjSYlGCpSjn/jMhgBtQsL9cxq5TSawhrydURUe6RlNUAKjnozrzlYwksPUMPLPgMeJNLw3JtzGtc1gY6h06Ao4gQiavAJ8hFevUblW7zoTlUr7/4SGUQ4xb399jhsnYkfjiRUkQkYANikyn5tACvq4wdg7wRXw+ZbcRqlvLa+T0ORGjNsJdv194r/gC0tBzyMgWcItmsi5rurOD3/q29Ew9nGr3KLMekTLT66dyAiEvuKg3nedmQ1+t9dpLYEOqwNYoAoHrvmlu1DM+QFTW9xisAG7cgeCZlcuvZAodkEAJBhXMOBrslrcFadCCkLdY1Y+SgaeCseQGP0/eIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 142jFMhj+bd37/sQhTMoXcARi05RXr7ljB9P2PbLgIU9vYMHK3GQaSck6bnSTKFcdLhbUqFIrzhEd1gK5AEp6QMiD5jixUvbYD/lRlpRZcHvaEV0wgmNRCd7HK0b3gVntywBaanns9MODp6d2izTlLe2L5lgr7LfgEw43RNj3F14+CeMDu7Z1b07fJ9/eZKMqmF2x/CA++w8iYzyKKEqa0myb5KE7PaowqKuw6Y8V5zwRzMNIn/7OiWxO34n0zAd1x3f/WcUqykd1WVgWCoFq4capxCXGgA9aJ6mMV6Q4Q5JF3VXfGEMu9X+pNp/Mv5xXOWGtIPs6TyrQc8ncG88tvNWmCVfWwuOLpMQTSAFPVwZX5GYPPkOT+uOo8n3wxGdoWoxPeylZHuj/d3bzJRfvGhxdRy61iYq6bTlRd3LT87PgR54cMO2vqunc07+43/h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:46:47.0137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eba83a-a12c-4249-b929-08df0d85b783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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

GPU drivers often need to queue work when a dma-fence signals
because certain operations (copy_to_user, eventfd_signal, memory
allocation) cannot run in IRQ context. This pattern is currently
open-coded in multiple drivers.

Introduce drm_work_fence — an embeddable base structure that handles the
dma-fence-callback-to-workqueue pattern in one place. Drivers embed this
in their own structure and implement ops->writeback() for the deferred
work and ops->destroy() for cleanup.

The helper manages:
 - kref lifetime
 - dma-fence callback registration
 - workqueue dispatch on fence signal
 - safe cancellation before driver teardown

For work that additionally requires borrowing the process MM via
kthread_use_mm(), see drm_user_fence which builds on top of this.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v8:
- Fix copyright: The Linux Foundation → Advanced Micro Devices, Inc.
- Switch EXPORT_SYMBOL_GPL → EXPORT_SYMBOL (MIT license, Matt)
- Rename drm_work_fence_ops callback writeback → worker (Matt)
- Update all kernel-doc references accordingly

 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_work_fence.c | 184 +++++++++++++++++++++++++++++++
 include/drm/drm_work_fence.h     |  69 ++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_work_fence.c
 create mode 100644 include/drm/drm_work_fence.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..c5be8e80d0c8 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -72,6 +72,7 @@ drm-y := \
 	drm_vblank.o \
 	drm_vblank_work.o \
 	drm_vma_manager.o \
+	drm_work_fence.o \
 	drm_writeback.o
 drm-$(CONFIG_DRM_CLIENT) += \
 	drm_client.o \
diff --git a/drivers/gpu/drm/drm_work_fence.c b/drivers/gpu/drm/drm_work_fence.c
new file mode 100644
index 000000000000..ac66ba129fff
--- /dev/null
+++ b/drivers/gpu/drm/drm_work_fence.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Advanced Micro Devices, Inc.
+ *
+ * Common DRM work fence helper.
+ *
+ * When a GPU dma-fence signals, drivers often need to perform work that
+ * cannot run in IRQ context (e.g., memory allocation, copy_to_user,
+ * eventfd_signal). This helper queues a work item when a dma-fence
+ * signals, allowing that work to run safely in a workqueue context.
+ *
+ * NOTE: This helper consumes dma_fences but CANNOT implement
+ * dma_fence_ops. Work items queued here may sleep; dma_fence_ops
+ * callbacks are called under the fence spinlock and must not sleep.
+ *
+ * For work that additionally requires accessing userspace memory via
+ * kthread_use_mm(), see drm_user_fence which builds on top of this.
+ */
+
+#include <linux/workqueue.h>
+
+#include <drm/drm_work_fence.h>
+
+static void drm_work_fence_destroy(struct kref *kref)
+{
+	struct drm_work_fence *wfence =
+		container_of(kref, struct drm_work_fence, refcount);
+	struct dma_fence *fence = wfence->fence;
+
+	wfence->ops->destroy(wfence);
+	dma_fence_put(fence);	/* NULL-safe */
+}
+
+/**
+ * drm_work_fence_get - Acquire a reference to a work fence
+ * @wfence: work fence
+ */
+void drm_work_fence_get(struct drm_work_fence *wfence)
+{
+	kref_get(&wfence->refcount);
+}
+EXPORT_SYMBOL(drm_work_fence_get);
+
+/**
+ * drm_work_fence_put - Release a reference to a work fence
+ * @wfence: work fence
+ */
+void drm_work_fence_put(struct drm_work_fence *wfence)
+{
+	kref_put(&wfence->refcount, drm_work_fence_destroy);
+}
+EXPORT_SYMBOL(drm_work_fence_put);
+
+static void drm_work_fence_work(struct work_struct *w)
+{
+	struct drm_work_fence *wfence =
+		container_of(w, struct drm_work_fence, work);
+
+	wfence->ops->worker(wfence);
+	drm_work_fence_put(wfence);
+}
+
+static void drm_work_fence_queue(struct drm_work_fence *wfence)
+{
+	queue_work(wfence->wq, &wfence->work);
+}
+
+static void drm_work_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
+{
+	struct drm_work_fence *wfence =
+		container_of(cb, struct drm_work_fence, cb);
+
+	drm_work_fence_queue(wfence);
+	/* Single ref: wfence->fence released in drm_work_fence_destroy(). */
+}
+
+/**
+ * drm_work_fence_init - Initialize a work fence
+ * @wfence: work fence to initialize
+ * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
+ * @ops: driver operations
+ */
+void drm_work_fence_init(struct drm_work_fence *wfence,
+			 struct workqueue_struct *wq,
+			 const struct drm_work_fence_ops *ops)
+{
+	kref_init(&wfence->refcount);
+	wfence->wq = wq;
+	wfence->ops = ops;
+	wfence->fence = NULL;
+	INIT_WORK(&wfence->work, drm_work_fence_work);
+}
+EXPORT_SYMBOL(drm_work_fence_init);
+
+/**
+ * drm_work_fence_add_callback - Attach a work fence to a dma-fence
+ * @wfence: work fence; caller retains their reference and must release
+ *          it via drm_work_fence_put() when no longer needed
+ * @fence: dma-fence to watch; one reference is consumed on any return value
+ *
+ * When @fence signals, a work item is queued that calls ops->worker().
+ * If @fence has already signaled, the work item is queued immediately.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int drm_work_fence_add_callback(struct drm_work_fence *wfence,
+				struct dma_fence *fence)
+{
+	int err;
+
+	drm_work_fence_get(wfence);
+	wfence->fence = fence;	/* transfer caller's ref — single ref, no get */
+
+	err = dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
+	if (err == -ENOENT) {
+		drm_work_fence_queue(wfence);
+		err = 0;
+	} else if (err) {
+		wfence->fence = NULL;
+		dma_fence_put(fence);
+		drm_work_fence_put(wfence);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(drm_work_fence_add_callback);
+
+/**
+ * drm_work_fence_cancel - Cancel a pending work fence callback
+ * @wfence: work fence
+ *
+ * Attempts to remove the pending callback before driver context teardown.
+ * The caller must hold a reference to @wfence across this call.
+ *
+ * If the callback has already fired this returns false and all cleanup
+ * has been handled internally.
+ *
+ * If removal succeeds the callback reference is released internally.
+ * The caller must still release its own reference via drm_work_fence_put().
+ *
+ * This function is safe to call from atomic context as it only acquires
+ * the dma-fence spinlock internally. If the caller also needs to wait
+ * for the worker to finish, use drm_work_fence_cancel_sync() instead,
+ * which may sleep.
+ *
+ * Return: true if callback was removed, false if it had already fired.
+ */
+bool drm_work_fence_cancel(struct drm_work_fence *wfence)
+{
+	struct dma_fence *fence = wfence->fence;
+
+	if (!fence)
+		return false;
+
+	if (dma_fence_remove_callback(fence, &wfence->cb)) {
+		drm_work_fence_put(wfence);	/* drop ref from add_callback */
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(drm_work_fence_cancel);
+
+/**
+ * drm_work_fence_cancel_sync - Cancel callback and wait for worker to finish
+ * @wfence: work fence
+ *
+ * Calls drm_work_fence_cancel() then cancel_work_sync() to guarantee
+ * the worker has fully completed before returning.
+ *
+ * This function may sleep. Must not be called from atomic or interrupt
+ * context. Use drm_work_fence_cancel() instead when sleeping is not allowed.
+ *
+ * Drivers must call this during teardown before freeing any resources
+ * accessed by ops->worker().
+ */
+void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
+{
+	if (drm_work_fence_cancel(wfence))
+		return;
+	if (cancel_work_sync(&wfence->work))
+		drm_work_fence_put(wfence);
+}
+EXPORT_SYMBOL(drm_work_fence_cancel_sync);
diff --git a/include/drm/drm_work_fence.h b/include/drm/drm_work_fence.h
new file mode 100644
index 000000000000..7fa1e2561295
--- /dev/null
+++ b/include/drm/drm_work_fence.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DRM_WORK_FENCE_H__
+#define __DRM_WORK_FENCE_H__
+
+#include <linux/dma-fence.h>
+#include <linux/kref.h>
+#include <linux/workqueue.h>
+
+struct drm_work_fence;
+
+/**
+ * struct drm_work_fence_ops - driver callbacks for a DRM work fence
+ */
+struct drm_work_fence_ops {
+	/**
+	 * @worker: Called from workqueue context when the dma-fence signals.
+	 *
+	 * Perform the deferred work here (copy_to_user, eventfd_signal, etc.).
+	 * May sleep. Must not requeue the fence.
+	 */
+	void (*worker)(struct drm_work_fence *wfence);
+
+	/**
+	 * @destroy: Called when the last reference is dropped.
+	 * Free the containing structure here.
+	 */
+	void (*destroy)(struct drm_work_fence *wfence);
+};
+
+/**
+ * struct drm_work_fence - DRM dma-fence-to-workqueue helper
+ *
+ * Embeddable base structure that queues a work item when a dma-fence signals.
+ * Drivers embed this in their own structure and implement ops->worker()
+ * for the deferred work and ops->destroy() for cleanup.
+ *
+ * Call drm_work_fence_init() at creation and drm_work_fence_add_callback()
+ * to arm on a dma-fence. Call drm_work_fence_cancel_sync() before teardown.
+ */
+struct drm_work_fence {
+	/** @refcount: Reference count. */
+	struct kref refcount;
+	/** @wq: Workqueue on which to run the worker. */
+	struct workqueue_struct *wq;
+	/** @ops: Driver operations. */
+	const struct drm_work_fence_ops *ops;
+	/** @fence: The watched dma-fence; holds a single reference. */
+	struct dma_fence *fence;
+	/** @work: Work item queued when the fence signals. */
+	struct work_struct work;
+	/** @cb: Callback registered on the dma-fence. */
+	struct dma_fence_cb cb;
+};
+
+void drm_work_fence_init(struct drm_work_fence *wfence,
+			 struct workqueue_struct *wq,
+			 const struct drm_work_fence_ops *ops);
+void drm_work_fence_get(struct drm_work_fence *wfence);
+void drm_work_fence_put(struct drm_work_fence *wfence);
+int  drm_work_fence_add_callback(struct drm_work_fence *wfence,
+				 struct dma_fence *fence);
+bool drm_work_fence_cancel(struct drm_work_fence *wfence);
+void drm_work_fence_cancel_sync(struct drm_work_fence *wfence);
+
+#endif /* __DRM_WORK_FENCE_H__ */
-- 
2.34.1

