Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD9FC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01CD10EEB8;
	Wed,  9 Sep 2026 04:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kt6OWuDX";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD17D10EEC3;
 Wed,  9 Sep 2026 04:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF+hAFdA94DIqDmv+5ypzrwV+NZqVvagcjWo9/UQlN1kw6X6H+A1O8CkCS+3UZpGbtcv/1vLXb/fst4+c28Wsn95RlVN1TkA8iX51yP7f+nuv85yijes0j+7+JJX8J52wecQCGy6DGghjifRIkZVPa9igJZiDajfi7BwmXxt2UUqVLnUJb/j9gouyV9V8KRay1yaixS81S8pJY9wQO9+s7mzmdLqbHpvxeNG3vfQr2oQT1aUO2dETAP7x4StEUKENvmuWBzk0G6i4hZZyP2wLnilWXZ2X7SnrpHXuNfB6WlrnGp1m9hFrpV0PUYQGIEMBLBAekFBIghwGEuZqTYAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1CqnWE8T442XpLGqZmXyJdceGm4lyGW+9jw9y3MJp8=;
 b=AXZ2d4BjOIuFzSCHkVs/tQlf+PYHnGm9zZmA93t5MvgE3InWcL37rSYDil+psMW9xbiNkR2+uG9aFPJ6GryklVeRSnzVD1SJk1MkC4ww//4ZhuO+kESDEPe2pP7hhIt6Gnm8HEMmwbzOm3nEqhkTxA9iN3DYdp0fGaB/YUCl6NguEBsDkeD7lCSAu/fuezXBwtnySdebRFtRxpm4e8EQaaiVoqpF1EhZB7Ly56WKXSkaA0uTliwNOaGv4g0gfoho3gIZwEVyl21LfjurHOkV/by81CeWVrtJWEd4olwVpoVBoPpD/VjNuKykgn+nAqRS8w79KZe+WRBrWE21xbOR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1CqnWE8T442XpLGqZmXyJdceGm4lyGW+9jw9y3MJp8=;
 b=Kt6OWuDXTa1a8eHORzZd2YF1e41p8g/tnyl+qjRFOL1tadqtGeSQ3M78jrnXpCL27bXwB+tSnb9CNggrfC2yKd7dLeL+Sf38ACPM9KPDXu94OIMLDahY0h0SKCVo68odXxHr5uPSI/QA3bJuKToOrxb/vVTEl5o0mzy9hoHdlno=
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:45:20 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::38) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 04:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 04:45:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 23:45:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, =?UTF-8?q?Thomas=20Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v9 3/3] drm/xe: Convert xe_user_fence to drm_user_fence
Date: Wed, 9 Sep 2026 10:14:54 +0530
Message-ID: <20260909044454.399340-4-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c58e9d-315a-40b2-b9ad-08df0e2d26f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O197dirzhGT6xvffQhjK6u6UZJgQIGBqI238ZLsGykd6ssoUfiHVvI7wDnc8vi3rTMcst6iEOowemPWje1Gjs9+8CWlSiqS6fQbesXvtgQPGRiyZztAbBPWbpNM/1xCiJ2W9QyRpVW0mjMbPX0MLzkV/bYvCc7qkxiXwXEkifnZl74yyxvPcsaovYkf81FvLQOFVmZkfI49F+281UdiIn0MPNQHAtP7+CWbQUUHeQY87ZRz3xUfvu2uiboZcvVtb795TYAFZ4/qRQSCAdOsD969dT4yot2otQFACeaaEB3cIoHoAcgyOFNjAkX7RVba0N7OB2zM43HF1wsOaweEYGdtGovZLLB8P6pbFHLOJhMbPswQq4GifFCKaVMFXoDR93TY5ZQs6CRZUG5ZCdWsOPl17mja64MoBr7Jyf6rofRmiGmb9kBS3u8X1Kmqqr7NhcvXvhvaG2VbpKCBD2ByjfGc9CiYx3m328EEl3R4CuXE0LDAbWQfUX9pmPcSR0DFcETLBCv7N9GVVHi2/AuJVKzyORSbYFejBTDf7RrdPIgMPkf/v+2Tx14A7HkbfuXsPMh6Kmlxz6F7gE/6XWF8sMOt2f7ITIuYzCdN2yFxk2jrAPjGdxQm8v+LI5jtVvSou14K0K8hN1v5OlrCV0uZnSJDf3Hc8MIYTTDGUqjquYdwjx+QzFRJM295o5fWQBL7mFjlAOG/zanqtbHUk7L64uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dsUyMcssXMGP++/1wDXvf20iJI2gtaSNJHHdbJLSx8V+0ZSLCQDk1pM1FSUsGvee+ZBIDIpipiSIa2F6n5mnweoQECT6VE6faqKEdug0uZ6J1bQvGV9wjJb6k5rH1illDcCNa1uFuhUYbA6xOt66LNMKoLYlWSEnfnQFHhhyD1HCYCx++5AVKFCm7S9i0KQ8eMypTeNE5SHqxJ2X2Fbv/BOqqym0xUZA2tWEXRWg2qs5BghFS8CFLd+YJsbHIvaQHz6XUz6P4ksCOJp/BMO3DroIRtckqtWR1b9EcLyAkqD0eAq5X1BAT2j0Wpwm4XIwz8GNVL0O7ypkjozAbyMhwV1+SGkz3Xa42aw/FOCxFBAyPuMg8MjuPu1DCps6OYqAQSagQ2PmFAaZdCNMmg18HlmIlKhtuR9Sp0RgHuIerdJJDIfb40AdqfWlEElTlEHS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:45:19.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c58e9d-315a-40b2-b9ad-08df0e2d26f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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
functions are removed. Their logic moves to xe_ufence_ops.writeback and
xe_ufence_ops.destroy, which are called by the drm_user_fence helper.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v9:
- Remove xe_sync_ufence_cancel_sync — no caller in this patch (Matt)
- Remove xe_sync_ufence_cancel from xe_vma_destroy_late — unnecessary
  behaviour change; xe_ufence_worker only accesses device-level
  resources, safe to run after VMA teardown (Matt)

