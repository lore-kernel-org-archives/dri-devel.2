Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A47CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B279910FBFE;
	Wed, 14 Oct 2026 08:17:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD25510FBEF;
 Wed, 14 Oct 2026 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791965827; x=1823501827;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IhJ/XA9BS8b/F4VkAfBryr0zzYa4M6J+aQ0MEbY5cJw=;
 b=jkUdauFXfWUs2AuSvP8zRFHrXAabbjqsza65r2qTrQb8IF4pludOzPMo
 nzebX88hssUG7ejCnvmbpJL/xOT6utGup3NwA2zcnDPayj6rrB7z/ZJe8
 rdrZEibu+ubO9wLylYnuKZTGTO3kQo2cHCtuGjeow1154nLPEFMjoIfJf
 BbLBY725yHKn5/wfMIDJEZ9AJ5BiRex/Q62nNOQFRCJq4vi0e++w/Nsy4
 fhgMgdYy/6OLUHz+utISNcimt6PojspYsYodTHsHyCgqluikRm73aeQdN
 Wg5Fjbc4cBSCyFl5kVG+PJK1NxrdFyNsHdbHO9L1NkprA1INx6ZoVj1U0 A==;
X-CSE-ConnectionGUID: 61y6sjGBRU2rL3UXiS2klA==
X-CSE-MsgGUID: YDDyCtrERRaMpoFt3fKPCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="584069"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="584069"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 01:17:07 -0700
X-CSE-ConnectionGUID: ysAE8+GIQh+TngSABg4hXA==
X-CSE-MsgGUID: PMnoT73FTRSO4lovkGDGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1331687"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa001.jf.intel.com with ESMTP; 14 Oct 2026 01:17:04 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 imre.deak@intel.com, jani.nikula@linux.intel.com, lyude@redhat.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH] drm/i915/dp: clear and restore MSTM_CTRL around MST DPMS
 off/on
Date: Wed, 14 Oct 2026 16:14:48 +0800
Message-ID: <20261014081448.2320363-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
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

When the last MST stream is disabled, i915 sends SET_POWER D3 to the
MST trunk while MSTM_CTRL (DPCD 0x111) still has MST mode enabled.
On re-enable, POWER_UP_PHY is sent before MSTM_CTRL is restored, so
the hub may process the PHY power-up in an inconsistent state and
fail to retrain its downstream links.

Fix this by clearing MSTM_CTRL before sending D3 on the last stream
disable, mirroring what drm_dp_mst_topology_mgr_set_mst() does on
MST disconnect. On re-enable, restore MSTM_CTRL after writing D0 and
before sending POWER_UP_PHY, so the hub is back in MST mode when it
processes the PHY power-up and retrains its downstream links.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c    | 2 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a46ab5d3d..7e4e18345 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3163,6 +3163,8 @@ static void intel_ddi_post_disable_dp(struct intel_atomic_state *state,
 	 * Power down sink before disabling the port, otherwise we end
 	 * up getting interrupts from the sink on detecting link loss.
 	 */
+	if (is_mst)
+		drm_dp_dpcd_write_byte(&intel_dp->aux, DP_MSTM_CTRL, 0);
 	intel_dp_set_power(intel_dp, DP_SET_POWER_D3);
 
 	if (DISPLAY_VER(display) >= 12) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 7023619aa..4109bb928 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1270,8 +1270,12 @@ static void mst_stream_pre_enable(struct intel_atomic_state *state,
 	drm_WARN_ON(display->drm, DISPLAY_VER(display) >= 12 && first_mst_stream &&
 		    !intel_dp_mst_is_master_trans(pipe_config));
 
-	if (first_mst_stream)
+	if (first_mst_stream) {
 		intel_dp_set_power(intel_dp, DP_SET_POWER_D0);
+		drm_dp_dpcd_write_byte(&intel_dp->aux, DP_MSTM_CTRL,
+				       DP_MST_EN | DP_UP_REQ_EN |
+				       DP_UPSTREAM_IS_SRC);
+	}
 
 	drm_dp_send_power_updown_phy(&intel_dp->mst.mgr, connector->mst.port, true);
 
-- 
2.43.0

