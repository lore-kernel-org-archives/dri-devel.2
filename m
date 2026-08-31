Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A90C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3224510E5FC;
	Mon, 31 Aug 2026 05:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMDfKZV5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2765D10E5ED;
 Mon, 31 Aug 2026 05:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJG4O0Wq/HOXhHshzk1F+yegLslMjp8Lwp6wD2He/FMh2eHfVkrK2z+G+TwtSqJn/vFKVYzsPaRbIZDxROJ+i+h1lWOM7Oji9Py16qNPiHKJq4B5aW5P0hIrTyD5oPX7+VTU4r6EGtp95Bl6IibfW4tbVW5pq51b0w75QOE3103Ywm7WksKkeFj796yinHSn55OWZjGFse+iYLPT2EsS/qqVKRdTr3rH5OYPwel5FXMpuw++8p4YQMZUOdqnPZGCn+uSzz6bmJwMhTiS1s3wRUsQ4oSafvsNxzmpnevoHcgE8L0h4+hKdX47uLmodVZYcDXMetz1OlHTw1I9Pw0uqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNSZBkM3A9F7VgbN+rs75nUIY0/zpew9AHRvVvhLb/g=;
 b=I4x2lNaMkuRmCRL99nMMrI7WiKNuPsUdNpXcHlyZv6r04UCtMIDmmD6Icf074myQaVRKXxqEFhKjvhyqwKstiUsvGW8B60i0C24YeqV0h1isSdgVCL72YAhpIfLusrhoWVxpER+V0ZjEZjN5rZUfK7P0lyIo/RRrTSEi3NLjhw+4Q9pzFNvytcLFURlJVtKyL+8OX0zOsTC1iLCY/mlR4KU0Vpy55+IIdJ/jtatIkvCUabAb80rGPk4D6R/IBqlNK/MdqV7j3Mb3fzhcmTkYyrHPm6AS3fcxcXszOjHtUv4WoqeJk7ZFG2KSTKKlPl2REmiBwPiNrFcbq3LeUn6mxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNSZBkM3A9F7VgbN+rs75nUIY0/zpew9AHRvVvhLb/g=;
 b=TMDfKZV53S9RWxujPJLQ4zsN9wZ8BZB1LBsoz7Su/Xc8KqIRYjmImvGF9DGrDy8lxYvoWSAFr1wBKMPaB6RtEf+KlKha7b0FEkK/QAz9O+6zCZCS2Vq+NXDu1RtH1VVdEgvVqsXE3RIHnKX2ehL7IA0NbD3TbMtCtqUcXjd7MI4=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:42:23 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::51) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:42:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:42:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
