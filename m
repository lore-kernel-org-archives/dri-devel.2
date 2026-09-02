Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8622AC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4F110E4F6;
	Wed,  2 Sep 2026 15:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kCjSaN4N";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D6A10E4F6;
 Wed,  2 Sep 2026 15:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+CgZElLkXqo1UIOck8APBybeScIpYVXdDQj3EF2HHmY/XKMGRxi5vKjZ1yhf+JeSChfUA3b71hff5/l00bymrJ/3vMqT7hMZ3RHfReKl2SXFE9U9OWejW5vcBicHWqqfm3/Loa43QPUFganxFePo5bL/+lTPdHO6BMzWZpiioadYuXTFZ8QTWEvVhSzvriA32SHWrnf7fYqFvRRqd/W/N86qx6v/3/0AXkAnrbJE8F1oRUYOn0NSX2GMyog7VdstzHdczpK/NPrWIFPWXkdp73FWvbm1CY0X2DkcLeDr3kcuNcdR1Y/oZ/jpusPSwNYqCv8wfu5LyHyjS9bYOT2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7J9RbAyb9b+wmqDNTAs9iimsrindBQV8/v3l6KbZlk=;
 b=df6QSbr3lAb33XBrR3ZnFPWvUrsTcRWSe/S94FnDLYwzgEzVN1svlJpPsvxSwo4VhV6bOtuJxikhabpSg6FITR7/7nVEBM4NAXzftCIzFbdw5Haq7UVzN5sNB7mW5m6y3g5i366uZ/r3T/ZiHPdxokaTccNSuIHjsRuuMw0Mz1JoZ9oFzIfkDN+rI1QRCcZsLp+7M2pfeBCgKzZg/VuMf0a07Jt1ff/lYYb+LOqqibFUBvCp3/0K5sAH7Cs1e9t1tzPaiPi4At+wIg5fOlkgmtvAs+BCS+uMU8q6NzcTH+TWqxENUGmHbekN5myVAmTbGxGVaEOFyc1sScuEEZAKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7J9RbAyb9b+wmqDNTAs9iimsrindBQV8/v3l6KbZlk=;
 b=kCjSaN4NSKiPBsAUkcqQYcJjdEFvEf/EZ3K1qKUuZI8d/VMq9/9hZrbAWUrMrJigh/qTU2WVSSE+72Bj/uTNFhvkCMhDhQ7hnUi9lkElmOCsNNQMEl8MGQVe+K3cKbcEcu13UDy+IaBwfiFqBgBx5D7zgUrZ8kK/Yg/22NFTZXg=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:21:22 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::88) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 15:21:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:21:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v7 4/4] drm: Add per-signal compare functionality to
 drm_user_fence
Date: Wed, 2 Sep 2026 20:50:49 +0530
Message-ID: <20260902152049.183685-4-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0e5264-a0fc-4bd1-37ba-08df0905d88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: bjsBSufGa8pV9UbOis8xO3n5j3UKdnoClqez2OwsDnzIWSYxtTGReSr/oQej5TkjCpfXIB5LkXipFilYNRwelPLQ5A0xXu2+8pumEOM1ou2YgxenR7SGPpW36e+NynRhXYdQBPxW1ODF0n9S7520IASw890PUBL0oi0TGPcA6P4KyBt8O5v5Ud5vBb7vS5vdoTYq5TTCo35WcbwziAmA9muKl7ZTEH0Mj165gek19AbDCKKXCPfH/XxLswNCrdGWmP4FGAfD+SA/6AUDSrWwp9QtW8S+/eZOgm3h3Z9qjJR1IPHtaCB9NWnOzpZFTmCyTgZSFqrd96q3+FwQ0BCCLnQ+zvMMAccanQ1J/A9DhwVSjlwmj4meONc2HJ03lRd4YThd9Yo5FBhWD7gebyMbx4CQ3hEqsgrk3Vn0yjVUgVMIjJoyiuGB64qNT1QkRNe0fHJJRY8OBhOtn/Ez5sU+NTSno11/gpexh2l0CjnTf+1gfMb31+ujVOd8WLnwNw0BFxjQ+mThQ3Ae5EcdQ4zj83Y/72rp7N576XdgHOadJHbQZAbJrrS8iGqk1VdAg77UmxXWZ/gaZxW0kAfVNNXfL7qU26rdQCJgp2ZlDbfQAORq5QyLht0HHEX6TSj3SfV443nFw1DUSJ17X+anjPIk5iqo2WfbxY6cuVC9nJ9rFNTZWD3bKHb4oGOacJJDVRiYn94Vs8VnS3I9FTlfb47Dug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9S7aZa6rJsUKdnvhTAY2+eImcYgX0MLLhjhMAmi9L+RdKWVl/U7ynpV1T+nFtSFHEnOsvzTP/ZtovVApOns+WXd/jlVoaYm87rZd6g1heS7mZX97d/c0U5hBX7F+c3ONx2lhA+obKp8qmbtLRNpkStra4fZJaGlfhPCbKewbbupT4gRYraTHeDJ3pi4/9nienzaLz0P3NO5cHlwJ+gT7+F/FQJCjwwJAN2jOrgHkGSCl/zO4kM+T5FD0Sk+9pFj2Muec3+nsG6XrSPpVByIqt5rRQFMRXiQrA3a00F0oUqbljuKOKmMe3nwiXjLUdFeY4lWU9sJQDQF+5VLDaAn4jdQv1wUhUOwwW90qFdChlxtSuq9TbxeB4lbFocQXXqtInK6BfOvhCycf8W9AalVZEw6hJTvOrhtc8ds9AaBmSG270Q3UBMI/V/4Cj1FjzlfR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:21:22.1062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0e5264-a0fc-4bd1-37ba-08df0905d88a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

