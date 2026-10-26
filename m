Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6A606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eLb+SLv5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D896510E98C;
	Mon, 26 Oct 2026 05:40:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84DB10E971;
 Mon, 26 Oct 2026 05:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993238; x=1824529238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=otmrJAsbBejv8PVxGyivTTsHpbAZmMPe3vjWGthMbHA=;
 b=eLb+SLv5HoSmy7l0MDuqw/DGHRMsHpQWpQG8aT1qKnI+r2DsxlmdFl5H
 0xe5JNF0cSq8tZnq8TqZ27Kpf+LYxE0pPy6j+uv5zS6PEQEvqA7aKrByZ
 R7u0OweFZzudmxzWGx3z4OSOupvwIsw6Yf8LIDuWAnf0W4xkbPc1wL5As
 HZxPk1rmQplSZdIOLDMQ+zqb5aPUd7K32lx7wDiJVRgx+MWxMQHrzypLT
 XVbI4kKMg34ulWYoFhdt9F8dg6Km1dUo4NEskw+LjrwTVepKxVEgvQm2V
 SRDo+yN/ZiIoQ26KXujf4rMlxlelChJJFmNy5WUz+j+h33IXKX6UpjncC A==;
X-CSE-ConnectionGUID: wfzZTQooQQSYsVU+ENc1ig==
X-CSE-MsgGUID: HkwWxeeeRP2duetvsMNwAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550196"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550196"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:38 -0700
X-CSE-ConnectionGUID: N2Cn3kF/SPOIT+nCm/7reA==
X-CSE-MsgGUID: si01WnaoTfihHUq8Qiv1Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001897"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:36 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME bitfield
 for xe3lpd
Date: Mon, 26 Oct 2026 11:09:19 +0530
Message-ID: <20261026054001.799894-9-animesh.manna@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AUX_LESS_WAKE_TIME bitfield in ALPM_CTL is widened from 6 bits to
8 bits starting from xe3lpd (display version 35). Add the register mask
and field macro for the wider bitfield and program the wake time using
the appropriate macro based on the display version. Also use the wider
limit when validating the computed wake lines and for the safest params
fallback.

v2: Modify AUX_LESS_WAKE_TIME bitfield for xe3lpd. [Suraj]
v3: Separate out AUX_LESS_WAKE_TIME bitfield change into its own
patch. [Jouni]
v4: Use the wider bitfield limit in aux-less wake time computation
and safest params. [Jouni, sashiko]

Bspec: 71477
Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 20 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_psr_regs.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index b9e31c29ab96..0083752d94f0 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -204,6 +204,12 @@ static int _lnl_compute_aux_less_wake_time(struct intel_dp *intel_dp,
 			    establishment_period, 1000);
 }
 
+static int get_aux_less_wake_lines_max(struct intel_display *display)
+{
+	return DISPLAY_VER(display) >= 35 ? ALPM_CTL_AUX_LESS_WAKE_TIME_MASK_XE3LPD :
+					    ALPM_CTL_AUX_LESS_WAKE_TIME_MASK;
+}
+
 static int
 _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 				  struct intel_crtc_state *crtc_state)
@@ -220,14 +226,14 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 
 	lfps_half_cycle = get_lfps_half_cycle_clocks(crtc_state);
 
-	if (aux_less_wake_lines > ALPM_CTL_AUX_LESS_WAKE_TIME_MASK ||
+	if (aux_less_wake_lines > get_aux_less_wake_lines_max(display) ||
 	    silence_period > PORT_ALPM_CTL_SILENCE_PERIOD_MASK ||
 	    lfps_half_cycle < 1 ||
 	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK + 1)
 		return false;
 
 	if (display->params.psr_safest_params)
-		aux_less_wake_lines = ALPM_CTL_AUX_LESS_WAKE_TIME_MASK;
+		aux_less_wake_lines = get_aux_less_wake_lines_max(display);
 
 	crtc_state->alpm_state.aux_less_wake_lines = aux_less_wake_lines;
 	crtc_state->alpm_state.silence_period_sym_clocks = silence_period;
@@ -617,10 +623,16 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	 * check panel support at this point.
 	 */
 	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+		int wake_lines = crtc_state->alpm_state.aux_less_wake_lines;
+
 		alpm_ctl = ALPM_CTL_ALPM_ENABLE |
 			ALPM_CTL_ALPM_AUX_LESS_ENABLE |
-			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS |
-			ALPM_CTL_AUX_LESS_WAKE_TIME(crtc_state->alpm_state.aux_less_wake_lines);
+			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS;
+
+		if (DISPLAY_VER(display) < 35)
+			alpm_ctl |= ALPM_CTL_AUX_LESS_WAKE_TIME(wake_lines);
+		else
+			alpm_ctl |= ALPM_CTL_AUX_LESS_WAKE_TIME_XE3LPD(wake_lines);
 
 		if (intel_dp->as_sdp_supported)
 			intel_alpm_configure_pr_as_sdp(intel_dp, crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index 78a05387eab5..124aa74e1dbb 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -301,7 +301,9 @@
 #define  ALPM_CTL_EXTENDED_FAST_WAKE_MIN_LINES		5
 #define  ALPM_CTL_EXTENDED_FAST_WAKE_TIME(lines)	REG_FIELD_PREP(ALPM_CTL_EXTENDED_FAST_WAKE_TIME_MASK, (lines) - ALPM_CTL_EXTENDED_FAST_WAKE_MIN_LINES)
 #define  ALPM_CTL_AUX_LESS_WAKE_TIME_MASK		REG_GENMASK(5, 0)
+#define  ALPM_CTL_AUX_LESS_WAKE_TIME_MASK_XE3LPD	REG_GENMASK(7, 0)
 #define  ALPM_CTL_AUX_LESS_WAKE_TIME(val)		REG_FIELD_PREP(ALPM_CTL_AUX_LESS_WAKE_TIME_MASK, val)
+#define  ALPM_CTL_AUX_LESS_WAKE_TIME_XE3LPD(val)	REG_FIELD_PREP(ALPM_CTL_AUX_LESS_WAKE_TIME_MASK_XE3LPD, val)
 
 #define _ALPM_CTL2_A	0x60954
 #define ALPM_CTL2(dev_priv, tran)	_MMIO_TRANS2(dev_priv, tran, _ALPM_CTL2_A)
-- 
2.43.0

