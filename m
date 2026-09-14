Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3548C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2E210F289;
	Mon, 14 Sep 2026 21:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NPO4Z3U9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B680810F1D1;
 Mon, 14 Sep 2026 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789423067; x=1820959067;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7WF1mmwkDYw6RmGlZkKVrS9t0kfA3ReBIr4uquttnRs=;
 b=NPO4Z3U9pvjb/Wsj3UKUZdMcJRuGY4BApndTpxdg2y4HNuHuQxccXp3r
 8UBLTlRE4yA8PeIqyoCfJXB5GK5GSBYS69a/HIbtXAL8GcMAEqVD18f1C
 IAbs4/kbSbOYNsYQ3T3MpwhcP83i+mSHwsgM4qwHbtRbgvi+dqIa/6RWk
 fIZ04R5JHYcj4VfQzI09kRsWkiACV9uddzLO3pBuOrrL+QNaO9W4p2jHm
 CYVUXRN8a+IIrqpOVu6YT4KEoQdyhktrs0zSzHJHZq+Xa+js8+rk6+ELM
 g91AEFxG22NNb0qf2gXtlpLVC0hHlOS3UjwxhnTVkM299MTMyOuk4UrK5 A==;
X-CSE-ConnectionGUID: zmDjycblQ9KNHBIkSG5MmQ==
X-CSE-MsgGUID: KNEtJm0SSO6HoRkha15ArQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="290867"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="290867"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 14:57:47 -0700
X-CSE-ConnectionGUID: vgIpJ0JjQDGD66S0NlBNRg==
X-CSE-MsgGUID: plTKHrmXQc+2vDawVAoa9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="974875"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa012.fm.intel.com with ESMTP; 14 Sep 2026 14:57:47 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Mon, 14 Sep 2026 14:57:45 -0700
Message-ID: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
and pick the correct helper according to the wait time and atomic.
Implement a similar helper to replace DIV_ROUND_UP for 32-bit CPUs.
Avoid growing delays becoming intollerably large by capping the
in-loop wait time.

v4: - Simplify using poll_timeout_us and poll_timeout_us_atopmic and
      update all callstack to never use a param for atomic (Jani)
v3: - Use div64_s64 kernel API for 32-bit vs 64-bit division.
v2: - Fixed checkpatch failure.
    - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
      review). Fixed bug max range in usleep_range(Shasiko review)

Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Assisted-by: Github-Copilot:Claude-Sonnet-5-0
---
 drivers/gpu/drm/xe/xe_device.c          |  10 +-
 drivers/gpu/drm/xe/xe_eu_stall.c        |   4 +-
 drivers/gpu/drm/xe/xe_force_wake.c      |   7 +-
 drivers/gpu/drm/xe/xe_gsc.c             |   2 +-
 drivers/gpu/drm/xe/xe_gsc_proxy.c       |   2 +-
 drivers/gpu/drm/xe/xe_gt.c              |   2 +-
 drivers/gpu/drm/xe/xe_gt_mcr.c          |   4 +-
 drivers/gpu/drm/xe/xe_guc.c             |  10 +-
 drivers/gpu/drm/xe/xe_huc.c             |   2 +-
 drivers/gpu/drm/xe/xe_mmio.c            | 118 ++++++++++--------------
 drivers/gpu/drm/xe/xe_mmio.h            |   8 +-
 drivers/gpu/drm/xe/xe_oa.c              |   4 +-
 drivers/gpu/drm/xe/xe_pcode.c           |   8 +-
 drivers/gpu/drm/xe/xe_pxp.c             |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c |   4 +-
 drivers/gpu/drm/xe/xe_uc_fw.c           |   3 +-
 16 files changed, 90 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 205cb4e7f9e8..8fb044331e62 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -573,7 +573,7 @@ static void __xe_driver_flr(struct xe_device *xe)
 	 * is still pending (unless the HW is totally dead), but better to be
 	 * safe in case something unexpected happens
 	 */
