Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12566C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2186D10EEB1;
	Wed,  9 Sep 2026 04:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvO8PRC5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5311810EEAF;
 Wed,  9 Sep 2026 04:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpklJnPmYg8JZMs0T4YyW/8DUYtbUIZfxJX7FoEgBbAZgbwuhnCNLcrmbRxp9ZOZ88Od4D0CyjGmocfY/0LL1iXqfp7TaSlRxTXFu8+Xad/EroMqCDFHYk7b2O76Dmj+wXmgWQCpJ2D5VMNhBMygdbKgo4/liH3VGtm7jbi1O6V6zycJsnHPIZNBDhhjVBuYuDUXg+iDdcEkOXWNxxhIZbXz4PFkI8GnSjVKLAPglv+/ExQDikUl+Qvbw4Gjb4NenYeqhYP24sZ+NlWg3vQ5Jkj76VYNb+X6sJ97eroos6fSOMSb7opJJcWza0fx7CzIG4O70XVJ8MBUpdt+oDd2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9j9JfD+YvEGzdA0P5T80699JRmDdC10sYO9RsZM4qY=;
 b=MB7X3qWFVxnwPNfbfez1Z+uG23lI00N4hTs1QkLdAq4bNVMITogTAAZHnjyFIxNFxTId0gHzL7Lb176PIvbLJca35gEewPrCrDcGhm7HZWHwYsltVZIoUNbX2raTIJgUrZv30fh5aMw5Vd7SphqJEdAZXNS4sQYHBFRD7fyjn7UUlQNC+1uRBEoyURmvteStxv4VWHLS+GTtzVfDZG2lGCJxphj24HkhT694hPqVIUjdHb1NZ40lsRg6xQRmAm0/kIS+bY0qQuwv7c9Wi2pfPAk76QF3MPpPzDgRQOSUiEyB1VZqJ0+35Gd2bsQKvPf4HUpQpydS4dyZPHixogC8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9j9JfD+YvEGzdA0P5T80699JRmDdC10sYO9RsZM4qY=;
 b=mvO8PRC5qzGJbfjXlzZnpvW9IDHQrVhDo87hEsQWprqcmkF3UuH+6/aI1fcfA/tBIZXOVRsvtwKMfpgOW19K31HDbNvozzVIFmqYqscTiqGzFRHvVuVoOfAk2XH/58jXlKZAgJjcqPecGt+WJo0UAy7XgTesC+cFncVkt1hc39k=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 9 Sep 2026
 04:45:16 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::68) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Wed, 9
 Sep 2026 04:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 04:45:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 23:45:14 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v9 2/3] drm: Add drm_user_fence helper
Date: Wed, 9 Sep 2026 10:14:53 +0530
Message-ID: <20260909044454.399340-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: bd685e3a-fcaf-4681-78e5-08df0e2d24f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: mGhQ60HEL+TU3z8Qiyn5nnGK90aPelhK80Gpz+6hF5EeojRLgmtJRS3n8EA9ceI0xxegtFw1VpyD9ywJSDLy16+OSrqTjH0uyudYVzmlaFSd7/YPIfokE7w7uiNVWPpKa57U33Sju9/pW9U6lpWyXErxtlW+ZXannK0xLOalxMJuEPLAdx84sgOWe7868ocpMeMA5uqDsq8/aBGcr/dxnnS//GJm68gphM0RulSZ0SggoAdx+Z3jNmJtBLrBsw0RcQt2gMKjBMskc29Tu3FazGhEWsG8LCCAnauiXzRKGKUQ/MqxN0lQo3f18yGBsI4y9MNrnBwRzXviZmsdsJYAxFurghe73DA4mw/hRTRBTxeNYFIYbQQJBphauYyV+2tTcbk0vz6TRuHc5v77PISFLMygna4UnW2/dFVHqFaQQnB5SxrevCIEiovY1NLbZgCtr2UZZ00+kIxLkCGO2CrUUFBWINr+nXBLRkh/pmzgGGxFwytBCLF8LhXyZAQ6OoccHrNnSWCF/whKmIqDc6XeQKc/WpYdY/eOBvsNrmyEKY6H+bQ8sTAjU42n9gCApc376/z+UOYQueevRDTFDjhN4ww20LV7vZuVt8dkIezZqTAU9nORpAlcF5PTLOozJjB5DUNJ9J3gZEWZgYtd94r7UPIEe80tMMxOLfjWhx14KZ0kNLw/O63tg8iWTOjLvW/I5GR6D0OGGfphUVpT6HvUjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ev7C+oXLRcEMZbgqGGdGghCNPgjbuKx4fOIFmP9xexuMc/RlD8FKpLQwoWLduSDCPtkpNKMjmYGoXef6BE0R32WZ4+OrZ5zxPQg/0eDnm2cikOCNWBnw8JB50y5ikl7Tz9KyyFYDB2tKGjHtlFrJLwFcCBJAwo16QJ0rtotesZkrMMW1Koks34tHW/qR5Vxu50RSrMdMzD4SoM+qD2v1SlYcnSYZoyjCeybTwjSviBwptMQK/b+Pwq6YoaTFKGRpBlbJ1AJ8vQSEysyl3FVyJ7HzzjhpTHkSxtWLOE0pg8G6I1ae2Kdxqe/ppuz+vmrbHdiLLXc4yh3yYOi/6K5fLCfJ6rIPPBRmVLHPTI03U0fBRplIk+ajfIZCWhoCsXzagCcHxz2j+x3IW34pyq1nUe69WuOYmQ5qbZOjHjFCWsqRslJvpFgbYwEsZqYoRQVY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:45:16.5078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd685e3a-fcaf-4681-78e5-08df0e2d24f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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
v9:
- No code changes

v8:
- Fix copyright: The Linux Foundation → Advanced Micro Devices, Inc.
- Switch EXPORT_SYMBOL_GPL → EXPORT_SYMBOL for MIT-licensed code (Matt)
- Rename drm_user_fence_ops callback: worker → writeback (Matt)
- Add WARNING in @writeback kdoc about userfaultfd/FUSE blocking

 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_user_fence.c |  70 ++++++++++++++++++
 include/drm/drm_user_fence.h     | 123 +++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
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
index 000000000000..f7882208a8b7
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Advanced Micro Devices, Inc.
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
+	ufence->ops->writeback(ufence, !!mm);
+
+	if (mm) {
+		kthread_unuse_mm(mm);
+		mmput_async(mm);	/* requires CONFIG_MMU — GPU requires MMU */
+	}
+}
+
+static const struct drm_work_fence_ops drm_user_fence_wfence_ops = {
+	.worker  = drm_user_fence_do_work,
+	.destroy = drm_user_fence_do_destroy,
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
+EXPORT_SYMBOL(drm_user_fence_init);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
new file mode 100644
index 000000000000..db410c12b286
--- /dev/null
+++ b/include/drm/drm_user_fence.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Advanced Micro Devices, Inc.
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
+	 * @writeback: Called from workqueue context with the process MM active.
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
+	void (*writeback)(struct drm_user_fence *ufence, bool mm_ok);
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
+ * When @fence signals, ops->writeback() is called from workqueue context.
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
+ * Must be called during teardown before freeing any resources accessed
+ * by ops->writeback(). May sleep.
+ */
+static inline void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
+{
+	drm_work_fence_cancel_sync(&ufence->base);
+}
+
+#endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

