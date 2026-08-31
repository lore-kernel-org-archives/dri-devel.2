Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF4CC624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19E810E5EA;
	Mon, 31 Aug 2026 05:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Cvlq785";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849E810E5E7;
 Mon, 31 Aug 2026 05:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1esWJbGCB6sRT9kWAGVAki3EWcUCC68V2qsSPsYdvTz6dX8no5EN6dB3VrogsmOScfOmJD8bI578X14KMYhEOy6d5BJ4Rw6v0TaYHaiAqAEm2zIBaLxm2nY4UeGaTw7b60BLCZezgDWm1QxGm8v6ffiZV1KKcWUVR/tEZ2iaatzOVKUH51xo3UIDzOTzzlkXY1q1bMF5RQ6fFTGpCEQaT+mAhSyWAiu/ZP4G2brcA96wiKmG0soVptU56W0aJnU/39f1C3jCFy/NfAKHjuPlVvUQqsn9yauvSWAI1O14uYXmlpwyxbilTFMa/1SmrBshDUQoAmx13qqV8Jp5B3vXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d05Us7Jo0mzLRJYfrJ6izhKzldsnuKMA0Ifyl7DQTWU=;
 b=qEoVWn9bhoBOhtQI6YTwaL2NVeT1mNlidftzl4+DoA+ktiMpFaAUzVjGmkKNv1RhEWzkXHvsM9AI1gzDeIWB1Q+Sf2hJYOcX7u6aXEFvO+Bs2PL1wIcbXjKpHQ/4WbSXkMKquUd7NUEIwI/ZKdO4i0DDayDdAmnSHpiMFS8qd7ZG9PKRiaAoQ5qjk9Dm8YC47Ref1AD2UWFVx4yBy0SBxZE+ctTX724C+mfhFhPXaw/aqzHyScNH+05LrnnendepE+Z0JM7TYP6NL692V3a6k3CR5uJjopuvRbHfY4+bmEw5W0ztZOdyKgyec8TaXUkc7QqWDOS+ocU9fvL1xrbK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d05Us7Jo0mzLRJYfrJ6izhKzldsnuKMA0Ifyl7DQTWU=;
 b=3Cvlq785C29p1zBo6dAlzWVBwhb4KQOySG2P0BKG0SpUL4JeREuTejLmWYxg4lGbgtCakyWzUqSsczoZup0dpRL3YuAgtmFSxEcKw9QE6r5JT/fHdq7jb5XESd3hSAPF8Gp/6liawxlFSehdGI6k92reiVif64LtYfm6AsmESRc=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:42:20 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::53) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:42:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:42:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
