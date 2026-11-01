Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BF606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sz3nt1Ch
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C5010E164;
	Sun,  1 Nov 2026 03:38:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8205010E164;
 Sun,  1 Nov 2026 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793504274; x=1825040274;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VB+Sh8ze+N2sL7K2IkIGPTCaXuoXqJWWhCPkLkhvbpY=;
 b=Sz3nt1CheTprxv9xQHwoh24QgjR1faGPUyTuP58HaPLsArulfgeUUYQO
 0hK3YcdICaQrhXUZVC9wjOaFAjgUQzVdmskvgUUtzK/wE1fRshAxYryCN
 OmHbegsmyJeJBFCX4FORvBmNZmDx1hs3CLXfAJhwjrTDSbXcO3JKanTCm
 8xJfcyLNeJl2I5UoNlfZfs+6h/b1+1brWhMIEJm5Y7JhSc9VVJhAhuuaI
 +Sfkxgyde+518ox3yCJdxWrYXaaXAcYUd6qGDH62gKuZdMyR4njg5rdx6
 BkMLd5C8pv9Nznr6aPgNOLWOiJcguqJ1zg/pbd2Z9hfYLpJpVuxFSiG0i w==;
X-CSE-ConnectionGUID: A5l6XWXFShiRYf1f9kKiyw==
X-CSE-MsgGUID: TGX3VbmATsu0bR/n9Edv1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2105643"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2105643"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 20:37:54 -0700
X-CSE-ConnectionGUID: dG5deO2wTA2YZkr0+QIR/A==
X-CSE-MsgGUID: kQsT93tQRZ6386uRVVAWvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5654232"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa008.jf.intel.com with ESMTP; 31 Oct 2026 20:37:52 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2 2/2] drm/i915/dp_mst: Skip link retrain and the ACT wait
 for disconnected MST streams
Date: Sun,  1 Nov 2026 11:35:35 +0800
Message-ID: <20261101033535.2078860-3-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101033535.2078860-1-xiaolu.xie@intel.com>
References: <20261101033535.2078860-1-xiaolu.xie@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a dock drops the upstream HPD, for instance when a TV behind it is
powered on, the MST topology is torn down and the MST connectors get
unregistered, while the CRTCs stay bound to them in the atomic state until
userspace disables them.

After the HPD is back, the link status of the link reads as all zeros, so
intel_dp_retrain_link() selects the pipe still bound to the old MST
connector and forces a modeset on it, while the topology is being
rediscovered. drm_dp_add_payload_part1() fails, as the port is not in the
topology anymore, but the enable sequence carries on and waits for an ACT
at the branch that is never triggered, since nothing was written to DPCD
0x1c0-0x1c2:

  [drm] *ERROR* Failed to get ACT after 3000 ms, last status: 04

The same wait happens when userspace disables the stale pipe afterwards,
as drm_dp_remove_payload_part1() doesn't remove the payload of a port that
is not in the topology. The new connector only gets registered after these
waits are over.

Fix this by:

- Not retraining the link if the MST sinks of all the active pipes are
  gone. If any stream is still connected all the pipes are kept, as the
  link only gets retrained after all the streams on it are disabled.

- Only waiting for the ACT at the branch if the payload was allocated to
  the DFP on enable, and if drm_dp_remove_payload_part1() removed it from
  the branch on disable. The ACT generation and the wait for it in the
  source are left as they were.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741
Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---

