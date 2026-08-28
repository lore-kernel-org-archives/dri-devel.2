Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B216EC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A661110F266;
	Fri, 28 Aug 2026 06:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdKXoi1e";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3506210F269;
 Fri, 28 Aug 2026 06:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrpPavSGDpm4lhCsjOR719z59ZfedS/KpoiauiZbHi6Hi5HCwZ3fqL1qhWhAWCI3QP5A6wIcz/85HI8r3A8sonPO+lKwTMuiy9HwHgMBvE8aEAcIZyP83sEVj3Fie6N9TXKeQw4Y+AkA0b1pupoymxFn0Oke8XqBgbZ7CPcfVv9yoNtWPpoCr+wB1O89Z75GXCbrxTdNR97GdxaTU0iSK5akNW/nNip+ovLk3kuY9k2cATMhbEvJ1at3qr8734QqMGVYXvHMDHTV+6hI7whTQktqt7dT81wLS326/CLgha5juZ+W4VAjvL5q+oO7n5OWNLKBoQA475DGLr/Wuo+Ltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPzQo6M5qqvxBMs49Y52eh0Lqs/jjdKQpCL7m6dvqzk=;
 b=mTLDcODK7YpRp7Dw0T7zWX2I+Ab7uSqNT4EhysWcmI7Jf4OrdCJYYCgJ/EvSvaFxxt+0NsH0Gv1VWQl7en+mFMwTqUBMTd8BX2YJft7cdKlj/QYpPYTmFC/XreQgsG2dpajkmc5SERSHqaRVYwAZ3IyGaPSrc3cn9iMBpiAqKQK2JD4cCxkGx6BOGZLGaiCggqba8Fki+2PwCE0mBm7oa+Kh6vvsJNDpsjNISvo5h5HkMFsqVXgTiz7yitTjlXyqzQlDJ3Iwzh8SlqOj+0smwtMA2VwKI/teDdt8eQ31V9gFnDrlCUdMYkmVY5qn7JQfcY63bJ/DEgMarhtJrxpWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPzQo6M5qqvxBMs49Y52eh0Lqs/jjdKQpCL7m6dvqzk=;
 b=pdKXoi1etuU5s9fJRHElhvTUWndl234r6Vn/eFsCR2Pl0OxYkUHcAX+zQYHPzwG8bZLTugzXMw6cV3tehh6alVBYCJ6JBstbM0amlH/xbjyDVdEWynAn2n/ZykMjY87wS2XfJ+y/THKRJhhif4WntJON2LTN1l+K2+K9+03u96A=
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:32:07 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::e) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 06:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 06:32:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 28 Aug 2026 01:32:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] drm/xe: Convert xe_user_fence to drm_user_fence
Date: Fri, 28 Aug 2026 12:01:03 +0530
Message-ID: <20260828063103.4106629-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4106b2ce-b4e0-425a-0000-08df04ce153b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|7416014|36860700016|376014|1800799024|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A/zftTAFK7zjZgHVFYhePWoKVwtkMwnf7hNpXmZvSa0g/S0ujKMEvct+vPZ0+yeveBmvOb7UKFAprLYJ0nWjtCTkoD4LtAYtrkf/JaqoVFFaXQBUXGwd6PFM49CgJclkLW90fMSBRXBhoEEgXRggnDJ5tXYb4EffkccRQD3wcxwR2fSFldyWYrJQwKV5E6kkJzJeg5LY3UZbjjD5IXG2VOhMRJF/gdaRs+hW7OB2mrNNZCvsE/7rHfkMF7gYSJA5ty/iK+edgEEyxW5ydbr5dC/SMArZ4TF11WPURWX/IWFV+4+yC2nwY2RkCF0y3GSG6YOwgHHLy15FGFPiCJi5cLBXUcoCTiq1cQ3qi3z9PB7PPtLdAXe/JbEy17K4j5w3/jzSVIBy/3MER2ja9Owr/CYukqd6AtzytrQR9umZLLfeV9U6m71MpmY0a04hqG2ySdDrfHn8qctBcH7eq+6Z76SgxVQDcfewzyzz5MSzW/w3e5WOPCg7XqS9QuBzh0qr9N29xIciwbTnNlLpd10TebUvd2Z1Py7nTItI+wGaiWaAlbbubbwgkv909PkKxzEHSZPsglxb2dNrg8eEiqkhOe3Z1uOgfSPIzRf+f5B3xBcKXIV0dxUVAw8/owJx/aSzoz2sudesqykDrd25D+tD9QPV6zc++ir8KnR+0Fj6++bUmXcUEHGQbGwh+dXSOV3LZ0ce2NAcy42u58nBHsMWrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(7416014)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FxP6pMfaKrrA2OQ5IrvkGc0y2S8RUNUdScbcAy3hSU4gD1K+D4kzFvCpL1yxeW4h7EO1ZuPstSrDwE6PCTKulK3jf1iv50NZe3wtyWzwfDOKyGK/cwg6FGZK8KaU82aO7ItTYSbf9JA3zzwYNjIxyOh1irFCzlRLKrp8U0Plr0wpmZOLH53YE235NTtrvEC5WMUmOMoJGhc/YIG1s3hySiZ+GRjC7W5gmtbSyWuEY/hzDANGFipjq3IJcUMzVWHal5LLjovTTtI0nNe6PbSAwd0KeO91DNDLfis7m3LIakVfA2dhlAspIgxixa9BczdLQ1ZZCwORwEgwluMeYvCXnYwFr6lo4BpEMDy6McR2WAKp/Q54+axNhUT5t0F5z/6kG63z/GGMMpwSkonXFNWZ1z+4TSpe61V5rNkvAUJWG614dROys9Ft3TknU60efyMa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:32:07.4844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4106b2ce-b4e0-425a-0000-08df04ce153b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

