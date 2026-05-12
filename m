Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD925CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F35E10EAF1;
	Tue, 12 May 2026 13:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hk5dXv99";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D98010EAF1;
 Tue, 12 May 2026 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778592586; x=1810128586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZwWCSjlDPAZ+5/tWxk/FXoC5CUSoCumacxVkIfnAsh4=;
 b=hk5dXv99sNrjYMOGqxv+UhyF5GQMleI2ymGP53HkFKSelTJ0kuJjqYeV
 KUvrKZgL3AlxG0wIubAc/lio3yA0xgRFFZe/f5J0Ti13M15pxE/lL9lYN
 QYL/1t0tVjbssOWbSC9tYDbzipkacJKjxMATMGP1iR0Bmt+nTb5MO/eMI
 yqHJYm5R2TFeKxUZZEyHtgPVY1s15VqWb6HsIU1V0WhwoOH500XdWtG9y
 LNhK1WjEpD5d7VI9IqIVmsEebRbGvP4dZ5cg7EJaLf5ONwTT/q+FDrxee
 Op0PxuomA6uLPRhMO3WXhZGXU3XMAqbpmB03URsc+ffkugMQk6EsoU/lt g==;
X-CSE-ConnectionGUID: BsAoNWuNR2ijW2aIl3EGIg==
X-CSE-MsgGUID: TcT6IC9oSW2vAuH0MHS+4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102164715"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="102164715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 06:29:46 -0700
X-CSE-ConnectionGUID: 7B6VEr7aThu1NdhqqpFsig==
X-CSE-MsgGUID: NmbWkIJEQuGuJihqJRLlmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237855922"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 12 May 2026 06:29:42 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v5 4/5] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Tue, 12 May 2026 18:56:19 +0530
Message-ID: <20260512132614.1793083-11-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
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

When PUNIT (power management unit) errors are detected that persist across
warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notify userspace that a complete device power cycle is required to
restore normal operation.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v3:
- Use PUNIT instead of PMU. (Riana)
- Use consistent wordingi.
- Remove log. (Raag)

v4:
- Make function static. (Raag)

v5:
- Remove kdoc for static function. (Raag)
- Remove xe_ prefix for static function.
---
 drivers/gpu/drm/xe/xe_ras.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index d79f8a6589ac..604470565bf3 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -4,6 +4,8 @@
  */
 
 #include "xe_bo.h"
+#include "xe_assert.h"
+#include "xe_device_types.h"
 #include "xe_device.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
@@ -222,6 +224,12 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+static void punit_error_handler(struct xe_device *xe)
+{
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
 							      struct xe_ras_error_array *arr)
 {
@@ -265,7 +273,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
 			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
 			       sev_to_str(error_class->common.severity),
 			       ieh_error->global_error_status);
-			/* TODO: Add PUNIT error handling */
+			punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.34.1

