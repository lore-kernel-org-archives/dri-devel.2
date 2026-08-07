Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B2EC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1131210F3BC;
	Fri,  7 Aug 2026 04:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="klU9RNir";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722D410F3B7;
 Fri,  7 Aug 2026 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077159; x=1817613159;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YSvoo45S4/G8V4hYGULawh20CywhVRvOzPfS72VozNs=;
 b=klU9RNirgc6Xfx6Xd1KIbMNx7N/MLnjovio/vg4nA6RRLLosXB8i6sqz
 sgAoH5sswNb+wtkmPtMFyxOzXszMf3dxdEgLKSkM5dmmiCRl019FCwMBe
 4y/hgQPiVvpdGUgYFPnfDS/wmykD2K7e+fEV072w0FAE9PSJiPq09HLYH
 ixFwOXAe0ZuKsh9/3w57A9ioHxe1cJy2IKtbMoTIMS1W2diMUn5IRlM7m
 JJol7A1czSlnz04RkK5AxR9MpNBZH1dpjQzn0G74dn2P5UjFbexw6L0xf
 uZZGe1YoCCSJmRleF9C3OTCa+BgzpgCOIaZKPz5eYPM2p282ovoz5STxb g==;
X-CSE-ConnectionGUID: HRPM9WKbTX23upXiKPSxhQ==
X-CSE-MsgGUID: XErCjaWIS7in4E4u60Q0RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619354"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619354"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:39 -0700
X-CSE-ConnectionGUID: bSTk5G8XQiqwo3VB6P4+yw==
X-CSE-MsgGUID: 0i6nAPGYRJu6lK62Xr0FJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666439"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:36 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 28/44] drm/i915/hdmi: Rename port clock valid to specify tmds
 clock
Date: Fri,  7 Aug 2026 09:44:13 +0530
Message-ID: <20260807041430.229038-29-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

The existing port clock valid function takes care of the TMDS mode of
transmission. Specify the port clock valid type explicitly as tmds.
This will pave way to add a separate port clock valid function for
FRL mode.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index fe5a092a1f0a..5a3241c054f7 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1884,9 +1884,9 @@ static int hdmi_port_tmds_clock_limit(struct intel_hdmi *hdmi,
 }
 
 static enum drm_mode_status
-hdmi_port_clock_valid(struct intel_hdmi *hdmi,
-		      int clock, bool respect_downstream_limits,
-		      bool has_hdmi_sink)
+hdmi_port_tmds_clock_valid(struct intel_hdmi *hdmi,
+			   int clock, bool respect_downstream_limits,
+			   bool has_hdmi_sink)
 {
 	struct intel_display *display = to_intel_display(hdmi);
 	struct intel_encoder *encoder = &hdmi_to_dig_port(hdmi)->base;
@@ -2010,7 +2010,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 						  sink_format))
 			continue;
 
-		status = hdmi_port_clock_valid(hdmi, tmds_clock, true, has_hdmi_sink);
+		status = hdmi_port_tmds_clock_valid(hdmi, tmds_clock, true, has_hdmi_sink);
 		if (status == MODE_OK)
 			return MODE_OK;
 	}
@@ -2186,9 +2186,9 @@ static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
 						       crtc_state->sink_format);
 
 		if (hdmi_bpc_possible(crtc_state, bpc) &&
-		    hdmi_port_clock_valid(intel_hdmi, tmds_clock,
-					  respect_downstream_limits,
-					  crtc_state->has_hdmi_sink) == MODE_OK)
+		    hdmi_port_tmds_clock_valid(intel_hdmi, tmds_clock,
+					       respect_downstream_limits,
+					       crtc_state->has_hdmi_sink) == MODE_OK)
 			return bpc;
 	}
 
-- 
2.50.1

