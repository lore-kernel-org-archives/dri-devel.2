Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC0AC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB6F10F858;
	Fri, 25 Sep 2026 04:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OC/2zjMn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F86510F858;
 Fri, 25 Sep 2026 04:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790312337; x=1821848337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Dkk4oJwvZCcswUWqzOd3RRTYzoakF3bQMXeNMULP0M=;
 b=OC/2zjMnEiJyGAikloD08vYiobKChh4Bj6MTsQ5y37bjaT/3BaULkEKd
 bz1H7DL9eS30hFzL2uhS214kC3/6L7qgoDpPPPQejeMhbicS4NGrw7rgb
 7QEiJVbsrTaE5g4cYbs67pOiy1UINaUTddX5rJX7uFg7NhwBoK8TI34wi
 exZiL++IFDt6EQeEkMC+H0WIGlomN35P17yoCmTtLjxAkpQj7Dv40fEnk
 PPtfTj/00ZO/qPkFlKRxPgcEnM1qN1fvC4agKlPs2ktG0k4IrBqjHQb5d
 k05WPT/eX+QACXFMC2h8jMgJX+cW1HU5hSaGbpg0a6ipSdLFQJBHp10QY Q==;
X-CSE-ConnectionGUID: IY12S4wNTmiTXdXlzNlKoQ==
X-CSE-MsgGUID: qJ3hKpf9TOufUHvM10u8Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90001724"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="90001724"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 21:58:55 -0700
X-CSE-ConnectionGUID: Uq+QI5DKSRqGK1FfB7M2Ag==
X-CSE-MsgGUID: MAUwL8XoSHuAkToy9F6uyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="273785851"
Received: from gdsworo-desk4-x299-aorus-gaming-3-pro.jf.intel.com
 ([10.54.67.206])
 by orviesa007.jf.intel.com with ESMTP; 24 Sep 2026 21:58:55 -0700
From: "George D. Sworo" <george.d.sworo@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 "George D. Sworo" <george.d.sworo@intel.com>
Subject: [PATCH v2] drm/i915/hdcp: refresh MST Type1 capability per sink
Date: Thu, 24 Sep 2026 22:03:10 -0700
Message-ID: <20260925050310.2058392-1-george.d.sworo@intel.com>
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

Thanks for the review.

You are right: the cached Type1 capability is only valid for the current MST sink,
and it must not outlive a hotplug or topology change. I've updated the patch to
clear the cached value when a new MST connector is created and when it is torn
down, and to refresh it only for the active sink.

This keeps the atomic check AUX-free while avoiding stale results across MST
hotplug events.

HDCP Content Type 1 requires HDCP 2.x support from both the source and
the downstream MST sink. A request for a sink that supports HDCP 1.x but
cannot use HDCP 2.x currently passes atomic validation and fails later in
the HDCP enable path.

Use the refreshed per-sink capability to reject unsupported Type1 requests
with -EOPNOTSUPP in intel_hdcp_atomic_check(), and propagate the error through
the digital connector atomic check.

Signed-off-by: George D. Sworo <george.d.sworo@intel.com>
---
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
@@ -332,6 +332,19 @@ intel_hdcp_mst_type1_is_unsupported(struct intel_connector *connector,
 	return hdcp_capable && (!hdcp->hdcp2_supported || !hdcp2_capable);
 }
 
+static void
+intel_hdcp_mst_update_type1_capability(struct intel_connector *connector,
+						       const struct intel_hdcp_shim *shim)
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
@@ -2441,9 +2454,8 @@ int intel_hdcp_init(struct intel_connector *connector,
 	if (is_hdcp2_supported(display))
 		intel_hdcp2_init(connector, dig_port, shim);
 
-	/* Cache the remote capability before atomic checks can run. */
-	connector->mst.type1_unsupported =
-		intel_hdcp_mst_type1_is_unsupported(connector, shim);
+	/* Cache the capability for the currently attached MST sink only. */
+	intel_hdcp_mst_update_type1_capability(connector, shim);
 
 	ret = drm_connector_attach_content_protection_property(&connector->base,
 											   hdcp->hdcp2_supported);
@@ -2676,6 +2688,8 @@ void intel_hdcp_cleanup(struct intel_connector *connector)
 {
 	struct intel_hdcp *hdcp = &connector->hdcp;
 
+	connector->mst.type1_unsupported = false;
+
 	if (!hdcp->shim)
 		return;
