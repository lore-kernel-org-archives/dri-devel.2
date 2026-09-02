Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FECEC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B721C10F280;
	Wed,  2 Sep 2026 15:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gucwMLh";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940A910F26C;
 Wed,  2 Sep 2026 15:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBOIttI7htCPZ0A1GR3B456HwVjUwLTZr2eHUrr+j3U7p8jflDLuLY2frFzai6V9c4dReAXUmliOHC5DQzdjJhqMu83etNyghFnTgz5l1xkCHQxwuJQd5hsgp1lsSq/smHrb91aKtFzvLURmPdHzDa0flmReiyCmFhSDyMAbcep8DD8UrsCdo0YFLAgsmVv1mNIWq77m9IuhzEXHNrvbcMPICe2Ncxgig1e5wdCI+XSBZVnmyOjAK870KVqfV5CSEeo8HAAudku8NNGShU5Po5y9/yIMQFQ7dm6govxRYgoCeEHDnNoKiyPkZG0X5BcLmnRWjWAz+9kabFyPpCLutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS7O4Ouw0US0RPcstSMBP5x/6hEJFag8ZZ3cIUJuXd4=;
 b=bhQR/tOSQySgHrcG3dbXHY3d0fZeG/NwEnDeS6GM3C4C0ssnKo0jGPg4WOUA5pVWWclJqNv29PrZq6ighq5E0Kf7aQglokAyIPR62+Ud3DcRGc/+f6YVMcrIe2+JL8o4hQl+rACAY1YlT3G2f/XL/kHq+y7REhSJJ945+HbydBTyLdpXodmSFmVJJml2Vne500HkMkCO/R/5lolaBua9pmTmulRILD2gL462Q4jsvMxelHcTz50Wijwe/w0vo6IlRYe+zMJfzaVK8YMD0vJnG8ci/5d/FVS1JtQV8FgfapWWiGZCiOkhD/pL0nI0FMRd9pnxnS9cXJ1FlTzaGl2iNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS7O4Ouw0US0RPcstSMBP5x/6hEJFag8ZZ3cIUJuXd4=;
 b=2gucwMLhrnnjtZHaDfWoic7iM2bXpBYQ1uT3xqGU/dVHaT1T7M6S2BgpZ7X/vVy2fjX4xPE8dGkhgZcjBEhJ04+0M/BmRtPhe8hzQmNPQ3A+v9cBDwgWtaRlA1TvA1c6Qhx2pWlvr/gaCdgzYPc+o49FDqPXbYWpw/ydACt6f78=
Received: from SJ0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:a03:3a0::28)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:21:18 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::2d) by SJ0PR03CA0263.outlook.office365.com
 (2603:10b6:a03:3a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 15:21:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:21:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v7 2/4] drm: Add drm_user_fence helper