GPU drivers sometimes need to read a value from a userspace VA when a
dma-fence signals, compare it with an expected value, and only perform
the deferred work (e.g. eventfd_signal) if the comparison passes. This
is the per-signal filtering pattern used in AMDGPU's EOP eventfd path.

Add optional compare fields to drm_user_fence and a new helper
drm_user_fence_set_compare() to configure them. Supported operators are
==, !=, >=.

When cmp_op is set, drm_user_fence reads the value from userspace via
copy_from_user_nofault() and calls ops->worker() with mm_ok=true only if
the comparison passes. If the process MM is gone or the read fails, the
worker is called with mm_ok=false to allow mandatory housekeeping (e.g.
wake_up()).

Drivers that do not need filtering (e.g. XE) leave cmp_op unset and the
worker is called unconditionally — no behavioral change.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I200dd4bf32286ba9bdd2ecb68fffb3c205f9fd52
---
 drivers/gpu/drm/drm_user_fence.c | 97 +++++++++++++++++++++++++++++---
 include/drm/drm_user_fence.h     | 47 +++++++++++++++-
 2 files changed, 135 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_fence.c
index 0f229b7210a9..06a5683db10d 100644
--- a/drivers/gpu/drm/drm_user_fence.c
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -2,16 +2,25 @@
 /*
  * Copyright © 2024 The Linux Foundation
  *
- * DRM user fence — extends drm_work_fence with kthread_use_mm() support.
+ * DRM user fence helper.
  *
- * Use this when a GPU fence signals and work needs to access userspace
- * memory (copy_to_user, fault-able operations) from a kthread context.
- * For work that does not require userspace memory access, use
- * drm_work_fence directly.
+ * Extends drm_work_fence with the ability to access userspace memory
+ * from workqueue context by borrowing the process MM via kthread_use_mm().
+ *
+ * Drivers that need to write completion status to userspace (e.g., user
+ * fences, signaling eventfds) embed drm_user_fence and implement
+ * ops->worker() to do the actual write.
+ *
+ * Optionally, drivers may configure a per-signal compare via
+ * drm_user_fence_set_compare(): work is skipped unless the value at a
+ * userspace address matches the expected value at signal time.
  */
 
 #include <linux/kthread.h>
+#include <linux/mm.h>
 #include <linux/sched/mm.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_user_fence.h>
 
@@ -30,13 +39,46 @@ static void drm_user_fence_do_work(struct drm_work_fence *wfence)
 	struct drm_user_fence *ufence =
 		container_of(wfence, struct drm_user_fence, base);
 	struct mm_struct *mm = NULL;
+	bool call_worker = true;
 
 	if (mmget_not_zero(ufence->mm)) {
 		mm = ufence->mm;
 		kthread_use_mm(mm);
 	}
 
