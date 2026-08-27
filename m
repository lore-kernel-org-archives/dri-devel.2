Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F9EC61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6113610F050;
	Thu, 27 Aug 2026 13:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zr71fCh9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7688310F034;
 Thu, 27 Aug 2026 13:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXN0vVUx/OuyuZM7sKL80BLpyxY/y83mZpzl51fCCZ3r/+FlSIUeR1q+ecccqEytYSwFLoKEXTBD96yHNOv0cMIqPr9hLRkqsPBkuFRwkMwmB5bzRFwMyxLknwuUNtB1QTtij492gIFIDE+xm+YJk5eABVVhi3CzJOuwZmTiZN36DxHFA63l8wfpMdGoyOstAQuXfPsqGil5RZKG6GFHTc0EjMp9ZoAZNHixPIU9q5Vqsrhx87k221eWKzP/Nvv3UHSB08T+vVA36IoID286ueCx2BSpLyhcKOvQkQtYDw4B8RSfSYlBDyeFdPS0lJtymToHDhXAFyiJmdmMBVJOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbLr7oJlpBkWZQPrWpFexsORj59xTv8BK+LST4NN228=;
 b=j+cCefVGFSr3pa2u4iHl9FpQZJ6WwADnMCPvM7lErFOLecEyaDWXXwhBgOYn4ncblK9B9Kde+DUBY/mjzJotlByFOPvoCou2oK8LUVbNXPFvecAJQQA+abFmOIDQvrn4v6Bki15qASoUy6gCsV3RWKXcZ0WWtrg00h9cbus5i2CLOrlvip9bPAdlsn1tgrxquwMs9CiDxDuHkRMa51x11KtxneAtRg/ozNKqllLrQH+HHLPT6ErNlNcrkgD7qKfSnBJxE/7f1LPanDuOFksCyU0zbbocllZEWJywxLARtg3rpj3wgR4PP9UCE094pAyJAko9zLTlgqRJ/dAeCljcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbLr7oJlpBkWZQPrWpFexsORj59xTv8BK+LST4NN228=;
 b=Zr71fCh9aP6LNXWd1WTwKiRBhEfWotjdL+h9VCdRrkazTemw4potOR4YZFrcZrZvGw/iIvnqcCgbOxVoW3m6OA2HvvZIkX4c8A0ukw4PSFVNNLqt9Xf/l/GcvCMZLmHvOogkD9RKbyuD2acjO4rZqTKrlU6VTpUPLpA7SO2hLmc=
Received: from PH7P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::9)
 by SAWPR12MB999292.namprd12.prod.outlook.com (2603:10b6:806:55c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 13:33:01 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::9b) by PH7P223CA0012.outlook.office365.com
 (2603:10b6:510:338::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 13:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 13:33:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 08:32:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] drm/xe: Convert xe_user_fence to drm_user_fence
Date: Thu, 27 Aug 2026 19:02:26 +0530
Message-ID: <20260827133226.4076593-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SAWPR12MB999292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddf7e00-2434-4092-0de1-08df043fb732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|56012099006|10067099003|18002099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: OBdBlgJG7fyAdqhGOt8/1dmWt+4WTNp3ldwlSTnLi8oHFAgCS6qt4ghTWziMWcBHk2IQRGCU0JDVIFpxtOl2EFNjuqWtuKOfokgFzY3DRlvCp02egEWha1KfYQAxDcOnO39eoS8dWRKG+rmCTu4Cn2rK0TiCHiPgQibZzdyteSBWFYnvpsEzNifbOQVY2Qev/BuELmniMs5JmpLqCRSNrfuwj5AxdAxuvzuhIlidsqLCEUXCuhBIl3Pj8tUzgLMJFErHD/Y76vqaD6xcJWDFkriEY3UPJBUOi/Rwjybnk/elPykosnKL7HSW3f0YIJK0CPjM1y5grw5yWvDQ1MlfMTY8Id6v/hEb8FZUpmVHi2sMaWkXlg9cvbmYCB0r0onEKTxlvEtA/YjNCwscaEwatmOFZKBvKzp0ZJ4qmTLY1ZEIlhT+96apOkLK71uRfdmoNGWZROncEB1cQ0NzE7H3Bfcx6fqy4PEKH1th/qoC6w/aNt4xnxH5BAch2+jE/VlhSnfuvAOiSs9Lo9PBqERjLjj8zSwSoAwWZh3IY1RHpUqmvNbqqmajnNekvUhkvM6BQ3ANwphfoIdCM7jRHEkaOl8ECgQTJF+06Ya4vH1W28xO08mABEp0ySMznlbFSLOzlBHbz3bYGgw7KZ9x+MalCE3BedaH/hKYSR8wT9s13XcgpoI2ISR+f9f908Lvwn1I0fmX3F8PG2zxrF8mjbX7Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pl56KfsAjLBiYBq/e4EnZmCjmE4e+uUGBT8yt3NRSFLTrgAXjGIEuQe/pPtIWVbFeCbbi7DsywAu/LvXv5+mnAKVb6SrwrzacKrVa678MZHrVtxL9CqRxTKJWIEgUm6ujKpiAHkQMiWpCYWWf8fx4ocSFqkWc1j0d3b1z2sRxs4F+/AA6j8w9OM+Y+Io/SCWredFCvfq+ROGkXsUE4XJQUPRe3GKe+Lw80TKUb3QkMWj2XGoZ0cm3Sks+1erfm1yYFply3u/lSXRgxZE+DjxoaEWB+Mp9aOss5whTcTacQGWYsRpF5K3CbF79YrR3Vcny1mWZPA/R2a9Rhx1q25mtxID11f0vXy3r4ffRq09DRlaos7NzYDnc1vjB9Q87uE3rH7PK2wtodkiobp23ALaB1pseEfKnonrIu04s8xq4/TD1wEl5+a8pgNJ9Yil3Fpb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:33:01.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddf7e00-2434-4092-0de1-08df043fb732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999292
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
v2:
 - Remove unconditional dma_fence_put(fence) after
   drm_user_fence_add_callback() in xe_sync_entry_signal(). The fence
   reference is now consumed by drm_user_fence_add_callback() in all
   paths — transferred to the callback on success, released internally
   on the already-signaled and error paths. (Sashiko review)

 drivers/gpu/drm/xe/xe_sync.c       | 112 ++++++++++++-----------------
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 2 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
index 37866768d64c..7549123f8486 100644
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
@@ -19,36 +18,51 @@
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
+	if (mm_ok) {
+		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
+			XE_WARN_ON("Copy to user failed");
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
@@ -63,51 +77,22 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
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
@@ -282,24 +267,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *sync, struct dma_fence *fence)
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

