Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A8FC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F6B10F05D;
	Thu, 27 Aug 2026 13:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgeCykK1";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB42910F057;
 Thu, 27 Aug 2026 13:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLaJwBMi9teujO5iBXga6Vloxam7D5wKXmi0hErDRpGmiJMitz+P2kuPPusWG5lBsL7F6ha+IBhO1MwVtOcVE9lRUqCh/d5I8akE7QQ8YWKJWG3oCJ5/bahWEayK+Tpd67bVTuM76go55r7Y0z6LQ5ep1hCKRTS4cBQjhi1oCYf4PyDhKIIuEwDucQHXIOFLMMyOj7HSlKfbFyHKg1EtNp6A1ZVez8wO1iMdKwgMqZCLUJphRbhof8TWmTDGeDInx94NnnASH8UU42TXRISvixefZXZU+1m7XL7hwqDT8RWN3tOGRPzFl/QC4B90vLqzLoYUYO9YxkX3bnclwUYdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCZMDCQOkLift3EJzy6pSs7fKDHeYigOD5t6rMI5qls=;
 b=sRxCRtiCz4Bqh0aKclkNciqHpJ+CcGaV4sUEiuwpoHjLkCttHklCgspxkq7PWZmkRJU41XOO/6xEEMAmzITlpxyO1ZyvhYFwWBOi+Y0cbp/+tY2Sz0DKCFRgpi3znEnmuWmK7O8qPPOiozbPpzQUGJhTWNhdbsFcBOiHtykXK/IS8dsNwM9drm5fSEutThgWMoQ/lddhRHmcohG/wzlYdbxxvdurSCbYvs5h1kx1v30Cm6M1/u/254TaU58hnIi+h73ejkdfVkYS1QCl8RWIcaDqMPkv9xJ0cfrRckokjKvsdLR0CREBU2BCa+zLQl6ZzHfbTwC4HQfVVXOeSxS9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCZMDCQOkLift3EJzy6pSs7fKDHeYigOD5t6rMI5qls=;
 b=sgeCykK11uLjrpsk/0RCa4C7aw4vfpVazv5YmhF8QNAjzUtu/di60y9BsJaY1KdT4tIC26VrQXOzkXHvWXSBOsfDBgBp288Qcq6ORq7mNSfFpCdIz4uJxvv6zoPx7364ddb1yG9PTgaW+CaoOStfuX/TyIConPQ3b786F8QY8m0=
