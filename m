Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85B606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n6S99osN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FBC10E30D;
	Sat, 31 Oct 2026 15:47:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B1210E0B7;
 Sat, 31 Oct 2026 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793461634; x=1824997634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/yw+d/1d9czNY+Xu9+xe4/pfryf778O+QF2TTt4JC+Y=;
 b=n6S99osNU1KVAVGwpX5S5agfWhxf62hruX2Xccip9+8c1Ae3dyV+leG9
 ADQvYWAZL4+ISvfSvcsmIL1r13+B/3T8jhzHAVhiwYU3qa91ajADpxF2t
 jajcaZ5v/uoGeEBAOgmgjJpmK74CcNRupSN4SWlW10VFh2Fad6ist3pUZ
 Xek+jkh5t8GtcJWwNfsxN1U2CeFAikK1Yh2OLhRUhmBzoFpQGX17F1bqT
 9PCp+YBqGqgiryhH2P0ZbrAC1QAdqT0uRbw807BoBzUibTGFXxt4Qkpoz
 vi0dugSWQ5vjBoVJFNeFJGrmzEeQP8uxJBdW0V32zYW8NgikU1/9Z0uAT w==;
X-CSE-ConnectionGUID: lVZ5mTH8S9yew2ue6pjv0Q==
X-CSE-MsgGUID: yK6EvNWbQ7KbgJPihQejzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2310834"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2310834"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 08:47:14 -0700
X-CSE-ConnectionGUID: IrIgvmDNQemFs70CTYRiXg==
X-CSE-MsgGUID: LnXJXzskQYKKOuHg8J7ZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="7519027"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa011.fm.intel.com with ESMTP; 31 Oct 2026 08:47:12 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH RESEND 1/2] drm/dp_mst: Return whether
 drm_dp_remove_payload_part1() removed the payload
Date: Sat, 31 Oct 2026 23:44:55 +0800
Message-ID: <20261031154456.465469-2-xiaolu.xie@intel.com>
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
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 10 +++++++++-
 include/drm/display/drm_dp_mst_helper.h       |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..363cd5237 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3369,8 +3369,14 @@ EXPORT_SYMBOL(drm_dp_add_payload_part1);
  * Removes a payload along the virtual channel if it was successfully allocated.
  * After calling this, the driver should set HW to generate ACT and then switch to new
  * payload allocation state.
+ *
+ * Returns:
+ * %true if the port of the payload is in the topology, so the removal was
+ * sent to the branch devices and the driver should generate the ACT and wait
+ * for it. %false if the port is not in the topology anymore, so nothing was
+ * sent to the branch devices and there is no ACT to generate or wait for.
  */
-void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
+bool drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_topology_state *mst_state,
 				 struct drm_dp_mst_atomic_payload *payload)
 {
@@ -3388,6 +3394,8 @@ void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr *mgr,
 			    payload->vcpi);
 
 	payload->payload_allocation_status = DRM_DP_MST_PAYLOAD_ALLOCATION_LOCAL;
+
+	return send_remove;
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

