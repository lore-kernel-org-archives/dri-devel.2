Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C25606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H+Fp2bKK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58FD10FDEA;
	Fri, 20 Nov 2026 05:11:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B2D10F075;
 Fri, 20 Nov 2026 05:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795151503; x=1826687503;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=udCC0yuWXpUuG6Xi1piz77NGQcuqbkvrdOGDmdG5gyc=;
 b=H+Fp2bKKBQvKWNDinTy9Iy3yFMrqkG9MivTwfhbq6WC5s3F3SWjOTvTG
 OuQAfqXGINxheFLvNc0e3oY6/hhJ/LYkc8ZpDLsHrq+6mo+OLISAluAq0
 e0xMCGW2ysjNfOcw6gv/5boCmIUtWlzvkU24xd2OxdmYtEOzG/4sBX8Fk
 qwcVaRyzbh/ILFLIUY/QtJo8/aV55g/COgitD/jtwiileUJFIIKHLZ1ys
 I6X7bYzyV8y+EZ8ty00xmtFKxKOHTF1YSUWWhkXsLga5zCw3/syxgu3pf
 +dVI5//FORdx1kkDNTdteFAphCOiHq0qHzr/QOw33ia9B+yKYM+evXGi+ A==;
X-CSE-ConnectionGUID: NEk0+u8/SVq4WHqS3K7liw==
X-CSE-MsgGUID: rHWuG/lEQVK5o5RFq11ysQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3907448"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3907448"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:11:42 -0800
X-CSE-ConnectionGUID: cjyEFGc6TuaQXaTgfsO9EA==
X-CSE-MsgGUID: lRtSBcr6SkGP0RuO/obDNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10607182"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2026 21:11:39 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Fri, 20 Nov 2026 10:36:06 +0530
Subject: [PATCH v5 07/13] drm/i915/display: Program the DP symbol based
 timing generator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vlk-64036-dp-symbol-tg-v5-7-bf8f78b32709@intel.com>
References: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
In-Reply-To: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Program the 128 bit LL symbol Data M/N before the LINK_N write which
arms the double buffered update, the LL symbol HACT/HTOTAL/CHUNK_SIZE
along with the other transcoder timings, and enable the timing
generator via TRANSCONF.DP_Symbol_TG_Enable before the transcoder is
enabled.

The Hblank Early count of the audio and the Early Count Scaling are a
pair: with the symbol based timing generator the count is in symbols, 96
of them (rolled down to fit the Hactive symbol count) with x1 scaling.
Program the count along with the scaling, and clear the scaling again when
disabling the transcoder.

v3: Remove redundant HAS_DP_SYMBOL_TG (Jani)
    Use intel_de_read64_2x32()
v4: Program the Hblank Early count paired with the x1 scaling
v5: Audio: pick the Hblank Early count in symbols, rolled down to fit the
    Hactive symbol count of the symbol TG, in enable_audio_dsc_wa()

Bspec: 68849, 68922, 68943, 69961
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_audio.c   |  28 ++++++-
 drivers/gpu/drm/i915/display/intel_ddi.c     |   2 +
 drivers/gpu/drm/i915/display/intel_display.c | 114 +++++++++++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_display.h |   1 +
 4 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 32f8c5e55319fbbf5a10558d067cc5e05f242b01..e1b4e7fdc22a91ce6a6e9d80e88c5791d2d72753 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -506,6 +506,20 @@ static unsigned int calc_samples_room(const struct intel_crtc_state *crtc_state)
 		(pixel_clk * (48 / lanes + 2));
 }
 
