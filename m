Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0695C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4CC10E691;
	Tue, 22 Sep 2026 09:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N4C7qlqt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B568D10E67C;
 Tue, 22 Sep 2026 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790069356; x=1821605356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LGXroHDRPSlBlYImfl5iU8CelMFnisF6TiEeL9eejKk=;
 b=N4C7qlqtgid7jwfMb1uge35EqB93pMPZB0dtFQ3XRl34Euzv+XY9wPeX
 pWhXT5BSV9iqhD8dbGAoowIxx/nMSUwki3pn3Gxb//xImIwrSeuEqVVvQ
 rb1CfMkjSoAP0fMKyY+pAU/VZi0Dg6bYUGNQDhn0xYRBtd7gIacHd4w9r
 XQypXEufhWFGiLuZtyq0F01z9AVQcDGS7Dcdb7nrhTDvp3mGj4dvfyuzY
 V6pP9zLP+OdYL01NpCWW3hLv+bSf/1zvpto7sfmAtopnHJ1FVPvlITPp1
 1HekYf+8U9h3A3TGcGJyfkEPR9iITXe6a5CP7fa9/MfBhMc4n1QP2cdkY w==;
X-CSE-ConnectionGUID: q4acaRvITNWwHwGuODsOrw==
X-CSE-MsgGUID: DukmBYljTPG+rWoh+ZIULQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108154061"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108154061"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:29:16 -0700
X-CSE-ConnectionGUID: UFVPGh3FSRqnUZngo3vWhQ==
X-CSE-MsgGUID: tJ5VFgueSii90T2izsx2Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299295832"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa002.fm.intel.com with ESMTP; 22 Sep 2026 02:29:14 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tvrtko.ursulin@linux.intel.com, lyude@redhat.com, David.Francis@amd.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2 2/2] drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD
 down-reply
Date: Tue, 22 Sep 2026 17:26:47 +0800
Message-ID: <20260922092647.2263962-3-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922092647.2263962-1-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
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

The DP MST ALLOCATE_PAYLOAD sideband message returns the payload bandwidth actually allocated by the branch in the allocated_pbn field of the down-reply. That value may differ from the requested PBN when an intermediate branch applies its own constraints, so the source should keep track of it instead of only relying on the local request.

Store the allocated_pbn returned by the ALLOCATE_PAYLOAD down-reply sideband message and use the larger of requested PBN and allocated PBN for the MST bandwidth limit checks. Also carry the value across dependent atomic commits and clear it when releasing the payload, matching the lifetime of the remote allocation state.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 19 ++++++++++++++-----
 include/drm/display/drm_dp_mst_helper.h       | 10 ++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..b0e4cf845 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3120,6 +3120,7 @@ drm_dp_get_last_connected_port_and_mstb(struct drm_dp_mst_topology_mgr *mgr,
 
 static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 				   struct drm_dp_mst_port *port,
+				   struct drm_dp_mst_atomic_payload *payload,
 				   int id,
 				   int pbn)
 {
@@ -3166,10 +3167,14 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 	 */
 	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
 	if (ret > 0) {
-		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK)
+		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
 			ret = -EINVAL;
-		else
+		} else {
+			if (payload)
+				payload->allocated_pbn =
+					txmsg->reply.u.allocate_payload.allocated_pbn;
 			ret = 0;
+		}
 	}
 	kfree(txmsg);
 fail_put:
@@ -3285,7 +3290,7 @@ static int drm_dp_create_payload_to_remote(struct drm_dp_mst_topology_mgr *mgr,
 	if (!port)
 		return -EIO;
 
-	ret = drm_dp_payload_send_msg(mgr, port, payload->vcpi, payload->pbn);
+	ret = drm_dp_payload_send_msg(mgr, port, payload, payload->vcpi, payload->pbn);
 	drm_dp_mst_topology_put_port(port);
 	return ret;
 }
@@ -3298,7 +3303,7 @@ static void drm_dp_destroy_payload_at_remote_and_dfp(struct drm_dp_mst_topology_
 
 	/* it's okay for these to fail */
 	if (payload->payload_allocation_status == DRM_DP_MST_PAYLOAD_ALLOCATION_REMOTE) {
-		drm_dp_payload_send_msg(mgr, payload->port, payload->vcpi, 0);
+		drm_dp_payload_send_msg(mgr, payload->port, NULL, payload->vcpi, 0);
 		payload->payload_allocation_status = DRM_DP_MST_PAYLOAD_ALLOCATION_DFP;
 	}
 
@@ -4495,6 +4500,8 @@ int drm_dp_atomic_find_time_slots(struct drm_atomic_commit *state,
 	}
 	payload->time_slots = req_slots;
 	payload->pbn = pbn;
+	/* Clear allocated_pbn so it is re-populated from the next ALLOCATE_PAYLOAD reply. */
+	payload->allocated_pbn = 0;
 
 	return req_slots;
 }
@@ -4575,6 +4582,7 @@ int drm_dp_atomic_release_time_slots(struct drm_atomic_commit *state,
 	drm_dbg_atomic(mgr->dev, "[MST PORT:%p] TU %d -> 0\n", port, payload->time_slots);
 	if (!payload->delete) {
 		payload->pbn = 0;
+		payload->allocated_pbn = 0;
 		payload->delete = true;
 		if (payload->vcpi > 0)
 			topology_state->payload_mask &= ~BIT(payload->vcpi - 1);
@@ -4670,6 +4678,7 @@ void drm_dp_mst_atomic_wait_for_dependencies(struct drm_atomic_commit *state)
 			new_payload = drm_atomic_get_mst_payload_state(new_mst_state,
 								       old_payload->port);
 			new_payload->vc_start_slot = old_payload->vc_start_slot;
+			new_payload->allocated_pbn = old_payload->allocated_pbn;
 			new_payload->payload_allocation_status =
 							old_payload->payload_allocation_status;
 		}
@@ -5352,7 +5361,7 @@ drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp_mst_port *port,
 			return -EINVAL;
 		}
 
-		pbn_used = payload->pbn;
+		pbn_used = max(payload->pbn, payload->allocated_pbn);
 	} else {
 		pbn_used = drm_dp_mst_atomic_check_mstb_bw_limit(port->mstb,
 								 state,
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 27658bfb5..1a9430a62 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -572,6 +572,16 @@ struct drm_dp_mst_atomic_payload {
 	int time_slots;
 	/** @pbn: The payload bandwidth for this payload */
 	int pbn;
+	/**
+	 * @allocated_pbn: The payload bandwidth actually confirmed by the
+	 * branch device in the ALLOCATE_PAYLOAD reply. Each MST branch along
+	 * the path overrides this field to the maximum of the requested and
+	 * its own constrained value, so the value received by the source
+	 * reflects the tightest bottleneck along the entire path.
+	 * Used instead of @pbn for bandwidth limit checks so that the source
+	 * accounts for any per-hop adjustments made by intermediate branches.
+	 */
+	int allocated_pbn;
 
 	/** @delete: Whether or not we intend to delete this payload during this atomic commit */
 	bool delete : 1;
-- 
2.43.0