Date: Wed, 2 Sep 2026 20:50:47 +0530
Message-ID: <20260902152049.183685-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
References: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: c49f7a69-489f-4f46-b0e9-08df0905d634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jID8BcxfemBHabTFE4fJC1LO9Iuyja4W67WNr3pel3HboZXf+PqjwuMwLjskqwgeh8udY6U9mSadAxvLEnw1GyYKS+qlLNVwTbdCq2CfMv1gwuHNwmHPkFgi2IAzQlkeOS+ME09ZW/lRqbmG/bDYAAVq4OtEphmOjTylmWq9hzvXMcjI5a2YUs2ckbxci81Q70geVWvXM9epQMWBxDYAZFN3adwVTSvs+ChoCfA7KQ3sZ6eKFK8eu3WJyEF+cqCj+EMXRdWZ/MdccL/L0AE+WsqE2KAtQCXnJurgoB77oYgcvPjyzUOkFgopEzKasrTpVVehhg44pPs3vigQUzPCwgsz7duDzOf+vMoC49iMOkimum+4XaFRQHtdEoEf41uNcPjGjH/mE0LqG2FbWOMYEunVP7VZ22YEfD6yzx65Ip9DiQn787wrnJHDA1kI302zkFiKFbUl+H4U3E7+9PwehVDBlTpcphxVdawe+KswIY4ApT5/vMUEvokT+wd+Ol3MfKDapcdXQNGqwSZP277OFnqKlc1irJzsLleZCwvv0BB99JXcJ1kvh8656aSV80xf2e0tFcqkJUb8VQhY/ESfuyfPJSASTqSGi/HdBD/UwB90lwupA0Djyf+EGSjnMhf4uUFPC3RxE3iEvFOZO1dHvrPuE8rSJvDejYg+4ve/y4mR5uBS8tL4NxhzUqnnftOHRP+c76MMqdXXTRdZDiGEcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eOtq44LsFU/4y4BT7OR/44svPD72Ndq1OrCIxcYusc7kfrI3LHVUSlZb4SdF7dPZb2ZMGrosv+ffb5A2wDIT9wcFnk6JgLUAKQn36zudxqLhnLCoI46kLhuxR7nTVCASLz6fqyRn9Dwr8GM7Z1kKAbPE+u85ravR9sc4jpAyX9hT8aPSJnuG5mZaL5IU5/34RnW9F7H2pyU7iJ76N0Dds7O3wSg+WI5SqVBJxLIs4nIZ2IWqX2oIA2O5kT5ZC0/zRErLqI7bi6Z9JN9t/jPyZHDjQdvoDwt7CDjpa3hTiQ1z1GbxZcLHpuYPzXHbrkJ5kKX4ILQYX8m9SBnSDzmapc+9k0lNO2Pz3LIlzoHXKx9aBRIfvAmBVO7zljBuO3sTJFZ9844NSSf3yRXZqULRz0BFQPSzLVTj9LIPPs8Utky/DCCDqJaG0iLy7kZNjA73
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:21:18.2503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49f7a69-489f-4f46-b0e9-08df0905d634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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
Change-Id: I09da42c688392326ed78235b302fba893e570eff
---
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_user_fence.c |  70 ++++++++++++++++++
 include/drm/drm_user_fence.h     | 122 +++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
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
index 000000000000..0f229b7210a9
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,70 @@
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
+static void drm_user_fence_do_destroy(struct drm_work_fence *wfence)
+{
+	struct drm_user_fence *ufence =
+		container_of(wfence, struct drm_user_fence, base);
+	struct mm_struct *mm = ufence->mm;
+
+	ufence->ops->destroy(ufence);
+	mmdrop(mm);
+}
+
+static void drm_user_fence_do_work(struct drm_work_fence *wfence)
+{
+	struct drm_user_fence *ufence =
+		container_of(wfence, struct drm_user_fence, base);
+	struct mm_struct *mm = NULL;
+
+	if (mmget_not_zero(ufence->mm)) {
+		mm = ufence->mm;
+		kthread_use_mm(mm);
+	}
+
+	ufence->ops->worker(ufence, !!mm);
+
+	if (mm) {
+		kthread_unuse_mm(mm);
+		mmput_async(mm);
+	}
+}
+
+static const struct drm_work_fence_ops drm_user_fence_wfence_ops = {
+	.writeback = drm_user_fence_do_work,
+	.destroy   = drm_user_fence_do_destroy,
+};
+
+/**
+ * drm_user_fence_init - Initialize a user fence
+ * @ufence: user fence to initialize
+ * @wq: workqueue on which to run the worker
+ * @ops: driver operations
+ *
+ * Must be called from process context with a valid current->mm.
+ * Grabs a reference to current->mm via mmgrab().
+ */
+void drm_user_fence_init(struct drm_user_fence *ufence,
+			 struct workqueue_struct *wq,
+			 const struct drm_user_fence_ops *ops)
+{
+	drm_work_fence_init(&ufence->base, wq, &drm_user_fence_wfence_ops);
+	ufence->mm = current->mm;
+	mmgrab(ufence->mm);
+	ufence->ops = ops;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_init);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
new file mode 100644
index 000000000000..d35438eaa9e2
--- /dev/null
+++ b/include/drm/drm_user_fence.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2024 The Linux Foundation
+ */
+
+#ifndef __DRM_USER_FENCE_H__
+#define __DRM_USER_FENCE_H__
+
+#include <linux/dma-fence.h>
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
+	 * If @mm_ok is false, the process MM was already gone; skip the
+	 * userspace write.
+	 *
+	 * wake_up() or other post-signal housekeeping should also happen here.
+	 *
+	 * WARNING: Fault-able operations such as copy_to_user() may block
+	 * indefinitely if userspace registers the target address with
+	 * userfaultfd or backs it with a FUSE mount. Drivers that cannot
+	 * tolerate blocking should use copy_to_user_nofault() instead.
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
+/**
+ * drm_user_fence_get - Acquire a reference to a user fence
+ * @ufence: user fence
+ */
+static inline void drm_user_fence_get(struct drm_user_fence *ufence)
+{
+	drm_work_fence_get(&ufence->base);
+}
+
+/**
+ * drm_user_fence_put - Release a reference to a user fence
+ * @ufence: user fence
+ */
+static inline void drm_user_fence_put(struct drm_user_fence *ufence)
+{
+	drm_work_fence_put(&ufence->base);
+}
+
+/**
+ * drm_user_fence_add_callback - Attach a user fence to a dma-fence
+ * @ufence: user fence; caller retains their reference and must release
+ *          it via drm_user_fence_put() when no longer needed
+ * @fence: dma-fence to watch; one reference is consumed on any return value
+ *
+ * When @fence signals, ops->worker() is called from workqueue context.
+ * If @fence has already signaled, the worker is queued immediately.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static inline int drm_user_fence_add_callback(struct drm_user_fence *ufence,
+					      struct dma_fence *fence)
+{
+	return drm_work_fence_add_callback(&ufence->base, fence);
+}
+
+/**
+ * drm_user_fence_cancel - Cancel a pending user fence callback
+ * @ufence: user fence
+ *
+ * Return: true if callback was removed, false if it had already fired.
+ */
+static inline bool drm_user_fence_cancel(struct drm_user_fence *ufence)
+{
+	return drm_work_fence_cancel(&ufence->base);
+}
+
+/**
+ * drm_user_fence_cancel_sync - Cancel callback and wait for worker to finish
+ * @ufence: user fence
+ *
+ * Must be called during teardown before freeing resources. May sleep.
+ */
+static inline void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
+{
+	drm_work_fence_cancel_sync(&ufence->base);
+}
+
+#endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