+static int symbol_tg_hblank_start_count(const struct intel_dp_symbol_tg *tg)
+{
+	if (tg->hactive >= 96)
+		return HBLANK_START_COUNT_96;
+	else if (tg->hactive >= 64)
+		return HBLANK_START_COUNT_64;
+	else if (tg->hactive >= 32)
+		return HBLANK_START_COUNT_32;
+	else if (tg->hactive >= 16)
+		return HBLANK_START_COUNT_16;
+	else
+		return HBLANK_START_COUNT_8;
+}
+
 static void enable_audio_dsc_wa(struct intel_encoder *encoder,
 				const struct intel_crtc_state *crtc_state)
 {
@@ -524,9 +538,17 @@ static void enable_audio_dsc_wa(struct intel_encoder *encoder,
 	else if (DISPLAY_VER(display) >= 12)
 		val |= HBLANK_EARLY_ENABLE_TGL(cpu_transcoder);
 
-	if (crtc_state->dsc.compression_enable &&
-	    crtc_state->hw.adjusted_mode.hdisplay >= 3840 &&
-	    crtc_state->hw.adjusted_mode.vdisplay >= 2160) {
+	if (crtc_state->dp_symbol_tg.enable) {
+		/*
+		 * The Hblank Early count and the Early Count Scaling (x1,
+		 * programmed in intel_enable_transcoder()) are a pair.
+		 */
+		val &= ~HBLANK_START_COUNT_MASK(cpu_transcoder);
+		val |= HBLANK_START_COUNT(cpu_transcoder,
+					  symbol_tg_hblank_start_count(&crtc_state->dp_symbol_tg));
+	} else if (crtc_state->dsc.compression_enable &&
+		   crtc_state->hw.adjusted_mode.hdisplay >= 3840 &&
+		   crtc_state->hw.adjusted_mode.vdisplay >= 2160) {
 		/* Get hblank early enable value required */
 		val &= ~HBLANK_START_COUNT_MASK(cpu_transcoder);
 		hblank_early_prog = calc_hblank_early_prog(encoder, crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a46ab5d3d70fc75c6975f46e14d1b0c24dc1ba5e..c814e0740aa064f56d844e304c0a93d1047475c6 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4083,6 +4083,7 @@ static void intel_ddi_read_func_ctl_dp_sst(struct intel_encoder *encoder,
 			REG_FIELD_GET(TRANS_DDI_MST_TRANSPORT_SELECT_MASK, ddi_func_ctl);
 
 	intel_cpu_transcoder_get_m1_n1(crtc, cpu_transcoder, &crtc_state->dp_m_n);
+	intel_cpu_transcoder_get_llsym_m_n(crtc_state);
 	intel_cpu_transcoder_get_m2_n2(crtc, cpu_transcoder, &crtc_state->dp_m2_n2);
 
 	crtc_state->enhanced_framing =
@@ -4119,6 +4120,7 @@ static void intel_ddi_read_func_ctl_dp_mst(struct intel_encoder *encoder,
 			REG_FIELD_GET(TRANS_DDI_MST_TRANSPORT_SELECT_MASK, ddi_func_ctl);
 
 	intel_cpu_transcoder_get_m1_n1(crtc, cpu_transcoder, &crtc_state->dp_m_n);
+	intel_cpu_transcoder_get_llsym_m_n(crtc_state);
 
 	if (DISPLAY_VER(display) >= 11)
 		crtc_state->fec_enable =
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 7caf5bee8718729667376b487b0584b47891f05a..1900a3fe28c23bdf9c6733997459a820f37551b5 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -521,9 +521,18 @@ void intel_enable_transcoder(const struct intel_crtc_state *new_crtc_state)
 		return;
 	}
 
-	/* Wa_1409098942:adlp+ */
-	if (DISPLAY_VER(display) >= 13 &&
-	    new_crtc_state->dsc.compression_enable) {
+	/*
+	 * The Hblank Early count is in symbols with the DP symbol TG, no scaling.
+	 * The matching count is programmed by the audio code, see
+	 * enable_audio_dsc_wa().
+	 */
+	if (new_crtc_state->dp_symbol_tg.enable) {
+		val &= ~TRANSCONF_PIXEL_COUNT_SCALING_MASK;
+		val |= REG_FIELD_PREP(TRANSCONF_PIXEL_COUNT_SCALING_MASK,
+				      TRANSCONF_PIXEL_COUNT_SCALING_X1);
+	} else if (DISPLAY_VER(display) >= 13 &&
+		   new_crtc_state->dsc.compression_enable) {
+		/* Wa_1409098942:adlp+ */
 		val &= ~TRANSCONF_PIXEL_COUNT_SCALING_MASK;
 		val |= REG_FIELD_PREP(TRANSCONF_PIXEL_COUNT_SCALING_MASK,
 				      TRANSCONF_PIXEL_COUNT_SCALING_X4);
@@ -575,9 +584,10 @@ void intel_disable_transcoder(const struct intel_crtc_state *old_crtc_state)
 	if (!display->platform.i830)
 		val &= ~TRANSCONF_ENABLE;
 
-	/* Wa_1409098942:adlp+ */
-	if (DISPLAY_VER(display) >= 13 &&
-	    old_crtc_state->dsc.compression_enable)
+	/* Wa_1409098942:adlp+, and the Hblank Early scaling of the DP symbol TG */
+	if ((DISPLAY_VER(display) >= 13 &&
+	     old_crtc_state->dsc.compression_enable) ||
+	    old_crtc_state->dp_symbol_tg.enable)
 		val &= ~TRANSCONF_PIXEL_COUNT_SCALING_MASK;
 
 	intel_de_write(display, TRANSCONF(display, cpu_transcoder), val);
@@ -588,6 +598,14 @@ void intel_disable_transcoder(const struct intel_crtc_state *old_crtc_state)
 
 	if ((val & TRANSCONF_ENABLE) == 0)
 		intel_wait_for_pipe_off(old_crtc_state);
+
+	/* Disable the DP symbol based timing generator */
+	if (old_crtc_state->dp_symbol_tg.enable) {
+		intel_de_rmw(display, TRANSCONF(display, cpu_transcoder),
+			     TRANSCONF_DP_SYMBOL_TG_ENABLE, 0);
+		intel_de_write(display, TRANS_LLSYM_HACT(display, cpu_transcoder), 0);
+		intel_de_write(display, TRANS_LLSYM_HTOTAL(display, cpu_transcoder), 0);
+	}
 }
 
 u32 intel_plane_fb_max_stride(struct intel_display *display,
@@ -1683,6 +1701,52 @@ static void hsw_set_frame_start_delay(const struct intel_crtc_state *crtc_state)
 		     HSW_FRAME_START_DELAY(crtc_state->framestart_delay - 1));
 }
 
+static void intel_cpu_transcoder_set_llsym_m_n(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder transcoder = crtc_state->cpu_transcoder;
+	const struct intel_dp_symbol_tg *tg = &crtc_state->dp_symbol_tg;
+
+	if (!tg->enable)
+		return;
+
+	/*
+	 * These are double buffered, updated by the LINK_N write in
+	 * intel_set_m_n(), so must be written before that.
+	 */
+	intel_de_write(display, DP_LLSYM_DATAM(display, transcoder, 0),
+		       lower_32_bits(tg->data_m[0]));
+	intel_de_write(display, DP_LLSYM_DATAM(display, transcoder, 1),
+		       upper_32_bits(tg->data_m[0]));
+	intel_de_write(display, DP_LLSYM_DATAM_EXT(display, transcoder, 0),
+		       lower_32_bits(tg->data_m[1]));
+	intel_de_write(display, DP_LLSYM_DATAM_EXT(display, transcoder, 1),
+		       upper_32_bits(tg->data_m[1]));
+	intel_de_write(display, DP_LLSYM_DATAN(display, transcoder, 0),
+		       lower_32_bits(tg->data_n[0]));
+	intel_de_write(display, DP_LLSYM_DATAN(display, transcoder, 1),
+		       upper_32_bits(tg->data_n[0]));
+	intel_de_write(display, DP_LLSYM_DATAN_EXT(display, transcoder, 0),
+		       lower_32_bits(tg->data_n[1]));
+	intel_de_write(display, DP_LLSYM_DATAN_EXT(display, transcoder, 1),
+		       upper_32_bits(tg->data_n[1]));
+}
+
+void intel_cpu_transcoder_get_llsym_m_n(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder transcoder = crtc_state->cpu_transcoder;
+	struct intel_dp_symbol_tg *tg = &crtc_state->dp_symbol_tg;
+
+	if (!tg->enable)
+		return;
+
+	tg->data_m[0] = intel_de_read64_2x32(display, DP_LLSYM_DATAM(display, transcoder, 0));
+	tg->data_m[1] = intel_de_read64_2x32(display, DP_LLSYM_DATAM_EXT(display, transcoder, 0));
+	tg->data_n[0] = intel_de_read64_2x32(display, DP_LLSYM_DATAN(display, transcoder, 0));
+	tg->data_n[1] = intel_de_read64_2x32(display, DP_LLSYM_DATAN_EXT(display, transcoder, 0));
+}
+
 static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
@@ -1693,6 +1757,7 @@ static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_sta
 		intel_cpu_transcoder_set_m1_n1(crtc, cpu_transcoder,
 					       &crtc_state->fdi_m_n);
 	} else if (intel_crtc_has_dp_encoder(crtc_state)) {
+		intel_cpu_transcoder_set_llsym_m_n(crtc_state);
 		intel_cpu_transcoder_set_m1_n1(crtc, cpu_transcoder,
 					       &crtc_state->dp_m_n);
 		intel_cpu_transcoder_set_m2_n2(crtc, cpu_transcoder,
@@ -2929,6 +2994,19 @@ void intel_set_transcoder_timings(const struct intel_crtc_state *crtc_state,
 		intel_de_write(display, DP_MIN_HBLANK_CTL(transcoder),
 			       crtc_state->min_hblank);
 	}
+
+	if (crtc_state->dp_symbol_tg.enable &&
+	    transcoder != TRANSCODER_CMTG0 &&
+	    transcoder != TRANSCODER_CMTG1) {
+		const struct intel_dp_symbol_tg *tg = &crtc_state->dp_symbol_tg;
+
+		intel_de_write(display, TRANS_LLSYM_HACT(display, transcoder),
+			       TRANS_LLSYM_HACT_VAL(tg->hactive - 1));
+		intel_de_write(display, TRANS_LLSYM_HTOTAL(display, transcoder),
+			       TRANS_LLSYM_HTOTAL_VAL(tg->htotal - 1));
+		intel_de_write(display, TRANS_LLSYM_CHUNK_SIZE(display, transcoder),
+			       TRANS_LLSYM_CHUNK_SIZE_VAL(tg->chunk_size));
+	}
 }
 
 void intel_set_transcoder_timings_lrr(const struct intel_crtc_state *crtc_state,
@@ -3095,6 +3173,26 @@ static void intel_get_transcoder_timings(struct intel_crtc *crtc,
 	if (DISPLAY_VER(display) >= 30)
 		pipe_config->min_hblank = intel_de_read(display,
 							DP_MIN_HBLANK_CTL(cpu_transcoder));
+
+	if (HAS_DP_SYMBOL_TG(display)) {
+		tmp = intel_de_read(display, TRANSCONF(display, cpu_transcoder));
+
+		if (tmp & TRANSCONF_DP_SYMBOL_TG_ENABLE) {
+			struct intel_dp_symbol_tg *tg = &pipe_config->dp_symbol_tg;
+			u32 hact, htotal, chunk_size;
+
+			hact = intel_de_read(display, TRANS_LLSYM_HACT(display, cpu_transcoder));
+			htotal = intel_de_read(display,
+					       TRANS_LLSYM_HTOTAL(display, cpu_transcoder));
+			chunk_size = intel_de_read(display,
+						   TRANS_LLSYM_CHUNK_SIZE(display, cpu_transcoder));
+
+			tg->enable = true;
+			tg->hactive = REG_FIELD_GET(TRANS_LLSYM_HACT_MASK, hact) + 1;
+			tg->htotal = REG_FIELD_GET(TRANS_LLSYM_HTOTAL_MASK, htotal) + 1;
+			tg->chunk_size = REG_FIELD_GET(TRANS_LLSYM_CHUNK_SIZE_MASK, chunk_size);
+		}
+	}
 }
 
 static void intel_joiner_adjust_pipe_src(struct intel_crtc_state *crtc_state)
@@ -3419,6 +3517,10 @@ static void hsw_set_transconf(const struct intel_crtc_state *crtc_state)
 	    crtc_state->output_format != INTEL_OUTPUT_FORMAT_RGB)
 		val |= TRANSCONF_OUTPUT_COLORSPACE_YUV_HSW;
 
+	/* Must be set before the transcoder is enabled, so only on modeset */
+	if (crtc_state->dp_symbol_tg.enable)
+		val |= TRANSCONF_DP_SYMBOL_TG_ENABLE;
+
 	intel_de_write(display, TRANSCONF(display, cpu_transcoder), val);
 	intel_de_posting_read(display, TRANSCONF(display, cpu_transcoder));
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
index d53b7b4a80e75f8cb3a76d923d05648ffe505e2d..fa9ae8799a1999d9dd6a1f4e4d56983b6536ba26 100644
--- a/drivers/gpu/drm/i915/display/intel_display.h
+++ b/drivers/gpu/drm/i915/display/intel_display.h
@@ -446,6 +446,7 @@ void intel_cpu_transcoder_get_m2_n2(struct intel_crtc *crtc,
 				    enum transcoder cpu_transcoder,
 				    struct intel_link_m_n *m_n);
 int intel_dotclock_calculate(int link_freq, const struct intel_link_m_n *m_n);
+void intel_cpu_transcoder_get_llsym_m_n(struct intel_crtc_state *crtc_state);
 int intel_crtc_dotclock(const struct intel_crtc_state *pipe_config);
 int intel_max_uncompressed_dotclock(struct intel_display *display);
 enum intel_display_power_domain intel_port_to_power_domain(struct intel_digital_port *dig_port);

-- 
2.25.1

