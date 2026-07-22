Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF2CC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667A010EFBA;
	Thu, 23 Jul 2026 07:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C5J81UdS";
	dkim-atps=neutral
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A7E10E3D4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:47:29 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-9771d9759d4so565465241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784681249; x=1785286049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AbhgRjlSJFWIxahaAPZPrTvVPU5EKkznrtXdho1/r/o=;
 b=C5J81UdSwHhZj3fZbnCC19A9DjBa9CfFSLLtXlDb4KrmuDlvSpAkU4DkFJY6Y7gTaU
 ZR3F3E8MmhqcrfU9rTcoJOCa+7SBHQF9p8Nwibb5+MD4e9mfsSnYlO7L2I2rPMfj8r7L
 9raM7nmmbMSdVe/RbVDXgqzmMOmAuOgJmSGB9fg2uHGRVClsN/CnYrmE66QH5t1Jwnlc
 2qaBtL7f4/ANvKB7KKACXA9R5xmqouF2V2cjGUyAoFjtZJ/Z6Zs0SQ8sr858mxoBgBwz
 NtfY2qk2i23Pdk2lOux8Iv5eFxX0VrMGwGIbZiCW6fZdIT9yRbSr9IqiT2BhpYQLNwom
 IOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784681249; x=1785286049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AbhgRjlSJFWIxahaAPZPrTvVPU5EKkznrtXdho1/r/o=;
 b=jqZvUmFke0ys6bMBSQGpBnaP+yxiotULOimdY9VzSqh5Bz9k6Xfo5Kt6nf6d4Gsghw
 aIVApeeFgAjVYOuJEH9swIO5YnKTGOT8lepyRJsm9NycE1YcIwRe+qb6+cY00aqCghN9
 MZq7b/GcXJlI5umq57jY3yGmruVADTODwrzU5gKd1l1z0UWa+FrfHy9HbvGp7YY+iQKw
 QzCk6NESzXYKmcFdOL6O2Sq6ftSqdYejf7Qroa85jjM96zcjZULmPjwrNyp/HtXb3Zw3
 xHSZbFjNWoIe7YoS8fIjIlnyTm1IrwMerc0w9tl2rXcjn4MsM7bM4B/NAgDcWAzObBmw
 u46Q==
X-Gm-Message-State: AOJu0YxEtlbHM56ED/W7FwhzEHQGqVrInIw3XoyCa5HcSQw8JQIVyHcq
 t+9YOTbZoYYBpaHah9GmXkc4MSwkuyhNNxVPC6XwfWZvc061cV5exxXb
X-Gm-Gg: AR+sD12NqMetCmwehW57gXjSPcpV/vKA6gzIY/tD31TQdRcONswEguXbXNMu7LH6nbO
 9BtnATP0uXOvdylUTNAYIPfugZj7sPQYT7BvFZl6ik2bQV/RIfoeiFkbmjRtiZkI2pCNthJLEUc
 I2E8NAySx2gXD1JYkG5jydsKr0enMOoacYsXUGetugmMmRaasFgxReoqJxs7xdoPPK22wCQqq2V
 LvltTghOJokkkt2YyEQ25j1h7SUK+LUbKmsYpIgaT5bN5IPc/YEiOtUEBfkuZbmgAdD10kLjUUk
 fFnpxqronGRxpMwNpVuP6OElU8S3yrf1UZOp97z4D7CuLZB6zTMAlA/NIJI5A+BG/NDC1NHzG65
 U92qCKlluaj9u/tD5x1jjKsH8GclYXQbTvt9WSCk+LyBzGKKZC8wpfyiumTWm/0CtEik0qlO09E
 XlhtMSlwKxnYpkbs5p6ZSHsJ3WwxWwM8b6S1jYzE50iSunzU1O7sS9xC0RswzTUrBUucX1DA==
X-Received: by 2002:a05:6102:1608:b0:740:22ba:8a4e with SMTP id
 ada2fe7eead31-7475346781fmr6512332137.6.1784681248772; 
 Tue, 21 Jul 2026 17:47:28 -0700 (PDT)
