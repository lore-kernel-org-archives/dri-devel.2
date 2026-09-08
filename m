Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB39C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E338E10EAB4;
	Tue,  8 Sep 2026 08:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eNpjOwlz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAAE10EAB1;
 Tue,  8 Sep 2026 08:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxZtv1Jdi5iEYGwUVGxyQAqL+6osZCXu7WJZc3P59lzuHyBbyiwZNGasU5C+JKsYEJqHH7lcinv/C/8cq88wfR7fY8JsWsPouC8WUDQO5atE9/27R+DNrAlowGCbx+cTwaCcD6PF8yU2UEps9gBYaw55Bo1XPJal46J2mixQiirktcf4Pk8Zaattx3IAbhi9HsPD25AiQoK7pNCjgbWiAUJR0cEkPPoP/jntyG7Gn4hytDFhi3WENK/bHtS9Z+aThw1hAo644Z0pW38BOSSX2YZXazJHqJ7Q2ogFmzpr2WES/pCwUdX262XtkRFGVMns+oBvhqxZCry35R48aMwhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuiEL/HHScrGf/PmYclR5fArqmB0tc4WgpLyMKjBsOY=;
 b=GmBqtG5EMJ7BLg6rcCm4oU0VZNf1UV7B5Q80UnpA2YcfgGHkZJrjXA5UBzaZb90ICoSdQX5dD3t4h3pSeAD0G82l/ljWedTOfSc4GwcNSF020qmsmTFjgwkfDHgIckX53teSxsl/L823zHroXI0l6zYGQQG9LRmQZ189t1z8hvhjcvpfTAbsHwubgm6N7DKSAFW02mLfJL4DeK4SRCn3w4IWi0GHSqvsludYihABUPjB54KHQ76QHub0H6Pg+IVjs7S/YqJRomRG3W5uJxu+McGe7iYCOfTESZ+IlIu2TbJCpKedkX71dgL3aGmIEZ4HjrAMuV72NgWajQGcehI18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuiEL/HHScrGf/PmYclR5fArqmB0tc4WgpLyMKjBsOY=;
 b=eNpjOwlz/MJ5QvDIVuFmaxgo/VYV+tKX9Vp/8TkCqY8UOTonmbL3I+LVwX+XnSqRZ7KFv1TZHoQZdaKhT8E4JUi1FSvzZivyt2bt+JQG7BoXRwwjSyzThxB96AoC9Ehbu6dT9WZjs3dZhzDoEJ4ATPcsWb4cd3mEPVN73StooN0=
Received: from CH2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:610:57::23)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:46:54 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::76) by CH2PR12CA0013.outlook.office365.com
 (2603:10b6:610:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 08:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 08:46:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 03:46:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v8 2/3] drm: Add drm_user_fence helper
Date: Tue, 8 Sep 2026 14:16:26 +0530
Message-ID: <20260908084627.352535-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 7226ab33-1001-4ff9-3138-08df0d85b8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: m2zHspl1qA8ck0wYtm4OlfjDR9MheOxuC4CeHTf3dCs2qJtVx0TUcJYdHxF7AmCjJwC5kfKMp5z+6oPkqp14OkFVFJWIeDJkx3LCRvz4ePyQ4ekv2aAj7q4Wtzo9LoyGwA8m7Zd14D3THjyS7HTVvj197fiAZZPYptrKm3xQ0XP93OATY4JLF27wygnQlEHCc6dN877dOaWoOr0chep4Ww6COkybILp5u85tTmDZxMqcxwHE2w8IBFDy2RbVLKprBgSBKhdYbz9GXsoCyJUNn8kJ1NPMRmiyGWavR4PO/CQZsopbEwkVc3XgqTTWrmaLgvNLpIajLZCdXAg9+FLwmdQLnz6961aaLdLdRbmzBV/ufhFgthbqQWIMZqEyXB7QBVX6DtjeAULboq6Mo5QPmEQPS2W5DZtWCy55iw/3PQdXeqpjU0aLOk9Hs5TY8TlK9mWoaQgmsSbtRKpMoGFjsfJks5nRPI/n6WGhs0b2MSFizlvDruKljY5PZ9efGL9yvE/qRrN9hjfr9aRktxYl3vG1IYwV2+KVukGVJSNrhGZFNXxflDy71YXlQoFZgC77QxEj25usWIQFdDeSCR1cvRz7U4gW5idfEzW2OmDon0Ue6VrsnzXafJIBLoEYlU9H54xCDdDixmBuYsrZLihw0mxPPYUq/BT6BoVOC4sIkmPs6agXxyzlsWcYtB6Jel+Vfhxo8CbuVZDt54KK+0sk2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6jqgFcblA52CKb/DItoYkB5q6gLNcqnkwFrtxn78dpHmWqTvhvyEivi+dQ7U5UMZY7eWp2pj+vJlGsg+d3RgWfN+5QvdzxUT75IfhmSnyjJ+icBuhZL8e4lCuqWgmToSZRaN4HrhTadP2vLRwf5bhZjwtU84ORNKgPLwvdROvyYiC8TDank2gw0IBwjb3iYylzK/NfxfBLS7BSXpAvcK1unuqwv/otbQkSZer4IjB+C+42mX0qlFKVppzN8czOOMMVk09R9P8bF8SkSpcpouxGq76TqoEYXSHUBkouYYRj47HBzJWptCsvrJ0dlNOoJxwiwcJCb2E24lTXNW4FMD7JUeOdcgd5zBixQyKEVHJ7cJ1GXUFPCF9Y/G8DD6ldcUyzAV12/r1Ajsuo5YO/8SQN4Gv+BbYjpEDWWgqxjvX9U1h75HUKEy3m4uw6hms72C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:46:49.2839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226ab33-1001-4ff9-3138-08df0d85b8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
v8:
- Fix copyright: The Linux Foundation → Advanced Micro Devices, Inc.
- Switch EXPORT_SYMBOL_GPL → EXPORT_SYMBOL (MIT license, Matt)
- Rename drm_user_fence_ops callback worker → writeback (Matt)
- Register as .worker in drm_work_fence_ops initializer
- Add WARNING in @writeback kdoc about userfaultfd/FUSE blocking
- Add mmput_async comment noting CONFIG_MMU requirement

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

