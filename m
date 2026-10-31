Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B66606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nQrE6ezS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EA810E2EE;
	Sat, 31 Oct 2026 15:47:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB4D10E043;
 Sat, 31 Oct 2026 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793461637; x=1824997637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/g4bDoLao7UbZ5UU4S/UlL0OF8osAahyhN+l9gNbe7k=;
 b=nQrE6ezSL3DE2g6QYYC5t+HWLfLYYaLRrcadea69CzM9b4yIRlD9/+Qe
 19NeYJUynqg/UgUFAKM7Dk4TcW/MZGtXsdQSZRCRBrYaUWrtVQltfyhz2
 UW2wWabH+BjrJd+hxhTxmmHTJQ2d+hvomuzI+Dgtl4PZe4dLSvQsCxAoc
 G7TU+BBPHlIQUM52ZIdUiOHPkpK+hzf2A1Ya8KRQekgl3cQdL41FTHQQJ
 XTSH51b+lxQw5Qk1UJC+03+e0U6YkeOXKOEAuPCCExrLw151Oxr6BbOz8
 QIpHJaWTy2BD+g0AVLi72vUbUD/c8uGIKcMnhHm+U2jk8eulPVC22mCGt Q==;
X-CSE-ConnectionGUID: Ra3JxTJhSMecgD/PT5wh4A==
X-CSE-MsgGUID: aSvf9llxRXuYwtdImZ0I0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2310838"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2310838"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 08:47:17 -0700
X-CSE-ConnectionGUID: qS93HEA3QJWfKPQfr57slg==
X-CSE-MsgGUID: eIut/hzSR/+sUJVKzWQCQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="7519034"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa011.fm.intel.com with ESMTP; 31 Oct 2026 08:47:14 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH RESEND 2/2] drm/i915/dp_mst: Skip link retrain and ACT for
 disconnected MST streams
Date: Sat, 31 Oct 2026 23:44:56 +0800
Message-ID: <20261031154456.465469-3-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031154456.465469-1-xiaolu.xie@intel.com>
References: <20261031154456.465469-1-xiaolu.xie@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
that is never triggered, since nothing was written to DPCD 0x1c0-0x1c2:

  [drm] *ERROR* Failed to get ACT after 3000 ms, last status: 04

The same wait happens when userspace disables the stale pipe afterwards,
as drm_dp_remove_payload_part1() doesn't remove the payload of a port that
is not in the topology. The new connector only gets registered after these
waits are over.

Fix this by not selecting the pipes of disconnected MST streams, using the
same condition as intel_dp_mst_stream_disconnected(), when retraining the
link, and by skipping the ACT generation and the wait on the disable path
if drm_dp_remove_payload_part1() didn't remove the payload from the branch
device.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741
Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 .../drm/i915/display/intel_dp_link_training.c |  3 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 68 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp_mst.h   |  1 +
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index ac1aff6ed..41bfb8b1a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -2576,6 +2576,9 @@ static int intel_dp_retrain_link(struct intel_encoder *encoder,
 	if (ret)
 		return ret;
 
+	/* Nothing to retrain for streams whose MST sink has left the topology */
+	pipe_mask &= ~intel_dp_mst_disconnected_pipes(intel_dp);
+
 	if (pipe_mask == 0)
 		return 0;
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 1e6190689..f6612a4d7 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1108,6 +1108,7 @@ static void mst_stream_post_disable(struct intel_atomic_state *state,
 		drm_atomic_get_mst_payload_state(new_mst_state, connector->mst.port);
 	struct intel_crtc *pipe_crtc;
 	bool last_mst_stream;
+	bool payload_removed;
 
 	last_mst_stream = intel_dp_mst_dec_active_streams(intel_dp);
 
@@ -1123,16 +1124,20 @@ static void mst_stream_post_disable(struct intel_atomic_state *state,
 
 	intel_disable_transcoder(old_crtc_state);
 
-	drm_dp_remove_payload_part1(&intel_dp->mst.mgr, new_mst_state, new_payload);
+	payload_removed = drm_dp_remove_payload_part1(&intel_dp->mst.mgr, new_mst_state,
+						      new_payload);
 
-	intel_ddi_clear_act_sent(encoder, old_crtc_state);
+	/* No ACT is needed if the payload table of the branch wasn't changed */
+	if (payload_removed) {
+		intel_ddi_clear_act_sent(encoder, old_crtc_state);
 
-	intel_de_rmw(display,
-		     TRANS_DDI_FUNC_CTL(display, old_crtc_state->cpu_transcoder),
-		     TRANS_DDI_DP_VC_PAYLOAD_ALLOC, 0);
+		intel_de_rmw(display,
+			     TRANS_DDI_FUNC_CTL(display, old_crtc_state->cpu_transcoder),
+			     TRANS_DDI_DP_VC_PAYLOAD_ALLOC, 0);
 
-	intel_ddi_wait_for_act_sent(encoder, old_crtc_state);
-	drm_dp_check_act_status(&intel_dp->mst.mgr);
+		intel_ddi_wait_for_act_sent(encoder, old_crtc_state);
+		drm_dp_check_act_status(&intel_dp->mst.mgr);
+	}
 
 	drm_dp_remove_payload_part2(&intel_dp->mst.mgr, new_mst_state,
 				    old_payload, new_payload);
@@ -2176,6 +2181,20 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
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
@@ -2185,16 +2204,37 @@ bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
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
+ * there is no sink behind them to retrain the link for. The caller must hold
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
+		if (mst_connector_stream_disconnected(connector))
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

