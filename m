Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0997C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1072E10E02D;
	Wed,  9 Sep 2026 02:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fMft9l5x";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C81110E02D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 02:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788919636; x=1820455636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5RKEXS8PehN9ttkv0+UAPYtfVlBlUxK1vjCiQHNQ6oA=;
 b=fMft9l5xCfvmO51hESr9PlZ4QxMT7PuhqwkNgByqmKulxIfto7c3khZM
 eHR27OhbE3xsveD76q6PGcrMxSxxw8I9WHG8Kiizl+JPWaSS4BuedeZjo
 6oRgocK3JEUOlQM1e23Qu0vtyM+UcOK7U4+4PM0FqYQYXfMqmZ8Yyvgwf
 EFG14Me5aZf+v7jOsgJKcnHAKSXGfhG94/K7lL1ykqrZ3++5/XPicDtjm
 s2v3MMUZTZWDimTFSPseCC3oWWPWt4pgk2XbzAXzS6wwY4AoODhCrVwsm
 rHhxDkrhjOP/S+InweCQq8oZAbz1OCIwCGJsPH7UHcFzGCSInWuaFNNMw Q==;
X-CSE-ConnectionGUID: fANT7xSPSXiJtwfTTFOiGw==
X-CSE-MsgGUID: rTYEt1s9S4mr6I6GPZ2+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88485294"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="88485294"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 19:07:16 -0700
X-CSE-ConnectionGUID: WITU7C8FRjWZCng4hPKxTA==
X-CSE-MsgGUID: vh952MQGSYi0BQ4jUi21HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="268608975"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa008.fm.intel.com with ESMTP; 08 Sep 2026 19:07:15 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: lyude@redhat.com,
	David.Francis@amd.com,
	Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2] drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD
 down-reply
Date: Wed,  9 Sep 2026 10:04:48 +0800
Message-ID: <20260909020448.4014238-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908132844.2309047-1-xiaolu.xie@intel.com>
References: <20260908132844.2309047-1-xiaolu.xie@intel.com>
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
v2: Clear allocated_pbn in drm_dp_atomic_find_time_slots() so that
    a subsequent bandwidth reduction does not retain a stale high value
    from the previous allocation, which could cause spurious -ENOSPC
    in the bandwidth limit check.
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

