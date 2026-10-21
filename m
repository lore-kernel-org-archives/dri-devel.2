Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F74606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aEWRjBZR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470E610F9D3;
	Wed, 21 Oct 2026 10:04:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910F410FD38;
 Wed, 21 Oct 2026 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577048; x=1824113048;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3b3+rcTdjf/nLt8C9vdmh2Lw6+iCADIYzpM+0prOXKg=;
 b=aEWRjBZRgncHV+vJaIFxPS2us9NKYwLYLkWaJHHFexGmSDNPm9vF+WOU
 nDnVvB6RgsFytps46uBWnOmQ7Ylcw567d8C2vpfKScEn/5NuTxHyESrZx
 oU5LuHYUSNcjnNhHNiQSp2HSsjU9uiWb+k0qTnjmarGjDVNjkbMyKixJ7
 /Q3ZPfLaB3L0pPt10IQI4LOmcvB2JJD8qCe6QXBLhCuYstCmvw96ZxXMK
 +Bppe1UEjNUHRHPe9B71jBYzWS9fq4+18T8JlNxJ6eEPLAxqMw1hQafyZ
 BCFW0/nko5lFVD2B6soMh8wJVjRkfPEu54MJsfR/UX9CuS0GuRknUHXsp g==;
X-CSE-ConnectionGUID: L8yj9ZQ2SXGvVvLsPDyeLw==
X-CSE-MsgGUID: PhQU5Sg7QWW/Isw9YifpHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290319"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290319"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:07 -0700
X-CSE-ConnectionGUID: Wpqv/XQ2SOa0xnXKyeVeOA==
X-CSE-MsgGUID: H2AmwJdHTQmIp3VJNaqazA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382148"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:05 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 12/17] drm/xe/irq: Protect IRQ state during wedge isolation
Date: Wed, 21 Oct 2026 15:33:13 +0530
Message-ID: <20261021100322.1014449-13-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
 drivers/gpu/drm/xe/xe_irq.c          | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index ab73dd08b5c6..7cb257912b75 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -6,6 +6,7 @@
 #ifndef _XE_DEVICE_TYPES_H_
 #define _XE_DEVICE_TYPES_H_
 
+#include <linux/mutex.h>
 #include <linux/pci.h>
 
 #include <drm/drm_device.h>
@@ -283,6 +284,9 @@ struct xe_device {
 		/** @irq.lock: lock for processing irq's on this device */
 		spinlock_t lock;
 
+		/** @irq.state_lock: Protects suspend and resume IRQ state updates */
+		struct mutex state_lock;
+
 		/** @irq.enabled: interrupts enabled on this device */
 		atomic_t enabled;
 
diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index b394c8edf89c..53e4d51b2b3b 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -799,8 +799,14 @@ static void irq_uninstall(void *arg)
 
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
 
@@ -845,6 +851,8 @@ static void xe_irq_msi_synchronize_irq(struct xe_device *xe)
 
 void xe_irq_suspend(struct xe_device *xe)
 {
+	mutex_lock(&xe->irq.state_lock);
+
 	atomic_set(&xe->irq.enabled, 0); /* no new irqs */
 
 	/* flush irqs */
@@ -853,6 +861,8 @@ void xe_irq_suspend(struct xe_device *xe)
 	else
 		xe_irq_msi_synchronize_irq(xe);
 	xe_irq_reset(xe); /* turn irqs off */
+
+	mutex_unlock(&xe->irq.state_lock);
 }
 
 void xe_irq_resume(struct xe_device *xe)
@@ -860,10 +870,14 @@ void xe_irq_resume(struct xe_device *xe)
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
@@ -871,6 +885,9 @@ void xe_irq_resume(struct xe_device *xe)
 
 	for_each_gt(gt, xe, id)
 		xe_irq_enable_hwe(gt);
+
+out_unlock:
+	mutex_unlock(&xe->irq.state_lock);
 }
 
 /* MSI-X related definitions and functions below. */
-- 
2.43.0

