Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3E9C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3EA610EC49;
	Tue, 22 Sep 2026 10:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T5HyC82k";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A0B10E47C;
 Tue, 22 Sep 2026 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072285; x=1821608285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=depGuTlBZLsdL2KWn8P6zXxjiM3N16lwDLBcKP9IHeU=;
 b=T5HyC82kcPxqjtHavauVLMgQdH8ZRJWjWJLGBfhqf2S652t6JCbr3TFk
 +OTDVRuQbGcETfIZCsyVxjHQGPzRhbUtjTPY64O9gLZoDD7axpsISnKNE
 ZYu+VdGwqhNBFJ+OpyFMOvZYIE7Kfpd2AAgSOe4Lzoqp9zfvfwkw1Ttnr
 jKRR+SVyLFpDSFKlIrYLNfpoPeAi3KcFHWbqG0Rx2/Y62cai5c45onAZ/
 1F4yxHtVRry0dUPeoXlKdffz4VchSt9LRSXwlCek8Sa9Cej0rKfgwl5TB
 mFMkp+d0NXkhuHAa1B4jK1S/e/OSRMzHdIh/0Fa45TW3d4M9xNBfAJw5J g==;
X-CSE-ConnectionGUID: YzM8l+fsQ/Gp8LHa/MLzEQ==
X-CSE-MsgGUID: 6Dk1iQxRSM2lB4T/CQgfUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322863"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:05 -0700
X-CSE-ConnectionGUID: 5EdVtgg/TcOBclVa8WXkXw==
X-CSE-MsgGUID: ZHdnlrGXSNGo2yd9iSFKGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307967"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:03 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 14/15] drm/xe: Skip PM notifier preparation when device I/O
 is blocked
Date: Tue, 22 Sep 2026 15:46:59 +0530
Message-ID: <20260922101721.1583542-15-arvind.yadav@intel.com>
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

The system PM notifier runs before the PCI suspend callback and may evict
BOs or submit migration work. This work must not start after the device
has been declared wedged.

Skip PM preparation for a wedged device. Track whether preparation ran
so the post callback only performs matching cleanup and releases the
runtime PM reference when needed.

The gate is held across xe_bo_evict_all_user(), so wedge isolation waits
for eviction to finish. GTs are declared wedged before the gate is
drained, so pending fences are signalled and eviction can finish.

v2:
 - Protect PM preparation with the common SRCU gate.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  2 ++
 drivers/gpu/drm/xe/xe_pm.c           | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 93bb38ed5975..24e8cb5fc88a 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -484,6 +484,8 @@ struct xe_device {
 
 	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
 	struct notifier_block pm_notifier;
+	/** @pm_notifier_active: PM notifier prepare work was performed */
+	bool pm_notifier_active;
 	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
 	struct completion pm_block;
 	/** @rebind_resume_list: List of wq items to kick on resume. */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index daa7ba2df317..fd265f9135c6 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -459,10 +459,16 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	case PM_SUSPEND_PREPARE:
 	{
 		struct xe_validation_ctx ctx;
+		int io_idx;
+
+		/* Do not start PM preparation while device I/O is blocked. */
+		if (xe_device_io_get(xe, &io_idx))
+			break;
 
 		reinit_completion(&xe->pm_block);
 		xe_pm_block_begin_signalling();
 		xe_pm_runtime_get(xe);
+		xe->pm_notifier_active = true;
 		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
 					     (struct xe_val_flags) {.exclusive = true});
 		err = xe_bo_evict_all_user(xe);
@@ -479,10 +485,16 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 		 * allocations.
 		 */
 		xe_pm_block_end_signalling();
+		xe_device_io_put(io_idx);
 		break;
 	}
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
+		if (!xe->pm_notifier_active)
+			break;
+
+		xe->pm_notifier_active = false;
+
 		complete_all(&xe->pm_block);
 		xe_pm_wake_rebind_workers(xe);
 		xe_bo_notifier_unprepare_all_pinned(xe);
-- 
2.43.0

