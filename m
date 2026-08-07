Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F54C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A6310F3B3;
	Fri,  7 Aug 2026 04:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z8DLDvOX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A65B10F3A9;
 Fri,  7 Aug 2026 04:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077152; x=1817613152;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UmklgA7WwvxCbidMP9VPMGv+4UychUMXXpPDWjHGPA4=;
 b=Z8DLDvOXw+Cxe/AumS2Tdv5EbLKYWSlXPJFUPF3eOteOR17LFUVTG/OH
 5lB9LiDf5x7GrMqYAlrsKfHoEuvb3GaAfncJwTDCyaHksL77lRi3Q5eMr
 BdaEv2H+7U8yspi1cvMilM5zhgLQ3or6MgsKcoVAwHjTNUORKcIErHo0G
 GKKvUddMQUg2RZJeujx5ErBE9GnSP1a7/l8FKYjmBaAli3bZvkFaySmEr
 au5XsnVZ0MLzTcOMD7GJu9VXz1KiZ1PY3P9nTI1I39xusafARStMzqPYR
 k6KgSNTFF4wZrQE/4m4XZZT+SkujahzbBSQAxEqJZDllzzCC6EVpgUqwf A==;
X-CSE-ConnectionGUID: 3nbytsGLRou+s40qlfxMvA==
X-CSE-MsgGUID: a50I4ApzTvKiJLs5i85GIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619348"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:32 -0700
X-CSE-ConnectionGUID: YYAdQ3MnRGO5lYezmFDx+A==
X-CSE-MsgGUID: ENW9wnReSiWN3xooIgu/Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666387"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:29 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 25/44] drm/i915/hdmi: Rename port clock limit to specify tmds
 clock
Date: Fri,  7 Aug 2026 09:44:10 +0530
Message-ID: <20260807041430.229038-26-ankit.k.nautiyal@intel.com>
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

The existing port clock limit function takes care of the TMDS mode of
transmission. Specify the port clock limit type explicitly as tmds.
This will pave way to add a separate port clock limit function for
FRL mode.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 8f0ee9282b61..fe5a092a1f0a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1858,9 +1858,9 @@ static bool intel_hdmi_is_ycbcr420(const struct intel_crtc_state *crtc_state)
 	return crtc_state->output_format == INTEL_OUTPUT_FORMAT_YCBCR420;
 }
 
-static int hdmi_port_clock_limit(struct intel_hdmi *hdmi,
-				 bool respect_downstream_limits,
-				 bool has_hdmi_sink)
+static int hdmi_port_tmds_clock_limit(struct intel_hdmi *hdmi,
+				      bool respect_downstream_limits,
+				      bool has_hdmi_sink)
 {
 	struct intel_encoder *encoder = &hdmi_to_dig_port(hdmi)->base;
 	int max_tmds_clock = intel_hdmi_source_max_tmds_clock(encoder);
@@ -1893,8 +1893,8 @@ hdmi_port_clock_valid(struct intel_hdmi *hdmi,
 
 	if (clock < 25000)
 		return MODE_CLOCK_LOW;
-	if (clock > hdmi_port_clock_limit(hdmi, respect_downstream_limits,
-					  has_hdmi_sink))
+	if (clock > hdmi_port_tmds_clock_limit(hdmi, respect_downstream_limits,
+					       has_hdmi_sink))
 		return MODE_CLOCK_HIGH;
 
 	/* GLK DPLL can't generate 446-480 MHz */
-- 
2.50.1