-	ret = xe_mmio_wait32(mmio, GU_CNTL, DRIVERFLR, 0, flr_timeout, NULL, false);
+	ret = xe_mmio_wait32(mmio, GU_CNTL, DRIVERFLR, 0, flr_timeout, NULL);
 	if (ret) {
 		drm_err(&xe->drm, "Driver-FLR-prepare wait for ready failed! %d\n", ret);
 		return;
@@ -584,7 +584,7 @@ static void __xe_driver_flr(struct xe_device *xe)
 	xe_mmio_rmw32(mmio, GU_CNTL, 0, DRIVERFLR);
 
 	/* Wait for hardware teardown to complete */
-	ret = xe_mmio_wait32(mmio, GU_CNTL, DRIVERFLR, 0, flr_timeout, NULL, false);
+	ret = xe_mmio_wait32(mmio, GU_CNTL, DRIVERFLR, 0, flr_timeout, NULL);
 	if (ret) {
 		drm_err(&xe->drm, "Driver-FLR-teardown wait completion failed! %d\n", ret);
 		return;
@@ -592,7 +592,7 @@ static void __xe_driver_flr(struct xe_device *xe)
 
 	/* Wait for hardware/firmware re-init to complete */
 	ret = xe_mmio_wait32(mmio, GU_DEBUG, DRIVERFLR_STATUS, DRIVERFLR_STATUS,
-			     flr_timeout, NULL, false);
+			     flr_timeout, NULL);
 	if (ret) {
 		drm_err(&xe->drm, "Driver-FLR-reinit wait completion failed! %d\n", ret);
 		return;
@@ -1168,7 +1168,7 @@ static void tdf_request_sync(struct xe_device *xe)
 		 * transient and need to be flushed..
 		 */
 		if (xe_mmio_wait32(&gt->mmio, XE2_TDF_CTRL, TRANSIENT_FLUSH_REQUEST, 0,
-				   300, NULL, false))
+					    300, NULL))
 			xe_gt_err_once(gt, "TD flush timeout\n");
 	}
 }
@@ -1214,7 +1214,7 @@ void xe_device_l2_flush(struct xe_device *xe, bool force)
 	spin_lock(&gt->global_invl_lock);
 
 	xe_mmio_write32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1);
-	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 1000, NULL, true))
+	if (xe_mmio_wait32_atomic(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 1000, NULL))
 		xe_gt_err_once(gt, "Global invalidation timeout\n");
 
 	spin_unlock(&gt->global_invl_lock);
diff --git a/drivers/gpu/drm/xe/xe_eu_stall.c b/drivers/gpu/drm/xe/xe_eu_stall.c
index 8a7c1b5d5ab9..865e08b75c29 100644
--- a/drivers/gpu/drm/xe/xe_eu_stall.c
+++ b/drivers/gpu/drm/xe/xe_eu_stall.c
@@ -707,7 +707,7 @@ static int xe_eu_stall_stream_enable(struct xe_eu_stall_data_stream *stream)
 		/* Request the firmware to apply the workaround and wait for an ACK */
 		xe_mmio_write32(&gt->mmio, SWF_SCRATCHPAD(0), REQ_EUSTALL_ENABLE);
 		ret = xe_mmio_wait32(&gt->mmio, SWF_SCRATCHPAD(0), SWF_EUSTALL_MASK,
-				     ACK_EUSTALL_ENABLE, FW_WA_WAIT_TIMEOUT_US, NULL, false);
+					     ACK_EUSTALL_ENABLE, FW_WA_WAIT_TIMEOUT_US, NULL);
 		if (ret) {
 			xe_gt_err(gt, "Timeout polling for EU stall enable ACK from firmware\n");
 			xe_force_wake_put(gt_to_fw(gt), stream->fw_ref);
@@ -880,7 +880,7 @@ static int xe_eu_stall_disable_locked(struct xe_eu_stall_data_stream *stream)
 		/* Request the firmware to revert the workaround and wait for an ACK */
 		xe_mmio_write32(&gt->mmio, SWF_SCRATCHPAD(0), REQ_EUSTALL_DISABLE);
 		ret = xe_mmio_wait32(&gt->mmio, SWF_SCRATCHPAD(0), SWF_EUSTALL_MASK,
-				     ACK_EUSTALL_DISABLE, FW_WA_WAIT_TIMEOUT_US, NULL, false);
+					     ACK_EUSTALL_DISABLE, FW_WA_WAIT_TIMEOUT_US, NULL);
 		if (ret)
 			xe_gt_err(gt, "Timeout polling for EU stall disable ACK from firmware\n");
 	}