Subject: [PATCH v5 1/4] drm: Add drm_work_fence helper
Date: Mon, 31 Aug 2026 11:11:51 +0530
Message-ID: <20260831054154.107602-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9108e3d7-8645-45e1-70c4-08df0722a00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: v8C281+ANBI+kCleedlt/EkzKdrPl+TD5IVRkZQdzkhMSeuE9EJQ9m5NLFQroqMWurHGOfM+uRYljSJa3HbOBRHx2VtG8/dmmR0t+YCG8bQWtl7uLWCsrBcQLHUdrSrPbMUE9L2Q5mdMnyY2YMBR7cOf+8O7yZYWW0DsJTCBrGTkevhfX048ZReB96FojVklC1Hd02rVZvJYucwk070/8aawbdwKivnNtFftAPWrzQZDuuIBCqF/6GCmRn5ebB6ov//Ee8PkqvqGb6HAleGjIoedWQAGwxosXfMAvii/JbNNNWG+OQqYQFoosuPA7G02J8pPBMXg1EmZ0t00i/0aBYdQGTccKekt0wlXs2QQHWDzEPmRg0QiWXqfU/BNHXi/ZPI6o7+J+U/Lu/rmZHP2ubzcEFQHxQ8v7Wc6BAr4HjHdWhpFahz6fYPAfqCFAFUjbeJp/PpZhHBz3N/Xx3KXobG/OxOVEuFGrDj9mOLJcNyuFcaxDWxE8smT9CRXCgnMKguhCd29bjuY5c6AslphVzxqHjS4JXYDhgicaVtZkhQnc8RdE2yvIHH+3qJf6jfSNgToJWSiIajrh+Jutk/h+e18HljCiXM+MjXQa67K/XL2tbUDi5MN14r3m2uD/1tRsqea6B6u0a1NQnmH5e/Lzjr6gksb9aU+JDitICDlYPZf9KwPkyNd2Anee9ZGSbn+i+iYDDNiY1bTXOgJ/LFY4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kEAcO+1rwSv/IkndLiu0+L0jYm1RDT3ebU72GiwjfP3HVRoBgi8kDdM+9YTMIB5HHsX9UqQcg+dDkUMHJaOiLL4pA69TcXEGB69iax32hQ59RxsamZAlF2i3T/sEPYZYIMjpS/fy9770DjfDmino+DzO8UpqUMh8OJQeiRcLyw+peJOT1ky2c9U7KMxNvxD+yjP9WLBWz7FcUsxCMgMzrKLm9O/lpfajeyK5jaJcWR1Hok/PPuE2UzojvbQHEe5+s7wuwpcM/jbaONbuMYuM6U98kboIcIle32XWU+TSFkfvxyp894p22eXtG392km9IWTzBEVufT6dZ/eP8tjSymaynJvNoAj7OijNREjjrZaVWv8OF6dtqqvksxNQnJIdHSAkPTqij4+H28cal+JhX3WwenxYKTuZ6sF9oNU2ln4tWYK7rbA2pIfrqMIyNRmPb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:42:20.4198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9108e3d7-8645-45e1-70c4-08df0722a00f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

