Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27794606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RNuGExE9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1F010E5A5;
	Tue, 20 Oct 2026 11:06:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB2F10E5A5;
 Tue, 20 Oct 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792494397; x=1824030397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1Qg9c8mXE64iSpKQbw4PGrJmPMZXcY2RNoFrm8Ieczk=;
 b=RNuGExE9JCOe0NJ0DrCq1XcPnhjwNvtok0FNRcgHr17uhmKgDUG4wuQB
 6iuuTmxlKzEKT/zayUjRR61OTfRvptvlPTyZi6MqMZe2Dd/m31fOOLFuF
 Vfca9GOEJb6H0LNUjgiW0pjmuz2MdwJvLJ1aA7gvdYAQhAYJYFUEQLoCB
 PMrA/XO2gN+rko7Mce4bGM04rbOCy9x4qaGk+z/Nt9SAl8UVe9hMCQRfP
 EOW6zzkPfLkwABq6nwf4FdLZnI/cPbZ7ezxhqJ8uJOerf8AfJWRyaxmor
 y6MEEqmwA3DCDiRUZ1wgpewh6D3MqH+xjTUBI1EmpyHIg1OVcza6O+okl g==;
X-CSE-ConnectionGUID: BQhl0wqlS6SYWYrgpVzFXA==
X-CSE-MsgGUID: JNAPTxZ5SbyueKg4C/Gclg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1297877"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1297877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 04:06:36 -0700
X-CSE-ConnectionGUID: PrPB4yRcR7+55/apBMXdHA==
X-CSE-MsgGUID: i5rzIgSORk2FiEXw/Ml79A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3202192"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa006.fm.intel.com with ESMTP; 20 Oct 2026 04:06:33 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, ville.syrjala@linux.intel.com,
 imre.deak@intel.com, Xiao Lu <xiaolu.xie@intel.com>,
 Marco Nenciarini <mnencia@kcore.it>
Subject: [PATCH v3] drm/i915/dp: clear and restore MSTM_CTRL around MST DPMS
 off/on
Date: Tue, 20 Oct 2026 19:04:18 +0800
Message-ID: <20261020110418.1272170-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020021714.62573-1-xiaolu.xie@intel.com>
References: <20261020021714.62573-1-xiaolu.xie@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the last MST stream is disabled, i915 sends SET_POWER D3 to the
MST trunk while MSTM_CTRL (DPCD 0x111) still has MST mode enabled.
On re-enable, POWER_UP_PHY is sent before MSTM_CTRL is restored, so
the hub may process the PHY power-up in an inconsistent state and
fail to retrain its downstream links.

Fix this by disabling the MST mode before sending D3 on the last
stream disable and re-enabling it after writing D0 and before sending
POWER_UP_PHY on the first stream enable, so the hub is back in MST mode
when it processes the PHY power-up and retrains its downstream links.

Do this in the MST topology manager, which owns MSTM_CTRL, by adding
drm_dp_mst_topology_mgr_pause() and drm_dp_mst_topology_mgr_unpause().
Pausing clears MST_EN and UP_REQ_EN, but keeps UPSTREAM_IS_SRC set. The
paused state is tracked in the manager and checked by the new
drm_dp_mst_topology_mgr_verify_ctrl(), used by
intel_dp_mst_verify_dpcd_state(). Otherwise a connector detection
during DPMS off, for instance after a runtime resume, would see
MSTM_CTRL as reset and tear down the MST topology. A real reset still
changes the register value to something else than expected and so it's
still detected. The state change and the register access are done under
the manager's lock, so verifying the state can't race with pausing or
unpausing.

A downstream sink can get plugged or unplugged while the MST mode is
paused and the branch device is powered down. The source doesn't know
about this, since the branch device may not send an UP message in this
state, so the SW topology can get out of sync with the actual one.
Re-probe the topology after unpausing, even if the link parameters
haven't changed, to resync it. Unlike tearing down and recreating the
topology, this keeps the connectors of the unchanged ports, and applies
the changes of the others the same way as when they are signalled by an
UP message.

v2: Write UPSTREAM_IS_SRC instead of 0 and accept it in
    intel_dp_mst_verify_dpcd_state(), to avoid removing the topology
    on a connector detection during DPMS off. (Marco)
v3: Move all the MSTM_CTRL accesses to the topology manager. (Jani)
    Track the paused state in the manager instead of using the number
    of active MST streams, to avoid racing with
    mst_stream_pre_enable().
    Re-probe the topology after unpausing.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Marco Nenciarini <mnencia@kcore.it>
Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
Hi Jani,

Thanks for the review. v3 moves all the DP_MSTM_CTRL accesses into the
topology manager (pause/unpause/verify_ctrl), i915 doesn't touch the
register anymore.

Is this what you had in mind, or would you rather not disable the MST
mode during DPMS off at all?

v2 was tested by Marco, v3 is not tested on HW yet.
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 103 ++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_ddi.c      |   2 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  29 ++---
 include/drm/display/drm_dp_mst_helper.h       |  11 ++
 4 files changed, 132 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..8dbf9dcc8 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3684,6 +3684,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		if (ret < 0)
 			goto out_unlock;
 
