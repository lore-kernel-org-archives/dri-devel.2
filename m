Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31746606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y8AruQAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5877910E988;
	Mon, 26 Oct 2026 05:41:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C6110E99D;
 Mon, 26 Oct 2026 05:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993276; x=1824529276;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b97ex+KxEyYAupFj2AOhxiUTL/tRK5oBQWuu8/XeWgY=;
 b=Y8AruQAO6nZERhZgWphtaJa7t2tm6Z20VNQhMhYQdrY8CdZBbgMSmjX6
 L9VNQs1JQofdJ1LEB94J9Wau7xTw5Jlva+UG6Eb1ONg45ELili/YnQTEr
 uDXjj4bQ1QqYNmi58QLNfhQhrcHpQJsrTe4fY771GkjDieOtIWYx1Rghx
 o7EbkQzNJYhII7ufDm9uVyV9mXvBqMv2ZXPaisqP537oef9HbXUSoEVtm
 49h/FDS25EJxSjLTVw2c93C27OZDjfxjIWAOrnd/9l9mxesT+JRuATjiE
 aLmJJ6oaIRRgPLXnyIyciQaKGgR96lSU9+Ggm4Fmdx2Gf9aq3+4/9kHCU A==;
X-CSE-ConnectionGUID: AIL6ITmOQ9CxUqwRkas6WA==
X-CSE-MsgGUID: 1uUT6nPyRpiyXsdcrStfVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550228"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550228"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:41:16 -0700
X-CSE-ConnectionGUID: 8zd8VsjZR+OnQIdxH56pqg==
X-CSE-MsgGUID: TeSpGi3CQ7iMo+T54OuTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6002067"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:41:14 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 20/20] drm/i915/dp: Enable AS SDP for DP Panel Replay with
 AUX-less ALPM
Date: Mon, 26 Oct 2026 11:09:31 +0530
Message-ID: <20261026054001.799894-21-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AS SDP for Panel Replay with AUX-less ALPM and the related
DP_FIXED_VTOTAL_AS_SDP_EN_IN_PR_ACTIVE setting are limited to eDP by
intel_psr_needs_alpm_aux_less(). DP Panel Replay can now use AUX-less
ALPM as well, so base these on the ALPM state instead.

has_alpm is decided only in the late compute config, after AS SDP has
been computed. Use alpm_state.aux_less_possible to decide whether AS
SDP is needed, and has_alpm for the link training DPCD setting, which
happens with the final state.

intel_psr_needs_alpm_aux_less() is now used only within intel_psr.c,
so make it static.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c               | 4 +++-
 drivers/gpu/drm/i915/display/intel_dp_link_training.c | 2 +-
 drivers/gpu/drm/i915/display/intel_psr.c              | 4 ++--
 drivers/gpu/drm/i915/display/intel_psr.h              | 2 --
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 43b17d2ed93f..02ea3f2b00ac 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3274,7 +3274,9 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 	if (drm_dp_is_branch(intel_dp->dpcd))
 		return false;
 
-	if (intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) &&
+	/* has_alpm is not final yet, so check if AUX-less ALPM is possible */
+	if (crtc_state->has_panel_replay &&
+	    crtc_state->alpm_state.aux_less_possible &&
 	    !intel_psr_pr_async_video_timing_supported(intel_dp))
 		return true;
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 0dbc6174c402..c7a3cfd29e37 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -1124,7 +1124,7 @@ static bool
 intel_dp_pr_with_as_sdp_enabled(struct intel_dp *intel_dp,
 				const struct intel_crtc_state *crtc_state)
 {
-	return intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) &&
+	return crtc_state->has_panel_replay && crtc_state->has_alpm &&
 		(crtc_state->infoframes.enable &
 		 intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC));
 }
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 4c429a14b50e..0875de33f0da 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4566,8 +4566,8 @@ static bool intel_psr_needs_alpm(struct intel_dp *intel_dp,
 					     crtc_state->has_panel_replay);
 }
 
-bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
-				   const struct intel_crtc_state *crtc_state)
+static bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
+					  const struct intel_crtc_state *crtc_state)
 {
 	return intel_dp_is_edp(intel_dp) && crtc_state->has_panel_replay;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index 2557776a402b..8adb27c21408 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -79,8 +79,6 @@ void intel_psr_trigger_frame_change_event(struct intel_dsb *dsb,
 int intel_psr_min_set_context_latency(const struct intel_crtc_state *crtc_state);
 void intel_psr_connector_debugfs_add(struct intel_connector *connector);
 void intel_psr_debugfs_register(struct intel_display *display);
-bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
-				   const struct intel_crtc_state *crtc_state);
 bool intel_psr_wake_lines_fit_into_vblank(const struct intel_crtc_state *crtc_state,
 					  int wake_lines);
 void intel_psr_compute_config_late(struct intel_dp *intel_dp,
-- 
2.43.0