diff --git a/drivers/gpu/drm/xe/xe_force_wake.c b/drivers/gpu/drm/xe/xe_force_wake.c
index 197e2197bd0a..12ab0304509c 100644
--- a/drivers/gpu/drm/xe/xe_force_wake.c
+++ b/drivers/gpu/drm/xe/xe_force_wake.c
@@ -109,9 +109,10 @@ static int __domain_wait(struct xe_gt *gt, struct xe_force_wake_domain *domain,
 	if (IS_SRIOV_VF(gt_to_xe(gt)))
 		return 0;
 
-	ret = xe_mmio_wait32(&gt->mmio, domain->reg_ack, domain->val, wake ? domain->val : 0,
-			     XE_FORCE_WAKE_ACK_TIMEOUT_MS * USEC_PER_MSEC,
-			     &value, true);
+	ret = xe_mmio_wait32_atomic(&gt->mmio, domain->reg_ack, domain->val,
+				    wake ? domain->val : 0,
+				    XE_FORCE_WAKE_ACK_TIMEOUT_MS * USEC_PER_MSEC,
+				    &value);
 	if (ret)
 		xe_gt_err(gt, "Force wake domain %d failed to ack %s (%pe) reg[%#x] = %#x\n",
 			  domain->id, str_wake_sleep(wake), ERR_PTR(ret),
diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 524ac56bdcc7..a43d3739d213 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -196,7 +196,7 @@ static int gsc_fw_wait(struct xe_gt *gt)
 	return xe_mmio_wait32(&gt->mmio, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
 			      HECI1_FWSTS1_INIT_COMPLETE,
 			      HECI1_FWSTS1_INIT_COMPLETE,
-			      500 * USEC_PER_MSEC, NULL, false);
+			   500 * USEC_PER_MSEC, NULL);
 }
 
 static int gsc_upload(struct xe_gsc *gsc)
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.c b/drivers/gpu/drm/xe/xe_gsc_proxy.c
index 707db650a2ae..63f72ca28ed4 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.c
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.c
@@ -80,7 +80,7 @@ int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc)
 	return xe_mmio_wait32(&gt->mmio, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
 			      HECI1_FWSTS1_CURRENT_STATE,
 			      HECI1_FWSTS1_PROXY_STATE_NORMAL,
-			      USEC_PER_SEC, NULL, false);
+			   USEC_PER_SEC, NULL);
 }
 
 static void __gsc_proxy_irq_rmw(struct xe_gsc *gsc, u32 clr, u32 set)
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 775c826b68b4..9edcc54ad4bf 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -832,7 +832,7 @@ static int do_gt_reset(struct xe_gt *gt)
 	xe_mmio_write32(&gt->mmio, GDRST, GRDOM_FULL);
 	err = xe_mmio_wait32(&gt->mmio, GDRST, GRDOM_FULL, 0,
 			     GRDOM_RESET_TIMEOUT_MS * USEC_PER_MSEC,
-			     NULL, false);
+			   NULL);
 	if (err)
 		xe_log_err(gt, GT, err,
 			   "full graphics reset not completed in %u ms\n",
diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index 1949bf7d370a..a08585f082d3 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -711,8 +711,8 @@ static void mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
 	 * when a read to the relevant register returns 1.
 	 */
 	if (GRAPHICS_VERx100(xe) >= 1270)
-		ret = xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0x1, 10, NULL,
-				     true);
+		ret = xe_mmio_wait32_atomic(&gt->mmio, STEER_SEMAPHORE, 0x1, 0x1, 10,
+					    NULL);
 
 	xe_gt_WARN_ON_ONCE(gt, ret == -ETIMEDOUT);
 }
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index c7f8bbd4cb92..670140e1aa36 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -967,13 +967,13 @@ static void guc_prevent_fw_dma_failure_on_reset(struct xe_guc *guc)
 
 	ret = xe_mmio_wait32(&gt->mmio, GUC_STATUS, GS_UKERNEL_MASK,
 			     FIELD_PREP(GS_UKERNEL_MASK, XE_GUC_LOAD_STATUS_READY),
-			     100000, &guc_status, false);
+				      100000, &guc_status);
 	if (ret)
 		xe_gt_warn(gt, "GuC not ready after disabling idle flow (GUC_STATUS: 0x%x)\n",
 			   guc_status);
 
 	ret = xe_mmio_wait32(&gt->mmio, GUC_SRAM_STATUS, GUC_SRAM_HANDLING_MASK,
-			     0, 5000, &sram_status, false);
+				      0, 5000, &sram_status);
 	if (ret)
 		xe_gt_warn(gt, "SRAM handling not complete (GUC_SRAM_STATUS: 0x%x)\n",
 			   sram_status);