Received: from lord.bigscale.net ([170.246.211.222])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-74ad31c215bsm1346505137.2.2026.07.21.17.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 17:47:27 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v1 1/4] drm/xe/mcr: Keep GT forcewake during MCR steering
Date: Tue, 21 Jul 2026 21:46:51 -0300
Message-ID: <20260722004654.744249-2-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722004654.744249-1-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

On MTL and newer platforms xe uses STEER_SEMAPHORE to synchronize MCR
steering with external agents such as firmware. The current code waits
only 10us for the semaphore, while already holding the software MCR
spinlock, and fires drm_WARN_ON_ONCE() with a full stack trace when the
wait times out. On an Arrow Lake-P system this triggers during resume
while firmware still owns the semaphore:

  drm_WARN_ON_ONCE(ret == -110)
  WARNING: drivers/gpu/drm/xe/xe_gt_mcr.c:697 mcr_lock

Port the i915 MCR locking model (intel_gt_mcr_lock/unlock) to xe:

- Wait for the hardware semaphore before taking the software spinlock,
  so the wait may sleep instead of spinning inside the critical
  section.
- Allow up to 100ms for firmware to release the semaphore, matching
  i915.
- Demote the WARN stack to a rate-limited GT error, using the same
  message as i915 for easier cross-driver triage.
- Grab GT forcewake before touching the semaphore and hold it over the
  entire lock/steer/unlock cycle (Wa_22018931422). The steering
  registers are in an "always on" domain with respect to RC6, but are
  sensitive while higher-level platform sleep states are
  entering/exiting.

The GT resume/reset paths already hold XE_FORCEWAKE_ALL around their
MCR accesses, so the forcewake reference taken here is usually just a
refcount increment; it closes the Wa_22018931422 window for the
remaining callers (debugfs, OA, EU stall, etc.).

mcr_lock() may now sleep; add might_sleep() to document and enforce
that contract. All current callers are in process context.

Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
---
 drivers/gpu/drm/xe/xe_gt_mcr.c | 70 +++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index a97b236dab7..e1e3c0688dc 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -10,6 +10,8 @@
 
 #include "regs/xe_gt_regs.h"
 #include "xe_assert.h"
+#include "xe_device.h"
+#include "xe_force_wake.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_topology.h"
 #include "xe_gt_types.h"
@@ -58,6 +60,8 @@ enum {
 	MCR_OP_WRITE
 };
 
