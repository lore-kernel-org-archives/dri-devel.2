Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E22CA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 460E910EC68;
	Mon, 12 Oct 2026 04:16:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4350D10EAD5;
 Mon, 12 Oct 2026 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778557; x=1823314557;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w/J3tBU++oM6gIEK+73WH+4QFGX2n1NaQyl5Sgk1Ni4=;
 b=JSIOJEZ/jrYO8+i30sDfjPwu1KVsL6BKHRLgJZIG+8m3BzQuri7ZHCrn
 l7W+UIztFgWdnDLbeD9V7g9yKwjqi9RmyDOONjamo3Q9thRjMvRg8Hxym
 4Dm9pGqdIw+ol5OFvpfF4hlxOMZGs3DgNy4gSMaiQVVJDg2EL2no1YvBK
 4I0LpCNBX8I8x0uHIFaQqjTiv7Hl+c5DfDfP/eCA/4Mo3+Z7kIKaKHmgI
 GqeL0IlR9AVNn0V4FEDvoCa02aC0iVl6CRwczm3krDzxs/ROJ9KZGu4+K
 RUkGk2xM29SyK2z2tPY7ZA+/eemrEf/atwMV2kLZnSgpUPrYOpW4dDRD2 A==;
X-CSE-ConnectionGUID: zsqEYpYhRwSs5yGMhyslgA==
X-CSE-MsgGUID: eODG6lbeTfWGr6ZiMqr6Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380945"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380945"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:57 -0700
X-CSE-ConnectionGUID: vJ3c+l2yTla6MdXONVg/dA==
X-CSE-MsgGUID: WShSNcHRSTmyeswIMS4pGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256706"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:55 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 45/56] drm/i915/hdmi: Use the real pixel clock as
 crtc_clock for FRL
Date: Mon, 12 Oct 2026 09:27:54 +0530
Message-ID: <20261012035806.3361439-46-ankit.k.nautiyal@intel.com>
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

For FRL, port_clock is the link rate, decoupled from the pixel clock, so
hsw_crtc_compute_clock() must not overwrite crtc_clock via
intel_crtc_dotclock().
The FRL pixel clock isn't recoverable from hardware (the FRL M/N is the DFM
tri-byte ratio), so take the sw value in verify_crtc_state()
for the derived clock fields.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dpll.c      |  2 +-
 .../drm/i915/display/intel_modeset_verify.c    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll.c b/drivers/gpu/drm/i915/display/intel_dpll.c
index 20fd091cb9db..851a4abf2448 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll.c
@@ -1171,7 +1171,7 @@ static int hsw_crtc_compute_clock(struct intel_atomic_state *state,
 		return 0;
 
 	/* CRT dotclock is determined via other means */
-	if (!crtc_state->has_pch_encoder)
+	if (!crtc_state->has_pch_encoder && !crtc_state->frl.enable)
 		crtc_state->hw.adjusted_mode.crtc_clock = intel_crtc_dotclock(crtc_state);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/display/intel_modeset_verify.c b/drivers/gpu/drm/i915/display/intel_modeset_verify.c
index f0761d8a7437..54ec1f439b90 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_verify.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_verify.c
@@ -218,6 +218,24 @@ verify_crtc_state(struct intel_atomic_state *state,
 	if (!sw_crtc_state->hw.active)
 		goto destroy_state;
 
+	/*
+	 * The HDMI FRL pixel clock is decoupled from port_clock and cannot be
+	 * recovered from hardware readout. The FRL M/N is the DFM tri-byte ratio, not
+	 * a pixel:link ratio so we cannot derive the pixel clock accurately.
+	 * To avoid mismatches and to avoid handling PIPE_CONF_CHECK for FRL,
+	 * copy the software value to the hardware state.
+	 */
+	if (sw_crtc_state->frl.enable) {
+		hw_crtc_state->hw.adjusted_mode.crtc_clock =
+			sw_crtc_state->hw.adjusted_mode.crtc_clock;
+		hw_crtc_state->hw.pipe_mode.crtc_clock =
+			sw_crtc_state->hw.pipe_mode.crtc_clock;
+		hw_crtc_state->pixel_rate =
+			sw_crtc_state->pixel_rate;
+		hw_crtc_state->pixel_rate_cdclk =
+			sw_crtc_state->pixel_rate_cdclk;
+	}
+
 	intel_pipe_config_sanity_check(hw_crtc_state);
 
 	if (!intel_pipe_config_compare(sw_crtc_state,
-- 
2.50.1

