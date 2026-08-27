Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85934C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BC810F0D3;
	Thu, 27 Aug 2026 15:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xU5tfqyh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B19810F0C2;
 Thu, 27 Aug 2026 15:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQQZShh/mhfNmg/FHGR2v70S72GXdtJP20SJ0+WgrCiiY7W9/yppeeR3CrpV6ZU/ninXRB3hUKwfAGLhjWWc+bWsIWNQwcvI+8iFwkbVJFei8X5aNsw3x+74Ak+V+KmNdOss8lPOKSUooblGxULcN6rYlgMj5mgisx9qvlRLjB+afnrndckGUndu9VDqhZnxykjnJNGbBTQAuuB3FORFmVJEwE0Eek0CFKJY8663FXilyR2wfPm91n8wPAYcodPKj3xxrCUsMh6pZgI1+5JhEsIdeaShJ/VW3ZlZVwn4+kspKVjUlGZGZQrwg1RzcpYG1QQaoOwYiWXXlpiYb7RneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07NLEWPyKqY8J7b1BWFsLE0WSc4j1PzmmyeYIeVIOHU=;
 b=t1lnv2r3hUGjY8n8ZG55JxDgPsu2T9tA3I9QPtlH0GoYKnKR7gqD5t9ABXdk1RV4ZnSZF0XLe+sJW3n46/KN8/wybcHvfNYmkDwJsP6DGk+HT/LgvKCOKyofm8Z9diUn94FinChbUTTs1nbr6bSUivd9LyMO34dlQO9hjFwSrQ7VyvVxY1lvkowl1zJUrr0WDL9hepEGQVaA+Eb+5reNattV5vNIDU2fOHk6tAErXOB4cOVplPZsSlt/JIp33qUEH/Z7Lql7ITY0tI2l4Tem4qCU5rOr4oTlS8BMqg+ONG+3GC2c1t/jUJ/QaK4qJ+0mG/fwhhc2GN+LaOI8HdGIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07NLEWPyKqY8J7b1BWFsLE0WSc4j1PzmmyeYIeVIOHU=;
 b=xU5tfqyhwfCpjadWE+CvCbF2din4TIn6fXsh29Y2dlsNjwAcukXcBCRAq6XYC8xvIRtx8ZFIG1dfzBZuq5QjjCg7acF4DAB6xlw3H5a1NzyRRIlnusAa4iqaRMXuAgPMux6M11O3QZnje6V/mXNu5jfWAnLa+0VK0S+AxTQeKHg=
Received: from SA9PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:21::14)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:20:16 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::46) by SA9PR13CA0009.outlook.office365.com
 (2603:10b6:806:21::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Thu, 27
 Aug 2026 15:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 15:20:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 10:20:10 -0500
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
Subject: [PATCH v3 1/2] drm: Add common drm_user_fence helper
Date: Thu, 27 Aug 2026 20:49:49 +0530
Message-ID: <20260827151950.4080674-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827151950.4080674-1-srinivasan.shanmugam@amd.com>
References: <20260827151950.4080674-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf0ad20-a09e-4305-98cf-08df044eb280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MTpVPLdExxVEpyy7tcB7eJat8s2oI4w3At3VrReS9Aqt2QZeljoNCGsoVuU4YdXhxFcuh6hemMvMJ4d/0YG5L4oe7viC+xYb17Fzyxln2+gRi1yavb7jWm1d4PfNSfteMH/c8G8Ala1bBMwLnr2Hrj2FUPzYksasqG/K8Nf/0LEA5J+UijkBq7Mhi05KTfRdootpyPvYOKz363XQJfx5yFqan98RekdQj3wUtQNFYRPPVvMbmLBxFKJk2uyAeyf5bBR8KohY+9p1ZHX2eGQJO0ao1920eDtwAJIw4cyjh30jixNyRts1xFYVNw+urck1eYzsz6Ut+GAT00PH0/COxUug4C0IEt1CyfahBAoM+9lvJGbwjyhoTqBVZopfMyaJCPJGfKMkfFbODXmTy82xOiInDLh67OZE6Zl6x6hqludRB0TksRQk7Bz70O7xiRKByREWzj+EOXunb5aGRJ9r3Wdv33mmydPwgRmC+Rl5zlv+52qP3VkrYkHjcXm1cUL7OzqmT5D/jZSslOl4tsk22jM0+XjIxxOAXURnNCDRbnBl8f97OeovAUpa+x+yZCdbh2geskuSS6qHQjmsNplNgfgrLL2+JRj4R9HRXwtOguC1Nyhl0p7ZiLSQLuFOm9pMsCteD9oTm5iKkmFKdEA+35IiEX8WWf5YfZrVFez+XUjaNyCQ8og8ExOQA1TRzmyFAyViQ2I0iUAPyFD811hyCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iVIt8nMt4fR2HnxcE44w8aq/IDgmikZW7W259DUrpVCCBbrU3KLbQBUh+u7dLpAaEENU5pdrd88kn2zKZJly2jo0HR5ubsgh08vkV058YBeTuyqyM+CMJ95yVEaC7wGQ88bJzsaeO/4pA8+JCrAG2HsFKtEsMRVSo/kU3X6bYkTKKKpkeLNYSDve+uBblDLROKvUh6HSmsFzDk4Hc0hR3y8JI7LYOY447W22oSfju6EMZ6jBwOuzke5+g52bH/EsKk/HQuHmfp4URevAZSi91DiwDhkJ4yzgE+IJjKUDb+cXhA3WkQm7Jh3XHTRqmPNUS+4wiTVhKdO9tmDguKOHoWnl3iOk1XLeThpfnKS+uBqj2p/++SWCppIlIxr6AAzoIedxvuyugqcM5ktnuqCf3B5NLCxsHxVRMkhbxnPWKJsVKZhbcDaYOsbb6iep156Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:20:15.8010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf0ad20-a09e-4305-98cf-08df044eb280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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
v3:
 - Store fence reference inside drm_user_fence during add_callback so
   drm_user_fence_cancel() can be called safely without the caller
   holding a separate fence reference, fixing a potential UAF when a
   foreign dma-fence signals after driver teardown. (Sashiko review)
 - Fix contradictory kernel-doc for drm_user_fence_cancel() which
   incorrectly instructed callers to put references that the function
   already puts internally. (Sashiko review)
 - Add drm_user_fence_cancel_sync() to guarantee the worker has fully
   completed before returning. (Sashiko review)

v2:
 - Move INIT_WORK() to drm_user_fence_init() fixing lockdep class
   divergence. (Sashiko review)
 - drm_user_fence_add_callback() now consumes the fence reference in
   all paths. (Sashiko review)
 - Add drm_user_fence_cancel() for safe driver teardown. (Sashiko review)
 - Fix missing newline at end of new files.
 
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_user_fence.c | 210 +++++++++++++++++++++++++++++++
 include/drm/drm_user_fence.h     |  76 +++++++++++
 3 files changed, 287 insertions(+)
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
index 000000000000..83920d2be43b
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,209 @@
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
+ * If the callback has already fired this returns false and all cleanup
+ * has already been handled internally — the caller needs no further action.
+ *
+ * If removal succeeds all references are released internally — the caller
+ * must NOT call drm_user_fence_put() or dma_fence_put() afterward.
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
+ * the worker has fully completed before returning. Drivers must call
+ * this during teardown before freeing any resources accessed by
+ * ops->worker().
+ */
+void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
+{
+	drm_user_fence_cancel(ufence);
+	cancel_work_sync(&ufence->work);
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

