Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF410C61DE8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C509410E5E9;
	Mon, 31 Aug 2026 05:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x70FkQkO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F067210E5F5;
 Mon, 31 Aug 2026 05:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uiw3+h/4GlXObqjMkyX6+Cc/cOGQOujZDuYQNbRbkjGUF+TC97WP/SQ2/cscdtt0/gH9LN0GgtFzR0Egh6ylojSpg5zM68wHMLIRoUv02q7oKbLnhC8s14+dcV7flwAQZthSIOfG97SfZiScKOVD708W1DuEbltxm7VnTOXSsaU+P03o/1qpWLsNcYAiR73F/HV2mWLcjw8ptqn6pitN2hdxkn4Yeru5aPzEu/m8u8KkQ/CeKZXSLf2qNR5ZmETAJ1Maz6stuvNHsZ6kfEkHpwoO0HO3CVEZwBXNAljb8yFLosLkK+cyYQpB58Pc/RtpDkog4HoVOGKlXHlcfMMJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYvo+As9LpHe5Z0PPsDWq2Lo51F72anIYfSQbcJlkPo=;
 b=hdudhLErz886pUzm+eeG+UkCdbOeIjqNY5Ivppw+o01XseHd4XlETVdmANmuh2nZcBY2bzCk03lC1jxJGxu+zjhdNMuFQZ9uG/t+f2amtyBMy3Wo6RxAJglQ2yDqT8zp1BXehwUCVtqMqkQnYrXbnUqNt4E+V7qzWJ30jBZYybNNYwNuyOYTbMGfvRV1qbTxTtSGUEEkKz+LFKqcwiR8dxijyJ4jb6eac4kqsCeyaAXPKQ27oe6CslYscR+J4jBFA8zwF1mZlZgEoMWcTB3p3J5T+hAwsSblDuD/srnTOsjUNrpLL1HImZzgVpigPYBnnJ4pyYgu07fpyMD+2mKqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYvo+As9LpHe5Z0PPsDWq2Lo51F72anIYfSQbcJlkPo=;
 b=x70FkQkOkSs6Q99/FWMLapowD0Yb+K+peidn8ydXp7xJmCj2KMtks8JwAi91Q3VE1Lo4piFIo5zMlTd8UN+L8utGxVNByMz4kY1AWAX7unSAbDD8WuxQYYsESPURJ2xT9P6i12wNWyLGun0MeaUKmKeEdk1ylLT9b9pbJlerd3Y=
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:42:30 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::6e) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:42:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:42:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Thomas=20Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 4/4] drm: Add per-signal compare functionality to
 drm_user_fence
Date: Mon, 31 Aug 2026 11:11:54 +0530
Message-ID: <20260831054154.107602-5-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: e806fdb9-dc32-4431-6d71-08df0722a5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6Q7xjfsLCk+f2++A9rEVMY3uxaK5wkzQT5YmDYYZwTUwiSeFMpjvNCibpqfN232YnZDH1woMRjWn+3aHC4LsBUg9Md4sKZ+71KaoM7IOVuSr9GVXyWNYy2qTyilQxhEFgHCn3OPeEWFcLaTqpCfS/N0LI4XBLI+mKEw+7Myy3jlRKUSsXthLKWHqlUlGEwSqbIqKHoRYqQoq8UByL6Y0WG9qDEzyeT9u3v9u8pRDxXxgBeckHSZWB4z7YUN/CNxYHjLnX18sJ5NJYJgeQ17xnmq95kApemNwHUw7ctHkvDcfn+K5iUlzMEH9sETQQaYVjqBuGLEfYzQRP8/tmyVhjXCfi090lkc1z1aVZUDaXqij0Ath34fNPK5UAxZ5oyGCL9Po4TPMUO/VOL21DvEN4pLWMm42vi60JoU3SlpEthMdDVm60TUzltbgjgtqFgWbcRBOuLhNXWzRJhtNmi/9RtVSeCvf3UYdipylW9SmMv0GiL/RTRRaFncI3gYBthHuNjrSHTqJwo+ws7Do86GcQPtIegMq9XWQDtKSFnnpiDz1W1tSq7PWMboH88TIdn66fx3M6GEi/eaxmP/Q8hFfedN22dS+J8tBkIlvtvQ42AtSsNxgGe4V/1FT0HV3vgTeMVQmMeEIRcVmXbVgi/AN3KpBG+L1N7rCB8FC0wb9XaIDhmgTkrhz88A3WPO0sgJNwGvUSj34uphKg4n7EROSkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eBBCisv8QDuY8yQbuUo82TEBFJVBNPQFJqXgxTyVQZg5LH+h84xh45/7ZwXcYE31nW9NmyhY4pk8g29TTaROSYC2dpCtx6HKNepLn/J+MmYf6vyvJw78b0bXnpN13NAd+D1V+ExluNWsLh2dGIx0gWGrkxzoQfqpMQeSrsWA3X485Z5vzKnM2YGJS7dgmqUoUnUBthVNuJkGFqw4U65o6WmAgxvPUwp97BtGe566St/lo15W0azYHMEA7FZKwtJYSbQI9ycTBr9BOEmYdmk0lqpK72a8x75tnIVxrtSvgnXFnUt8bQR/Ajz35+ZEZEl+A2ILlB/lqHy/9xDNiGe4Te9V49EnqyxFuqTacgQTR+4KNsFExlKRtRiKnLQBPe9Pupyzc06L/MVpX9xVoxlLdvn+6R53/hWeqO+mTBsYe7X0w4JEZXcCnl+5lHD0+1db
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:42:30.3163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e806fdb9-dc32-4431-6d71-08df0722a5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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
drm_user_fence_set_compare() to configure them. Supported operators
are ==, !=, >, >=, <, <=.

