Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4113606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ag6tYi6W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265BD10E991;
	Mon, 26 Oct 2026 05:41:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3937210E965;
 Mon, 26 Oct 2026 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993253; x=1824529253;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wLRVvx39bv5eLZwIi7y5VlkPjCGbKbU5Ks/gD85gXDE=;
 b=ag6tYi6W6b8QWCq9lOlzoksRm62w46+B9Yu/NQZZRIQgOvQG+2U80WUa
 EDeVG0Pe9No8imgUb4fxqKhZ4RF3zhWO7WZkMvi/SeqjT1nCg8eUGXfsj
 BxzfQYgTqI6Ael5H3BRbRH2su/5AOksdFToVV6bMFsvKOUmPBHRpoeN2+
 jIw3TZ6U9vnaeb7T6HoXYaWvX/zBNcU38uBOPh6Ec8wOybcCj3iCiBPGp
 kIniBCRWD+UzRq84sPlbgxxYsHGkGCQlvrH3pNm2kviv2xrmcUXGrZThu
 nxwHt033ZAefP+HCm4C40SUe+xEjc69FWPeQrIT2F7ZfwIkHocn5ES4xT w==;
X-CSE-ConnectionGUID: Si3UpUr/SdqU1u5eX0F+IQ==
X-CSE-MsgGUID: hugacVP0QQavG33EaufiZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550206"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550206"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:53 -0700
X-CSE-ConnectionGUID: ytLLeDkvQU+v3bL7FaBr7Q==
X-CSE-MsgGUID: qqRdx85cTZKE4T7q5P8kKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001962"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:51 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 13/20] drm/i915/alpm: Program LTTPR count for DP 2.1 ALPM
Date: Mon, 26 Oct 2026 11:09:24 +0530
Message-ID: <20261026054001.799894-14-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Issue a AUX write transaction to DPCD DP_TOTAL_LTTPR_CNT (0xf000a)
with total number of LTTPR before link training.

v2: Cosmetic changes. [Suraj]
v3:
- Use same encoding format for lttpr_count. [Jouni]
- Avoid reading alpm_ctl2 register. [Jouni]
v4:
- Program DP_TOTAL_LTTPR_CNT only for DP, not eDP. [Jouni, sashiko]
- Drop redundant lttpr_count check. [Jouni, sashiko]
- Check drm_dp_lttpr_count() return value before programming
  ALPM_CTL2. [Jouni, sashiko]
- Fix LTTPR revision check to match the comment. [sashiko]
- Use drm_dp_dpcd_write_byte(). [Jani]

Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 10 +++++++++-
 .../drm/i915/display/intel_dp_link_training.c | 20 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index f3c0884989ce..831dfa5e677b 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -687,7 +687,8 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
-	u32 alpm_ctl;
+	u32 alpm_ctl, alpm_ctl2;
+	int lttpr_count;
 
 	if (DISPLAY_VER(display) < 20 || (!intel_psr_needs_alpm(intel_dp, crtc_state) &&
 					  !crtc_state->has_lobf))
@@ -725,6 +726,13 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 
 	alpm_ctl |= ALPM_CTL_ALPM_ENTRY_CHECK(crtc_state->alpm_state.check_entry_lines);
 
+	lttpr_count = drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
+	if (lttpr_count < 0)
+		lttpr_count = 0;
+
+	alpm_ctl2 = ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);
+
+	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
 	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
 	mutex_unlock(&intel_dp->alpm.lock);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index ac1aff6edf05..0dbc6174c402 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -2271,6 +2271,24 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
 	return passed;
 }
 
+static void intel_dp_update_lttpr_count(struct intel_dp *intel_dp)
+{
+	u8 val;
+
+	/*
+	 * Program only for DP and return if LTTPR revision is less than 0x20
+	 * where 0:3 represents minor rev and 4:7 represent major rev
+	 */
+	if (intel_dp_is_edp(intel_dp) ||
+	    intel_dp->lttpr_common_caps[0] < 0x20)
+		return;
+
+	val = intel_dp->lttpr_common_caps[DP_PHY_REPEATER_CNT -
+					  DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+	if (drm_dp_dpcd_write_byte(&intel_dp->aux, DP_TOTAL_LTTPR_CNT, val) < 0)
+		lt_dbg(intel_dp, DP_PHY_DPRX, "Failed to write total LTTPR count\n");
+}
+
 /**
  * intel_dp_start_link_train - start link training
  * @state: Atomic state
@@ -2310,6 +2328,8 @@ void intel_dp_start_link_train(struct intel_atomic_state *state,
 
 	intel_dp_prepare_link_train(intel_dp, crtc_state);
 
+	intel_dp_update_lttpr_count(intel_dp);
+
 	if (intel_dp_is_uhbr(crtc_state))
 		passed = intel_dp_128b132b_link_train(intel_dp, crtc_state, lttpr_count);
 	else
-- 
2.43.0