+		mgr->paused = false;
+
 		/* Write reset payload */
 		drm_dp_dpcd_clear_payload(mgr->aux);
 
@@ -3697,6 +3699,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		/* this can fail if the device is gone */
 		drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL, 0);
 		ret = 0;
+		mgr->paused = false;
 		mgr->payload_id_table_cleared = false;
 
 		mgr->reset_rx_state = true;
@@ -3753,6 +3756,104 @@ void drm_dp_mst_topology_queue_probe(struct drm_dp_mst_topology_mgr *mgr)
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_queue_probe);
 
+/**
+ * drm_dp_mst_topology_mgr_pause() - disable the MST mode of the branch device
+ * @mgr: manager to pause
+ *
+ * Disable the MST mode of the branch device, while keeping the MST topology
+ * in the SW state. This is meant to be called when all the MST streams are
+ * disabled and the branch device is about to be powered down.
+ *
+ * The branch device may not send UP messages while it is powered down, so
+ * after the MST mode is enabled again by drm_dp_mst_topology_mgr_unpause(),
+ * the topology must be re-probed.
+ */
+void drm_dp_mst_topology_mgr_pause(struct drm_dp_mst_topology_mgr *mgr)
+{
+	mutex_lock(&mgr->lock);
+
+	if (!mgr->mst_state || !mgr->mst_primary || mgr->paused)
+		goto out_unlock;
+
+	if (drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
+				   DP_UPSTREAM_IS_SRC) == 0)
+		mgr->paused = true;
+
+out_unlock:
+	mutex_unlock(&mgr->lock);
+}
+EXPORT_SYMBOL(drm_dp_mst_topology_mgr_pause);
+
+/**
+ * drm_dp_mst_topology_mgr_unpause() - re-enable the MST mode of the branch device
+ * @mgr: manager to unpause
+ *
+ * Re-enable the MST mode of the branch device disabled by
+ * drm_dp_mst_topology_mgr_pause(). Does nothing if the manager isn't paused.
+ *
+ * Returns %true if the manager was paused. In this case the MST topology
+ * should be re-probed with drm_dp_mst_topology_queue_probe(), once the link
+ * parameters to the branch device are set up.
+ */
+bool drm_dp_mst_topology_mgr_unpause(struct drm_dp_mst_topology_mgr *mgr)
+{
+	bool was_paused = false;
+
+	mutex_lock(&mgr->lock);
+
+	if (!mgr->paused)
+		goto out_unlock;
+
+	if (drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
+				   DP_MST_EN | DP_UP_REQ_EN |
+				   DP_UPSTREAM_IS_SRC) == 0) {
+		mgr->paused = false;
+		was_paused = true;
+	}
+
+out_unlock:
+	mutex_unlock(&mgr->lock);
+
+	return was_paused;
+}
+EXPORT_SYMBOL(drm_dp_mst_topology_mgr_unpause);
+
+/**
+ * drm_dp_mst_topology_mgr_verify_ctrl() - verify the MST mode of the branch device
+ * @mgr: manager to verify
+ *
+ * Verify that the MST mode enabled in the branch device matches the manager's
+ * state. A long HPD pulse could've reset the branch device's MST mode, which
+ * requires tearing down and recreating the MST topology.
+ *
+ * Returns %true if the branch device's MST mode matches the manager's state,
+ * %false otherwise.
+ */
+bool drm_dp_mst_topology_mgr_verify_ctrl(struct drm_dp_mst_topology_mgr *mgr)
+{
+	u8 expected, val = 0;
+	int ret;
+
+	mutex_lock(&mgr->lock);
+
+	expected = mgr->paused ? DP_UPSTREAM_IS_SRC :
+		   DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC;
+
+	ret = drm_dp_dpcd_read_byte(mgr->aux, DP_MSTM_CTRL, &val);
+
+	mutex_unlock(&mgr->lock);
+
+	if (ret < 0 || val != expected) {
+		drm_dbg_kms(mgr->dev,
+			    "%s: MSTM_CTRL mismatch (ret=%d, ctrl=0x%02x, expected=0x%02x)\n",
+			    mgr->aux->name, ret, val, expected);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(drm_dp_mst_topology_mgr_verify_ctrl);
+
 /**
  * drm_dp_mst_topology_mgr_suspend() - suspend the MST manager
  * @mgr: manager to suspend
@@ -3822,6 +3923,8 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
 		goto out_fail;
 	}
 
+	mgr->paused = false;
+
 	/* Some hubs forget their guids after they resume */
 	ret = drm_dp_dpcd_read_data(mgr->aux, DP_GUID, buf, sizeof(buf));
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a46ab5d3d..9d918f968 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3163,6 +3163,8 @@ static void intel_ddi_post_disable_dp(struct intel_atomic_state *state,
 	 * Power down sink before disabling the port, otherwise we end
 	 * up getting interrupts from the sink on detecting link loss.
 	 */
+	if (is_mst)
+		drm_dp_mst_topology_mgr_pause(&intel_dp->mst.mgr);
 	intel_dp_set_power(intel_dp, DP_SET_POWER_D3);
 
 	if (DISPLAY_VER(display) >= 12) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 7023619aa..2e3a2424d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1232,9 +1232,11 @@ static void intel_mst_set_probed_link_params(struct intel_dp *intel_dp,
 }
 
 static void intel_mst_reprobe_topology(struct intel_dp *intel_dp,
-				       const struct intel_crtc_state *crtc_state)
+				       const struct intel_crtc_state *crtc_state,
+				       bool force)
 {
-	if (intel_mst_probed_link_params_valid(intel_dp,
+	if (!force &&
+	    intel_mst_probed_link_params_valid(intel_dp,
 					       crtc_state->port_clock, crtc_state->lane_count))
 		return;
 
@@ -1259,6 +1261,7 @@ static void mst_stream_pre_enable(struct intel_atomic_state *state,
 		drm_atomic_get_new_mst_topology_state(&state->base, &intel_dp->mst.mgr);
 	int ret;
 	bool first_mst_stream;
+	bool was_paused = false;
 
 	/* MST encoders are bound to a crtc, not to a connector,
 	 * force the mapping here for get_hw_state.
@@ -1270,8 +1273,10 @@ static void mst_stream_pre_enable(struct intel_atomic_state *state,
 	drm_WARN_ON(display->drm, DISPLAY_VER(display) >= 12 && first_mst_stream &&
 		    !intel_dp_mst_is_master_trans(pipe_config));
 
-	if (first_mst_stream)
+	if (first_mst_stream) {
 		intel_dp_set_power(intel_dp, DP_SET_POWER_D0);
+		was_paused = drm_dp_mst_topology_mgr_unpause(&intel_dp->mst.mgr);
+	}
 
 	drm_dp_send_power_updown_phy(&intel_dp->mst.mgr, connector->mst.port, true);
 
@@ -1281,7 +1286,11 @@ static void mst_stream_pre_enable(struct intel_atomic_state *state,
 		primary_encoder->pre_enable(state, primary_encoder,
 					    pipe_config, NULL);
 
-		intel_mst_reprobe_topology(intel_dp, pipe_config);
+		/*
+		 * The branch device may not have sent UP messages while it
+		 * was powered down, re-probe the topology to sync it.
+		 */
+		intel_mst_reprobe_topology(intel_dp, pipe_config, was_paused);
 	}
 
 	ret = drm_dp_add_payload_part1(&intel_dp->mst.mgr, mst_state,
@@ -2246,21 +2255,15 @@ bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp)
 	struct intel_connector *connector = intel_dp->attached_connector;
 	struct intel_digital_port *dig_port = dp_to_dig_port(intel_dp);
 	struct intel_encoder *encoder = &dig_port->base;
-	int ret;
-	u8 val;
 
 	if (!intel_dp->is_mst)
 		return true;
 
-	ret = drm_dp_dpcd_read_byte(intel_dp->mst.mgr.aux, DP_MSTM_CTRL, &val);
-
-	/* Adjust the expected register value for SST + SideBand. */
-	if (ret < 0 || val != (DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC)) {
+	if (!drm_dp_mst_topology_mgr_verify_ctrl(&intel_dp->mst.mgr)) {
 		drm_dbg_kms(display->drm,
-			    "[CONNECTOR:%d:%s][ENCODER:%d:%s] MST mode got reset, removing topology (ret=%d, ctrl=0x%02x)\n",
+			    "[CONNECTOR:%d:%s][ENCODER:%d:%s] MST mode got reset, removing topology\n",
 			    connector->base.base.id, connector->base.name,
-			    encoder->base.base.id, encoder->base.name,
-			    ret, val);
+			    encoder->base.base.id, encoder->base.name);
 
 		return false;
 	}
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 27658bfb5..19cf896d6 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -700,6 +700,13 @@ struct drm_dp_mst_topology_mgr {
 	 */
 	bool mst_state : 1;
 
+	/**
+	 * @paused: Whether the MST mode of the branch device is disabled by
+	 * drm_dp_mst_topology_mgr_pause(), while @mst_state is still set.
+	 * Protected by @lock.
+	 */
+	bool paused : 1;
+
 	/**
 	 * @payload_id_table_cleared: Whether or not we've cleared the payload
 	 * ID table for @mst_primary. Protected by @lock.
@@ -900,6 +907,10 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 
 void drm_dp_mst_topology_queue_probe(struct drm_dp_mst_topology_mgr *mgr);
 
+void drm_dp_mst_topology_mgr_pause(struct drm_dp_mst_topology_mgr *mgr);
+bool drm_dp_mst_topology_mgr_unpause(struct drm_dp_mst_topology_mgr *mgr);
+bool drm_dp_mst_topology_mgr_verify_ctrl(struct drm_dp_mst_topology_mgr *mgr);
+
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int __must_check
 drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.43.0