Replace the open-coded user fence implementation in xe_sync.c with the
new common drm_user_fence helper.

struct xe_user_fence now embeds struct drm_user_fence as its base.
XE-specific fields (xe_device pointer for the ufence_wq wake-up,
userspace VA, expected value, signalled flag) remain in the wrapper.

The local user_fence_destroy/get/put/worker/kick_ufence/user_fence_cb
functions are removed. Their logic moves to xe_ufence_ops.worker and
xe_ufence_ops.destroy, which are called by drm_user_fence_work().

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v4:
 - Remove drm_user_fence_cancel_sync() from xe_sync_entry_cleanup().
   Cancelling the callback there breaks VM_BIND user fences by
   disarming the completion signal before the GPU finishes.
   (Sashiko review)

 drivers/gpu/drm/xe/xe_sync.c       | 136 ++++++++++++++---------------
 drivers/gpu/drm/xe/xe_sync.h       |   1 +
 drivers/gpu/drm/xe/xe_sync_types.h |   3 +-
 drivers/gpu/drm/xe/xe_vm.c         |   1 +
 4 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 37866768d64c..56f8e290424e 100644
--- a/drivers/gpu/drm/xe/xe_sync.c
+++ b/drivers/gpu/drm/xe/xe_sync.c
@@ -6,12 +6,11 @@
 #include "xe_sync.h"
 
 #include <linux/dma-fence-array.h>
-#include <linux/kthread.h>
-#include <linux/sched/mm.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
+#include <drm/drm_user_fence.h>
 #include <uapi/drm/xe_drm.h>
 
 #include "xe_device.h"
@@ -19,36 +18,60 @@
 #include "xe_macros.h"
 #include "xe_sched_job_types.h"
 
