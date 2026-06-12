Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF08A10F31A;
	Fri, 12 Jun 2026 08:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HFx+d8DH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7129310F319;
 Fri, 12 Jun 2026 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781251864; x=1812787864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iiY63fuYm/uJJQi1BrfeWb2t++BDYYJubs+Hf0ezHnA=;
 b=HFx+d8DHFEq39u4G3Og7I58O4r4BQA69b/LKVYON+ra/mycMOg0MrnW9
 cVBMcZawn0uLBf+nTiKbeKjd4jvC69EJmdITCPQmwQqWuKZzm1PdllSag
 djQ8JyR/5l+4Rr1d7MoTk0jIYQ0FheE82DyUMVVpjuozu8tcwGulbQxFu
 f/f6FKtXV/2ntv0pYQ/cKB0fFigThSADODHS2NFfKzrsoTuK+Kfk18j5Z
 Zg+Zh1OAEergmMHDE/JmwXx4EBO5RN0oHhUTk9FrcJsLEcW8wJ0JKUIQl
 MquU4lvvjtDTM0XNZ+P9Q89iC2l24EtQ49JhCRjaHOBYgTCpOUEGAhQuC w==;
X-CSE-ConnectionGUID: AxryEF9UTAaKo7jpz06SqQ==
X-CSE-MsgGUID: gunU1AyhROeIEyvhnKxijA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85921419"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="85921419"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 01:11:04 -0700
X-CSE-ConnectionGUID: sS9346tsStq01/vjTKXE8g==
X-CSE-MsgGUID: oA7NFO+ATV+GkEAuEjfXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245667200"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa006.jf.intel.com with ESMTP; 12 Jun 2026 01:10:59 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v8 4/6] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Fri, 12 Jun 2026 13:37:27 +0530
Message-ID: <20260612080722.26726-12-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
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
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v3:
- Use PUNIT instead of PMU. (Riana)
- Use consistent wording.
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
index 6a5140bc47e5..93a56a0269f1 100644
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
@@ -207,6 +209,12 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_ras_erro
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
@@ -239,7 +247,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
 			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
 			       sev_to_str(counter->common.severity),
 			       ieh_error->global_error_status);
-			/* TODO: Add PUNIT error handling */
+			punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.34.1

