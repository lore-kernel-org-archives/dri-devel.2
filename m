Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA64C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F2610E28E;
	Tue, 15 Sep 2026 18:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZyvUsY0x";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D8010E28E;
 Tue, 15 Sep 2026 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497543; x=1821033543;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4sC4xICaWpkU0/BfMDA17xOpNk3w6Hxfn+wy+/jD778=;
 b=ZyvUsY0xALMw9K99CMkmOVbqDbkowdbJ77RmUcaCupGM05laMkJqJyzS
 W94jkrJo/b3TeJ7hHU/51bEANopQ+aVxD7HRPBKDsUgO2on4aR1LQVIiT
 hyNT0e0f9lnTSXfu8nq7gr8iQslj+J2Gwn9MPb6ofENVF5QHgYBWkAWTU
 uQBJ3mU5BfdIpiO8CFPFSg/1jYNYco941w5JMILCxyEgxUSaT+iefOIX+
 f2KRo5REpaWuGeVurhKpDrcH0Exjc5t25GQdWEmWkPzOnqmbwjXr/hdDm
 A3fSBXUNHBIfgJ36YMnkhgx3Xz+dzc/YA7V8HLRwK5pLMNfTAStrzeW3R g==;
X-CSE-ConnectionGUID: q6kg86OhTkuaxbpym0FOqw==
X-CSE-MsgGUID: ODGRELLFQP29V9rI4DZAXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380265"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:02 -0700
X-CSE-ConnectionGUID: 7D76uYXjTkaIM36swKx/4g==
X-CSE-MsgGUID: nOs3HkgYRhmVm5mBMuAiew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148459"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:00 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 02/18] drm/i915/alpm: Move alpm sink capability readout
 into a separate function
Date: Tue, 15 Sep 2026 23:34:33 +0530
Message-Id: <20260915180449.277933-3-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
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

Abstract ALPM DPCD initialization into its own function.

v2:
- Improve commit description. [Suraj, Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_alpm.h |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c   |  6 +-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 10943539bc7c..a6743fe62d48 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -43,6 +43,17 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
 		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
 }
 
+bool intel_alpm_init_dpcd(struct intel_dp *intel_dp)
+{
+	u8 dpcd;
+
+	if (drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP, &dpcd) < 0)
+		return false;
+
+	intel_dp->alpm_dpcd = dpcd;
+	return true;
+}
+
 void intel_alpm_init(struct intel_dp *intel_dp)
 {
 	mutex_init(&intel_dp->alpm.lock);
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index f8f605d94f96..56c3e1482e37 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -15,6 +15,7 @@ struct intel_connector;
 struct intel_atomic_state;
 struct intel_crtc;
 
+bool intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0cd5e6b5034c..650c8b39270b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4783,7 +4783,6 @@ static bool
 intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
-	int ret;
 	u8 dprx;
 
 	/* this function is meant to be called only once */
@@ -4829,10 +4828,7 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector
 	 */
 	intel_dp_init_source_oui(intel_dp);
 
-	/* Read the ALPM DPCD caps */
-	ret = drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP,
-				    &intel_dp->alpm_dpcd);
-	if (ret < 0)
+	if (!intel_alpm_init_dpcd(intel_dp))
 		return false;
 
 	/*
-- 
2.29.0

