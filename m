Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AABFFF4942
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC2010E33B;
	Mon, 30 Mar 2026 04:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Djd4A7SF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7535C10E346;
 Mon, 30 Mar 2026 04:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844539; x=1806380539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8fHRg09kmlg4W410dOYhoxfAwbLFY3HQa5UFaqNxw54=;
 b=Djd4A7SFXJIaEPFSO5DYpIrQQPChTpNL6zRNvcjz6c6upE79i2qS3oYP
 DDDqJPeKZ1pZaON97/AkD413U/G6o08UOkSNWKtsAakIivgSLxdl6QtjY
 ZiqX0JC6WLvkku40UYb7+RTJXT4p1vdTVSTg1bk1nf2Zibke1CA2WUVUq
 ZwdD0Eb7HvUDMcLdk8AOY3nLDTTZHnAEYX+GaH38OZl6/a5kFsefKfYG5
 Ic7+67YLoMZAw4ccoeFmUWbiSOTwragE7CdbPQjSIET3rDof88ICsZDkq
 QIXwZqJVPVeHuL5KXOnVHSKOEeAdP64Isr6Ifqs2P+E4fRyGuqS+k8dkh A==;
X-CSE-ConnectionGUID: ENLgS2YoQ8eCasGeDdsOIg==
X-CSE-MsgGUID: ZNY8yi7ZTSGq85NAYAU8Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218230"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:19 -0700
X-CSE-ConnectionGUID: +Ih01W/RRyuXgXEo/N6m9A==
X-CSE-MsgGUID: MaQKk/fIQuaE4Xh2ztR+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871183"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:17 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 08/19] drm/i915/dp: Add a helper to decide if AS SDP can be
 used
Date: Mon, 30 Mar 2026 09:36:45 +0530
Message-ID: <20260330040656.4116502-9-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

Add a helper that determines whether AS SDP can be used for the
current DP configuration. For now this is true only when the sink
supports AS SDP and VRR is enabled, but more conditions may be added
later.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 499850c2abcf..7ca3f9d583db 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3124,6 +3124,15 @@ static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state *crtc
 	vsc->content_type = DP_CONTENT_TYPE_NOT_DEFINED;
 }
 
+static bool intel_dp_can_use_as_sdp(struct intel_dp *intel_dp,
+				    struct intel_crtc_state *crtc_state)
+{
+	if (!intel_dp->as_sdp_supported)
+		return false;
+
+	return crtc_state->vrr.enable;
+}
+
 static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
 				    struct intel_crtc_state *crtc_state)
 {
@@ -3131,7 +3140,7 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
 
-	if (!crtc_state->vrr.enable || !intel_dp->as_sdp_supported)
+	if (!intel_dp_can_use_as_sdp(intel_dp, crtc_state))
 		return;
 
 	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
-- 
2.45.2

