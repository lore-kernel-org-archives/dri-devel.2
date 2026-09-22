Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CADC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9A210E685;
	Tue, 22 Sep 2026 09:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TPmey4Ax";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4922B10E67B;
 Tue, 22 Sep 2026 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790069355; x=1821605355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VcmQrORzDPYON7a1kpg7FxVSiQsluwV+TAnKBk9x9PM=;
 b=TPmey4AxuYKAJGCFMlSCBxqhO73TC6RcsWvzcD+65NaFLS9lCdRVJ8M9
 GdTcPgs+aZJKtIhYOGH3txwXMZUZu4qVvCzG4YciGKb7C6kmutU/rEwkT
 CzeLVOVryTD8CTyDnfBK29b0z6kcbfOlaiX1kIDJpARhgufXpSnrYemaa
 baHQhuZQxFJAQB22dzxs0qQ0l6piWg5VUZIIsCtBjub7bv7adJXR/s6et
 bR2dTzq0HCpNPeoob20q9EciJtp4ODBXhFE+h0KaqE8S9tHgj6VAvKZaj
 jQHsiHUJh9s/EjVqS1h8E8+BY2UdDW0E7QaJGOYNZOQtFaTIos77iiVu7 Q==;
X-CSE-ConnectionGUID: tuJ3YI/6RYqZajOfTowOug==
X-CSE-MsgGUID: abg+hoNwSC6w9URKMbamvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108154047"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108154047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:29:14 -0700
X-CSE-ConnectionGUID: 9R2ZS9/bTa2fLoKaYAXD+g==
X-CSE-MsgGUID: cqIBjNuVR6qpFlWrxfGVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299295824"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa002.fm.intel.com with ESMTP; 22 Sep 2026 02:29:12 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tvrtko.ursulin@linux.intel.com, lyude@redhat.com, David.Francis@amd.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2 1/2] drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request to
 use actual video bandwidth
Date: Tue, 22 Sep 2026 17:26:46 +0800
Message-ID: <20260922092647.2263962-2-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922092647.2263962-1-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When computing the number of time slots for an MST stream,
intel_dp_mtp_tu_compute_config() was passing the TU-aligned PBN value
to drm_dp_atomic_find_time_slots() instead of the actual video
bandwidth PBN.

The aligned PBN is computed by rounding up the raw video bandwidth to
the nearest TU boundary and aligning to the hardware TU granularity
(4 / lane_count). This inflated PBN is then used as the requested PBN
in the ALLOCATE_PAYLOAD sideband message, causing the MST core's
bandwidth check in drm_dp_mst_atomic_check_port_bw_limit() to
incorrectly reject configurations that should fit within the available
link bandwidth.

Per DP v2.1b Section 2.6.4.1, the PBN in an ALLOCATE_PAYLOAD request
represents the video stream bandwidth and is independent of the source
TX link rate. The same video stream should result in the same PBN value
regardless of the link rate used on the source side. Passing the
TU-aligned PBN violates this requirement, as it incorporates link-rate-
specific TU granularity into the payload bandwidth value.

This was observed in a 3-display MST daisy-chain topology (PS8650 MST
hub → ViewSonic VP2468 × 2 → Lenovo Pro 27UD-10) where switching
Lenovo to 4K@60Hz failed with -ENOSPC despite the actual video
bandwidth fitting within the DFP link capacity. The inflated PBN of
the VP2468 streams (537 instead of the correct 532 for 1920x1080@60Hz)
consumed excess slots, leaving insufficient room for the 4K@60Hz stream.

Fix this by separating raw_pbn (the actual video bandwidth used for
payload allocation and ALLOCATE_PAYLOAD) from the aligned pbn (used
only for TU hardware programming). Pass raw_pbn to
drm_dp_atomic_find_time_slots() so that bandwidth accounting in the
MST core reflects the true stream requirements.

Depends-on: <20260908132844.2309047-1-xiaolu.xie@intel.com>
  ("drm/dp/mst: track allocated_pbn from ALLOCATE_PAYLOAD reply")

The companion patch above tracks the allocated_pbn returned in the
ALLOCATE_PAYLOAD reply from the branch device. Together with this fix,
the correct raw_pbn is used as the requested PBN in the
ALLOCATE_PAYLOAD request, and the allocated_pbn from the reply is used
for bandwidth limit checks. This pairing ensures that both the request
and the check accurately reflect the actual video stream bandwidth
and any per-hop capacity constraints along the MST path.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 33 +++++++++++++++------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 0c362784a..31e846aad 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -350,6 +350,7 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 		if (is_mst) {
 			int remote_bw_overhead;
 			int remote_tu;
+			int raw_pbn;
 			fixed20_12 pbn;
 
 			remote_bw_overhead = intel_dp_mst_bw_overhead(crtc_state,
@@ -369,9 +370,10 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 			 * crtc_state->dp_m_n.tu), provided that the driver doesn't
 			 * enable SSC on the corresponding link.
 			 */
-			pbn.full = dfixed_const(intel_dp_mst_calc_pbn(adjusted_mode->crtc_clock,
-								      link_bpp_x16,
-								      remote_bw_overhead));
+			raw_pbn = intel_dp_mst_calc_pbn(adjusted_mode->crtc_clock,
+							 link_bpp_x16,
+							 remote_bw_overhead);
+			pbn.full = dfixed_const(raw_pbn);
 			remote_tu = DIV_ROUND_UP(pbn.full, mst_state->pbn_div.full);
 
 			/*
@@ -384,11 +386,10 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 			remote_tu = ALIGN(remote_tu, 4 / crtc_state->lane_count);
 
 			/*
-			 * Also align PBNs accordingly, since MST core will derive its
-			 * own copy of TU from the PBN in drm_dp_atomic_find_time_slots().
-			 * The above comment about the difference between the PBN
-			 * allocated for the whole path and the TUs allocated for the
-			 * first branch device's link also applies here.
+			 * Keep the PBN corresponding to the aligned hardware TU separate
+			 * from raw_pbn. The aligned value describes the TU granularity of
+			 * the first downstream branch link; raw_pbn is the video bandwidth
+			 * value passed to the MST payload allocator and ALLOCATE_PAYLOAD.
 			 */
 			pbn.full = remote_tu * mst_state->pbn_div.full;
 
@@ -397,7 +398,21 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 
 			slots = drm_dp_atomic_find_time_slots(state, &intel_dp->mst.mgr,
 							      connector->mst.port,
-							      dfixed_trunc(pbn));
+							      raw_pbn);
+
+			drm_dbg_kms(display->drm,
+				    "MST TU %s pipe %c: clock=%d lanes=%d bpp=%d link_bpp=%d fec=%d\n",
+				    connector->base.name,
+				    pipe_name(to_intel_crtc(crtc_state->uapi.crtc)->pipe),
+				    crtc_state->port_clock, crtc_state->lane_count,
+				    fxp_q4_to_int(bpp_x16), fxp_q4_to_int(link_bpp_x16),
+				    crtc_state->fec_enable);
+			drm_dbg_kms(display->drm,
+				    "MST TU %s: overhead=%d raw_pbn=%d pbn=%d pbn_div=%d tu=%d slots=%d full_pbn=%d\n",
+				    connector->base.name,
+				    remote_bw_overhead, raw_pbn,
+				    dfixed_trunc(pbn), dfixed_trunc(mst_state->pbn_div),
+				    remote_tu, slots, connector->mst.port->full_pbn);
 
 			/* TODO: Check this already in drm_dp_atomic_find_time_slots(). */
 			if (slots > mst_state->total_avail_slots)
-- 
2.43.0