+#define MCR_STEER_SEMAPHORE_TIMEOUT_US	100000
+
 static const struct xe_mmio_range xelp_l3bank_steering_table[] = {
 	{ 0x00B100, 0x00B3FF },
 	{},
@@ -692,33 +696,58 @@ bool xe_gt_mcr_get_nonterminated_steering(struct xe_gt *gt,
  * to synchronize with external clients (e.g., firmware), so a semaphore
  * register will also need to be taken.
  */
-static void mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
+static unsigned int mcr_lock(struct xe_gt *gt) __acquires(&gt->mcr_lock)
 {
 	struct xe_device *xe = gt_to_xe(gt);
+	unsigned int fw_ref = 0;
 	int ret = 0;
 
-	spin_lock(&gt->mcr_lock);
+	might_sleep();
 
 	/*
 	 * Starting with MTL we also need to grab a semaphore register
 	 * to synchronize with external agents (e.g., firmware) that now
 	 * shares the same steering control register. The semaphore is obtained
 	 * when a read to the relevant register returns 1.
+	 *
+	 * The steering control and semaphore registers are inside an
+	 * "always on" power domain with respect to RC6.  However there
+	 * are some issues if higher-level platform sleep states are
+	 * entering/exiting at the same time these registers are accessed.
+	 * Grabbing GT forcewake and holding it over the entire
+	 * lock/steer/unlock cycle ensures that those sleep states have
+	 * fully exited before we access these registers, matching what
+	 * i915 does in intel_gt_mcr_lock().
+	 *
+	 * Wa_22018931422
 	 */
-	if (GRAPHICS_VERx100(xe) >= 1270)
-		ret = xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0x1, 10, NULL,
-				     true);
+	if (GRAPHICS_VERx100(xe) >= 1270) {
+		fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+		if (!xe_force_wake_ref_has_domain(fw_ref, XE_FW_GT))
+			xe_gt_err_ratelimited(gt, "failed to get MCR forcewake\n");
+
+		ret = xe_mmio_wait32(&gt->mmio, STEER_SEMAPHORE, 0x1, 0x1,
+				     MCR_STEER_SEMAPHORE_TIMEOUT_US, NULL,
+				     false);
+	}
+
+	spin_lock(&gt->mcr_lock);
+
+	if (ret == -ETIMEDOUT)
+		xe_gt_err_ratelimited(gt, "hardware MCR steering semaphore timed out\n");
 
-	xe_gt_WARN_ON_ONCE(gt, ret == -ETIMEDOUT);
+	return fw_ref;
 }
 
-static void mcr_unlock(struct xe_gt *gt) __releases(&gt->mcr_lock)
+static void mcr_unlock(struct xe_gt *gt, unsigned int fw_ref) __releases(&gt->mcr_lock)
 {
+	spin_unlock(&gt->mcr_lock);
+
 	/* Release hardware semaphore - this is done by writing 1 to the register */
-	if (GRAPHICS_VERx100(gt_to_xe(gt)) >= 1270)
+	if (GRAPHICS_VERx100(gt_to_xe(gt)) >= 1270) {
 		xe_mmio_write32(&gt->mmio, STEER_SEMAPHORE, 0x1);
-
-	spin_unlock(&gt->mcr_lock);
+		xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	}
 }
 
 /*
@@ -807,10 +836,11 @@ u32 xe_gt_mcr_unicast_read_any(struct xe_gt *gt, struct xe_reg_mcr reg_mcr)
 						     &group, &instance);
 
 	if (steer) {
-		mcr_lock(gt);
+		unsigned int fw_ref = mcr_lock(gt);
+
 		val = rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ,
 					   group, instance, 0);
-		mcr_unlock(gt);
+		mcr_unlock(gt, fw_ref);
 	} else {
 		val = xe_mmio_read32(&gt->mmio, reg);
 	}
@@ -832,13 +862,14 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
 			   struct xe_reg_mcr reg_mcr,
 			   int group, int instance)
 {
+	unsigned int fw_ref;
 	u32 val;
 
 	xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
 
-	mcr_lock(gt);
+	fw_ref = mcr_lock(gt);
 	val = rw_with_mcr_steering(gt, reg_mcr, MCR_OP_READ, group, instance, 0);
-	mcr_unlock(gt);
+	mcr_unlock(gt, fw_ref);
 
 	return val;
 }
@@ -857,11 +888,13 @@ u32 xe_gt_mcr_unicast_read(struct xe_gt *gt,
 void xe_gt_mcr_unicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr,
 			     u32 value, int group, int instance)
 {
+	unsigned int fw_ref;
+
 	xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
 
-	mcr_lock(gt);
+	fw_ref = mcr_lock(gt);
 	rw_with_mcr_steering(gt, reg_mcr, MCR_OP_WRITE, group, instance, value);
-	mcr_unlock(gt);
+	mcr_unlock(gt, fw_ref);
 }
 
 /**
@@ -876,6 +909,7 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr,
 			       u32 value)
 {
 	struct xe_reg reg = to_xe_reg(reg_mcr);
+	unsigned int fw_ref;
 
 	xe_gt_assert(gt, !IS_SRIOV_VF(gt_to_xe(gt)));
 
@@ -884,9 +918,9 @@ void xe_gt_mcr_multicast_write(struct xe_gt *gt, struct xe_reg_mcr reg_mcr,
 	 * access, the MULTICAST bit should already be set, so there's no need
 	 * to touch the steering register.
 	 */
-	mcr_lock(gt);
+	fw_ref = mcr_lock(gt);
 	xe_mmio_write32(&gt->mmio, reg, value);
-	mcr_unlock(gt);
+	mcr_unlock(gt, fw_ref);
 }
 
 void xe_gt_mcr_steering_dump(struct xe_gt *gt, struct drm_printer *p)
-- 
2.55.0

