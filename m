Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3B0CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1206F10EC56;
	Mon, 12 Oct 2026 04:16:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453D410EC59;
 Mon, 12 Oct 2026 04:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778566; x=1823314566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZI5009CJRVNY/YKFWSCcsWU6oSVormcEAyPIDX/8rog=;
 b=dtHakR8HoN/WstZoDj8vNPVxF6Wc2jHWJpo7Ge11TTv62j3hXKG4BenM
 niIVPhy6r03lk3eYCDHGTU2qfC0CAUnQU5b10BOoYlt3b0gmupWEZe++C
 2jGHZncKlKtRxqboR+jmnLlQqxzw2gU6Y+D4Pf2E2fd1uBG1jENl8+b8y
 WuSnlYZs8d4pJRigIRfKeUDTBAAK7jxgOzzEarRRrQrNsZN60yj6DxkQZ
 NTeFo1Y7AsGlqnf8ITxd0GtB6cFPY/HiQ7abMcfcAqcdj/ynbZNBmmGq4
 U1PM8p8V+xf51Jv705NzCQnsokpxBUL1hzVE0FobRtryL8oeVwdF3S56G Q==;
X-CSE-ConnectionGUID: Ikg4T4wWSV6pBMrsQrGeXA==
X-CSE-MsgGUID: yD8Vbi8IRi6TPsxd2ILR0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380952"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380952"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:06 -0700
X-CSE-ConnectionGUID: kvqeMZEIRsStAJPaw4XhxA==
X-CSE-MsgGUID: EPg3iZrSRtWTYVqvbNJOXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256760"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:04 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 49/56] drm/i915/audio: Add the mode pruning logic for HDMI
 FRL
Date: Mon, 12 Oct 2026 09:27:58 +0530
Message-ID: <20261012035806.3361439-50-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

Prune the audio modes that are not supported with given HDMI FRL
configuration.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_audio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 32f8c5e55319..fd62eaf14a3c 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -39,6 +39,7 @@
 #include "intel_display_types.h"
 #include "intel_display_wa.h"
 #include "intel_dp.h"
+#include "intel_hdmi.h"
 #include "intel_lpe_audio.h"
 
 /**
@@ -817,10 +818,19 @@ static void intel_audio_hdmi_eld_compute_config(struct intel_crtc_state *crtc_st
 		channels = sad.channels + 1;
 
 		for (bit = 0; bit < 7; bit++) {
+			bool supported;
+
 			if (!(sad.freq & BIT(bit)))
 				continue;
-			if (hdmi_audio_rate_supported(crtc_state, available_tmds,
-						      sad_freqs[bit], channels))
+
+			if (crtc_state->frl.enable)
+				supported = intel_hdmi_frl_audio_rate_supported(crtc_state,
+										sad_freqs[bit],
+										channels);
+			else
+				supported = hdmi_audio_rate_supported(crtc_state, available_tmds,
+								      sad_freqs[bit], channels);
+			if (supported)
 				new_freq_mask |= BIT(bit);
 		}
 
-- 
2.50.1