+/*
+ * xe_user_fence wraps drm_user_fence with XE-specific fields.
+ * The drm_user_fence base handles MM borrowing and work-item lifetime.
+ */
 struct xe_user_fence {
-	struct xe_device *xe;
-	struct kref refcount;
-	struct dma_fence_cb cb;
-	struct work_struct worker;
-	struct mm_struct *mm;
-	u64 __user *addr;
-	u64 value;
-	int signalled;
+	struct drm_user_fence base;
+	struct xe_device     *xe;
+	u64 __user           *addr;
+	u64                   value;
+	int                   signalled;
 };
 
-static void user_fence_destroy(struct kref *kref)
+static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
 {
-	struct xe_user_fence *ufence = container_of(kref, struct xe_user_fence,
-						 refcount);
+	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
 
-	mmdrop(ufence->mm);
-	kfree(ufence);
-}
+	/*
+	 * Mark signalled before waking waiters so UMD can safely reuse
+	 * the same ufence without hitting -EBUSY.
+	 */
+	WRITE_ONCE(ufence->signalled, 1);
 
-static void user_fence_get(struct xe_user_fence *ufence)
-{
-	kref_get(&ufence->refcount);
+	/*
+	 * Ensure the signalled store is visible before the user memory write
+	 * on weakly ordered architectures (e.g. ARM64). Without this barrier
+	 * the CPU may reorder stores, causing userspace to observe the user
+	 * memory update before signalled == 1.
+	 */
+	smp_wmb();
+
+	if (mm_ok) {
+		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
+			drm_dbg(&ufence->xe->drm,
+				"copy_to_user failed, user fence wasn't signaled\n");
+	} else {
+		drm_dbg(&ufence->xe->drm,
+			"mmget_not_zero() failed, ufence wasn't signaled\n");
+	}
+
+	wake_up_all(&ufence->xe->ufence_wq);
 }
 
-static void user_fence_put(struct xe_user_fence *ufence)
+static void xe_ufence_destroy(struct drm_user_fence *base)
 {
-	kref_put(&ufence->refcount, user_fence_destroy);
+	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
+
+	kfree(ufence);
 }
 
+static const struct drm_user_fence_ops xe_ufence_ops = {
+	.worker  = xe_ufence_worker,
+	.destroy = xe_ufence_destroy,
+};
+
 static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
 					       u64 value)
 {
@@ -63,51 +86,22 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
 	if (!ufence)
 		return ERR_PTR(-ENOMEM);
 
-	ufence->xe = xe;
-	kref_init(&ufence->refcount);
-	ufence->addr = ptr;
+	ufence->xe    = xe;
+	ufence->addr  = ptr;
 	ufence->value = value;
-	ufence->mm = current->mm;
-	mmgrab(ufence->mm);
+	drm_user_fence_init(&ufence->base, xe->ordered_wq, &xe_ufence_ops);
 
 	return ufence;
 }
 
-static void user_fence_worker(struct work_struct *w)
-{
-	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
-
-	WRITE_ONCE(ufence->signalled, 1);
-	if (mmget_not_zero(ufence->mm)) {
-		kthread_use_mm(ufence->mm);
-		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
-			XE_WARN_ON("Copy to user failed");
-		kthread_unuse_mm(ufence->mm);
-		mmput(ufence->mm);
-	} else {
-		drm_dbg(&ufence->xe->drm, "mmget_not_zero() failed, ufence wasn't signaled\n");
-	}
-
-	/*
-	 * Wake up waiters only after updating the ufence state, allowing the UMD
-	 * to safely reuse the same ufence without encountering -EBUSY errors.
-	 */
-	wake_up_all(&ufence->xe->ufence_wq);
-	user_fence_put(ufence);
-}
-
-static void kick_ufence(struct xe_user_fence *ufence, struct dma_fence *fence)
+static void user_fence_get(struct xe_user_fence *ufence)
 {
-	INIT_WORK(&ufence->worker, user_fence_worker);
-	queue_work(ufence->xe->ordered_wq, &ufence->worker);
-	dma_fence_put(fence);
+	drm_user_fence_get(&ufence->base);
 }
 