Notes:
    v2 (Sashiko):
     - Skip the link retrain only if all the active pipes have a disconnected MST
       sink, otherwise the link isn't retrained when some streams stay.
     - Check that the port is in the topology too, as the connector unregistration
       is asynchronous.
     - Keep the ACT generation and the wait for it in the source, skip only the
       wait at the branch.
     - Guard the wait at the branch on enable as well.

 .../drm/i915/display/intel_dp_link_training.c |  8 +++
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 69 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp_mst.h   |  1 +
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index ac1aff6ed..4ba302a2c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -2579,6 +2579,14 @@ static int intel_dp_retrain_link(struct intel_encoder *encoder,
 	if (pipe_mask == 0)
 		return 0;
 
+	/*
+	 * Nothing to retrain if the MST sinks of all the active pipes are gone.
+	 * Otherwise keep all the pipes, as the link only gets retrained after all
+	 * the streams on it are disabled.
+	 */
+	if (!(pipe_mask & ~intel_dp_mst_disconnected_pipes(intel_dp)))
+		return 0;
+
 	if (!intel_dp_needs_link_retrain(intel_dp))
 		return 0;
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 1e6190689..dce6b70ef 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1108,6 +1108,7 @@ static void mst_stream_post_disable(struct intel_atomic_state *state,
 		drm_atomic_get_mst_payload_state(new_mst_state, connector->mst.port);
 	struct intel_crtc *pipe_crtc;
 	bool last_mst_stream;
+	bool payload_removed;
 
 	last_mst_stream = intel_dp_mst_dec_active_streams(intel_dp);
 
@@ -1123,7 +1124,8 @@ static void mst_stream_post_disable(struct intel_atomic_state *state,
 
 	intel_disable_transcoder(old_crtc_state);
 
-	drm_dp_remove_payload_part1(&intel_dp->mst.mgr, new_mst_state, new_payload);
+	payload_removed = drm_dp_remove_payload_part1(&intel_dp->mst.mgr, new_mst_state,
+						      new_payload);
 
 	intel_ddi_clear_act_sent(encoder, old_crtc_state);
 
@@ -1132,7 +1134,9 @@ static void mst_stream_post_disable(struct intel_atomic_state *state,
 		     TRANS_DDI_DP_VC_PAYLOAD_ALLOC, 0);
 
 	intel_ddi_wait_for_act_sent(encoder, old_crtc_state);
-	drm_dp_check_act_status(&intel_dp->mst.mgr);
+	/* The payload table of the branch wasn't changed, so there is no ACT to wait for */
+	if (payload_removed)
+		drm_dp_check_act_status(&intel_dp->mst.mgr);
 
 	drm_dp_remove_payload_part2(&intel_dp->mst.mgr, new_mst_state,
 				    old_payload, new_payload);
@@ -1351,6 +1355,8 @@ static void mst_stream_enable(struct intel_atomic_state *state,
 		drm_atomic_get_new_mst_topology_state(&state->base, &intel_dp->mst.mgr);
 	enum transcoder trans = pipe_config->cpu_transcoder;
 	bool first_mst_stream = intel_dp_mst_active_streams(intel_dp) == 1;
+	struct drm_dp_mst_atomic_payload *payload =
+		drm_atomic_get_mst_payload_state(mst_state, connector->mst.port);
 	struct intel_crtc *pipe_crtc;
 	int ret;
 
@@ -1379,14 +1385,14 @@ static void mst_stream_enable(struct intel_atomic_state *state,
 		     TRANS_DDI_DP_VC_PAYLOAD_ALLOC);
 
 	intel_ddi_wait_for_act_sent(encoder, pipe_config);
-	drm_dp_check_act_status(&intel_dp->mst.mgr);
+	/* Nothing was allocated at the branch if part 1 failed, so there is no ACT to wait for */
+	if (payload->payload_allocation_status == DRM_DP_MST_PAYLOAD_ALLOCATION_DFP)
+		drm_dp_check_act_status(&intel_dp->mst.mgr);
 
 	if (first_mst_stream)
 		intel_ddi_wait_for_fec_status(encoder, pipe_config, true);
 
-	ret = drm_dp_add_payload_part2(&intel_dp->mst.mgr,
-				       drm_atomic_get_mst_payload_state(mst_state,
-									connector->mst.port));
+	ret = drm_dp_add_payload_part2(&intel_dp->mst.mgr, payload);
 	if (ret < 0)
 		intel_dp_queue_modeset_retry_for_link(state, primary_encoder, pipe_config);
 
@@ -2176,6 +2182,20 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 	return false;
 }
 
+static bool mst_connector_stream_disconnected(struct intel_connector *connector)
+{
+	if (!connector->mst.dp)
+		return false;
+
+	if (!connector->mst.dp->mst.mgr.mst_state)
+		return true;
+
+	if (drm_connector_is_unregistered(&connector->base))
+		return true;
+
+	return false;
+}
+
 bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
 				      const struct intel_crtc *crtc)
 {
@@ -2185,16 +2205,39 @@ bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
 	if (!connector)
 		return false;
 
-	if (!connector->mst.dp)
-		return false;
+	return mst_connector_stream_disconnected(connector);
+}
 
-	if (!connector->mst.dp->mst.mgr.mst_state)
-		return true;
+/**
+ * intel_dp_mst_disconnected_pipes - get the pipes driving disconnected MST streams
+ * @intel_dp: DP port object
+ *
+ * Returns the mask of pipes whose MST connector has left the topology, so
+ * there is no sink behind them. The caller must hold
+ * &drm_mode_config.connection_mutex.
+ */
+u8 intel_dp_mst_disconnected_pipes(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct drm_connector_list_iter conn_iter;
+	struct intel_connector *connector;
+	u8 pipe_mask = 0;
 
-	if (drm_connector_is_unregistered(&connector->base))
-		return true;
+	drm_connector_list_iter_begin(display->drm, &conn_iter);
+	for_each_intel_connector_iter(connector, &conn_iter) {
+		struct drm_connector_state *conn_state = connector->base.state;
 
-	return false;
+		if (connector->mst.dp != intel_dp || !conn_state->crtc)
+			continue;
+
+		if (mst_connector_stream_disconnected(connector) ||
+		    !drm_dp_mst_port_downstream_of_parent(&intel_dp->mst.mgr,
+							  connector->mst.port, NULL))
+			pipe_mask |= BIT(to_intel_crtc(conn_state->crtc)->pipe);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return pipe_mask;
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
index 8ce89242c..2c796a3e5 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -30,6 +30,7 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
 bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
 				      const struct intel_crtc *crtc);
+u8 intel_dp_mst_disconnected_pipes(struct intel_dp *intel_dp);
 void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
 bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
-- 
2.43.0

