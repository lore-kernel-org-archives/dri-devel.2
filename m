Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A8C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875E210ED28;
	Wed,  5 Aug 2026 07:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="laPRK+XN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF0510ED2E;
 Wed,  5 Aug 2026 07:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785913938; x=1817449938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZIaf5uyFyTpfdCyTrdnLdRuMQV1WytGE3CX+PrANPD0=;
 b=laPRK+XNVwskY96RFDZy508N2JIVFlwAfvZCrYjV8s9Q7DyzM2RHDAMM
 nPQq2Y2dlPyR92x2AqJHsPBFM/c+vkj9aE+8FGs+8NbmeXohhEZQIPNZL
 Y+uaBh7R/20kl93DSFGP6JRXeKfUi3RDeKzFLxOMqhMFQpif064M1Ds2f
 Htxy4Bqq4UMQOyvtiDOt8e0KcS7Z9sCz3+pMYTHgyCBdUOo0oE5zpTID1
 o4byawiN1JTxzI4OyPWuYOSbveNc6TGsJp8eoBZBqyl9cH6nzWS5KtEHr
 qWWvnkQoDCTzFKW/i8aNwr5WQxmh2O2UwPZAb2xV7uQFmSP/gzleoy1mO w==;
X-CSE-ConnectionGUID: jjgY//WKS5KooqWm1U73/g==
X-CSE-MsgGUID: RrqSDLZ0Q6yiAIQ2lR6h7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="89003235"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="89003235"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 00:12:16 -0700
X-CSE-ConnectionGUID: oE/dCYZoS0+/ZspMNbuTFQ==
X-CSE-MsgGUID: hTEOtgVBTQ+KhT4dMfQf6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="260460959"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa010.jf.intel.com with ESMTP; 05 Aug 2026 00:12:11 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v13 3/4] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Wed,  5 Aug 2026 12:41:56 +0530
Message-ID: <20260805071152.1225416-9-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
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

v9:
- Remove unwanted header. (Sashiko)
---
 drivers/gpu/drm/xe/xe_ras.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 352f056fd9ef..3033a377bace 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -254,6 +254,12 @@ static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+static void punit_error_handler(struct xe_device *xe)
+{
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_error_array *arr)
 {
 	struct xe_ras_soc_error *info = (void *)arr->details;
@@ -285,7 +291,7 @@ static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_error_a
 			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
 			       sev_to_str(counter->common.severity),
 			       ieh_error->global_error_status);
-			/* TODO: Add PUNIT error handling */
+			punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
-- 
2.48.1

