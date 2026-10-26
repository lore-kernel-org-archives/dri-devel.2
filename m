Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325A606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XhEeSJNj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686C110E973;
	Mon, 26 Oct 2026 05:40:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B1110E965;
 Mon, 26 Oct 2026 05:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993225; x=1824529225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PhW6qsp2E/4EtS3MTIFWuzXeEv6TpTLsfh4bHU82vsU=;
 b=XhEeSJNj1RtbHxvHiTYJof4iObbo9eJ5N6SKiteUkYdSmb2SnT12eb+d
 q5FSMHJjHKOwYPN4I6ZvE9zZJ5YYQE60HE9I+B/fnpzH5xSUq40mK9Pa6
 FsP0YKlS9v7BdC9o3MGwHJ/yll07N2On2sY8SnUDdmyPer3MwnovtjkbI
 IpPlH0ZUQ+csQZ2Jbw235+e6U//HT7ipxNZNfQ2VcmrbX2NTaLUtuQF41
 hvp3wpyiqaXWWcqZg74MRkC53KNOK0rr1J0h8yNDNJ1hVMzixWqSukrts
 3KQc1h/PQYqnBTbRMkVOD+XSSdLrGuBY09vU58AXWm8Z1bJoNOFqwuA4I A==;
X-CSE-ConnectionGUID: n/IfmjVQSLqfzqD6J+TACA==
X-CSE-MsgGUID: PspeTJf3Qmu2pu8wpmLa1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550172"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550172"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:25 -0700
X-CSE-ConnectionGUID: ys3I3ovoRzWW/Twdw0rx6w==
X-CSE-MsgGUID: Ev2CFWJOTCexEmfPwgZq4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001855"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:23 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 04/20] drm/i915/alpm: alpm_init() for DP2.1
Date: Mon, 26 Oct 2026 11:09:15 +0530
Message-ID: <20261026054001.799894-5-animesh.manna@intel.com>
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

Initialize ALPM for DP2.1 and separate out ALPM mutex-init
from alpm-init.

v2: Separate out mutex-init. [Jani]
v3: Refactor further to avoid DISPLAY_VER check in multiple places. [Jani]
v4: Cosmetic changes. [Suraj]
v5: Reset alpm_dpcd and simplify source-supported check.
v6: Drop display-version check for eDP for backward compatible.
v7:
- Read ALPM DPCD in detect only for DP, eDP already does it. [Jouni]
- Move source-supported check into intel_alpm_init/_dpcd(). [Jouni]
- Check source support instead of sink caps in intel_alpm_disable()
  as alpm_dpcd is reset on disconnect before the CRTC is disabled.
  [Sashiko]

Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_dp.c   |  9 ++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index cb1d68fef198..b6307862b756 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -43,11 +43,21 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
 		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
 }
 
+static bool intel_alpm_source_supported(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	return intel_dp_is_edp(intel_dp) || DISPLAY_VER(display) >= 35;
+}
+
 int intel_alpm_init_dpcd(struct intel_dp *intel_dp)
 {
 	u8 dpcd;
 	int ret;
 
+	if (!intel_alpm_source_supported(intel_dp))
+		return 0;
+
 	ret = drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP, &dpcd);
 	if (ret < 0)
 		return ret;
@@ -59,6 +69,9 @@ int intel_alpm_init_dpcd(struct intel_dp *intel_dp)
 
 void intel_alpm_init(struct intel_dp *intel_dp)
 {
+	if (!intel_alpm_source_supported(intel_dp))
+		return;
+
 	mutex_init(&intel_dp->alpm.lock);
 }
 
@@ -750,7 +763,11 @@ void intel_alpm_disable(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	enum transcoder cpu_transcoder = intel_dp->alpm.transcoder;
 
-	if (DISPLAY_VER(display) < 20 || !intel_dp->alpm_dpcd)
+	/*
+	 * Don't check sink ALPM caps here, they are reset on disconnect
+	 * before the CRTC is disabled.
+	 */
+	if (DISPLAY_VER(display) < 20 || !intel_alpm_source_supported(intel_dp))
 		return;
 
 	mutex_lock(&intel_dp->alpm.lock);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 816337efeb91..c543fe551eb8 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6607,6 +6607,7 @@ intel_dp_detect(struct drm_connector *_connector,
 		connector->dp.panel_replay_caps.su_support = false;
 		connector->dp.panel_replay_caps.dsc_support =
 			INTEL_DP_PANEL_REPLAY_DSC_NOT_SUPPORTED;
+		intel_dp->alpm_dpcd = 0;
 
 		intel_dp_mst_disconnect(intel_dp);
 
@@ -6629,8 +6630,10 @@ intel_dp_detect(struct drm_connector *_connector,
 	if (ret == 1)
 		connector->base.epoch_counter++;
 
-	if (!intel_dp_is_edp(intel_dp))
+	if (!intel_dp_is_edp(intel_dp)) {
+		intel_alpm_init_dpcd(intel_dp);
 		intel_psr_init_dpcd(intel_dp, connector);
+	}
 
 	intel_dp_detect_dsc_caps(intel_dp, connector);
 
@@ -7272,8 +7275,6 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	 */
 	intel_hpd_enable_detection(encoder);
 
-	intel_alpm_init(intel_dp);
-
 	/* Cache DPCD and EDID for edp. */
 	has_dpcd = intel_edp_init_dpcd(intel_dp, connector);
 
@@ -7488,6 +7489,8 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 
 	intel_psr_init(intel_dp);
 
+	intel_alpm_init(intel_dp);
+
 	return true;
 
 fail:
-- 
2.43.0

