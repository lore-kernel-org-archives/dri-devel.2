Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44278C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F7B10EBF7;
	Tue, 30 Jun 2026 10:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MgpfWjqX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85C410E19D;
 Tue, 30 Jun 2026 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782814621; x=1814350621;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mIwuhWkMrH9uKMppkRzzKMnN8kxnBLom7CvAGowHokQ=;
 b=MgpfWjqX1mjjjXYoVfbpgzJx7C89aA+XCyfQhUyt//qFVdY4dcgKSgdD
 CZN9wKDwGf/OZeBIzTxA64xho11SuPNRjtPJM1/4divo3+k1HWy5A1jar
 2PLV3YM2royzjmDIfQRkTf0cRIYuurLoCHB/Wx1P14n604lLXYuG/Aees
 PGHwSBOK6P1haSytoVfhQcCmOQM3bs8cDIGWwVJtBPfFcLEctLX0Q0VE+
 KAqfKVWT15iY4y6Dgd5FqXoElcsSjU4GdNCfqfbmx9lCLqWBJ66vKFgFB
 PwzE96LOm+/RohR6Mco0DDi7VxwV9uCXmpNf5uKxpGcGn8hoTTsB9ZzMw g==;
X-CSE-ConnectionGUID: yNT8qwleRSalFpwpWmIJ+Q==
X-CSE-MsgGUID: inmbjA1wSmOi+GOu6fZiPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="86074038"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="86074038"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:17:00 -0700
X-CSE-ConnectionGUID: 97wgWLmnTkG+U6c7Mv8eOg==
X-CSE-MsgGUID: osI9SIihSWyz5lPC7wgqyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="249584311"
Received: from woei-desk.jf.intel.com ([10.165.243.17])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2026 03:17:00 -0700
From: mei.fan.liou@intel.com
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	"LIOU, Mei Fan" <mei.fan.liou@intel.com>, LIOU@freedesktop.org
Subject: [PATCH] drm/i915: add disable_edp module parameter to skip phantom
 eDP init
Date: Tue, 30 Jun 2026 03:28:45 -0700
Message-ID: <20260630102845.2678707-1-mei.fan.liou@intel.com>
X-Mailer: git-send-email 2.43.0
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

From: "LIOU, Mei Fan" <mei.fan.liou@intel.com>

Some platforms have BIOS/VBT that declares an eDP panel present while
no physical panel is connected. This causes intel_edp_init_connector()
to spend ~6 seconds waiting on PPS power sequencer and AUX channel
timeouts before failing gracefully.

Introduce a new boolean module parameter 'disable_edp' (default: false)
that allows users to skip eDP connector initialization entirely. When
set, the driver logs an informational message and returns false early
from intel_edp_init_connector(), bypassing all PPS/AUX probing.

This is modeled after the existing 'disable_display' parameter and
is intended as a workaround for headless or display-less deployments
where the BIOS incorrectly advertises an internal panel.

Signed-off-by: LIOU, Mei Fan <mei.fan.liou@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_params.c | 3 +++
 drivers/gpu/drm/i915/display/intel_display_params.h | 1 +
 drivers/gpu/drm/i915/display/intel_dp.c             | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_params.c b/drivers/gpu/drm/i915/display/intel_display_params.c
index 2aed110c5b09..8d47d19b1667 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_params.c
@@ -102,6 +102,9 @@ intel_display_param_named_unsafe(force_reset_modeset_test, bool, 0400,
 intel_display_param_named(disable_display, bool, 0400,
 	"Disable display (default: false)");
 
+intel_display_param_named(disable_edp, bool, 0400,
+	"Disable eDP panel init, skips PPS/AUX probing when VBT declares eDP but no panel is present (default: false)");
+
 intel_display_param_named(verbose_state_checks, bool, 0400,
 	"Enable verbose logs (ie. WARN_ON()) in case of unexpected hw state conditions.");
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
index b95ecf728daa..98ab0d753dab 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.h
+++ b/drivers/gpu/drm/i915/display/intel_display_params.h
@@ -41,6 +41,7 @@ struct drm_printer;
 	param(bool, load_detect_test, false, 0600) \
 	param(bool, force_reset_modeset_test, false, 0600) \
 	param(bool, disable_display, false, 0400) \
+	param(bool, disable_edp, false, 0400) \
 	param(bool, verbose_state_checks, true, 0400) \
 	param(bool, nuclear_pageflip, false, 0400) \
 	param(bool, enable_dp_mst, true, 0600) \
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 85d3aa3b9894..c6293a1b3840 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7214,6 +7214,13 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	if (!intel_dp_is_edp(intel_dp))
 		return true;
 
+	if (display->params.disable_edp) {
+		drm_info(display->drm,
+			 "[ENCODER:%d:%s] eDP disabled by module parameter, skipping init\n",
+			 encoder->base.base.id, encoder->base.name);
+		return false;
+	}
+
 	/*
 	 * On IBX/CPT we may get here with LVDS already registered. Since the
 	 * driver uses the only internal power sequencer available for both
-- 
2.43.0

