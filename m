Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9909AC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C2A10F378;
	Fri,  7 Aug 2026 04:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RdQnA1vQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC4910F36E;
 Fri,  7 Aug 2026 04:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077118; x=1817613118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ljp5VwMJJPJE7ZY7S2B/c4Dr9KiBkYtaBMqOfuekYDo=;
 b=RdQnA1vQudA1KTmFz9SNvkSS1KN1FGTjSN5gWDmouvXSgQOYw3NrSpGy
 yMAmgVHMCGNbgvgoLA1ktxHHlyAJPyeVoHkpmhuFy98UlWaMs4yiiGiKj
 7sCecAykHekXNwsf/ZpxGzsuFySUtetfRwi8Yz6ixCgrjFKbLqE7FL+z6
 VQXrX6jmuf+64eRj2rkNl+dLTS/14OcmxkvBiNUw+FRjw2nSbEq7toVOZ
 SabKHow0Rg3KctXvwtlbhw8p32kGyuo1gQqNwutTLVXJPOEZ9iyOhE4v0
 3wBwVy7dFInm54SyW1jLlivmWituUtASYCTRovTXs50TTihsEO6rBo5Wo A==;
X-CSE-ConnectionGUID: jPYvjztrSSaqA786cBP0gA==
X-CSE-MsgGUID: LDFkJSExS7qhHvYO66VQow==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619263"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:57 -0700
X-CSE-ConnectionGUID: SZEhHIf9The0WFok+R643Q==
X-CSE-MsgGUID: Pc1YNYGcSRyMqGquRDPSiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666131"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:55 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 12/44] drm/i915/ddi: Update HDMI modeset sequence for MTL+
Date: Fri,  7 Aug 2026 09:43:57 +0530
Message-ID: <20260807041430.229038-13-ankit.k.nautiyal@intel.com>
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

Per BSpec, the HDMI enable sequence differs starting MTL+: the port
must be fully configured and enabled (DDI_CTL_DE) before enabling the
transcoder (TRANS_CONF), whereas pre-MTL platforms enable the
transcoder before the port (DDI_BUF_CTL).

Today the HDMI path still uses the pre-MTL ordering: when the MTL+ DDI
sequences were implemented, HDMI was left enabling the transcoder before
the port. This does not cause any visible issue with current TMDS usage,
but it needs to be corrected before FRL can be wired up.

Bspec: 49191, 54145 (pre-MTL)
Bspec: 65750, 68848 (MTL+)
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 5be4a7f00313..d6e7e7863d36 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3474,7 +3474,8 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_vrr_transcoder_enable(crtc_state);
 
-	intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
+	if (DISPLAY_VER(display) < 14)
+		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
 
 	if (!intel_hdmi_handle_sink_scrambling(encoder, connector,
 					       crtc_state->hdmi_high_tmds_clock_ratio,
@@ -3577,6 +3578,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_ddi_buf_enable(encoder, buf_ctl);
 
+	if (DISPLAY_VER(display) >= 14)
+		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
+
 	intel_hdmi_poll_for_scrambling_enable(crtc_state, connector);
 }
 
-- 
2.50.1

