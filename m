Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB13C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2469F10E8B9;
	Mon, 31 Aug 2026 13:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fm8aHKpy";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925C610E8B7;
 Mon, 31 Aug 2026 13:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQL5dNQAZF4w/W7hlD5GYAxznNVtRKMLDmh0PgHmNUEjNtE/0WIe67UwlWqfIaxfIkK3XhLeSvT/zSxLk3mz68pFVs5RC+ASZHU5/gVnyYakzNzYArJH7p4/yJodUWMR7IW9+mm8lxIkZk4NqenBpe8+ID01PgkRvVK6yh+VIpymmqBzu4B/sPnKfXwyXHH1VOSQS+WML+2AKnWnGVLEwOpQ0Pvy8W5nJ+9D8AJNnFbTLmC4zCGWrDx2wNW7u4OdImrD5ITC4/+JaVx2Ul6n5JiGcxumWbhSVf0PC8IxyL7YRuUaRrIaGhqwWaKELAiTCe1jxIDflqOgOW3L8tRUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHeaGD4mdlZmYt58g+LSpMT/PtS3eJZiVjN+5Lno/xw=;
 b=PrI1LBH3Xu01aqd6LmnvYXO/fzgeWBU8xu0YYLlGvO3OgKQt6fzNO9xkFLiU1U/hCYW25F5eMsv3Hmzf1t6wMnXfVQeX1MjcuOh/BJfNzaUMmodKALoaViMnBjAAO1H8uzmaI0hf9nQbYdK2+ykqsBnb4zXFcFPMoYEOLJU1wdlbVyQ207nnoz5laRlNSITsrmPc/XsrNEOW6qUw3lEepZLMwr5dfbYiYNeXa94GZFr5QmHNvrABDxRAHb+0qfqcXiwoCoXiCyHVz2kx9lHcI1XlsDzw6jUz09h+kBlAmeKL62TT6UdQ8JIiDtAiDm5f8AP4TGO1r9+czr3NEqIpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHeaGD4mdlZmYt58g+LSpMT/PtS3eJZiVjN+5Lno/xw=;
 b=fm8aHKpy4Pd4Cuz+DpSqNZGOVr2bT0f9B3Y/aQXrEMG3bx+W5K2++F+HaHxsXzuilyx8i8FX9GiJvjcGvoHvWT8vK/DcMVCGMkCjBEA2RPVMm1J1ucSOUUgyu/aH61giz2+g3wIPYsYM3G5+DL6QUbuQYkLGYRuRONP2hPL9DQw=
Received: from SA1PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:2d3::24)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:46:14 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::16) by SA1PR03CA0021.outlook.office365.com
 (2603:10b6:806:2d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 13:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 13:46:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 08:46:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 4/4] drm: Add per-signal compare functionality to
 drm_user_fence
Date: Mon, 31 Aug 2026 19:15:39 +0530
Message-ID: <20260831134539.112690-5-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e55b538-c46d-424c-c08b-08df076638d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 391KveGTtUBoW9Idm4qmRGw9RqA9r2YQwlrA8hncloS9ZM2TKRFguaXeXh9JLZcrKdkGxrEz1g1aqffXaKvGQdGaBYVAnAUuUJJFAFvspRvT0wtI9CYNFf+JEB9fEnNDABckA9agdmwh+3O8NruU0ndWhsGAsXbAIH4vDaI6zXpz528huFwVUFMnh2rgSEIxmmyoPrEkhEOmzw4uEybBablcWn2eqzWI5o+qTM5OyHN7eEt+oAQVkqpJTbKs7NFCq5FSppsnb0+OTtWnxUyJzLvFaMfS2bwTWhn7esLxjHA151+xmkVbTDpLHK+GSgm8OOZKQLo3icpmcNza8wjlpU/PLztUUau3PVCXjfDJQRrBiXSzlFlOyQ2YaXCF6z+IHZPy16K/5gJwwZuPG0S+PM4jGB0QVhb/SuM+rBlzlRBuSrGfSN0seFqjkubBjpUyuqcBDLQRG5nTwi/j1dz1HVnNSPAIQubW+wL2hxp9ujRDQxBh/0nzv7/4J3vs1VHVUI8is2SYypNm6gWpzTx0uVHC2wZ/mh2ExE2oeKB71KZwPi8rwV6vvIMj7mFSHFR6eTsdCugfdvRViGlUnqiV/++VhxteEgdtB1+lRZ1I46kelsR2YdOea58VcuYyCsmx9VHADa/m+fkFH0EQmX292BPx4iYBZegN1AML+obVIWm+5YgWu+Nu2kt7aEHkHZswuZnIuWTdQcLPt7+zeksMlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXrEhpRgb4doCg+5HmQ5MqkQTyHblhBZ4029pT8tRgmVDo3c1Vm7g9m0H3iFngLRuMQLOK1zRbLjLY27Vpps9+d4RvNcLo3slgFsNJG6BWdzNbzy7H7KUF+hPFVKyl1PkjNnT1RNPjWtGgsITETtGv+NUgSuJvMRnf/n4bxIgFhgRtQ9S60LsrcRjrIqhhhgPPCkj8APron0HrhG6/1/iMwyJO3spVoYCBgeNeNfIThV2FER5w3SSM/T1EqHpvo5Zd+QFquLJK3u5qmcaa3DvjRftxJgvxy9WLMUQYsn2zEtEzzhMeBiW0gxuiUVjk95095KAqi/LMhLql37NZP1t+/iHFUZQ0nEf3UA5UuvDvv3tYQyB/zvX7idqSEIQeYzBkbRZ0gbtvJtzKWnR8rtJ57RG5LX/fjqyANCu3PhaUGKJQnjeSApnB5nOUmaUy+o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:46:13.1036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e55b538-c46d-424c-c08b-08df076638d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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
Change-Id: I03a726d5368674d06bd40fe7d11effd88c492741
---
v6:
 - Add WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT)) in
   drm_user_fence_set_compare() to warn if called on a 32-bit system.
   Plain WARN_ON_ONCE() is used since drm_user_fence has no
   struct drm_device * reference. (Thomas Hellström review)

 drivers/gpu/drm/drm_user_fence.c | 82 +++++++++++++++++++++++++++++++-
 include/drm/drm_user_fence.h     | 29 +++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_fence.c
index 664178e2d74c..e55d03ebf75f 100644
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
@@ -65,5 +112,38 @@ void drm_user_fence_init(struct drm_user_fence *ufence,
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
+	WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT));
+
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

