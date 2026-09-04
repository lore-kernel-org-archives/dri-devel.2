Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D5C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F0710E60A;
	Sat,  5 Sep 2026 15:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GpGhdHhZ";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC4F10FAE3
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:02:36 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-46ad7304688so1935066fac.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523355; x=1789128155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MSrHHKF/QU1b/Dh6LeXUkOxqaikEIYdeQRpXfVfhK+M=;
 b=GpGhdHhZ8lMttt50rG3tr/pN0hSyn6xU0KHDJxITMANhL/JMpnQTuEOgv3cRz1SHr2
 EQDXSljewVX42xM1pF7M39K1HBxG1/jcFYf1yJhEC0pZeaTHp2HY8DA/DHqdMM4zY2LD
 OOtIOknesks0uy+wvaXTCo1aqWVcOYNfUSUOnwJBsKHI5IkWRv6cigT/FpubugWxoUnC
 zWLXAN9Eu7IR37RTaRZOXQVnDYeiIGXruDE6e5wE8apqty8Bs3Sadk2zqlD32rTihHfL
 FE1HTb0C6RqoWAYDciyDrhuN8M8wsmHV1tDtStpmbbuEALdC0iYS/bIsrrvtN5zJ407u
 VEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523355; x=1789128155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MSrHHKF/QU1b/Dh6LeXUkOxqaikEIYdeQRpXfVfhK+M=;
 b=Yfm/GCFFCqfxMEc4H+VCCEuAYBDzDsCszWFfYW2FpzY8K0h/unbrf2v6MUest9QybF
 FFUrtXYtMHGAJXKw6gtbxWiMkGZ9lIBuSx/qPTPmRp66es1265YjXGrLROPirTC+Cpu3
 2RTI4+QfkfTOtjAPt2w+EyIlHr50TAqzLfkXBEMImptOY7dH8fXOfA2btYHxxb4YYQ8/
 xpFByxhd1v/Kh5QHyY5Nk76gT+grzTPQqARNOP+gMgiERq5EttZU5hB/YBVYjRGOhg6Z
 N+X+y3dYM1eRdvLEuzHSiM5JNFSck7c6SlJnHnTDHQCay8ZVGLK9ZSw+tM0ynvARplI0
 OfiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTyDlfkDDWVz0mTIdjpaluIbIn6lXzd+jun5QL1NQ8i1s4h9v6bekoSs7V+0/dkRqSVaDW3jAzrws=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltS6cCJM5cd2c+AkLJJQzY1QVdNY3FH4uwoSL4AsOwZ4yHn0Fa
 v5DrNkzIaHAFnrR32jXgcAW3GW8gD0dFxTz4K/SY4OQcOqUNWW0ClXpX
X-Gm-Gg: AYBFou0j1iHimUl4a2pAkzdt7pc85NDqdOkPtmi42+FD/WXFnrSD/cn/8oM0dF0vSIo
 BzZunGKdgfsH0/7KmqaIF9IuiH1c4ic0cOmzfTtXQxZ2auKnOC0jSHjbTnSyzrOadqqmi6nVXun
 ObDoFUPlIZe+sykxBRAiCyWZaJT2vwo+AaZt/a6abhSrh5Kt+0DaQ+PLM4BCRzmSFMXuknSY5h7
 A/vYxVSPU1FgE771sg5peUM+hN67Fb6FvfYVSqdU4VunCAHny8d2cyX13p6DbEQkWeV614seS9m
 Dk8wdb00tgfUlQd7r0aLVb+V38oDDbcse0t5pwzfsJbhGMErwWdrAP5pB7PbxIKT/CWeTFiraFT
 +5bIKsNKhajvDge98XrI134jkkdIXtiy9gfWH38YioR7vHExv0qhcZ5TC84aXvA68DXbidKSL9W
 N4ASHQC5+9lBW9nTP/sNVa47Zht63SBRU4vEFgbgNIcxEhtz9n0WKYlhqzYkP25IXHOdAvTwWMv
 a+qyrt/U2llTaCe44u0uRYbQ+8=
X-Received: by 2002:a05:6820:1791:b0:6b7:f498:cec3 with SMTP id
 006d021491bc7-6b7f498e151mr266433eaf.35.1788523355085; 
 Fri, 04 Sep 2026 05:02:35 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432435648esm7713194c88.5.2026.09.04.05.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:02:34 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/i915: fix typos in comments