-	ufence->ops->worker(ufence, !!mm);
+	if (ufence->cmp_op != DRM_USER_FENCE_CMP_NONE &&
+	    !(wfence->fence && wfence->fence->error)) {
+		if (!mm) {
+			call_worker = false;
+		} else {
+			__le64 raw;
+
+			/*
+			 * Use copy_from_user_nofault() to prevent a
+			 * userfaultfd-registered page from blocking this
+			 * workqueue thread indefinitely (DoS).
+			 */
+			if (copy_from_user_nofault(&raw, ufence->cmp_addr,
+						   sizeof(raw))) {
+				call_worker = false;
+			} else {
+				/* GPU writes LE; convert before comparing. */
+				u64 cur_val = le64_to_cpu(raw);
+
+				if (!drm_user_fence_cmp_match(cur_val,
+							      ufence->cmp_value,
+							      ufence->cmp_op))
+					call_worker = false;
+			}
+		}
+	}
+
+	/*
+	 * Always invoke the worker so drivers can perform mandatory
+	 * housekeeping (e.g. wake_up()). Pass false if the compare
+	 * filter suppressed the write.
+	 */
+	ufence->ops->worker(ufence, call_worker ? !!mm : false);
 
 	if (mm) {
 		kthread_unuse_mm(mm);
@@ -63,8 +105,47 @@ void drm_user_fence_init(struct drm_user_fence *ufence,
 			 const struct drm_user_fence_ops *ops)
 {
 	drm_work_fence_init(&ufence->base, wq, &drm_user_fence_wfence_ops);
-	ufence->mm = current->mm;
+	ufence->mm        = current->mm;
 	mmgrab(ufence->mm);
-	ufence->ops = ops;
+	ufence->ops       = ops;
+	ufence->cmp_op    = DRM_USER_FENCE_CMP_NONE;
+	ufence->cmp_addr  = NULL;
+	ufence->cmp_value = 0;
 }
 EXPORT_SYMBOL_GPL(drm_user_fence_init);
+
+/**
+ * drm_user_fence_set_compare - Set per-signal compare filter
+ * @ufence: user fence
+ * @addr: 8-byte-aligned userspace address to read from at signal time
+ * @value: expected value to compare against
+ * @op: comparison operator; pass %DRM_USER_FENCE_CMP_NONE to disable
+ *
+ * When @op is not %DRM_USER_FENCE_CMP_NONE, the worker is only called
+ * with mm_ok=true if the value at @addr matches @value according to @op.
+ * The worker is always called for mandatory housekeeping.
+ * If the MM is gone or the read fails, mm_ok is passed as false.
+ *
+ * Must only be called before drm_work_fence_add_callback().
+ */
+void drm_user_fence_set_compare(struct drm_user_fence *ufence,
+				u64 __user *addr, u64 value,
+				enum drm_user_fence_cmp op)
+{
+	/*
+	 * get_user() of u64 is not atomic on 32-bit — caller should not
+	 * reach here on non-64-bit kernels.
+	 */
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT)))
+		return;
+
+	if (op != DRM_USER_FENCE_CMP_NONE) {
+		if (!addr || !IS_ALIGNED((unsigned long)addr, sizeof(u64)))
+			return;
+	}
+
+	ufence->cmp_addr  = addr;
+	ufence->cmp_value = value;
+	ufence->cmp_op    = op;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_set_compare);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
index d35438eaa9e2..65287052370f 100644
--- a/include/drm/drm_user_fence.h
+++ b/include/drm/drm_user_fence.h
@@ -40,11 +40,23 @@ struct drm_user_fence_ops {
 	void (*destroy)(struct drm_user_fence *ufence);
 };
 
+/**
+ * enum drm_user_fence_cmp - compare operator for per-signal filtering
+ */
+enum drm_user_fence_cmp {
+	DRM_USER_FENCE_CMP_NONE = 0,
+	DRM_USER_FENCE_CMP_EQ,
+	DRM_USER_FENCE_CMP_NEQ,
+	DRM_USER_FENCE_CMP_GTE,
+};
+
 /**
  * struct drm_user_fence - DRM user fence with MM borrowing
  *
  * Extends drm_work_fence with kthread_use_mm() support for drivers
  * that need to access userspace memory when a GPU fence signals.
+ * For work that does not need userspace memory access, use
+ * drm_work_fence directly.
  *
  * Call drm_user_fence_init() at creation and drm_user_fence_add_callback()
  * to arm on a dma-fence. Call drm_user_fence_cancel_sync() before teardown.
@@ -56,11 +68,20 @@ struct drm_user_fence {
 	struct mm_struct *mm;
 	/** @ops: Driver operations. */
 	const struct drm_user_fence_ops *ops;
+	/** @cmp_addr: Userspace address to read for per-signal compare. */
+	u64 __user *cmp_addr;
+	/** @cmp_value: Expected value for per-signal compare. */
+	u64 cmp_value;
+	/** @cmp_op: Compare operator; DRM_USER_FENCE_CMP_NONE disables. */
+	enum drm_user_fence_cmp cmp_op;
 };
 
 void drm_user_fence_init(struct drm_user_fence *ufence,
 			 struct workqueue_struct *wq,
 			 const struct drm_user_fence_ops *ops);
+void drm_user_fence_set_compare(struct drm_user_fence *ufence,
+				u64 __user *addr, u64 value,
+				enum drm_user_fence_cmp op);
 
 /**
  * drm_user_fence_get - Acquire a reference to a user fence
@@ -112,11 +133,35 @@ static inline bool drm_user_fence_cancel(struct drm_user_fence *ufence)
  * drm_user_fence_cancel_sync - Cancel callback and wait for worker to finish
  * @ufence: user fence
  *
- * Must be called during teardown before freeing resources. May sleep.
+ * Must be called during teardown before freeing any resources accessed
+ * by ops->worker(). May sleep.
  */
 static inline void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
 {
 	drm_work_fence_cancel_sync(&ufence->base);
 }
 
+/**
+ * drm_user_fence_cmp_match - Test a value against the compare filter
+ * @cur_val: value read from userspace (already converted from LE)
+ * @cmp_value: expected value
+ * @op: comparison operator
+ *
+ * Return: true if the comparison passes, false otherwise.
+ */
+static inline bool drm_user_fence_cmp_match(u64 cur_val, u64 cmp_value,
+					    enum drm_user_fence_cmp op)
+{
+	switch (op) {
+	case DRM_USER_FENCE_CMP_EQ:
+		return cur_val == cmp_value;
+	case DRM_USER_FENCE_CMP_NEQ:
+		return cur_val != cmp_value;
+	case DRM_USER_FENCE_CMP_GTE:
+		return cur_val >= cmp_value;
+	default:
+		return false;
+	}
+}
+
 #endif /* __DRM_USER_FENCE_H__ */
-- 
2.34.1

