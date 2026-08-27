Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E351C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FB610EF91;
	Thu, 27 Aug 2026 10:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Irs4rUGo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AB710EFA5;
 Thu, 27 Aug 2026 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825926; x=1819361926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=waTq+7PvsYOAOqUo2gYmMjh4ebFD60goZ2y5gdnL5G4=;
 b=Irs4rUGoGwQ/HFd3uwg+XyGiA/V+qd9h2lfD62JFJHEqU4Pa3JleZWOY
 i9wLr6sdH86+tVgvPPypWs8mvWDMYjZw4tMhELTXWeIknqYZh01XJnQmw
 kjWWNjP9gd+jqtv+qHZVr3N3Nk/N3SroDyP+w0vcj6EKetWVdKZ/6sQcl
 IiPAeBBICEwvUckUaK26itPfiI6kv5Vgmrgm07ngN0nAiouPWxFhm9OSg
 o5VfC91lHNbWDuyMZl9Yu3MaOfYu2oVeHWAUphcnTOg7w3G1RKP3l+r4G
 vVFcoUsf7xYxKpoUBfAyvcaXtjsmIjI27jICVj4e9VjfXlaqOjhVFjzwt A==;
X-CSE-ConnectionGUID: X+85ZwYNTZGOtjvP3GIYpQ==
X-CSE-MsgGUID: veLPI6g6RCqy83rRA8ZJ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445872"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445872"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:45 -0700
X-CSE-ConnectionGUID: S32WU25JR8Ktbu1I96dIlA==
X-CSE-MsgGUID: dRGOnEbNTi6zphgDLvVmNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057640"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:44 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 08/13] drm/xe/irq: Serialize IRQ suspend and resume
Date: Thu, 27 Aug 2026 15:47:56 +0530
Message-ID: <20260827101801.1247654-9-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Wedge isolation suspends interrupts from a worker. This can race with
PM resume and allow resume to enable interrupts after isolation has
disabled them.

Add a managed mutex around IRQ suspend and resume. Check the wedged state
while holding the mutex so either ordering leaves interrupts disabled.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_irq.c          | 26 +++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 43a86564adf0..dda4d9919ca6 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/srcu.h>
 
@@ -266,6 +267,9 @@ struct xe_device {
 		/** @irq.lock: lock for processing irq's on this device */
 		spinlock_t lock;
 
+		/** @irq.pm_lock: Serializes IRQ suspend and resume */
+		struct mutex pm_lock;
+
 		/** @irq.enabled: interrupts enabled on this device */
 		atomic_t enabled;
 
diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index d314993b14a1..9cdcb16f3ca8 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -797,8 +797,14 @@ static void irq_uninstall(void *arg)
 
 int xe_irq_init(struct xe_device *xe)
 {
+	int err;
+
 	spin_lock_init(&xe->irq.lock);
 
+	err = drmm_mutex_init(&xe->drm, &xe->irq.pm_lock);
+	if (err)
+		return err;
+
 	return xe_irq_msix_init(xe);
 }
 
@@ -843,6 +849,8 @@ static void xe_irq_msi_synchronize_irq(struct xe_device *xe)
 
 void xe_irq_suspend(struct xe_device *xe)
 {
+	mutex_lock(&xe->irq.pm_lock);
+
 	atomic_set(&xe->irq.enabled, 0); /* no new irqs */
 
 	/* flush irqs */
@@ -851,6 +859,8 @@ void xe_irq_suspend(struct xe_device *xe)
 	else
 		xe_irq_msi_synchronize_irq(xe);
 	xe_irq_reset(xe); /* turn irqs off */
+
+	mutex_unlock(&xe->irq.pm_lock);
 }
 
 void xe_irq_resume(struct xe_device *xe)
@@ -858,10 +868,17 @@ void xe_irq_resume(struct xe_device *xe)
 	struct xe_gt *gt;
 	int id;
 
+	mutex_lock(&xe->irq.pm_lock);
+
+	if (xe_device_wedged(xe))
+		goto out_unlock;
+
 	/*
-	 * lock not needed:
-	 * 1. no irq will arrive before the postinstall
-	 * 2. display is not yet resumed
+	 * pm_lock serializes resume against wedge isolation.
+	 *
+	 * irq.lock is not needed because:
+	 * 1. no IRQ arrives before postinstall;
+	 * 2. display has not been resumed yet.
 	 */
 	atomic_set(&xe->irq.enabled, 1);
 	xe_irq_reset(xe);
@@ -869,6 +886,9 @@ void xe_irq_resume(struct xe_device *xe)
 
 	for_each_gt(gt, xe, id)
 		xe_irq_enable_hwe(gt);
+
+out_unlock:
+	mutex_unlock(&xe->irq.pm_lock);
 }
 
 /* MSI-X related definitions and functions below. */
-- 
2.43.0