Subject: [PATCH v5 2/4] drm: Add drm_user_fence helper
Date: Mon, 31 Aug 2026 11:11:52 +0530
Message-ID: <20260831054154.107602-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a21731-6345-4a75-3b48-08df0722a19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: BX/0JgiqpCZxls3JY5gUm+t1T1+HntPLTsE30hiTsInre2yabuJU5rR9rbWHQrf0lzVgUBKG5c5+7wZgNeNUfpT5tvRKEV/NQGB5W1QABjZZ2YrL0q6iyZb8J5mQDEJpv1h5y98b/90vULXnfBYgBPdiPU42M7wwE41o6SBdIbXossh9NgoFKyfmmU9KrBuuZLQxlAJESNhWBr5GuHTcmVSNFZRGbIsK5Pf3k7KE7nE9EYjdrbsm1GCQexeu8z2CC6lETl34gSPaUQwmGE8uqQRbnndJTOnBEn7SbP42L7N5q8m4tIzheQu1dRIzL0Z3SZlMzQ8ffbY3hbJQ67wDkMJZpmWvxvzCxldxw5LOcQxXM3nANm4OTaGw+FP/pZ3zt2cGpjHPNUNqs0TJjxbYtH6ufgv8rU2xHPpZNVp+jcF+6+yfhFjNQnAhCs0uonEHcxVL/LhF+espIQNuGFwW+ZiGy7W1qYJifU1D0HEvka5zfKpBHMsgdX6MPH5bzyXS64a2qoWZ7ajPNixKynrFKNkJB2FX7FfDLZF5qVnVrriyN94wdHB100kyakOrlUQRgM0DJ04alfvToHBjFxXH5o7cQN9IcAH2zjZx6sHqLQHFigtBNqWFFLpeTRGTmfUq+QR5kcFdRlQONvgVnzawwK9bzH/OLXOJLhv+EiSJLmrK/O0LOdjWNnYXJjFKCDeLslKTjKsb6IukR2j79JYP+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tqHdJLYDjgNUPoSdtiq2Im5I9Iy8BP+Xa0PNRrZ7J1gzivikVh6WK7xRa5fw6GgD+L5IhVWBogFxG+L01QbZvSQBY7OXEGGLx6CT1UY6e/xZCt16SueHKTWAeUFO+OYJCxEyo2eupu2UHY7rYxcLR/N76S/FJ06g3J7qVH7k9gHisjeWFFKxyY4EaCyWQ0NqpK3yt9QQFOKOwVYOtz3nc6ZcrEOXUljACh9b3d4BIc/5JYh7ZASVVFPDA257+LTK97RROfmlab4wh4rHoXv1HhBWKEHScj0b04pt+8uSkxQ8eRXYDDmqNXcXFqWx7i03N6taGoH4wpdMhqdHgMZVK7843+YFRQOF4Rdeze4tRfSGkOVO5mCit41qIY/dmWdjeB1TorK5Zz1gjTZ9tnXkUF7JWmFCTHUpWTukuVDYFpmu3vzqQXdIcdjNeeBLojC0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:42:23.0384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a21731-6345-4a75-3b48-08df0722a19f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/Makefile         |  1 +
 drivers/gpu/drm/drm_user_fence.c | 69 +++++++++++++++++++++++++
 include/drm/drm_user_fence.h     | 86 ++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 include/drm/drm_user_fence.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c5be8e80d0c8..ddb770738992 100644
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
index 000000000000..664178e2d74c
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2024 The Linux Foundation
+ *
+ * DRM user fence — extends drm_work_fence with kthread_use_mm() support.
+ *
+ * Use this when a GPU fence signals and work needs to access userspace
+ * memory (copy_to_user, fault-able operations) from a kthread context.
+ * For work that does not require userspace memory access, use
+ * drm_work_fence directly.
+ */
+
+#include <linux/kthread.h>
+#include <linux/sched/mm.h>
+
+#include <drm/drm_user_fence.h>
+
+static void drm_user_fence_do_work(struct drm_work_fence *wfence)
+{
+	struct drm_user_fence *ufence =
+		container_of(wfence, struct drm_user_fence, base);
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
+		mmput_async(ufence->mm);
+	}
+}
+
+static void drm_user_fence_do_destroy(struct drm_work_fence *wfence)
+{
+	struct drm_user_fence *ufence =
+		container_of(wfence, struct drm_user_fence, base);
+
+	mmdrop(ufence->mm);
+	ufence->ops->destroy(ufence);
+}
+
+static const struct drm_work_fence_ops drm_user_fence_wf_ops = {
+	.work    = drm_user_fence_do_work,
+	.destroy = drm_user_fence_do_destroy,
+};
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
+	drm_work_fence_init(&ufence->base, wq, &drm_user_fence_wf_ops);
+	ufence->mm = current->mm;
+	mmgrab(ufence->mm);
+	ufence->ops = ops;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_init);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
new file mode 100644
index 000000000000..2b2b640f510f
--- /dev/null
+++ b/include/drm/drm_user_fence.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2024 The Linux Foundation
+ */
+
+#ifndef __DRM_USER_FENCE_H__
+#define __DRM_USER_FENCE_H__
+
+#include <drm/drm_work_fence.h>
+
+struct drm_user_fence;
+
+/**
+ * struct drm_user_fence_ops - driver callbacks for a DRM user fence
+ */
+struct drm_user_fence_ops {
+	/**
+	 * @worker: Called from workqueue context with the process MM active.
+	 *
+	 * If @mm_ok is true, kthread_use_mm() is active and userspace memory
+	 * (copy_to_user, etc.) may be accessed safely.
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
+ * struct drm_user_fence - DRM user fence with MM borrowing
+ *
+ * Extends drm_work_fence with kthread_use_mm() support for drivers
+ * that need to access userspace memory when a GPU fence signals.
+ * For work that does not need userspace memory access, use
+ * drm_work_fence directly.
+ *
+ * Call drm_user_fence_init() at creation and drm_user_fence_add_callback()
+ * to arm on a dma-fence. Call drm_user_fence_cancel_sync() before teardown.
+ */
+struct drm_user_fence {
+	/** @base: Base work fence. Must be first. */
+	struct drm_work_fence base;
+	/** @mm: Process MM grabbed at init time. */
+	struct mm_struct *mm;
+	/** @ops: Driver operations. */
+	const struct drm_user_fence_ops *ops;
+};
+
+void drm_user_fence_init(struct drm_user_fence *ufence,
+			 struct workqueue_struct *wq,
+			 const struct drm_user_fence_ops *ops);
+
+static inline void drm_user_fence_get(struct drm_user_fence *ufence)
+{
+	drm_work_fence_get(&ufence->base);
+}
+
+static inline void drm_user_fence_put(struct drm_user_fence *ufence)
+{
+	drm_work_fence_put(&ufence->base);
+}
+
+static inline int drm_user_fence_add_callback(struct drm_user_fence *ufence,
+					      struct dma_fence *fence)
+{
+	return drm_work_fence_add_callback(&ufence->base, fence);
+}
+
+static inline bool drm_user_fence_cancel(struct drm_user_fence *ufence)
+{
+	return drm_work_fence_cancel(&ufence->base);
+}
+
+static inline void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
+{
+	drm_work_fence_cancel_sync(&ufence->base);
+}
+
+#endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

