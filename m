Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AFFC5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AB410EBBB;
	Tue,  2 Jun 2026 04:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X6KQBg0V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1B110EBBB;
 Tue,  2 Jun 2026 04:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780376014; x=1811912014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LDiCs39i7sseXfcE/JedV2+W+ZuipQRkvXef9lhXc3U=;
 b=X6KQBg0VOTm+mDHTxlap2wPPxEhxgqnklrFlZcV5I1qCP6yTYgO/dSB1
 gkkCfsqji+17I2ovH8Je/uULRSMFRHT0tZvuFDOXXR5RNEK7VolvNHZI5
 DvuZ/WJJ02dgjiJWNW3MGJffncFh8LJmDI1Ag60+ykQQ9muC3SFcoTuEZ
 r9sqIWy22EJ3eBRgJkK51ynmZLfykaVz6G8AFm0djk94CO19djBQo7toF
 H+wPFu+fCw0WN6ckWxBN5LGudPsG2Y/hYz4z8p/uyaJMLVS0Drg48jwaJ
 8By1MjNzKuqXW0qDAQkxI0VBlDEGtvjn7Pph8DQSRnewIYSzK0iOM09i0 w==;
X-CSE-ConnectionGUID: eQwSSgiJSZSITAOHbGZweQ==
X-CSE-MsgGUID: 8FS7kZ6iS66vVVS3+4fSDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120487"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="81120487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 21:53:33 -0700
X-CSE-ConnectionGUID: hvsyJ33IRhOS6f1+BbIqng==
X-CSE-MsgGUID: Ky8HeC22QAmJdHD+SKqXfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="245604138"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:30 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Date: Tue,  2 Jun 2026 10:18:44 +0530
Message-ID: <20260602044919.702209-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602044919.702209-1-raag.jadav@intel.com>
References: <20260602044919.702209-1-raag.jadav@intel.com>
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

Hardware errors should be logged with HW_ERR prefix. Make them
consistent with existing logs.

Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 5135e8e4093f..4b72959b2276 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
 	struct xe_device *xe = tile_to_xe(tile);
 
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
+		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
 	else
-		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
+		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
 }
 
 static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
@@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
 	struct xe_device *xe = tile_to_xe(tile);
 
 	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
+		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
 			 name, severity_str, i, err);
 	else
-		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
+		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
 				    name, severity_str, i, err);
 }
 
@@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
 
 	if (strcmp(name, "Undefined")) {
 		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
-			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
+			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
 		else
-			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
+			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
 		atomic_inc(&info[index].counter);
 	}
 }
-- 
2.43.0

