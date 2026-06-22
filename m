Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F6DCDB476
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164C110E89A;
	Mon, 22 Jun 2026 21:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c3I+7/C+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50C310E871;
 Mon, 22 Jun 2026 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782164174; x=1813700174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xuk9majFbY0IfOEORsSf0A/SUiblC28wIU018j8DalA=;
 b=c3I+7/C+SlvP8bSIwcvzmiKywpNcXqESkjvxfyEddsWa5LYVLg7+Mrv0
 QSG8gjWMi8By3vech0+Qoqs3YkP4Qtzukaw7/UC60Z7OG5novsApM7RJr
 O5htbPVQUiyGEPYnfngWXUKz8ZDscf7RqiyHIudpfEyt1JbOIWz7Zng+a
 5lhkFsbJf9FGfrKGLg0O1/YKZyMWp73VuhcHAFsfSPjZwznkA/E147t8e
 TuOx0tv11YDSQ54A8bMFrACyxvLFn2BIw8TOQS6ulD0jAfhrmAhaijMRD
 ysewjD8vCjwVeu1eVkggiOBi6tyumMCV9p1zrfLS4Rt2gKAnJIjMVGn0o A==;
X-CSE-ConnectionGUID: ANSIMSuHQnu/olJwcwim7g==
X-CSE-MsgGUID: LAvJt+QoTKenUFO6lQ31Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86812056"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="86812056"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 14:36:14 -0700
X-CSE-ConnectionGUID: kO1vPLiESDWZDkJd+enHzg==
X-CSE-MsgGUID: ioY0VZWrS3uQ3pDMKPheKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="253229815"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.160])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 14:36:12 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH v2 1/5] drm/i915/panel: Split VRR vs. fixed refresh rate fixed
 mode selection into separate stages
Date: Tue, 23 Jun 2026 00:35:58 +0300
Message-ID: <20260622213602.7244-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622213602.7244-1-ville.syrjala@linux.intel.com>
References: <20260622213602.7244-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Split the VRR vs. fixed refresh rate fixed mode selection into two
completely separate stages. First try the VRR method, which will
only accept fixed modes that are in the VRR range and whose refresh
rate is equal or higher to the user's requested mode's refresh rate.
If the VRR method doesn't find anything we fall back to the fixed
refresh rate method of simply looking for the fixed mode with the
closest refresh rate to the user's request.

The main benefit is that we will only perform the VRR vtotal adjustment
on fixed modes that have equal or higher refresh rate to the user's
requested mode, thus we will never end up in a situation where we'd
have to shrink the fixed mode's vtotal. This avoids any risk of ending
up with a vtotal that is too short.

Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 123 ++++++++++++++-------
 1 file changed, 84 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81fb349ece5f..12a27edf8bc8 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -67,21 +67,43 @@ static bool is_best_fixed_mode(struct intel_connector *connector,
 	if (!best_mode)
 		return true;
 
-	/*
-	 * With VRR always pick a mode with equal/higher than requested
-	 * vrefresh, which we can then reduce to match the requested
-	 * vrefresh by extending the vblank length.
-	 */
-	if (intel_vrr_is_in_range(connector, vrefresh) &&
-	    intel_vrr_is_in_range(connector, fixed_mode_vrefresh) &&
-	    fixed_mode_vrefresh < vrefresh)
-		return false;
-
 	/* pick the fixed_mode that is closest in terms of vrefresh */
 	return abs(fixed_mode_vrefresh - vrefresh) <
 		abs(drm_mode_vrefresh(best_mode) - vrefresh);
 }
 
+static const struct drm_display_mode *
+intel_panel_fixed_mode_vrr(struct intel_connector *connector,
+			   const struct drm_display_mode *mode)
+{
+	const struct drm_display_mode *fixed_mode, *best_mode = NULL;
+	int vrefresh = drm_mode_vrefresh(mode);
+
+	if (!intel_vrr_is_in_range(connector, vrefresh))
+		return NULL;
+
+	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head) {
+		int fixed_mode_vrefresh = drm_mode_vrefresh(fixed_mode);
+
+		if (!intel_vrr_is_in_range(connector, fixed_mode_vrefresh))
+			continue;
+
+		/*
+		 * With VRR always pick a mode with equal/higher than requested
+		 * vrefresh, which we can then reduce to match the requested
+		 * vrefresh by extending the vblank length.
+		 */
+		if (fixed_mode_vrefresh < vrefresh)
+			continue;
+
+		if (is_best_fixed_mode(connector, vrefresh,
+				       fixed_mode_vrefresh, best_mode))
+			best_mode = fixed_mode;
+	}
+
+	return best_mode;
+}
+
 const struct drm_display_mode *
 intel_panel_fixed_mode(struct intel_connector *connector,
 		       const struct drm_display_mode *mode)
