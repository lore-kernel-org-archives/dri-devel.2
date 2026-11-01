Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BD606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bQrVj+oV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A9A10E261;
	Sun,  1 Nov 2026 03:38:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A0010E108;
 Sun,  1 Nov 2026 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793504272; x=1825040272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BCxsbxv6XmgS8r4N9oKg7MYr1Jq3Invf/gpS/4n2JGw=;
 b=bQrVj+oVkoJhE99BfE9Bi3vQzrW7N9PFLsMqODEhmGb9nNW+jTDf/97s
 d5S2sNgNQesmsO0QrTDFyi8Jr81LjlQobSrD33iTzz7v69QZsu9VGx9Q+
 p6vpSwDCbuioLMCkgT8vNZ22q090W5g59RjwDL8sjYEzuivbEIzQTUJnx
 HZ1IlmoB97HAGgYQRyNanuaySOSP9iyQQagqSCVBYAZ9lJadXKoIdbL6F
 HrYFcdaAG9uK15cKN7g3d6GzBe3OxerEIfJix7YDcdCgiRDNmO7OO3Nfe
 txrdqdf7MJu5jaok8I+zjMlsUg8eTmuKj69+f/99lbk+dbN/wOghSuyry A==;
X-CSE-ConnectionGUID: koeqK/ZWQQSdpnTOGD+WUw==
X-CSE-MsgGUID: aigCu1PpQRGkZaLCGL6TnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2105638"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2105638"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 20:37:51 -0700
X-CSE-ConnectionGUID: xrskoqHiT6uSwoByfXaZEQ==
X-CSE-MsgGUID: zu6Y4CFDRTmTRWeWwcXuxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5654222"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa008.jf.intel.com with ESMTP; 31 Oct 2026 20:37:50 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2 1/2] drm/dp_mst: Return whether
 drm_dp_remove_payload_part1() removed the payload
Date: Sun,  1 Nov 2026 11:35:34 +0800
Message-ID: <20261101033535.2078860-2-xiaolu.xie@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_dp_remove_payload_part1() doesn't send the removal of a payload to the
branch devices if the port of the payload is not in the topology anymore.
The caller can't tell, so it generates the ACT and waits for it afterwards,
polling DPCD 0x2c0 for up to 3 seconds, although the payload table of the
branch devices wasn't changed and the ACT will never be handled.

Return whether the removal was sent, so that drivers can skip the ACT in
the other case. The existing callers ignore the return value and are not
affected.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---

Notes:
    v2: also require the payload to have been allocated to the DFP or the
    remote end for the return value to be true, not only that the port is in the
    topology (Sashiko).

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++++++++++++++-
 include/drm/display/drm_dp_mst_helper.h       |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..1763dd0ae 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3369,18 +3369,31 @@ EXPORT_SYMBOL(drm_dp_add_payload_part1);
  * Removes a payload along the virtual channel if it was successfully allocated.
  * After calling this, the driver should set HW to generate ACT and then switch to new
  * payload allocation state.
+ *
+ * Returns:
+ * %true if the payload was removed from the branch devices, so the driver
+ * should generate the ACT and wait for it. %false if nothing was sent to the
+ * branch devices, because the port of the payload is not in the topology
+ * anymore or the payload was never allocated to the DFP, so there is no ACT
+ * to generate or wait for.
  */
-void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
+bool drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_topology_state *mst_state,
 				 struct drm_dp_mst_atomic_payload *payload)
 {
 	/* Remove remote payload allocation */
 	bool send_remove = false;
+	bool removed;
 
 	mutex_lock(&mgr->lock);
 	send_remove = drm_dp_mst_port_downstream_of_branch(payload->port, mgr->mst_primary);
 	mutex_unlock(&mgr->lock);
 
+	/* Only a payload allocated to the DFP or the remote end is removed from the branches */
+	removed = send_remove &&
+		(payload->payload_allocation_status == DRM_DP_MST_PAYLOAD_ALLOCATION_DFP ||
+		 payload->payload_allocation_status == DRM_DP_MST_PAYLOAD_ALLOCATION_REMOTE);
+
 	if (send_remove)
 		drm_dp_destroy_payload_at_remote_and_dfp(mgr, mst_state, payload);
 	else
@@ -3388,6 +3401,8 @@ void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 			    payload->vcpi);
 
 	payload->payload_allocation_status = DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL;
+
+	return removed;
 }
 EXPORT_SYMBOL(drm_dp_remove_payload_part1);
 
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 27658bfb5..d5a3bbb28 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -885,7 +885,7 @@ int drm_dp_add_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 			     struct drm_dp_mst_atomic_payload *payload);
 int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
 			     struct drm_dp_mst_atomic_payload *payload);
-void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
+bool drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_topology_state *mst_state,
 				 struct drm_dp_mst_atomic_payload *payload);
 void drm_dp_remove_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.43.0