-static void user_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
+static void user_fence_put(struct xe_user_fence *ufence)
 {
-	struct xe_user_fence *ufence = container_of(cb, struct xe_user_fence, cb);
-
-	kick_ufence(ufence, fence);
+	drm_user_fence_put(&ufence->base);
 }
 
 int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
@@ -282,24 +276,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *sync, struct dma_fence *fence)
 	} else if (sync->syncobj) {
 		drm_syncobj_replace_fence(sync->syncobj, fence);
 	} else if (sync->ufence) {
-		int err;
-
 		drm_syncobj_add_point(sync->ufence_syncobj,
 				      sync->ufence_chain_fence,
 				      fence, sync->ufence_timeline_value);
 		sync->ufence_chain_fence = NULL;
 
 		fence = drm_syncobj_fence_get(sync->ufence_syncobj);
-		user_fence_get(sync->ufence);
-		err = dma_fence_add_callback(fence, &sync->ufence->cb,
-					     user_fence_cb);
-		if (err == -ENOENT) {
-			kick_ufence(sync->ufence, fence);
-		} else if (err) {
+		if (drm_user_fence_add_callback(&sync->ufence->base, fence))
 			XE_WARN_ON("failed to add user fence");
-			user_fence_put(sync->ufence);
-			dma_fence_put(fence);
-		}
+		/* fence ref consumed by drm_user_fence_add_callback */
 	}
 }
 
@@ -434,6 +419,19 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
 	user_fence_put(ufence);
 }
 
+/**
+ * xe_sync_ufence_cancel_sync() - Cancel user fence callback and wait for worker
+ * @ufence: user fence reference
+ *
+ * Cancels any pending dma-fence callback and waits for the worker to fully
+ * complete before returning. Must be called during teardown before freeing
+ * any resources accessed by the worker.
+ */
+void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence)
+{
+	drm_user_fence_cancel_sync(&ufence->base);
+}
+
 /**
  * xe_sync_ufence_get_status() - Get user fence status
  * @ufence: user fence
@@ -443,4 +441,3 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
 int xe_sync_ufence_get_status(struct xe_user_fence *ufence)
 {
 	return READ_ONCE(ufence->signalled);
-}
+}
diff --git a/drivers/gpu/drm/xe/xe_sync.h b/drivers/gpu/drm/xe/xe_sync.h
index 6b949194acff..ff47882b3f6f 100644
--- a/drivers/gpu/drm/xe/xe_sync.h
+++ b/drivers/gpu/drm/xe/xe_sync.h
@@ -44,6 +44,7 @@ static inline bool xe_sync_is_ufence(struct xe_sync_entry *sync)
 struct xe_user_fence *__xe_sync_ufence_get(struct xe_user_fence *ufence);
 struct xe_user_fence *xe_sync_ufence_get(struct xe_sync_entry *sync);
 void xe_sync_ufence_put(struct xe_user_fence *ufence);
+void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence);
 int xe_sync_ufence_get_status(struct xe_user_fence *ufence);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_sync_types.h
index b88f1833e28c..49df2bfa817c 100644
--- a/drivers/gpu/drm/xe/xe_sync_types.h
+++ b/drivers/gpu/drm/xe/xe_sync_types.h
@@ -12,7 +12,6 @@ struct drm_syncobj;
 struct dma_fence;
 struct dma_fence_chain;
 struct drm_xe_sync;
-struct user_fence;
 
 struct xe_sync_entry {
 	struct drm_syncobj *syncobj;
@@ -28,4 +27,3 @@ struct xe_sync_entry {
 	u32 flags;
 };
 
-#endif
+#endif
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index b01f31ed4417..0a1f7615aed9 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1181,6 +1181,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
 	struct xe_bo *bo = xe_vma_bo(vma);
 
 	if (vma->ufence) {
+		xe_sync_ufence_cancel_sync(vma->ufence);
 		xe_sync_ufence_put(vma->ufence);
 		vma->ufence = NULL;
 	}
-- 
2.34.1