@@ -197,47 +219,23 @@ enum drrs_type intel_panel_drrs_type(struct intel_connector *connector)
 	return connector->panel.vbt.drrs_type;
 }
 
-int intel_panel_compute_config(struct intel_connector *connector,
-			       struct drm_display_mode *adjusted_mode)
+static int intel_panel_compute_config_vrr(struct intel_connector *connector,
+					  struct drm_display_mode *adjusted_mode)
 {
 	const struct drm_display_mode *fixed_mode =
 		intel_panel_fixed_mode(connector, adjusted_mode);
 	int vrefresh, fixed_mode_vrefresh;
-	bool is_vrr;
 
+	fixed_mode = intel_panel_fixed_mode_vrr(connector, adjusted_mode);
 	if (!fixed_mode)
-		return 0;
+		return -EINVAL;
 
 	vrefresh = drm_mode_vrefresh(adjusted_mode);
 	fixed_mode_vrefresh = drm_mode_vrefresh(fixed_mode);
 
-	/*
-	 * Assume that we shouldn't muck about with the
-	 * timings if they don't land in the VRR range.
-	 */
-	is_vrr = intel_vrr_is_in_range(connector, vrefresh) &&
-		intel_vrr_is_in_range(connector, fixed_mode_vrefresh);
-
-	if (!is_vrr) {
-		/*
-		 * We don't want to lie too much to the user about the refresh
-		 * rate they're going to get. But we have to allow a bit of latitude
-		 * for Xorg since it likes to automagically cook up modes with slightly
-		 * off refresh rates.
-		 */
-		if (abs(vrefresh - fixed_mode_vrefresh) > 1) {
-			drm_dbg_kms(connector->base.dev,
-				    "[CONNECTOR:%d:%s] Requested mode vrefresh (%d Hz) does not match fixed mode vrefresh (%d Hz)\n",
-				    connector->base.base.id, connector->base.name,
-				    vrefresh, fixed_mode_vrefresh);
-
-			return -EINVAL;
-		}
-	}
-
 	drm_mode_copy(adjusted_mode, fixed_mode);
 
-	if (is_vrr && fixed_mode_vrefresh != vrefresh) {
+	if (fixed_mode_vrefresh != vrefresh) {
 		int vsync_start_offset = adjusted_mode->vtotal - adjusted_mode->vsync_start;
 		int vsync_end_offset = adjusted_mode->vtotal - adjusted_mode->vsync_end;
 
@@ -254,6 +252,53 @@ int intel_panel_compute_config(struct intel_connector *connector,
 	return 0;
 }
 
+static int intel_panel_compute_config_fixed_rr(struct intel_connector *connector,
+					       struct drm_display_mode *adjusted_mode)
+{
+	const struct drm_display_mode *fixed_mode;
+	int vrefresh, fixed_mode_vrefresh;
+
+	fixed_mode = intel_panel_fixed_mode(connector, adjusted_mode);
+	if (!fixed_mode)
+		return 0;
+
+	vrefresh = drm_mode_vrefresh(adjusted_mode);
+	fixed_mode_vrefresh = drm_mode_vrefresh(fixed_mode);
+
+	/*
+	 * We don't want to lie too much to the user about the refresh
+	 * rate they're going to get. But we have to allow a bit of latitude
+	 * for Xorg since it likes to automagically cook up modes with slightly
+	 * off refresh rates.
+	 */
+	if (abs(vrefresh - fixed_mode_vrefresh) > 1) {
+		drm_dbg_kms(connector->base.dev,
+			    "[CONNECTOR:%d:%s] Requested mode vrefresh (%d Hz) does not match fixed mode vrefresh (%d Hz)\n",
+			    connector->base.base.id, connector->base.name,
+			    vrefresh, fixed_mode_vrefresh);
+
+		return -EINVAL;
+	}
+
+	drm_mode_copy(adjusted_mode, fixed_mode);
+
+	drm_mode_set_crtcinfo(adjusted_mode, 0);
+
+	return 0;
+}
+
+int intel_panel_compute_config(struct intel_connector *connector,
+			       struct drm_display_mode *adjusted_mode)
+{
+	int ret;
+
+	ret = intel_panel_compute_config_vrr(connector, adjusted_mode);
+	if (ret)
+		ret = intel_panel_compute_config_fixed_rr(connector, adjusted_mode);
+
+	return ret;
+}
+
 static void intel_panel_add_edid_alt_fixed_modes(struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(connector);
-- 
2.53.0