@@ -996,7 +996,7 @@ int xe_guc_reset(struct xe_guc *guc)
 
 	xe_mmio_write32(mmio, GDRST, GRDOM_GUC);
 
-	ret = xe_mmio_wait32(mmio, GDRST, GRDOM_GUC, 0, 5000, &gdrst, false);
+	ret = xe_mmio_wait32(mmio, GDRST, GRDOM_GUC, 0, 5000, &gdrst);
 	if (ret) {
 		xe_gt_err(gt, "GuC reset timed out, GDRST=%#x\n", gdrst);
 		goto err_out;
@@ -1538,7 +1538,7 @@ int xe_guc_mmio_send_recv(struct xe_guc *guc, const u32 *request,
 
 	ret = xe_mmio_wait32(mmio, reply_reg, GUC_HXG_MSG_0_ORIGIN,
 			     FIELD_PREP(GUC_HXG_MSG_0_ORIGIN, GUC_HXG_ORIGIN_GUC),
-			     50000, &header, false);
+				     50000, &header);
 	if (ret) {
 		/* scratch registers might be cleared during FLR, try once more */
 		if (!header) {
@@ -1574,7 +1574,7 @@ int xe_guc_mmio_send_recv(struct xe_guc *guc, const u32 *request,
 		BUILD_BUG_ON((GUC_HXG_TYPE_RESPONSE_SUCCESS ^ GUC_HXG_TYPE_RESPONSE_FAILURE) != 1);
 
 		ret = xe_mmio_wait32(mmio, reply_reg, resp_mask, resp_mask,
-				     2000000, &header, false);
+					     2000000, &header);
 
 		if (unlikely(FIELD_GET(GUC_HXG_MSG_0_ORIGIN, header) !=
 			     GUC_HXG_ORIGIN_GUC))
diff --git a/drivers/gpu/drm/xe/xe_huc.c b/drivers/gpu/drm/xe/xe_huc.c
index 57afe21444b1..3517bba09399 100644
--- a/drivers/gpu/drm/xe/xe_huc.c
+++ b/drivers/gpu/drm/xe/xe_huc.c
@@ -272,7 +272,7 @@ int xe_huc_auth(struct xe_huc *huc, enum xe_huc_auth_types type)
 	}
 
 	ret = xe_mmio_wait32(&gt->mmio, huc_auth_modes[type].reg, huc_auth_modes[type].val,
-			     huc_auth_modes[type].val, 100000, NULL, false);
+			     huc_auth_modes[type].val, 100000, NULL);
 	if (ret) {
 		xe_gt_err(gt, "HuC: firmware not verified: %pe\n", ERR_PTR(ret));
 		goto fail;
diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 7fa18dfcb5a2..fc0509aa384b 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -5,8 +5,8 @@
 
 #include "xe_mmio.h"
 
-#include <linux/delay.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/minmax.h>
 #include <linux/pci.h>
 
@@ -320,82 +320,44 @@ u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg)
 	return (u64)udw << 32 | ldw;
 }
 