v8:
- Fix xe_ufence_worker ordering: WRITE_ONCE(signalled, 1) before
  copy_to_user(), add smp_wmb() before wake_up_all() (Matt,
  mirrors upstream fix 8ae04fe9ffc93)
- Rename .worker → .writeback in xe_ufence_ops (Matt)

 drivers/gpu/drm/xe/xe_sync.c       | 141 +++++++++++++++--------------
 drivers/gpu/drm/xe/xe_sync.h       |   1 +
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 3 files changed, 74 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 37866768d64c..a335dd5f4478 100644
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
@@ -19,36 +18,65 @@
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
+	 * Mark signalled before the userspace write so that if userspace
+	 * observes the written value and immediately issues a VM unmap,
+	 * check_ufence() will see signalled=1 and not return -EBUSY.
+	 *
+	 * NOTE: copy_to_user() may block if userspace backs the address with
+	 * userfaultfd or FUSE. Drivers requiring non-blocking semantics should
+	 * use a dedicated workqueue instead of xe->ordered_wq.
+	 */
+	WRITE_ONCE(ufence->signalled, 1);
 
-static void user_fence_get(struct xe_user_fence *ufence)
-{
-	kref_get(&ufence->refcount);
+	if (mm_ok) {
+		if (copy_to_user(ufence->addr, &ufence->value,
+				 sizeof(ufence->value)))
+			drm_dbg(&ufence->xe->drm,
+				"copy_to_user failed, user fence wasn't signaled\n");
+	} else {
+		drm_dbg(&ufence->xe->drm,
+			"mmget_not_zero() failed, ufence wasn't signaled\n");
+	}
+
+	/*
+	 * Ensure both signalled=1 and the fence value written by copy_to_user()
+	 * are visible to all CPUs before wake_up_all() wakes waiters. Without
+	 * this barrier, weakly ordered architectures (e.g. ARM64) may allow
+	 * waiters to observe the wakeup before seeing the updated values.
+	 */
+	smp_wmb();
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
+	.writeback = xe_ufence_worker,
+	.destroy   = xe_ufence_destroy,
+};
+
 static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
 					       u64 value)
 {
@@ -63,51 +91,22 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
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
@@ -282,24 +281,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *sync, struct dma_fence *fence)
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
 
@@ -434,6 +424,21 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
 	user_fence_put(ufence);
 }
 
+/**
+ * xe_sync_ufence_cancel() - Non-blocking cancel of user fence callback
+ * @ufence: user fence reference
+ *
+ * Attempts to cancel the pending callback without waiting for the worker.
+ * Safe to call while holding dma_resv_lock or vm->lock. If the callback
+ * has already fired, the worker runs independently — xe_ufence_worker
+ * only accesses device-level and userspace resources, both safe after
+ * VMA teardown.
+ */
+void xe_sync_ufence_cancel(struct xe_user_fence *ufence)
+{
+	drm_user_fence_cancel(&ufence->base);
+}
+
 /**
  * xe_sync_ufence_get_status() - Get user fence status
  * @ufence: user fence
diff --git a/drivers/gpu/drm/xe/xe_sync.h b/drivers/gpu/drm/xe/xe_sync.h
index 6b949194acff..a21f0e0501c6 100644
--- a/drivers/gpu/drm/xe/xe_sync.h
+++ b/drivers/gpu/drm/xe/xe_sync.h
@@ -44,6 +44,7 @@ static inline bool xe_sync_is_ufence(struct xe_sync_entry *sync)
 struct xe_user_fence *__xe_sync_ufence_get(struct xe_user_fence *ufence);
 struct xe_user_fence *xe_sync_ufence_get(struct xe_sync_entry *sync);
 void xe_sync_ufence_put(struct xe_user_fence *ufence);
+void xe_sync_ufence_cancel(struct xe_user_fence *ufence);
 int xe_sync_ufence_get_status(struct xe_user_fence *ufence);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_sync_types.h
index b88f1833e28c..67048199b070 100644
--- a/drivers/gpu/drm/xe/xe_sync_types.h
+++ b/drivers/gpu/drm/xe/xe_sync_types.h
@@ -12,7 +12,6 @@ struct drm_syncobj;
 struct dma_fence;
 struct dma_fence_chain;
 struct drm_xe_sync;
-struct user_fence;
 
 struct xe_sync_entry {
 	struct drm_syncobj *syncobj;
-- 
2.34.1

