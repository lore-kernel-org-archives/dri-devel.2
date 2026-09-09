Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADBDC79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5D310EEA8;
	Wed,  9 Sep 2026 04:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vC4OQLgh";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C0810E0CF;
 Wed,  9 Sep 2026 04:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFQv8lvQUj7WscJ0P5HR77Ua4YiH9FhDOlrEdzTWw8dX1+HFnzpgHUJEJKqbX34tzQ7GfARu1LhAgZw0oaB99zok/cxWpilf1U94DXws7p+OtqACFdLWBYWHt+DZZLc1MxRF0lJPjD+07Ti0BPMQ0Ve9SOn+BRuFHUga97YGt1o9vH05QAH76+I7t8vdKK3reEeLeBCLeh0Nx9rfQYQDphXHCOO4b1lOrQBRtvuHKx1XPtfTFs8jsHnjslv5bVHq+T5ADaLZfMKSeH8DpJ9UoQzdwNqihqUIUIjYOJpIqL/QpOl3BB9948UbVdyXyA/GOWAvZ6Ry37sTKjE9C7C+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NpT0vAM8QDrx6UQkmRUystQo7ySgsrqlf+WXCvAk9g=;
 b=qMoam5jwBbmmJzqS6ILpeYqSYL+rhzXJzyYU7l5aP38hkxtqlttVucVwRmTvV7fneX7UsPq4F5+EDp5gfuF5oNA1N7TRZ4ayExD6yHa6f41NIm8eRFNUi4F0zWSuKhCK08noY8edeeR8B3garAOMTY0GsRyNyORqZ6w4qLsCaeui2wIBykKGGrumhylJ/zWjYMHT7CnAHoto3zO2P56Cq07yqZ7q7U7fVTIoUxenmbXx7qw1fhOoUEnkv6PZAXlBZ5ytKNbQR9aSg4/XE7/9iy+1KIZSFAgAlta8fuJ8cn4YyN+tl5R2kEXlD4SoP6Yzs0F6s+3cVt49jBjs3NkxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NpT0vAM8QDrx6UQkmRUystQo7ySgsrqlf+WXCvAk9g=;
 b=vC4OQLgheAaHpA4iJd0SEOBfeLkPniN8Z+wwawQxHGlOn4mOy5XCydkADVwM07wIu7UpDol8HM/O9jMy9K/7BjofY6MSUlS+Sf5kn1YCvaBskIo3S3IDIWY2DKMkSn2+/36HSUREafCZhnXKMSHIyrxYLys92pKldHG3F1hY0rY=
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:45:14 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::25) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 04:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 04:45:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 23:45:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v9 1/3] drm: Add drm_work_fence helper
Date: Wed, 9 Sep 2026 10:14:52 +0530
Message-ID: <20260909044454.399340-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909044454.399340-1-srinivasan.shanmugam@amd.com>
References: <20260909044454.399340-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: ba789c07-2149-4fb1-b06f-08df0e2d23bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SppzC6Hcu/OTY1BLDtViaDLWSYYlnh2tNMcqh1ToYQcxifHAKYxwZkBlvpV9UiJfWNzp2/ZlBkHNRwztLN2+LVTyvUTXJyyztc80Ta7DPyGUQaGfKejrwJ8n5X9ozWlbbulxu3bobZHNR8aOX9loJY9j8HQ+T1HsQ0hiKKq5Xn+/aF6FmYvnfwRmCtPXPNPHJdcv08RtIv3zBIjpH6fquY2o//tL9Kl0IKc/SXVegcS/oNx/QZa/XICx9Fwp/pA1YKCawdGf9WHrdD4z/+Dw3NIdurOQNewcISFP0SQYSbkMoVmRuEwCWnxGLaz8YXaKcMmShnSYAGwGEiF5l2hPCABasuTIzZJaOZ9KeO50unVRL049ex6PjNwhOMwYnhMDc1qWBgsj0S4iUpvXnHiZAEfR5t3xrWztZfvuhrdxKwQBjVJ7qjUkBo+3EswnRiE/6DmuL369Pmaa2xF4YlimYlehFFqL1UF8fG4LeOLMgJhO5vH3WtBrOK+6jTZakXTb9B64hHdz/9p7JVfUMmpxVo14TROO6/zfMVj8VB+u0uwH7QTbm7TXyAue+y9drp6aE+R9mC0tMUQAgkPfZvVsd5UBxWKd99ujWIKvUgQcNAJbaviV3y2+3mHwS46Vja5SknrCxSI/kzC8sFYEP8mA8G/1q1ONZKnOIKVoHriUybKh+pR3rq4GZJZeI9isqtYFbSVwu5+rLukhc23wzIAo4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Zip1kCHYU5m5rJZ8SkoVO+Mz2AUvYX+K7+gqujfeVAQot9xQkWp8Y8wT6DiDSOyPzwhtjkUMlZzs/WQe7oMF2080avcBkxcsCM/ea3A+X8kpshrZxJ/MBlugsND+W+TYDjDkm3zq81PihTlp8XQBobrMu4/O4XWKiyX39Yovls9vMruc+Z3eGyTZEmjnOnxS53bUELpTa1vnnuQK8K/c1ynrG6SDrk6DLptk+oOiRsZoutF96ppgDKNuCASiZsDCIJzj10sjWw8kRLYbC5lWb5nZD1Lq2awKGTzPmKnRMoJ8PH1fqD0Hv8t1sxIRNrUOQfreHT8Di49YpJGTStsaqOhjCwyJdeqj7t1DX08R7TGgMYyqXg/vhZAMipILesDHt/l3aQhuRt1G5gUkLaXKXL2k9IdH3BFQkJL50Sa6YnVILa4/kb6O9YLfgyh4rdU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:45:14.4562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba789c07-2149-4fb1-b06f-08df0e2d23bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

GPU drivers often need to queue work when a dma-fence signals because
certain operations (copy_to_user, eventfd_signal, memory allocation)
cannot run in IRQ context. This pattern is currently open-coded in
multiple drivers.

Introduce drm_work_fence — an embeddable base structure that handles the
dma-fence-callback-to-workqueue pattern in one place. Drivers embed this
in their own structure and implement ops->worker() for the deferred work
and ops->destroy() for cleanup.

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
v9:
- Fix drm_work_fence_queue: drop ref if queue_work returns false,
  closing the race between callback firing and queue_work() (Matt)
- Fix drm_work_fence_cancel_sync: use disable_work_sync() instead of
  cancel_work_sync() to close the UAF race window (Matt)

v8:
- Fix copyright: The Linux Foundation → Advanced Micro Devices, Inc.
- Switch EXPORT_SYMBOL_GPL → EXPORT_SYMBOL for MIT-licensed code (Matt)
- Rename drm_work_fence_ops callback: writeback → worker (Matt)

 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_work_fence.c | 186 +++++++++++++++++++++++++++++++
 include/drm/drm_work_fence.h     |  69 ++++++++++++
 3 files changed, 256 insertions(+)
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
index 000000000000..5e0cbc53edb8
--- /dev/null
+++ b/drivers/gpu/drm/drm_work_fence.c
@@ -0,0 +1,186 @@
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
+	if (!queue_work(wfence->wq, &wfence->work))
+		drm_work_fence_put(wfence);
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
+ * Calls drm_work_fence_cancel() then disable_work_sync() to guarantee
+ * the worker has fully completed before returning, closing the race
+ * window between the callback firing and queue_work() being called.
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
+	if (disable_work_sync(&wfence->work))
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