Date: Fri,  4 Sep 2026 17:32:20 +0530
Message-ID: <20260904120225.15868-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120225.15868-1-hemanth.selam@gmail.com>
References: <20260904120225.15868-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c      | 2 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c   | 2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c   | 4 ++--
 drivers/gpu/drm/i915/display/intel_vdsc.c   | 2 +-
 drivers/gpu/drm/i915/display/intel_vrr.c    | 2 +-
 drivers/gpu/drm/i915/display/skl_scaler.c   | 2 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c      | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 drivers/gpu/drm/i915/gt/intel_migrate.c     | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ea0cdb7822f3..d2b1a0b68260 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -958,7 +958,7 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	/* TRANS_HSYNC register to be programmed only for video mode */
 	if (is_vid_mode(intel_dsi)) {
 		if (intel_dsi->video_mode == NON_BURST_SYNC_PULSE) {
-			/* BSPEC: hsync size should be atleast 16 pixels */
+			/* BSPEC: hsync size should be at least 16 pixels */
 			if (hsync_size < 16)
 				drm_err(display->drm,
 					"hsync size < 16 pixels\n");
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e56df337dc6d..0003dd7b106b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -787,7 +787,7 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
 
 	/*
 	 * When V prime mismatches, DP Spec mandates re-read of
-	 * V prime atleast twice.
+	 * V prime at least twice.
 	 */
 	for (i = 0; i < tries; i++) {
 		ret = intel_hdcp_validate_v_prime(connector, shim,
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 8a019d3574df..59af06443476 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3234,7 +3234,7 @@ intel_hdmi_dsc_get_num_slices(const struct intel_crtc_state *crtc_state,
 #define HDMI_DSC_PEAK_PIXEL_RATE		2720000
 /*
  * Rates at which the source and sink are required to process pixels in each
- * slice, can be two levels: either atleast 340000KHz or atleast 40000KHz.
+ * slice, can be two levels: either at least 340000KHz or at least 40000KHz.
  */
 #define HDMI_DSC_MAX_ENC_THROUGHPUT_0		340000
 #define HDMI_DSC_MAX_ENC_THROUGHPUT_1		400000
@@ -3267,7 +3267,7 @@ intel_hdmi_dsc_get_num_slices(const struct intel_crtc_state *crtc_state,
 
 	/*
 	 * As per spec, the rate at which the source and the sink process
-	 * the pixels per slice are at two levels: atleast 340Mhz or 400Mhz.
+	 * the pixels per slice are at two levels: at least 340Mhz or 400Mhz.
 	 * This depends upon the pixel clock rate and output formats
 	 * (kslice adjust).
 	 * If pixel clock * kslice adjust >= 2720MHz slices can be processed
diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
index 8f06c3a4d56d..e61808dc2ce6 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.c
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
@@ -378,7 +378,7 @@ int intel_dsc_compute_params(struct intel_crtc_state *pipe_config)
 
 	/*
 	 * From XE_LPD onwards we supports compression bpps in steps of 1
-	 * upto uncompressed bpp-1, hence add calculations for all the rc
+	 * up to uncompressed bpp-1, hence add calculations for all the rc
 	 * parameters
 	 *
 	 * We don't want to calculate all rc parameters when the panel
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 51e4f3309b8b..4e1e849ab150 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -46,7 +46,7 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 	/*
 	 * DP Sink is capable of VRR video timings if
 	 * Ignore MSA bit is set in DPCD.
-	 * EDID monitor range also should be atleast 10 for reasonable
+	 * EDID monitor range also should be at least 10 for reasonable
 	 * Adaptive Sync or Variable Refresh Rate end user experience.
 	 */
 	switch (connector->base.connector_type) {
diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index 7994b983d509..066fb0587aa3 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -194,7 +194,7 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 
 	/*
 	 * if plane is being disabled or scaler is no more required or force detach
-	 *  - free scaler binded to this plane/crtc
+	 *  - free scaler bound to this plane/crtc
 	 *  - in order to do this, update crtc->scaler_usage
 	 *
 	 * Here scaler state in crtc_state is set free so that
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 8829f365592e..693084164713 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1028,7 +1028,7 @@ static void bxt_dsi_get_pipe_config(struct intel_encoder *encoder,
 	adjusted_mode_sw = &crtc->config->hw.adjusted_mode;
 
 	/*
-	 * Atleast one port is active as encoder->get_config called only if
+	 * At least one port is active as encoder->get_config called only if
 	 * encoder->get_hw_state() returns true.
 	 */
 	for_each_dsi_port(port, intel_dsi->ports) {
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index c58ffa5a8fa6..ee9d2991f162 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1378,7 +1378,7 @@ static struct intel_engine_cs *active_engine(struct intel_context *ce)
 	list_for_each_entry_reverse(rq, &ce->timeline->requests, link) {
 		bool found;
 
-		/* timeline is already completed upto this point? */
+		/* timeline is already completed up to this point? */
 		if (!i915_request_get_rcu(rq))
 			break;
 
diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
index aff5aca591e6..86927e0c76e2 100644
--- a/drivers/gpu/drm/i915/gt/intel_migrate.c
+++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
@@ -643,7 +643,7 @@ calculate_chunk_sz(struct drm_i915_private *i915, bool src_is_lmem,
 {
 	if (ccs_bytes_to_cpy && !src_is_lmem)
 		/*
-		 * When CHUNK_SZ is passed all the pages upto CHUNK_SZ
+		 * When CHUNK_SZ is passed all the pages up to CHUNK_SZ
 		 * will be taken for the blt. in Flat-ccs supported
 		 * platform Smem obj will have more pages than required
 		 * for main memory hence limit it to the required size
-- 
2.48.1

