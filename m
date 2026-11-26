Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED57606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269E410E9A4;
	Thu, 26 Nov 2026 13:14:54 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408CD10E9A4;
 Thu, 26 Nov 2026 13:14:51 +0000 (UTC)
X-UUID: 58c197b2e99b11f19a56ed5b684f684d-20261126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:9b17007a-f1ff-44cf-a6c3-77c62fad18fa, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:91f54dd06ed4c0aa7bd1334aa0f0726b,
 BulkI
 D:nil,BulkQuantity:0,SF:81|82|102|123|136|850|865|898,TC:nil,Content:0|15|
 50|99,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 58c197b2e99b11f19a56ed5b684f684d-20261126
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1250133750; Thu, 26 Nov 2026 21:14:44 +0800
From: yaolu@kylinos.cn
To: piotr.piorkowski@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, matthew.brost@intel.com,
 michal.wajdeczko@intel.com, rodrigo.vivi@intel.com,
 satyanarayana.k.v.p@intel.com, stuart.summers@intel.com,
 thomas.hellstrom@linux.intel.com, yaolu@kylinos.cn
Subject: [PATCH v2] drm/xe/gt: Log LMTT init failure and block VF operations
Date: Thu, 26 Nov 2026 21:14:41 +0800
Message-Id: <20261126131441.1734445-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119095003.reakox5n3mhp5utx@intel.com>
References: <20261119095003.reakox5n3mhp5utx@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lu Yao <yaolu@kylinos.cn>

If xe_lmtt_init() fails on a PF, the driver currently keeps going
with an unusable LMTT: xe_lmtt_init() clears lmtt->ops and leaves
lmtt->pd NULL, so xe_lmtt_init_hw() returns early and VF local memory
is left without a translation directory.

Log the error in gt_init_lmtt() and keep the PF alive, but refuse to
operate on VFs afterwards from xe_sriov_pf_wait_ready(), which gates
VF enabling as well as the PF-side VF sysfs/debugfs operations.

Fixes: b1d204058218 ("drm/xe/pf: Introduce Local Memory Translation Table")
Suggested-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Suggested-by: Summers Stuart <stuart.summers@intel.com>
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
v1->v2:
 - Do not abort GT init when the LMTT allocation fails; log the error and
   keep the PF usable instead of failing probe.
 - Refuse VF operations in xe_sriov_pf_wait_ready() when the LMTT is not
   ready (new xe_lmtt_is_ready() and pf_check_lmtt()).
Link: https://lore.kernel.org/dri-devel/20261119095003.reakox5n3mhp5utx@intel.com/

---
 drivers/gpu/drm/xe/xe_gt.c       | 24 ++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_lmtt.c     | 16 ++++++++++++++++
 drivers/gpu/drm/xe/xe_lmtt.h     |  1 +
 drivers/gpu/drm/xe/xe_sriov_pf.c | 18 ++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 286aee5775c0..3ec1b1f027d4 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -36,6 +36,7 @@
 #include "xe_gt_mcr.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_sriov_pf.h"
+#include "xe_gt_sriov_printk.h"
 #include "xe_gt_sriov_vf.h"
 #include "xe_gt_stats.h"
 #include "xe_gt_sysfs.h"
@@ -563,6 +564,25 @@ static void dump_pat_on_error(struct xe_gt *gt)
 	xe_pat_dump(gt, &p);
 }
 
+static void gt_init_lmtt(struct xe_gt *gt)
+{
+	struct xe_lmtt *lmtt = &gt_to_tile(gt)->sriov.pf.lmtt;
+	int err;
+
+	if (!IS_SRIOV_PF(gt_to_xe(gt)))
+		return;
+
+	/*
+	 * LMTT is required to enable VFs only, so keep the PF usable even if
+	 * the allocation failed. VF operations are then refused by
+	 * xe_sriov_pf_wait_ready().
+	 */
+	err = xe_lmtt_init(lmtt);
+	if (err)
+		xe_gt_sriov_err(gt, "LMTT init failed (%pe), VFs will be unavailable\n",
+				ERR_PTR(err));
+}
+
 static int gt_init_with_gt_forcewake(struct xe_gt *gt)
 {
 	int err;
@@ -584,8 +604,8 @@ static int gt_init_with_gt_forcewake(struct xe_gt *gt)
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
 		if (err)
 			return err;
-		if (IS_SRIOV_PF(gt_to_xe(gt)))
-			xe_lmtt_init(&gt_to_tile(gt)->sriov.pf.lmtt);
+
+		gt_init_lmtt(gt);
 	}
 
 	/* Enable per hw engine IRQs */