Introduce drm_work_fence — an embeddable base structure that handles
the dma-fence-callback-to-workqueue pattern in one place. Drivers
embed this in their own structure and implement ops->work() for the
deferred work and ops->destroy() for cleanup.

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
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_work_fence.c | 195 +++++++++++++++++++++++++++++++
 include/drm/drm_work_fence.h     |  76 ++++++++++++
 3 files changed, 272 insertions(+)
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
index 000000000000..9f6b779d0fe9
--- /dev/null
+++ b/drivers/gpu/drm/drm_work_fence.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2024 The Linux Foundation
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
+
+	if (wfence->fence)
+		dma_fence_put(wfence->fence);
+
+	wfence->ops->destroy(wfence);
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
+EXPORT_SYMBOL_GPL(drm_work_fence_get);
+
+/**
+ * drm_work_fence_put - Release a reference to a work fence
+ * @wfence: work fence
+ */
+void drm_work_fence_put(struct drm_work_fence *wfence)
+{
+	kref_put(&wfence->refcount, drm_work_fence_destroy);
+}
+EXPORT_SYMBOL_GPL(drm_work_fence_put);
+
+static void drm_work_fence_work(struct work_struct *w)
+{
+	struct drm_work_fence *wfence =
+		container_of(w, struct drm_work_fence, work);
+
+	wfence->ops->work(wfence);
+	drm_work_fence_put(wfence);
+}
+
+static void drm_work_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
+{
+	struct drm_work_fence *wfence =
+		container_of(cb, struct drm_work_fence, cb);
+
+	queue_work(wfence->wq, &wfence->work);
+	/*
+	 * Put the transferred reference from add_callback. The stored
+	 * reference in wfence->fence is released in drm_work_fence_destroy().
+	 */
+	dma_fence_put(fence);
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
+EXPORT_SYMBOL_GPL(drm_work_fence_init);
+
+/**
+ * drm_work_fence_add_callback - Attach a work fence to a dma-fence
+ * @wfence: work fence
+ * @fence: dma-fence to watch; ownership of this reference is transferred
+ *         to the callback — caller must NOT put it afterward.
+ *
+ * When @fence signals, a work item is queued that calls ops->work().
+ * If @fence has already signaled, the work item is queued immediately.
+ *
+ * An additional reference to @fence is stored internally in @wfence to
+ * allow drm_work_fence_cancel() to be called safely without the caller
+ * needing to hold a separate fence reference.
+ *
+ * On any return value the caller's fence reference is consumed.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int drm_work_fence_add_callback(struct drm_work_fence *wfence,
+				struct dma_fence *fence)
+{
+	int err;
+
+	drm_work_fence_get(wfence);
+	wfence->fence = dma_fence_get(fence);
+
+	err = dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
+	if (err == -ENOENT) {
+		queue_work(wfence->wq, &wfence->work);
+		dma_fence_put(fence);
+		err = 0;
+	} else if (err) {
+		dma_fence_put(wfence->fence);
+		wfence->fence = NULL;
+		drm_work_fence_put(wfence);
+		dma_fence_put(fence);
+	}
+	/* on success: transferred ref goes to drm_work_fence_cb */
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(drm_work_fence_add_callback);
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
+		wfence->fence = NULL;
+		dma_fence_put(fence);  /* callback ref */
+		dma_fence_put(fence);  /* stored ref */
+		drm_work_fence_put(wfence);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(drm_work_fence_cancel);
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
+ * accessed by ops->work().
+ */
+void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
+{
+	drm_work_fence_cancel(wfence);
+	if (cancel_work_sync(&wfence->work))
+		drm_work_fence_put(wfence);
+}
+EXPORT_SYMBOL_GPL(drm_work_fence_cancel_sync);
diff --git a/include/drm/drm_work_fence.h b/include/drm/drm_work_fence.h
new file mode 100644
index 000000000000..4fa369f937d7
--- /dev/null
+++ b/include/drm/drm_work_fence.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2024 The Linux Foundation
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
+	 * @work: Called from workqueue context when the dma-fence signals.
+	 * Perform any work that cannot run in IRQ context here.
+	 */
+	void (*work)(struct drm_work_fence *wfence);
+
+	/**
+	 * @destroy: Called when the last reference is dropped.
+	 * Free the containing structure here.
+	 */
+	void (*destroy)(struct drm_work_fence *wfence);
+};
+
+/**
+ * struct drm_work_fence - embeddable DRM work fence
+ *
+ * Provides a dma-fence callback that queues a work item when the fence
+ * signals, allowing work that cannot run in IRQ context to be deferred
+ * to a workqueue. Drivers embed this in their own structure.
+ *
+ * NOTE: This helper is a *consumer* of dma_fences only. It CANNOT be
+ * used to implement dma_fence_ops. dma_fence callbacks are invoked
+ * while holding the fence spinlock; work queued here may sleep
+ * (copy_to_user, kthread_use_mm, eventfd_signal) and must not be
+ * called under that spinlock.
+ *
+ * Call drm_work_fence_init() at creation and drm_work_fence_add_callback()
+ * to arm. Call drm_work_fence_cancel_sync() before driver teardown.
+ */
+struct drm_work_fence {
+	/** @refcount: Reference count. */
+	struct kref refcount;
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
+	const struct drm_work_fence_ops *ops;
+};
+
+void drm_work_fence_init(struct drm_work_fence *wfence,
+			 struct workqueue_struct *wq,
+			 const struct drm_work_fence_ops *ops);
+void drm_work_fence_get(struct drm_work_fence *wfence);
+void drm_work_fence_put(struct drm_work_fence *wfence);
+int drm_work_fence_add_callback(struct drm_work_fence *wfence,
+				struct dma_fence *fence);
+bool drm_work_fence_cancel(struct drm_work_fence *wfence);
+void drm_work_fence_cancel_sync(struct drm_work_fence *wfence);
+
+#endif /* __DRM_WORK_FENCE_H__ */
-- 
2.34.1