-static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
-			    u32 timeout_us, u32 *out_val, bool atomic, bool expect_match)
-{
-	ktime_t cur = ktime_get_raw();
-	const ktime_t end = ktime_add_us(cur, timeout_us);
-	int ret = -ETIMEDOUT;
-	s64 wait = 10;
-	u32 read;
-	bool check;
-
-	for (;;) {
-		read = xe_mmio_read32(mmio, reg);
-
-		check = (read & mask) == val;
-		if (!expect_match)
-			check = !check;
-
-		if (check) {
-			ret = 0;
-			break;
-		}
-
-		cur = ktime_get_raw();
-		if (!ktime_before(cur, end))
-			break;
-
-		if (ktime_after(ktime_add_us(cur, wait), end))
-			wait = ktime_us_delta(end, cur);
-
-		if (atomic)
-			udelay(wait);
-		else
-			usleep_range(wait, wait << 1);
-		wait <<= 1;
-	}
-
-	if (ret != 0) {
-		read = xe_mmio_read32(mmio, reg);
-
-		check = (read & mask) == val;
-		if (!expect_match)
-			check = !check;
-
-		if (check)
-			ret = 0;
-	}
-
-	if (out_val)
-		*out_val = read;
-
-	return ret;
-}
-
 /**
  * xe_mmio_wait32() - Wait for a register to match the desired masked value
  * @mmio: MMIO target
  * @reg: register to read value from
  * @mask: mask to be applied to the value read from the register
  * @val: desired value after applying the mask
- * @timeout_us: time out after this period of time. Wait logic tries to be
- * smart, applying an exponential backoff until @timeout_us is reached.
+ * @timeout_us: time out after this period of time
  * @out_val: if not NULL, points where to store the last unmasked value
- * @atomic: needs to be true if calling from an atomic context
  *
  * This function polls for the desired masked value and returns zero on success
  * or -ETIMEDOUT if timed out.
- *
- * Note that @timeout_us represents the minimum amount of time to wait before
- * giving up. The actual time taken by this function can be a little more than
- * @timeout_us for different reasons, specially in non-atomic contexts. Thus,
- * it is possible that this function succeeds even after @timeout_us has passed.
  */
 int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val, u32 timeout_us,