diff --git a/drivers/gpu/drm/xe/xe_lmtt.c b/drivers/gpu/drm/xe/xe_lmtt.c
index 8a5a434931b0..6d46aaadb422 100644
--- a/drivers/gpu/drm/xe/xe_lmtt.c
+++ b/drivers/gpu/drm/xe/xe_lmtt.c
@@ -212,6 +212,22 @@ int xe_lmtt_init(struct xe_lmtt *lmtt)
 	return err;
 }
 
+/**
+ * xe_lmtt_is_ready() - Check if LMTT is ready to be used.
+ * @lmtt: the &xe_lmtt to check
+ *
+ * This function shall be called only by PF.
+ *
+ * Return: true if LMTT is not needed on this device or was successfully
+ * initialized by xe_lmtt_init(), false otherwise.
+ */
+bool xe_lmtt_is_ready(struct xe_lmtt *lmtt)
+{
+	lmtt_assert(lmtt, IS_SRIOV_PF(lmtt_to_xe(lmtt)));
+
+	return !xe_device_has_lmtt(lmtt_to_xe(lmtt)) || lmtt->pd;
+}
+
 static void lmtt_setup_dir_ptr_gt(struct xe_gt *gt, u32 config)
 {
 	struct xe_device *xe = gt_to_xe(gt);
diff --git a/drivers/gpu/drm/xe/xe_lmtt.h b/drivers/gpu/drm/xe/xe_lmtt.h
index 5ef065dd573c..980b3126b952 100644
--- a/drivers/gpu/drm/xe/xe_lmtt.h
+++ b/drivers/gpu/drm/xe/xe_lmtt.h
@@ -15,6 +15,7 @@ struct xe_lmtt_ops;
 
 #ifdef CONFIG_PCI_IOV
 int xe_lmtt_init(struct xe_lmtt *lmtt);
+bool xe_lmtt_is_ready(struct xe_lmtt *lmtt);
 void xe_lmtt_init_hw(struct xe_gt *gt);
 void xe_lmtt_invalidate_hw(struct xe_lmtt *lmtt);
 int xe_lmtt_prepare_pages(struct xe_lmtt *lmtt, unsigned int vfid, u64 range);
diff --git a/drivers/gpu/drm/xe/xe_sriov_pf.c b/drivers/gpu/drm/xe/xe_sriov_pf.c
index 33bd754d138f..2122964610a0 100644
--- a/drivers/gpu/drm/xe/xe_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
@@ -11,6 +11,7 @@
 #include "xe_configfs.h"
 #include "xe_device.h"
 #include "xe_gt_sriov_pf.h"
+#include "xe_lmtt.h"
 #include "xe_module.h"
 #include "xe_sriov.h"
 #include "xe_sriov_pf.h"
@@ -19,6 +20,7 @@
 #include "xe_sriov_pf_service.h"
 #include "xe_sriov_pf_sysfs.h"
 #include "xe_sriov_printk.h"
+#include "xe_tile.h"
 
 static unsigned int wanted_max_vfs(struct xe_device *xe)
 {
@@ -143,6 +145,18 @@ int xe_sriov_pf_init_late(struct xe_device *xe)
 	return 0;
 }
 
+static int pf_check_lmtt(struct xe_device *xe)
+{
+	struct xe_tile *tile;
+	unsigned int id;
+
+	for_each_tile(tile, xe, id)
+		if (!xe_lmtt_is_ready(&tile->sriov.pf.lmtt))
+			return -ENODEV;
+
+	return 0;
+}
+
 /**
  * xe_sriov_pf_wait_ready() - Wait until PF is ready to operate.
  * @xe: the &xe_device to test
@@ -160,6 +174,10 @@ int xe_sriov_pf_wait_ready(struct xe_device *xe)
 	if (xe_device_wedged(xe))
 		return -ECANCELED;
 
+	err = pf_check_lmtt(xe);
+	if (err)
+		return err;
+
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_sriov_pf_wait_ready(gt);
 		if (err)
-- 
2.25.1

