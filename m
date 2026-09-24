Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F8C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637D010F409;
	Thu, 24 Sep 2026 09:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HfsbhCh4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C1410F3FF;
 Thu, 24 Sep 2026 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790243147; x=1821779147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wUJ5zdPV81SZII58tnVUWBYKnfGPlnHWu4mJFcWgx9U=;
 b=HfsbhCh4zA71OjDA1tTOuD5ynmZfXOWbUVunEpHkimjmRaO5Yq6A421/
 frISVxpj+nX/X5ePEW4Fbbpy06zfX51TkhXatY/JZ78tM6J2ZqWWnZ6rD
 TVFbbw5UdehdzH9BieyixaVq4nmAarAr5jWPvATWUvy80nXKmnC76Oqlw
 CBq3lJCIbUkdV1srXQJgHPImPqLlJ0Llgi+XQ0ca5DSD6wJhBw2LihMHL
 U3tOSdz6JwIDUAHaE8XojThbqjlSkaS9RpKa9CXT9lEswIADeznc2ENVq
 IqSvK0Wi7u3rnZZ60B82YgSPuragM05ZBXDRfOfXtZeqIIvNDp/7QBQus w==;
X-CSE-ConnectionGUID: xXt0o1otTTuLOEd4aKkLJQ==
X-CSE-MsgGUID: zTSMsw8ZRtSLrL2ckZFsWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90048163"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90048163"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 02:45:47 -0700
X-CSE-ConnectionGUID: BCpiATubTTCIuLZ0IT5GYA==
X-CSE-MsgGUID: HO7SonksQ2usBDVYm0WnuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311879561"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 02:45:44 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v3 2/2] drm/dp_mst: Track allocated_pbn from ALLOCATE_PAYLOAD
 down-reply
Date: Thu, 24 Sep 2026 17:43:16 +0800
Message-ID: <20260924094316.822211-3-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924094316.822211-1-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
 <20260924094316.822211-1-xiaolu.xie@intel.com>
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

The ALLOCATE_PAYLOAD reply may report a larger PBN than requested
when an intermediate branch applies its own constraints.

Store the reported PBN and use the larger of requested and allocated
PBN for bandwidth checks. Preserve it when recalculating time slots,
since clearing it there makes the next atomic check underestimate
active payloads. Clear it only when releasing the payload.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++++++++++-----
 include/drm/display/drm_dp_mst_helper.h       | 10 ++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..86a42c5e2 100644
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
 
@@ -4575,6 +4580,7 @@ int drm_dp_atomic_release_time_slots(struct drm_atomic_commit *state,
 	drm_dbg_atomic(mgr->dev, "[MST PORT:%p] TU %d -> 0\n", port, payload->time_slots);
 	if (!payload->delete) {
 		payload->pbn = 0;
+		payload->allocated_pbn = 0;
 		payload->delete = true;
 		if (payload->vcpi > 0)
 			topology_state->payload_mask &= ~BIT(payload->vcpi - 1);
@@ -4670,6 +4676,7 @@ void drm_dp_mst_atomic_wait_for_dependencies(struct drm_atomic_commit *state)
 			new_payload = drm_atomic_get_mst_payload_state(new_mst_state,
 								       old_payload->port);
 			new_payload->vc_start_slot = old_payload->vc_start_slot;
+			new_payload->allocated_pbn = old_payload->allocated_pbn;
 			new_payload->payload_allocation_status =
 							old_payload->payload_allocation_status;
 		}
@@ -5352,7 +5359,7 @@ drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp_mst_port *port,
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

