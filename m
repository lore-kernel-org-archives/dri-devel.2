Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944DCC44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE93F10E86E;
	Mon, 13 Jul 2026 08:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bmN7rMGf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3329510E804;
 Mon, 13 Jul 2026 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783932224; x=1815468224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SVfTlLZFEuTLjuiL3oH2+aGEgJ0bjfYEsTrc8+h6YSM=;
 b=bmN7rMGf3pJ7Tdf2EfbdH15Ug9MTWCt6jP9ZtqO8kZHU2N/HXclr4Zo6
 ymq5ifiZGniljlSi6gu4FL6yVHx6j3CJRKfwbMW8KMWHi3xxjz7dvdc/R
 ek8wTIKtYVM67uHtIw2pY5BrLUQ8s2Kyc6USj92L2ycvj7NzcqG23fCws
 OrqGj2mgjGfwsnP/dkibOhvAQ5CmSGfmw80qROhODDEmi7LOjqQAmbw/W
 wABcnXh0rJQylxluzWAnlyRoTtQ5/akui/rw5LYjRKlf5q56GYaPYzXLz
 BPpOriUMaOhxdNDMnv3ztkAIXkK0HobwKpTHWx5nsLIJzn0oLICr86ecj w==;
X-CSE-ConnectionGUID: 8Z8y/cgWQF+XsgX2qdcX0Q==
X-CSE-MsgGUID: dN3NUAMGQxKJUq0CluVwFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95903992"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95903992"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 01:43:44 -0700
X-CSE-ConnectionGUID: FwooLK12S9KsWXV80h/96Q==
X-CSE-MsgGUID: pfqZX8neS4m1Cmaux1Pw1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251073105"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 13 Jul 2026 01:43:39 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v10 4/4] drm/xe: Handle PUNIT errors by requesting cold-reset
 recovery
Date: Mon, 13 Jul 2026 14:09:44 +0530
Message-ID: <20260713083939.251872-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
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
index 3d39bb95e94d..cc2a0e59dedf 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -194,6 +194,12 @@ static void ras_usp_aer_init(struct xe_device *xe)
 	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmasked\n");
 }
 
+static void punit_error_handler(struct xe_device *xe)
+{
+	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_device_declare_wedged(xe);
+}
+
 static __maybe_unused enum xe_ras_recovery_action
 handle_soc_internal_errors(struct xe_device *xe,
 			   struct xe_ras_error_array *arr)
@@ -227,7 +233,7 @@ handle_soc_internal_errors(struct xe_device *xe,
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

