Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11159C98306
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 05:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C0510E5AC;
	Fri, 25 Sep 2026 05:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P2c+kC/h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BCF10E0FB;
 Fri, 25 Sep 2026 05:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790313751; x=1821849751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x28N74LYipHfq6ue5vmW3eEN28yZ+FZR2VLLmGD2xlQ=;
 b=P2c+kC/hpwkOq7/FiRXMeUzCT2d9syGocm+wICTccButL3Tg87uGVxKz
 svSiLXWJkaRTciBM7VgBAXVkBlf7xo7LeXBQeXLT1wa7dcHvFg1X4yoGq
 lDHQueSB2KgbPFqlYKfR0EdZxOfHsk4lGx4uYpa3flwYo35aJ0mQrUnjL
 xA5pu+zlOPfACkhmcwZikv0lzs+ZlIw0r9rOMxtcxMZ4zWV3Q3A+a2wiQ
 B1iBKzI+AGdjl5UoLati3fUmbOApvjt/azhvudpNwmms6c+Ukgn30HMn4
 4smW7QkuZ2NhQnR4SoFQBP6WMgGUZlbMoiqkoUS5KPPdCvpXru5QYM4QF A==;
X-CSE-ConnectionGUID: bVy+CSlHQqyyK2DcxSlH3g==
X-CSE-MsgGUID: S89kFF4MTJSO8WTfDqntlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89959969"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="89959969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 22:22:31 -0700
X-CSE-ConnectionGUID: 0Oe/psGQTDa22zeemYsHSg==
X-CSE-MsgGUID: NnCtelh+SFmr7uIBsFtlHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="303747866"
Received: from gdsworo-desk4-x299-aorus-gaming-3-pro.jf.intel.com
 ([10.54.67.206])
 by orviesa002.jf.intel.com with ESMTP; 24 Sep 2026 22:22:31 -0700
From: "George D. Sworo" <george.d.sworo@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 "George D. Sworo" <george.d.sworo@intel.com>
Subject: [PATCH v3] drm/i915/hdcp: Fail fast when HDCP Type 1 is unsupported
 via MST
Date: Thu, 24 Sep 2026 22:26:10 -0700
Message-ID: <20260925052703.2068117-1-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925035639.2034315-1-george.d.sworo@intel.com>
References: <20260925035639.2034315-1-george.d.sworo@intel.com>
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

HDCP Content Type 1 requires HDCP 2.x support from both the source and
the downstream MST sink. A request for a sink that supports HDCP 1.x but
cannot use HDCP 2.x currently passes atomic validation and fails later in
the HDCP enable path.

Query the downstream sink through its MST remote AUX channel during HDCP
initialization. Cache the result only when the sink reports HDCP support
and either the source or sink lacks HDCP 2.x. Treat a missing callback,
probe failure, or no reported HDCP support as unknown and non-fatal.

Use the cached result to reject unsupported Content Type 1 requests with
-EOPNOTSUPP in intel_hdcp_atomic_check(), and propagate the error through
the digital connector atomic check. This keeps remote AUX transactions
out of the atomic check path.

