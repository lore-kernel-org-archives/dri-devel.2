Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65D2C98309
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62FA10EC47;
	Tue, 22 Sep 2026 10:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KkTj0Krj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AA110E6BE;
 Tue, 22 Sep 2026 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072277; x=1821608277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lZhZny7rdxbZ0GGPcq3bSzykZU2dcwmwDaB6gOsav4A=;
 b=KkTj0KrjFpQdomrPpywNM8r8ZwFFbT1fiSV6BrMJ1ZtXo8cKMfPHpD5Q
 2E3bH/NEf0QJF0rEVWtuuLgG2h9rlpRe51Xp8hFdUPrgLaCEBMEC6F7kO
 LjoFTx8waxL5ZF8KlvDKsv+6ZDI19uFw3Tr4MDF/7whidJ92wkUE4tqNP
 S+YzgaguYQnQ5zPzNXoT2lkIj5JiJXrr99ZqFiyv1f3oiqMASvpRjdg2F
 L++MaDK1W2Iq3qxQ2kE+F3SrHKi5KhNMRqDtAVX5RaBhS70bPwKuATJ5e
 mcUGu0iqI8gVZJ1r5SoE8uMoPFx1yuMrWWKeYy/umb/1P6oY8jn8ORcRA Q==;
X-CSE-ConnectionGUID: jBsFmx9XTD2rHLD/VETX5g==
X-CSE-MsgGUID: tGFA09btQ7mU1yuYpHV+Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322836"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322836"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:56 -0700
X-CSE-ConnectionGUID: jUI1xrCRSzeh0hEG4Me7mg==
X-CSE-MsgGUID: RwgS2lQzTDGwhITJyrIlEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307900"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:54 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 10/15] drm/xe/irq: Protect IRQ state during wedge isolation
Date: Tue, 22 Sep 2026 15:46:55 +0530
Message-ID: <20260922101721.1583542-11-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
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

Wedge isolation can disable interrupts from a worker while PM resume
enables them. If both state changes overlap, resume can leave interrupts
enabled after the device is wedged.

Add a mutex to protect updates to `irq.enabled` and the related hardware
programming. Check the wedged state while holding the same lock so the
final IRQ state remains disabled.

v2:
 - Rename pm_lock to state_lock and document the IRQ state it protects.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_irq.c          | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index df4e274bc719..f89d539df010 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/mutex.h>
 #include <linux/pci.h>
 
 #include <drm/drm_device.h>
@@ -272,6 +273,9 @@ struct xe_device {
 		/** @irq.lock: lock for processing irq's on this device */
 		spinlock_t lock;
 
+		/** @irq.state_lock: Protects suspend and resume IRQ state updates */
+		struct mutex state_lock;
+
 		/** @irq.enabled: interrupts enabled on this device */
 		atomic_t enabled;
 
diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index d314993b14a1..f7ff3fe5b843 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -797,8 +797,14 @@ static void irq_uninstall(void *arg)
 
 int xe_irq_init(struct xe_device *xe)
 {
+	int err;
+
 	spin_lock_init(&xe->irq.lock);
 
+	err = drmm_mutex_init(&xe->drm, &xe->irq.state_lock);
+	if (err)
+		return err;
+
 	return xe_irq_msix_init(xe);
 }
 
@@ -843,6 +849,8 @@ static void xe_irq_msi_synchronize_irq(struct xe_device *xe)
 
 void xe_irq_suspend(struct xe_device *xe)
 {
+	mutex_lock(&xe->irq.state_lock);
+
 	atomic_set(&xe->irq.enabled, 0); /* no new irqs */
 
 	/* flush irqs */
@@ -851,6 +859,8 @@ void xe_irq_suspend(struct xe_device *xe)
 	else
 		xe_irq_msi_synchronize_irq(xe);
 	xe_irq_reset(xe); /* turn irqs off */
+
+	mutex_unlock(&xe->irq.state_lock);
 }
 
 void xe_irq_resume(struct xe_device *xe)
@@ -858,10 +868,14 @@ void xe_irq_resume(struct xe_device *xe)
 	struct xe_gt *gt;
 	int id;
 
+	mutex_lock(&xe->irq.state_lock);
+
+	if (xe_device_wedged(xe))
+		goto out_unlock;
+
 	/*
-	 * lock not needed:
-	 * 1. no irq will arrive before the postinstall
-	 * 2. display is not yet resumed
+	 * irq.lock is not needed because no IRQ can arrive before
+	 * postinstall and the display has not been resumed yet.
 	 */
 	atomic_set(&xe->irq.enabled, 1);
 	xe_irq_reset(xe);
@@ -869,6 +883,9 @@ void xe_irq_resume(struct xe_device *xe)
 
 	for_each_gt(gt, xe, id)
 		xe_irq_enable_hwe(gt);
+
+out_unlock:
+	mutex_unlock(&xe->irq.state_lock);
 }
 
 /* MSI-X related definitions and functions below. */
-- 
2.43.0

