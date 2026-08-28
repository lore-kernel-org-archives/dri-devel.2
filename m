Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3866C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D4B10F260;
	Fri, 28 Aug 2026 06:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCeFQXGg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010028.outbound.protection.outlook.com
 [52.101.193.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC1F10F260;
 Fri, 28 Aug 2026 06:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZx7H7L5C3PHHu3FmjfXNevtWxJr4hQmNViwianinmKwPQqciL0XCjjClafdCSjyuk1kBs27MUKE2mgk5j7WuD7HlAcgJeJwp6P0cfw4LBrYuoJ+tLuVSvKeCs7zMmYh0kzdc8901rA6BvrNWCFjPa3WARpAXmRhUyTmsZ6b9CiSR+lULXwp1XGsZsFtta/fX12vxvNhgqZJewMyj5C+xGz96CueKYPlSVSlvUA+hbK4OQ+uKIpBZONj+5oJeVvNaCSBIMS8Mn8dGZU7NsDrnl00H60w8a5gEgk4CuXskmdcGLe8oVugUOjWO1HW2a/b2znrltFR7IfOoyon5hbHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/uPbK4da1enkqwd4GctbRKUQZpgNAEPmbzk/YoaWJ8=;
 b=m9Q9pyuaRSdhscxm3fx8aE42y3RrJaN/3zCcYMzgF/ezjDX9awzQmgHLspAWciFrGUcU9vUe00g8/UqKdvulfAbKjY58Yy8golI5LxT6TEyntY2v6S2cgWi2TPIDoIby+ZXtx0x4aHPr22WSjDr0RWzXBCWDl35uUf7porw6Xgrc+AkVKBzavbdMFNL651GYUAs4qLIEnt218M//6ggPDX1mlKZvl5ngvRK4ZDZ79Z7veV3Dg+4GyazS14/AWQGL8zGx+Gb9SENTYOAsCq+lkt+iZJ73ulx4qMxErY8/UKcKdm64EkMAS1/BjBVZLlI6SWVHpvtLd0kqOq9mivsEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/uPbK4da1enkqwd4GctbRKUQZpgNAEPmbzk/YoaWJ8=;
 b=tCeFQXGgYXd0KYflD2JPGBzP0GPljs7NQYQrGeTvodzudf3IsSfRSfdA9On+7/a49opWYcPY3sOWxtgn72KJHRRGVCA7FnnWa/MBCqzHTDbhhk6kSieaIAAfOCbDWH8FJzi3cDrbc/ZZV00dyYfeUh1M6h6S1nQLJ7t6zpVHBPg=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:32:07 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::96) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 06:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 06:32:06 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 28 Aug 2026 01:31:23 -0500
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
Date: Fri, 28 Aug 2026 12:01:02 +0530
Message-ID: <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
References: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: de02d830-72b7-4e8f-8b63-08df04ce14aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|7416014|36860700016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8gOfmy7dsrEY47ocZzcZpZ5e5mqgeGMx2gQ7zUKMm9t3acWSDbH7fX5rAnmPkMd6CqM8Y3QomX55z9MH17vk8j582bhKYWpGaIseNZhKvtV1rEtbwH37iJOGEMAV1qZR5Qp8llzxASV31gmpvHFLDLcNiL0uBdQ/5uiDjRzQ4DfiZwR1gTRian0ZuJmLEBRariz5gVNxUjFV6gXWBx035ecz6TKc9bEwa+fopVC7KydL+mFo37jeQz0R7W8pi38wa+5vfFbzmr2UhzRxbDZTAi9DwUWQBpe9up3u4FVEeCcem43mma/0VC3v+euHwJfOy9rKoz5w0f4OdkB13vcH/CFOil/1WfdBqPeleAD5pfTaptimegbKtLKZKtRLMhKlolRtxAm0v9kBEO86ayGqn9UitWEUJfi0DrAiS4K975qIAE0MEryNk3HcZbjQGEUvVw7xaSJrxZ9JB9sWx7BoeVE2ch+PLPaCUuWIkXEl24kXcidbBeH0QmEnEAs5wB7hGY7biGQDMx0/gsNxc1/a95Yqh0cKWWcRY5JyAHoVLThK7nPnJtQ50of4v7yan4qQOZhzplZBnOq8EDbv4NYVnQ9m9c4uebFnsPHeU6SyfWqBUBBb4zIUvTreBUEH2b7OtBoXpjFHM7SiXZxDXU1UmHcQNP2C5T5ZfuBi4PN4F46cBcXgr1UA56BIZQC/KoHcmsm6fR1DhKqCaYK9CtfedA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(7416014)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7waRfQEC72ohxBcIK53cYH8aDHHBQdHRC5dBc9RP2Z7yvCxBYg5LJy6X1kWp1e7TtxCW50xjrKHzEwJZozMfM83UqjPNO3PUc6gEmyBCEzb3/eUSqxIvUjb/1Ou8vhwH9eASEYdNpXQE445tzGkYUmDKw9AtLWhjt20ium/0KT8mjGY8Q1454jEiib8e5YI+LBzBoPmCY6APzN/iU8+6rTDELE0GWeY/TgbF2ShgnNkIjObKzrOQPv8+74vFDQY3gNTnHYy1RJ2e9d1/D2zmXpFL//lfeDJrwMq3GakSR7zJBxndYi1bgF6KUQpEPyLEa2GRJlqKv37ZcBk4Db1/s+s+E9E/P+hocttbm+GEztPAn/3pIQZ/xUM2gaLILG8Gmh6D26KhqGs7T91THlswOqUlCLF4pRczYG1NjzpH8qQ3n6JP26/k2cxOLN/aT4+L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:32:06.5369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de02d830-72b7-4e8f-8b63-08df04ce14aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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

