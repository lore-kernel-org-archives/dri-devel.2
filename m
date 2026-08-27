Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC6C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704BF10EFA1;
	Thu, 27 Aug 2026 10:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bG6d9+JB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8775B10EF90;
 Thu, 27 Aug 2026 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825934; x=1819361934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JVQDUUH3DQaJlMs1iKS7yPiv1XIwwP2dSpKjaGpxFzE=;
 b=bG6d9+JBQzlGWJVG8WhHbHokpXg5Tro4gPdasvpsa0mKrdZnRVaRGmBD
 h6m7pwX4h8T9NeVOpMFEcOik0bbJ/SIKkpwEtJ4iUDT6Tj7af+f1fB4QL
 tzufe1DcMwFfZ4fGM0y+wn0qebcignyu9FohU9DmldYaPwD6joL5lgxwt
 pvA5ZzX6NgU+P6cJLb6PI4LM9M6vR0gG0Ifj9hOYXBVxzVIcG4u+UFrg7
 /dhgLt24f/oLl4amhPLRpEXt1l7ks8i+tdTVxYL3AyhF5OD8EuRlJkilk
 WdNlH9IzZf6KHShaxm3EBBEiC0ZfgHB29VQXO+F1c95vtu3JihBXANgmR w==;
X-CSE-ConnectionGUID: fiPIv192S0OLVywCqbushg==
X-CSE-MsgGUID: heTphoVzSii5sSdo96RZIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445881"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445881"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:54 -0700
X-CSE-ConnectionGUID: TM+Gsd7KQhGogawbr9OTqw==
X-CSE-MsgGUID: Ra5YE3lKTsG+hIn8bspQBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057664"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:53 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 12/13] drm/xe: Skip PM notifier preparation for wedged devices
Date: Thu, 27 Aug 2026 15:48:00 +0530
Message-ID: <20260827101801.1247654-13-arvind.yadav@intel.com>
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

The system PM notifier runs before the PCI suspend callback and may evict
BOs or submit migration work. This work must not start after the device
has been declared wedged.

Skip PM preparation for a wedged device. Track whether preparation ran
so the post callback only performs matching cleanup and releases the
runtime PM reference when needed.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_device_types.h |  2 ++
 drivers/gpu/drm/xe/xe_pm.c           | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 508ba3872e72..c9dc417878e7 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -471,6 +471,8 @@ struct xe_device {
 
 	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
 	struct notifier_block pm_notifier;
+	/** @pm_notifier_active: PM notifier prepare work was performed */
+	bool pm_notifier_active;
 	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
 	struct completion pm_block;
 	/** @rebind_resume_list: List of wq items to kick on resume. */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 720e083cd279..dd7fd170bc94 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -457,9 +457,14 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
 	{
 		struct xe_validation_ctx ctx;
 
+		/* Do not start PM preparation after a wedge is declared. */
+		if (xe_device_wedged(xe))
+			break;
+
 		reinit_completion(&xe->pm_block);
 		xe_pm_block_begin_signalling();
 		xe_pm_runtime_get(xe);
+		xe->pm_notifier_active = true;
 		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
 					     (struct xe_val_flags) {.exclusive = true});
 		err = xe_bo_evict_all_user(xe);
@@ -480,6 +485,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
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