When cmp_addr is set, drm_user_fence reads the value from userspace
via get_user() and calls ops->worker() only if the comparison passes.
If the process MM is gone and cmp_addr is set, the worker is skipped
since the comparison cannot be performed.

Drivers that do not need filtering (e.g. XE) leave cmp_addr NULL and
the worker is called unconditionally — no behavioral change.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I44fe8ec50babaa140dd875c00e249e0f6edc0551
---
 drivers/gpu/drm/drm_user_fence.c | 80 +++++++++++++++++++++++++++++++-
 include/drm/drm_user_fence.h     | 29 ++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_fence.c
index 664178e2d74c..9e141533622e 100644
--- a/drivers/gpu/drm/drm_user_fence.c
+++ b/drivers/gpu/drm/drm_user_fence.c
@@ -12,21 +12,68 @@
 
 #include <linux/kthread.h>
 #include <linux/sched/mm.h>
+#include <linux/uaccess.h>
 
 #include <drm/drm_user_fence.h>
 
+static bool drm_user_fence_cmp_match(u64 cur_val, u64 expected,
+				     enum drm_user_fence_cmp op)
+{
+	switch (op) {
+	case DRM_USER_FENCE_CMP_EQ:
+		return cur_val == expected;
+	case DRM_USER_FENCE_CMP_NE:
+		return cur_val != expected;
+	case DRM_USER_FENCE_CMP_GT:
+		return cur_val > expected;
+	case DRM_USER_FENCE_CMP_GE:
+		return cur_val >= expected;
+	case DRM_USER_FENCE_CMP_LT:
+		return cur_val < expected;
+	case DRM_USER_FENCE_CMP_LE:
+		return cur_val <= expected;
+	default:
+		return true;
+	}
+}
+
 static void drm_user_fence_do_work(struct drm_work_fence *wfence)
 {
 	struct drm_user_fence *ufence =
 		container_of(wfence, struct drm_user_fence, base);
 	bool mm_ok = false;
+	bool call_worker = true;
 
 	if (mmget_not_zero(ufence->mm)) {
 		kthread_use_mm(ufence->mm);
 		mm_ok = true;
 	}
 
-	ufence->ops->worker(ufence, mm_ok);
+	/*
+	 * Per-signal comparison: read a value from userspace and compare
+	 * with the expected value. Skip ops->worker if the condition is
+	 * not met. Drivers that do not need filtering leave cmp_addr NULL.
+	 *
+	 * If the MM is gone and cmp_addr is set we cannot perform the
+	 * comparison, so skip the worker rather than calling it without
+	 * having verified the condition.
+	 */
+	if (ufence->cmp_op != DRM_USER_FENCE_CMP_NONE) {
+		if (!mm_ok) {
+			call_worker = false;
+		} else {
+			u64 cur_val;
+
+			if (get_user(cur_val, ufence->cmp_addr) ||
+			    !drm_user_fence_cmp_match(cur_val,
+						      ufence->cmp_value,
+						      ufence->cmp_op))
+				call_worker = false;
+		}
+	}
+
+	if (call_worker)
+		ufence->ops->worker(ufence, mm_ok);
 
 	if (mm_ok) {
 		kthread_unuse_mm(ufence->mm);
@@ -65,5 +112,36 @@ void drm_user_fence_init(struct drm_user_fence *ufence,
 	ufence->mm = current->mm;
 	mmgrab(ufence->mm);
 	ufence->ops = ops;
+	ufence->cmp_addr = NULL;
+	ufence->cmp_value = 0;
+	ufence->cmp_op = DRM_USER_FENCE_CMP_NONE;
 }
 EXPORT_SYMBOL_GPL(drm_user_fence_init);
+
+/**
+ * drm_user_fence_set_compare - Configure per-signal value comparison
+ * @ufence: user fence
+ * @addr: userspace VA to read when the fence signals
+ * @value: expected value to compare against
+ * @op: comparison operator (see &enum drm_user_fence_cmp)
+ *
+ * When set, drm_user_fence reads @addr via get_user() each time the
+ * fence signals and calls ops->worker() only if the comparison passes.
+ * This enables per-signal filtering without open-coding the read+compare
+ * pattern in each driver.
+ *
+ * Must be called after drm_user_fence_init() and before
+ * drm_user_fence_add_callback().
+ */
+void drm_user_fence_set_compare(struct drm_user_fence *ufence,
+				u64 __user *addr, u64 value,
+				enum drm_user_fence_cmp op)
+{
+	if (WARN_ON(op != DRM_USER_FENCE_CMP_NONE && !addr))
+		return;
+
+	ufence->cmp_addr = addr;
+	ufence->cmp_value = value;
+	ufence->cmp_op = op;
+}
+EXPORT_SYMBOL_GPL(drm_user_fence_set_compare);
diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
index 2b2b640f510f..764dd55ed3a2 100644
--- a/include/drm/drm_user_fence.h
+++ b/include/drm/drm_user_fence.h
@@ -33,6 +33,22 @@ struct drm_user_fence_ops {
 	void (*destroy)(struct drm_user_fence *ufence);
 };
 
+/**
+ * enum drm_user_fence_cmp - comparison operators for per-signal filtering
+ *
+ * Used with drm_user_fence_set_compare() to control when ops->worker is
+ * called based on a value read from userspace.
+ */
+enum drm_user_fence_cmp {
+	DRM_USER_FENCE_CMP_NONE = 0, /* always call worker — default */
+	DRM_USER_FENCE_CMP_EQ, /* call worker if *addr == value */
+	DRM_USER_FENCE_CMP_NE, /* call worker if *addr != value */
+	DRM_USER_FENCE_CMP_GT, /* call worker if *addr > value */
+	DRM_USER_FENCE_CMP_GE, /* call worker if *addr >= value */
+	DRM_USER_FENCE_CMP_LT, /* call worker if *addr < value */
+	DRM_USER_FENCE_CMP_LE, /* call worker if *addr <= value */
+};
+
 /**
  * struct drm_user_fence - DRM user fence with MM borrowing
  *
@@ -51,11 +67,24 @@ struct drm_user_fence {
 	struct mm_struct *mm;
 	/** @ops: Driver operations. */
 	const struct drm_user_fence_ops *ops;
+	/**
+	 * @cmp_addr: Userspace VA to read for per-signal comparison.
+	 * NULL means always call ops->worker (default XE behavior).
+	 * Set via drm_user_fence_set_compare().
+	 */
+	u64 __user *cmp_addr;
+	/** @cmp_value: Expected value for comparison. */
+	u64 cmp_value;
+	/** @cmp_op: Comparison operator. */
+	enum drm_user_fence_cmp cmp_op;
 };
 
 void drm_user_fence_init(struct drm_user_fence *ufence,
 			 struct workqueue_struct *wq,
 			 const struct drm_user_fence_ops *ops);
+void drm_user_fence_set_compare(struct drm_user_fence *ufence,
+				u64 __user *addr, u64 value,
+				enum drm_user_fence_cmp op);
 
 static inline void drm_user_fence_get(struct drm_user_fence *ufence)
 {
-- 
2.34.1

