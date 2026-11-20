Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F3606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RmJ8xiwZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1189410FE82;
	Fri, 20 Nov 2026 05:12:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C240210FE82;
 Fri, 20 Nov 2026 05:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795151519; x=1826687519;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=TNkeVE4H/t6x9zLQe4RNI9R9/O6XANZSZP+0AUK6gY0=;
 b=RmJ8xiwZ0DuNhIRd1xwXSeR5V6rkARDjmWxJyuheEL5IXJFdfUh1KOSX
 0bK2Y1KsMLKD31+LE3b8R5xyfiOXG51Ap0a5TFupqobGajkZKG2dR/Tlx
 1g1j2O9bQKR1rojUTJFEJ8R4z4fHQgK2aRWImwLgTbZteiMr5TFsNdnua
 wciDC8ue0UMiYCdmmoTVgdaacLI546avEyw6XvlSLX7t77qLuCngYZUe9
 x8PXLQcOcCowfwzMfaXb5ubZCcSr2Ix6BwtSuV/2X+YtBkCIY8ZL6lGSF
 bKkLDwAUzJQLkextz/YZW0xoaCgM1D/y8w0xa3qiZEifeq6LUcGszzXvY w==;
X-CSE-ConnectionGUID: eGQLuXgQQ3iQgv2h0rRmbw==
X-CSE-MsgGUID: fNvZQaoDSkGHavhSugO8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3907501"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3907501"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:11:58 -0800
X-CSE-ConnectionGUID: tjuv1bCdQ/WLv12MRTfO2A==
X-CSE-MsgGUID: I8uF9mAETVqEXezdhMzqzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10607354"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2026 21:11:55 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Fri, 20 Nov 2026 10:36:12 +0530
Subject: [PATCH v5 13/13] drm/i915/dp: Enable the DP symbol TG, with a
 debugfs knob to disable it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vlk-64036-dp-symbol-tg-v5-13-bf8f78b32709@intel.com>
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

Enable symbol TG for 8b/10b MST and 128b/132b SST/MST on the platforms
supporting it.

Keep a debugfs knob, enable_dp_symbol_tg, to still select the pixel based
timing generator, for the case of a sink having issues with the symbol
based one, or for debugging purpose.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 .../gpu/drm/i915/display/intel_display_params.h    |  6 ++++
 drivers/gpu/drm/i915/display/intel_dp.c            | 32 ++++++++++------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
index 5c5a1a1358c32a08a460bdb81da76c3682827ab9..503eef8cf744fbf802bcf86d25f581871fcc3f8c 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.h
+++ b/drivers/gpu/drm/i915/display/intel_display_params.h
@@ -56,6 +56,12 @@ struct drm_printer;
 	 * in intel_display_params.c on purpose. Runtime-toggle via debugfs.
 	 */ \
 	param(bool, enable_periodic_assdp, false, 0600) \
+	/*
+	 * Debugfs-only knob (per-device), to fall back to the pixel based DP timing
+	 * generator, if a sink has issues with the symbol based one. Applies to the
+	 * next modeset or mode validation.
+	 */ \
+	param(bool, enable_dp_symbol_tg, true, 0600) \
 
 #define MEMBER(T, member, ...) T member;
 struct intel_display_params {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 217b5d1e082f2bb9ee15773e382c528700671584..d312b82253b89359958ac326121121c0ef225e97 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1271,13 +1271,13 @@ bool intel_dp_has_dsc(const struct intel_connector *connector)
 }
 
 /*
- * The symbol based timing generator is to be used for 8b/10b MST and 128b/132b
- * SST/MST, but only once all the pieces needed for that are in place, which is
- * done by a later patch.
+ * The symbol based timing generator is used for 8b/10b MST and 128b/132b
+ * SST/MST, unless disabled by the enable_dp_symbol_tg debugfs knob.
  */
 bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr)
 {
-	return false;
+	return HAS_DP_SYMBOL_TG(display) && display->params.enable_dp_symbol_tg &&
+		(is_mst || is_uhbr);
 }
 
 static int
@@ -4004,7 +4004,7 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 
 	/* MSO is only used with 8b/10b SST, where the symbol TG isn't used */
 	if (drm_WARN_ON(display->drm, crtc_state->splitter.enable))
-		return 0;
+		return -EINVAL;
 
 	ret = intel_dp_compute_dsc_slices_and_link_bpp(crtc_state, connector,
 						       &dsc_slices, &link_bpp_x16);
@@ -4019,12 +4019,11 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 	hblank_cycles = cycles.hblank;
 	chunk_cycles = cycles.chunk;
 
-	if (!intel_dp_symbol_tg_cycles_in_range(&cycles)) {
-		drm_dbg_kms(display->drm,
-			    "LL symbol timings out of range (hactive %d, hblank %d, chunk %d), using pixel TG\n",
-			    hactive_cycles, hblank_cycles, chunk_cycles);
-		return 0;
-	}
+	/* The link config search already checked that the timings fit. */
+	if (drm_WARN(display->drm, !intel_dp_symbol_tg_cycles_in_range(&cycles),
+		     "LL symbol timings out of range (hactive %d, hblank %d, chunk %d)\n",
+		     hactive_cycles, hblank_cycles, chunk_cycles))
+		return -EINVAL;
 
 	if (is_uhbr) {
 		ch_num = 1568768;
@@ -4077,12 +4076,11 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 				     (u64)ch_num * (ssc_num / ssc_gcd),
 				     data_n[ssc]);
 
-		if (intel_dp_cmp_u128(data_m[ssc], data_n[ssc]) > 0) {
-			drm_dbg_kms(display->drm,
-				    "LL symbol data M/N ratio exceeds 1.0 (SSC %s), using pixel TG\n",
-				    str_enabled_disabled(ssc));
-			return 0;
-		}
+		/* The link config search already checked that the stream fits. */
+		if (drm_WARN(display->drm, intel_dp_cmp_u128(data_m[ssc], data_n[ssc]) > 0,
+			     "LL symbol data M/N ratio exceeds 1.0 (SSC %s)\n",
+			     str_enabled_disabled(ssc)))
+			return -EINVAL;
 	}
 
 	tg->enable = true;

-- 
2.25.1

