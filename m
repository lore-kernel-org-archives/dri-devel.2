Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5F606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IqJ1pQ6w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D74610ECB9;
	Fri, 20 Nov 2026 05:11:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502CA10ECB9;
 Fri, 20 Nov 2026 05:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795151492; x=1826687492;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=vqh2mdVcAKk0JQ+pHO0CvxmOT6NCeC0umd824YC+fCg=;
 b=IqJ1pQ6wnVQCA9kHi5qoSH80+OAT4zsbryqKTbd+a77O7WRF+hCJezvj
 hPTaM1rtflAtmCSvD04vLDg1vvloHiMU+Kp4A6M+Q8yKBK+xFoh4/1yHd
 nJZs29VOP7MpBMnnWe29XFoauWTTtJ6IR2E5Acc2bHs5lFa1R3tZEaYgR
 aN9cQwZ2opiVsRHDJP5VcECxQW2nCKXUfMqfuxXPT/oGge+wwlVEjqiDG
 pkbZkdxwtTyxpyACO9qPGaMuPIQdx3DLmcMGae5APMxBsJlZBvG4Bwu4o
 5Dw9imt4fbBwo+5jg6S3Sh6sCgSd5KKcqx/HnemiGXtRSM2EpXnLH1pts w==;
X-CSE-ConnectionGUID: JH02aBrHR06cVZo7PGmhMw==
X-CSE-MsgGUID: hLK8xO84SoGfhCoiLQr43g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3907436"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3907436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:11:32 -0800
X-CSE-ConnectionGUID: jyn12b5AQQKyGk6ZQVk23A==
X-CSE-MsgGUID: Nvpw2YnEQmmlN6c2bp/4EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10607120"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2026 21:11:29 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Fri, 20 Nov 2026 10:36:02 +0530
Subject: [PATCH v5 03/13] drm/i915/display: Add the DP symbol timing
 generator crtc state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vlk-64036-dp-symbol-tg-v5-3-bf8f78b32709@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the DP link layer (LL) symbol based timing generator parameters to
the crtc state. Dump them in the crtc state dump and compare them in
the pipe config checker.

Bspec: 68922
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_display.c       | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_display_types.h | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c b/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c
index c51b21222dc6e7c0e6621b903fa0c04cb7508b60..2e10c9a5bba63b026d1ce02e4e1580fb5aeecb02 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c
@@ -262,6 +262,17 @@ void intel_crtc_state_dump(const struct intel_crtc_state *pipe_config,
 			   pipe_config->dip.pps_sdp_tl,
 			   pipe_config->dip.vsc_sdp_tl,
 			   pipe_config->dip.vsc_ext_sdp_tl);
+
+		drm_printf(&p,
+			   "dp symbol tg: %s, hactive: %d, htotal: %d, chunk size: %d, data m: 0x%016llx%016llx, data n: 0x%016llx%016llx\n",
+			   str_enabled_disabled(pipe_config->dp_symbol_tg.enable),
+			   pipe_config->dp_symbol_tg.hactive,
+			   pipe_config->dp_symbol_tg.htotal,
+			   pipe_config->dp_symbol_tg.chunk_size,
+			   pipe_config->dp_symbol_tg.data_m[1],
+			   pipe_config->dp_symbol_tg.data_m[0],
+			   pipe_config->dp_symbol_tg.data_n[1],
+			   pipe_config->dp_symbol_tg.data_n[0]);
 	}
 
 	drm_printf(&p, "audio: %i, infoframes: %i, infoframes enabled: 0x%x\n",
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index afe70e9ce34739b67e4d87754f9c361ff77f37a6..7caf5bee8718729667376b487b0584b47891f05a 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5515,6 +5515,17 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 
 	PIPE_CONF_CHECK_I(min_hblank);
 
+	PIPE_CONF_CHECK_BOOL(dp_symbol_tg.enable);
+	if (pipe_config->dp_symbol_tg.enable) {
+		PIPE_CONF_CHECK_I(dp_symbol_tg.hactive);
+		PIPE_CONF_CHECK_I(dp_symbol_tg.htotal);
+		PIPE_CONF_CHECK_I(dp_symbol_tg.chunk_size);
+		PIPE_CONF_CHECK_LLI(dp_symbol_tg.data_m[0]);
+		PIPE_CONF_CHECK_LLI(dp_symbol_tg.data_m[1]);
+		PIPE_CONF_CHECK_LLI(dp_symbol_tg.data_n[0]);
+		PIPE_CONF_CHECK_LLI(dp_symbol_tg.data_n[1]);
+	}
+
 	if (HAS_DOUBLE_BUFFERED_M_N(display)) {
 		if (!fastset || !pipe_config->update_m_n)
 			PIPE_CONF_CHECK_M_N(dp_m_n);
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index d0748837ce97ce6291b36adeb0014686f7d699f9..ee4152afb86dbe1ad041d4d99c058bdb97932350 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1196,6 +1196,28 @@ struct intel_crtc_state {
 	int max_pipe_bpp;	/* in 1 bpp units */
 	int pipe_bpp;		/* in 1 bpp units */
 	int min_hblank;
+
+	/* DP link layer (LL) symbol based timing generator, 8b/10b MST and 128b/132b SST/MST */
+	struct intel_dp_symbol_tg {
+		bool enable;
+		/* in LL symbol cycles, as opposed to the zero based register values */
+		u16 hactive;
+		u16 htotal;
+		u16 chunk_size;
+		/* 128 bit Data M/N as {low 64 bits, high 64 bits}, the one for the active PLL */
+		u64 data_m[2];
+		u64 data_n[2];
+		/*
+		 * The Data M/N depends on if the PLL uses SSC, which is known only
+		 * once the active PLL is selected. These are the computed values,
+		 * for the SSC disabled (0) and SSC enabled (1) case.
+		 */
+		struct intel_dp_symbol_tg_mn {
+			u64 data_m[2];
+			u64 data_n[2];
+		} mn[2];
+	} dp_symbol_tg;
+
 	struct intel_link_m_n dp_m_n;
 
 	/* m2_n2 for eDP downclock */

-- 
2.25.1