-		   u32 *out_val, bool atomic)
+		   u32 *out_val)
 {
-	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atomic, true);
+	u32 read;
+	int ret;
+
+	ret = poll_timeout_us(read = xe_mmio_read32(mmio, reg), (read & mask) == val,
+			      10, timeout_us, false);
+	if (out_val)
+		*out_val = read;
+
+	return ret;
+}
+
+int xe_mmio_wait32_atomic(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
+			  u32 timeout_us, u32 *out_val)
+{
+	u32 read;
+	int ret;
+
+	ret = poll_timeout_us_atomic(read = xe_mmio_read32(mmio, reg), (read & mask) == val,
+				     10, timeout_us, false);
+	if (out_val)
+		*out_val = read;
+
+	return ret;
 }
 
 /**
@@ -406,15 +368,35 @@ int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val, u
  * @val: value not to be matched after applying the mask
  * @timeout_us: time out after this period of time
  * @out_val: if not NULL, points where to store the last unmasked value
- * @atomic: needs to be true if calling from an atomic context
- *
  * This function works exactly like xe_mmio_wait32() with the exception that
  * @val is expected not to be matched.
  */
 int xe_mmio_wait32_not(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val, u32 timeout_us,
-		       u32 *out_val, bool atomic)
+		       u32 *out_val)
 {
-	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atomic, false);
+	u32 read;
+	int ret;
+
+	ret = poll_timeout_us(read = xe_mmio_read32(mmio, reg), (read & mask) != val,
+			      10, timeout_us, false);
+	if (out_val)
+		*out_val = read;
+
+	return ret;
+}
+
+int xe_mmio_wait32_not_atomic(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
+			      u32 timeout_us, u32 *out_val)
+{
+	u32 read;
+	int ret;
+
+	ret = poll_timeout_us_atomic(read = xe_mmio_read32(mmio, reg), (read & mask) != val,
+				     10, timeout_us, false);
+	if (out_val)
+		*out_val = read;
+
+	return ret;
 }
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/gpu/drm/xe/xe_mmio.h b/drivers/gpu/drm/xe/xe_mmio.h
index befe021f2215..6391f0fd6507 100644
--- a/drivers/gpu/drm/xe/xe_mmio.h
+++ b/drivers/gpu/drm/xe/xe_mmio.h
@@ -27,9 +27,13 @@ bool xe_mmio_in_range(const struct xe_mmio *mmio, const struct xe_mmio_range *ra
 
 u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg);
 int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
-		   u32 timeout_us, u32 *out_val, bool atomic);
+		   u32 timeout_us, u32 *out_val);
+int xe_mmio_wait32_atomic(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
+			  u32 timeout_us, u32 *out_val);
 int xe_mmio_wait32_not(struct xe_mmio *mmio, struct xe_reg reg, u32 mask,
-		       u32 val, u32 timeout_us, u32 *out_val, bool atomic);
+		       u32 val, u32 timeout_us, u32 *out_val);
+int xe_mmio_wait32_not_atomic(struct xe_mmio *mmio, struct xe_reg reg, u32 mask,
+			      u32 val, u32 timeout_us, u32 *out_val);
 
 static inline u32 xe_mmio_adjusted_addr(const struct xe_mmio *mmio, u32 addr)
 {
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index a3484e943c55..98a6f57701e4 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -513,14 +513,14 @@ static void xe_oa_disable(struct xe_oa_stream *stream)
 
 	xe_mmio_rmw32(mmio, __oa_regs(stream)->oa_ctrl, __oactrl_used_bits(stream), 0);
 	if (xe_mmio_wait32(mmio, __oa_regs(stream)->oa_ctrl,
-			   OAG_OACONTROL_OA_COUNTER_ENABLE, 0, 50000, NULL, false))
+			   OAG_OACONTROL_OA_COUNTER_ENABLE, 0, 50000, NULL))
 		drm_err(&stream->oa->xe->drm,
 			"wait for OA to be disabled timed out\n");
 
 	if (GRAPHICS_VERx100(stream->oa->xe) <= 1270 && GRAPHICS_VERx100(stream->oa->xe) != 1260) {
 		/* <= XE_METEORLAKE except XE_PVC */
 		xe_mmio_write32(mmio, OA_TLB_INV_CR, 1);
-		if (xe_mmio_wait32(mmio, OA_TLB_INV_CR, 1, 0, 50000, NULL, false))
+		if (xe_mmio_wait32(mmio, OA_TLB_INV_CR, 1, 0, 50000, NULL))
 			drm_err(&stream->oa->xe->drm,
 				"wait for OA tlb invalidate timed out\n");
 	}
