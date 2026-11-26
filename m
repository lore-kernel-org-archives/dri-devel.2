Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154ED606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k7rrYfax
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BCE11217B;
	Thu, 26 Nov 2026 08:40:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09AE911216E;
 Thu, 26 Nov 2026 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682433; x=1827218433;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Cj7EoeDARuwS26rgD1zIld/Lh3NjsHTQHrnx+TzngD8=;
 b=k7rrYfaxtC+TT3R9LGE3C29kVNvM30qSPqre6jWnAG1eAutCKrTU53X0
 DVn+KEPrtRj+c3B7PgGxtW6ljgf96yQf4B4llLjO7ILqlRrS1zwJZSbIt
 ZHbda2awRoeWpMl+WZ9PIYtCTLbRtNUddZvyoqSFSvS8rnM3ALS4ijfdI
 3w8zlxzYcy7VYiIwaKIj7CBk/w33ss/V6zOYwYDiSTnvJqfZAd/EjXCag
 bBsaZHK4m2pXu1UWyALehvQBRZmbig0nBxoQtmSAojjMf3pSgxN7AJwDc
 GDEkUxbH9D+ke3GJjL6tRIZF2SyfZI0QwftcvsRLcb/+70MYdgX4Lhbbv w==;
X-CSE-ConnectionGUID: 6D3EEjezS/mdRGvz3qLSmw==
X-CSE-MsgGUID: iqCxeOyBSkWBTkz2B754JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488560"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488560"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:33 -0800
X-CSE-ConnectionGUID: zH6cK1VFSVW96p+n/LMKCA==
X-CSE-MsgGUID: mFXEe2dWQ7aEQP8g9Vu/wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125715"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:30 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:03 +0530
Subject: [PATCH v6 08/13] drm/i915/dp: Don't limit the Link M/N ratio with
 the symbol timing generator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-8-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
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

The limit on the Link M/N ratio only applies to the pixel based timing
generator, there is no such restriction when the symbol based timing
generator is used.

Bspec: 68922
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c     | 20 +++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_dp.h     |  1 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c |  4 +++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 196388800326803fd5b8544af498b0546a1661db..6be2e77c984c1fa13d6896325864f4241c1c1f74 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1275,14 +1275,18 @@ bool intel_dp_has_dsc(const struct intel_connector *connector)
  * SST/MST, but only once all the pieces needed for that are in place, which is
  * done by a later patch.
  */
-static bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr)
+bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr)
 {
 	return false;
 }
 
 static int
-intel_dp_get_max_m_n_ratio(struct intel_display *display)
+intel_dp_get_max_m_n_ratio(struct intel_display *display, bool is_mst, int link_rate)
 {
+	/* No Link M/N ratio limit with the symbol based timing generator */
+	if (intel_dp_use_symbol_tg(display, is_mst, drm_dp_is_uhbr_rate(link_rate)))
+		return INT_MAX;
+
 	if (DISPLAY_VER(display) >= 35)
 		return 22;
 
@@ -1312,7 +1316,9 @@ bool intel_dp_can_support_m_n(struct intel_display *display,
 			      const struct intel_crtc_state *crtc_state,
 			      int pixel_clock, int link_rate)
 {
-	int max_m_n_ratio = intel_dp_get_max_m_n_ratio(display);
+	bool is_mst = crtc_state &&
+		      intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
+	int max_m_n_ratio = intel_dp_get_max_m_n_ratio(display, is_mst, link_rate);
 	enum transcoder cpu_transcoder = TRANSCODER_A;
 	u32 link_m, link_n;
 	int m_n_ratio;
@@ -1335,7 +1341,10 @@ void intel_dp_check_m_n_ratio(const struct intel_crtc_state *crtc_state,
 			      struct intel_link_m_n *m_n)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
-	int max_m_n_ratio = intel_dp_get_max_m_n_ratio(display);
+	int max_m_n_ratio =
+		intel_dp_get_max_m_n_ratio(display,
+					   intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST),
+					   crtc_state->port_clock);
 	int m_n_ratio;
 
 	m_n->bypass_m_n_ratio_limit = false;
@@ -2819,7 +2828,8 @@ intel_dp_compute_m_n_ratio_limits(struct intel_dp *intel_dp,
 		drm_dbg_kms(display->drm,
 			    "[CONNECTOR:%d:%s] No link config with a Link M/N ratio <= %d\n",
 			    connector->base.base.id, connector->base.name,
-			    intel_dp_get_max_m_n_ratio(display));
+			    intel_dp_get_max_m_n_ratio(display, false,
+						       crtc_state->port_clock));
 
 		return false;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 352c656299e3b2d81e0612a71da6247d02b5aa17..929dd099a44aac40bcfa36dbc2e832023a5751f6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -215,6 +215,7 @@ int intel_dp_dsc_min_src_input_bpc(void);
 int intel_dp_dsc_min_src_compressed_bpp(void);
 int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 				const struct drm_connector_state *conn_state);
+bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr);
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
 			       const struct drm_connector_state *conn_state);
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index e8864477ee1fa3ad8313b90dc0f03332a2f77c2d..58ca5312c195e2428b0356da090d540bfb8012ce 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1569,7 +1569,9 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 					   min_link_bpp_x16,
 					   bw_overhead_flags);
 
-	if (!intel_dp_can_support_m_n(display, NULL, mode->clock, max_link_clock)) {
+	/* The symbol based timing generator has no Link M/N ratio limit */
+	if (!intel_dp_use_symbol_tg(display, true, drm_dp_is_uhbr_rate(max_link_clock)) &&
+	    !intel_dp_can_support_m_n(display, NULL, mode->clock, max_link_clock)) {
 		*status = MODE_CLOCK_HIGH;
 		return 0;
 	}

-- 
2.25.1