Signed-off-by: George D. Sworo <george.d.sworo@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index b66c2d4ba2b3..c6383e27e62b 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -123,8 +123,12 @@ int intel_digital_connector_atomic_check(struct drm_connector *conn,
 	struct intel_digital_connector_state *old_conn_state =
 		to_intel_digital_connector_state(old_state);
 	struct drm_crtc_state *crtc_state;
+	/* Propagate HDCP capability failures during atomic validation. */
+	int ret;
 
-	intel_hdcp_atomic_check(conn, old_state, new_state);
+	ret = intel_hdcp_atomic_check(conn, old_state, new_state);
+	if (ret)
+		return ret;
 
 	if (!new_state->crtc)
 		return 0;
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 79f30660c2b6..1c169849e502 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -605,6 +605,8 @@ struct intel_connector {
 	struct {
 		struct drm_dp_mst_port *port;
 		struct intel_dp *dp;
+		/* Used to reject unsupported HDCP Type1 requests during atomic check. */
+		bool type1_unsupported;
 	} mst;
 
 	struct {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 7023619aaaba..da54699fb121 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1838,6 +1838,7 @@ mst_topology_add_connector(struct drm_dp_mst_topology_mgr *mgr,
 	connector->sync_state = intel_dp_connector_sync_state;
 	connector->mst.dp = intel_dp;
 	connector->mst.port = port;
+	connector->mst.type1_unsupported = false;
 	drm_dp_mst_get_port_malloc(port);
 
 	ret = drm_connector_dynamic_init(display->drm, &connector->base, &mst_connector_funcs,
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e56df337dc6d..b6f28dc3e5c4 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -312,6 +312,39 @@ static void intel_hdcp_get_remote_capability(struct intel_connector *connector,
 		*hdcp2_capable = false;
 }
 
+/* Determine whether atomic check should reject Type1 for this MST sink. */
+static bool
+intel_hdcp_mst_type1_is_unsupported(struct intel_connector *connector,
+				    const struct intel_hdcp_shim *shim)
+{
+	struct intel_hdcp *hdcp = &connector->hdcp;
+	bool hdcp_capable = false, hdcp2_capable = false;
+	int ret;
+
+	if (!shim->get_remote_hdcp_capability)
+		return false;
+
+	ret = shim->get_remote_hdcp_capability(connector, &hdcp_capable,
+						   &hdcp2_capable);
+	if (ret)
+		return false;
+
+	return hdcp_capable && (!hdcp->hdcp2_supported || !hdcp2_capable);
+}
+
+static void
+intel_hdcp_mst_update_type1_capability(struct intel_connector *connector,
+					       const struct intel_hdcp_shim *shim)
+{
+	connector->mst.type1_unsupported = false;
+
+	if (!shim || !shim->get_remote_hdcp_capability)
+		return;
+
+	connector->mst.type1_unsupported =
+		intel_hdcp_mst_type1_is_unsupported(connector, shim);
+}
+
 static bool intel_hdcp_in_use(struct intel_display *display,
 			      enum transcoder cpu_transcoder, enum port port)
 {
@@ -2421,6 +2454,9 @@ int intel_hdcp_init(struct intel_connector *connector,
 	if (is_hdcp2_supported(display))
 		intel_hdcp2_init(connector, dig_port, shim);
 
+	/* Cache the capability for the currently attached MST sink only. */
+	intel_hdcp_mst_update_type1_capability(connector, shim);
+
 	ret = drm_connector_attach_content_protection_property(&connector->base,
 							       hdcp->hdcp2_supported);
 	if (ret) {
@@ -2652,6 +2688,8 @@ void intel_hdcp_cleanup(struct intel_connector *connector)
 {
 	struct intel_hdcp *hdcp = &connector->hdcp;
 
+	connector->mst.type1_unsupported = false;
+
 	if (!hdcp->shim)
 		return;
 
@@ -2684,10 +2722,11 @@ void intel_hdcp_cleanup(struct intel_connector *connector)
 	mutex_unlock(&hdcp->mutex);
 }
 
-void intel_hdcp_atomic_check(struct drm_connector *connector,
-			     struct drm_connector_state *old_state,
-			     struct drm_connector_state *new_state)
+int intel_hdcp_atomic_check(struct drm_connector *connector,
+			    struct drm_connector_state *old_state,
+			    struct drm_connector_state *new_state)
 {
+	struct intel_connector *intel_connector = to_intel_connector(connector);
 	u64 old_cp = old_state->content_protection;
 	u64 new_cp = new_state->content_protection;
 	struct drm_crtc_state *crtc_state;
@@ -2700,7 +2739,20 @@ void intel_hdcp_atomic_check(struct drm_connector *connector,
 		if (old_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
 			new_state->content_protection =
 				DRM_MODE_CONTENT_PROTECTION_DESIRED;
-		return;
+		return 0;
+	}
+
+	/*
+	 * Fail fast if userspace asks for Type1 but neither the platform nor
+	 * the downstream sink can do HDCP 2.x, instead of only discovering
+	 * this once intel_hdcp_enable() is reached.
+	 */
+	if (new_cp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	    new_state->hdcp_content_type == DRM_MODE_HDCP_CONTENT_TYPE1 &&
+	    intel_connector->mst.type1_unsupported) {
+		drm_dbg_kms(connector->dev,
+			    "HDCP Type1 requested without HDCP 2.x support\n");
+		return -EOPNOTSUPP;
 	}
 
 	crtc_state = drm_atomic_get_new_crtc_state(new_state->state,
@@ -2725,10 +2777,12 @@ void intel_hdcp_atomic_check(struct drm_connector *connector,
 	     new_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)) {
 		if (old_state->hdcp_content_type ==
 				new_state->hdcp_content_type)
-			return;
+			return 0;
 	}
 
 	crtc_state->mode_changed = true;
+
+	return 0;
 }
 
 /* Handles the CP_IRQ raised from the DP HDCP sink */
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.h b/drivers/gpu/drm/i915/display/intel_hdcp.h
index efe86808e17e..34661b074784 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.h
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.h
@@ -22,9 +22,9 @@ struct intel_hdcp_shim;
 struct seq_file;
 enum port;
 
-void intel_hdcp_atomic_check(struct drm_connector *connector,
-			     struct drm_connector_state *old_state,
-			     struct drm_connector_state *new_state);
+int intel_hdcp_atomic_check(struct drm_connector *connector,
+			    struct drm_connector_state *old_state,
+			    struct drm_connector_state *new_state);
 int intel_hdcp_init(struct intel_connector *connector,
 		    struct intel_digital_port *dig_port,
 		    const struct intel_hdcp_shim *hdcp_shim);
-- 
2.43.0


Thanks for the review.

You are right: the cached Type1 capability is only valid for the current MST sink,
and it must not outlive a hotplug or topology change. I've updated the patch to
clear the cached value when a new MST connector is created and when it is torn
down, and to refresh it only for the active sink.

This keeps the atomic check AUX-free while avoiding stale results across MST
hotplug events.