Received: from PH7P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::28)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 13:33:00 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::66) by PH7P223CA0002.outlook.office365.com
 (2603:10b6:510:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 13:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 13:33:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 08:32:47 -0500
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
Subject: [PATCH v2 1/2] drm: Add common drm_user_fence helper
Date: Thu, 27 Aug 2026 19:02:25 +0530
Message-ID: <20260827133226.4076593-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827133226.4076593-1-srinivasan.shanmugam@amd.com>
References: <20260827133226.4076593-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: afab1fd9-3ed7-42db-246d-08df043fb6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qOIVj2D9fphMwJ2Heb+Xj5ipEbYzkXAgUbdubjXEhuGRTRDCNrdS4EkNCE6UY2X+2ph/Zc5tyEhrmYPDFA4/uTTuaUPl+0nKsZlFF8DH3BloULhqkSgedDQ86p79JrUW+N52GSri7D2PiQ5vPnU66d0styVfw5LSNt0MyobFqTE1GKyyUDhA0r2ucJ3S84m4SzQ4Ze4pi/vXKSTR1NXzXRIj05Hq3ax0xJQu5+bI69ZpziEb9YhsSQze7NSsozq+MWRzEVcDgfkJNbQIHpw3lWb1O0M3qUFOVjG1kD2CaGkHZn03SYV8YPt9G2uvAZauI+ZS1EkpLwMFaXgR1f9aZA4Hupf6gh0/WK7qzDzNVLQP4aS645qb+d0P+bHhE6xyRu6nMp/2cxpywhFsWqSfVFQF45OIQiMhVOsHZvQB+hw/NnBBSBAC8fq9yPo8pJAVy/LHlSAwaQibEePshQQutthwvdpo1edcRLoFAt6qqB2NKDlUYXwWiWK347hpqimamqAhtGox6QhfK8LWblkz2DzbQ70Wr5PDNQhXS2zOTmu0anHd1LZXAk08UsH83KCcsTVXs9Cq6r0t0KEPW/4TEi5ZLMbRSwJ4cpm2jJijDxzZargNP56wuavA0T1q5f/P9WglRI2PnBsYiDDr1CTG8R/2JK5w22riBnIbZNYS2keC80Fzr09HeG8kUdvTlnZKwZj/dAVI9sT3FSEacJaIGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3DeLovTBSPYzTaOVaU/Z3ToOFi8tfnijpO1dGEZG5ZCINFWn7PDeWVjzPEju43HBLv2zaahTlS7sen+2/wVQo1MrvbRbCf1zMAdw56TsJkBNbEOjCOTg0KoJUvdR/+SUbByTTU8QaloPD+cjegYxirwG72Q0heEWfV4FDmegAYN4QCvgTdxpFXeSLxLGq1YKdGBs7cAtnCVpZxrjLpQCtSvpw3jwRPTnRu3SqJZi7SIviy+YQm6ru2V5xsO2YjYCvm/nJM2dN2LzAPLAddhgAAtQVqs01YFsk/+/Ob1cKpPsfIAy+3GbnN83jqHm81WWNmrwIM1u7RGcrbIcgGfh9PCPAkT0bfagWGcI/FI+sywSp98cREB5nN7Av6GPPjNO9gQBcgBUL2XoD0TNT13dk9THQlCgpUlxneWp6jjTjeseaw7c82m23QNW94VP/Gsx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:33:00.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afab1fd9-3ed7-42db-246d-08df043fb6a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
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
v2:
 - Move INIT_WORK() to drm_user_fence_init() so the work_struct is
   initialized once at object creation, fixing lockdep class divergence
   caused by two different INIT_WORK() call sites. (Sashiko review)
 - drm_user_fence_add_callback() now consumes the fence reference in
   all paths: transferred to the callback on success, put immediately
   on the already-signaled and error paths. Callers must not put the
   fence after this call. (Sashiko review)
 - Add drm_user_fence_cancel() to allow drivers to safely detach a
   pending callback before context teardown, preventing use-after-free
   when a foreign dma-fence signals after driver unload. (Sashiko review)
 - Fix missing newline at end of new files.

 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/drm_user_fence.c | 164 +++++++++++++++++++++++++++++++
 include/drm/drm_user_fence.h     |  71 +++++++++++++
 3 files changed, 236 insertions(+)
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
index 000000000000..a3b14245163a
--- /dev/null
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -0,0 +1,164 @@
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
+	queue_work(ufence->wq, &ufence->work);
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
+	err = dma_fence_add_callback(fence, &ufence->cb, drm_user_fence_cb);
+	if (err == -ENOENT) {
+		/* fence already signaled — queue work and release fence */
+		queue_work(ufence->wq, &ufence->work);
+		dma_fence_put(fence);
+		err = 0;
+	} else if (err) {
+		drm_user_fence_put(ufence);
+		dma_fence_put(fence);
+	}
+	/* on success: fence ref transferred to drm_user_fence_cb */
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_add_callback);
+
+/**
+ * drm_user_fence_cancel - Cancel a pending user fence callback
+ * @ufence: user fence
+ * @fence: the same dma-fence passed to drm_user_fence_add_callback()
+ *
+ * Attempts to remove the pending callback before driver context teardown.
+ * Must be called before the driver tears down its workqueue or ops.
+ *
+ * If the callback has already fired this is a no-op and returns false.
+ * If removal succeeds the caller must call drm_user_fence_put() to
+ * release the reference taken by drm_user_fence_add_callback(), and
+ * must also call dma_fence_put() to release the fence reference that
+ * was transferred at add_callback time.
+ *
+ * Return: true if callback was removed, false if it had already fired.
+ */
+bool drm_user_fence_cancel(struct drm_user_fence *ufence,
+			   struct dma_fence *fence)
+{
+	if (dma_fence_remove_callback(fence, &ufence->cb)) {
+		dma_fence_put(fence);
+		drm_user_fence_put(ufence);
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_cancel);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
new file mode 100644
index 000000000000..0252ce776749
--- /dev/null
+++ b/include/drm/drm_user_fence.h
@@ -0,0 +1,71 @@
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
+ * Call drm_user_fence_cancel() before driver teardown.
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
+bool drm_user_fence_cancel(struct drm_user_fence *ufence,
+			   struct dma_fence *fence);
+
+#endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

