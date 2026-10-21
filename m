Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DFA606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JtS0MngD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1765310FD43;
	Wed, 21 Oct 2026 10:04:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DBF10F9D3;
 Wed, 21 Oct 2026 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577056; x=1824113056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M9/x9f0llhjIeSo1RL78I3G0duRZBoTSouHhcGeCrGI=;
 b=JtS0MngDEP9Zcthubw90B/ekXBYxmd9cT0OyXhc4YiYl7NXnLFuCpOXG
 8K/oTLftCSYcjXZG+9+PFpTvzT+l1lAkmmxglw/zKBd2xeINeJu2702JA
 cYqdNoFWA+DdUcIUO6rtwp+kuQT2KR1m+o/B8++wKlOu0O2J/+XhYdliz
 wr7ROQuxAUBAqUHV/est1fnjhhocmFXR91LR/qAtFLjVlDtIrjwpIsP7Y
 C/OV+IBVFdSHCXYDLmEv3NQnqgdgslids2KIWwDfZw4l3banZCy2b3Dlw
 hb4Lpjd409SiZvIdULwgeRLACmA9ZQjrbj6TRjOMii33wezsKEYuZ8CxH A==;
X-CSE-ConnectionGUID: CctW7lUvSuioFiQCLnI4xQ==
X-CSE-MsgGUID: S263gJaJQl6Q2B0OSCzn0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290327"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290327"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:16 -0700
X-CSE-ConnectionGUID: RueteCcyQYmIW2OUVrE0Zg==
X-CSE-MsgGUID: 45Vbz/8dT8aDjk5Gw64r4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382164"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:13 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 16/17] drm/xe: Skip PM notifier preparation when device I/O
 is blocked
Date: Wed, 21 Oct 2026 15:33:17 +0530
Message-ID: <20261021100322.1014449-17-arvind.yadav@intel.com>
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

The system PM notifier runs before the PCI suspend callback and may
evict BOs or prepare pinned BOs.

Hold the common device I/O gate during preparation and skip it when
the device is blocked or unplugged. Track whether preparation ran so
the post callback only performs matching cleanup and releases the
runtime PM reference when needed.

Keep the gate held across BO eviction so isolation waits for
preparation admitted before the device was blocked.

v2:
 - Protect PM preparation with the common SRCU gate.

v3:
- Replace the private I/O gate with the DRM device SRCU helper.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  2 ++
 drivers/gpu/drm/xe/xe_pm.c           | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 1d3f72f6f315..983f0ce6062c 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -499,6 +499,8 @@ struct xe_device {
 
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