diff --git a/drivers/gpu/drm/xe/xe_pcode.c b/drivers/gpu/drm/xe/xe_pcode.c
index 266deecbb100..9b3487c8b07a 100644
--- a/drivers/gpu/drm/xe/xe_pcode.c
+++ b/drivers/gpu/drm/xe/xe_pcode.c
@@ -87,8 +87,12 @@ static int __pcode_mailbox_rw(struct xe_tile *tile, u32 mbox, u32 *data0, u32 *d
 	xe_mmio_write32(mmio, PCODE_DATA1, data1 ? *data1 : 0);
 	xe_mmio_write32(mmio, PCODE_MAILBOX, PCODE_READY | mbox);
 
-	err = xe_mmio_wait32(mmio, PCODE_MAILBOX, PCODE_READY, 0,
-			     timeout_ms * USEC_PER_MSEC, NULL, atomic);
+	if (atomic)
+		err = xe_mmio_wait32_atomic(mmio, PCODE_MAILBOX, PCODE_READY, 0,
+					    timeout_ms * USEC_PER_MSEC, NULL);
+	else
+		err = xe_mmio_wait32(mmio, PCODE_MAILBOX, PCODE_READY, 0,
+				     timeout_ms * USEC_PER_MSEC, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/gpu/drm/xe/xe_pxp.c b/drivers/gpu/drm/xe/xe_pxp.c
index 2fef274a585e..d6b820c47c09 100644
--- a/drivers/gpu/drm/xe/xe_pxp.c
+++ b/drivers/gpu/drm/xe/xe_pxp.c
@@ -136,7 +136,7 @@ static int pxp_wait_for_session_state(struct xe_pxp *pxp, u32 id, bool in_play)
 	u32 mask = BIT(id);
 
 	return xe_mmio_wait32(&gt->mmio, KCR_SIP, mask, in_play ? mask : 0,
-			      250, NULL, false);
+			   250, NULL);
 }
 
 static void pxp_invalidate_queues(struct xe_pxp *pxp);
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
index 72baf1aa4b3a..269ec70aa22a 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
@@ -40,7 +40,7 @@ static bool sysctrl_wait_bit_clear(struct xe_sysctrl *sc, u32 bit_mask,
 	int ret;
 
 	ret = xe_mmio_wait32_not(sc->mmio, SYSCTRL_MB_CTRL, bit_mask, bit_mask,
-				 timeout_ms * 1000, NULL, false);
+				   timeout_ms * 1000, NULL);
 
 	return ret == 0;
 }
@@ -51,7 +51,7 @@ static bool sysctrl_wait_bit_set(struct xe_sysctrl *sc, u32 bit_mask,
 	int ret;
 
 	ret = xe_mmio_wait32(sc->mmio, SYSCTRL_MB_CTRL, bit_mask, bit_mask,
-			     timeout_ms * 1000, NULL, false);
+			     timeout_ms * 1000, NULL);
 
 	return ret == 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_uc_fw.c b/drivers/gpu/drm/xe/xe_uc_fw.c
index e29878b255ba..8fa8a02f73bc 100644
--- a/drivers/gpu/drm/xe/xe_uc_fw.c
+++ b/drivers/gpu/drm/xe/xe_uc_fw.c
@@ -899,8 +899,7 @@ static int uc_fw_xfer(struct xe_uc_fw *uc_fw, u32 offset, u32 dma_flags)
 			REG_MASKED_FIELD_ENABLE(dma_flags | START_DMA));
 
 	/* Wait for DMA to finish */
-	ret = xe_mmio_wait32(mmio, DMA_CTRL, START_DMA, 0, 100000, &dma_ctrl,
-			     false);
+	ret = xe_mmio_wait32(mmio, DMA_CTRL, START_DMA, 0, 100000, &dma_ctrl);
 	if (ret)
 		drm_err(&xe->drm, "DMA for %s fw failed, DMA_CTRL=%u\n",
 			xe_uc_fw_type_repr(uc_fw->type), dma_ctrl);
-- 
2.43.0

