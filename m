Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF0606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jidIZzOx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE96510E992;
	Mon, 26 Oct 2026 05:41:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED4610E99C;
 Mon, 26 Oct 2026 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993263; x=1824529263;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/9mTBotJD8PHlnAIFufTMMp08uqP64z+hJB2OoAVBMc=;
 b=jidIZzOxqmL79pyeLu8b/Jockv0O4SeklZxBh/WOUZUI9A3hP8oRS8K5
 I79Iiii/RYFJqv2SwBlp18oOATnYeCMqWCTv821egzC4Jb8ZV8aWOejFk
 X9RURWjf29thSs/qX1YIxgoJB2nGzxl6W94RMcQ2C14vwMBAkqqihhmAe
 uF6f6gxvZxRWC+g6TUvLay3G+kmCPEL8T63Ck0nkUzN7LLFT8sZVzRxro
 eTfZUf/N326hlcXJlsGqf07t/+40FXiCnGFAGmbZNDIwCl7ucjTXlDtAb
 7m+fiIlj13x7xJwkJr2KjaXkqm2Qo7QsXxXyS5n7XkF9e8CTgtr1/gyjw w==;
X-CSE-ConnectionGUID: R+mW2h7uTxipa9pYzlLwHg==
X-CSE-MsgGUID: OJVUzP+sRXmfQVaQgDU+WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550216"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550216"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:41:02 -0700
X-CSE-ConnectionGUID: AkFSsDNRSBaIDH9aur/inw==
X-CSE-MsgGUID: u5X+fzaSRF6gz/QiRSHD1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6002011"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:41:00 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 16/20] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
Date: Mon, 26 Oct 2026 11:09:27 +0530
Message-ID: <20261026054001.799894-17-animesh.manna@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a separate alpm_is_possible() which will check for alpm
capability from dpcd info.

ALPM is possible if the sink supports AUX-wake or AUX-less ALPM. With
LTTPRs present only AUX-less ALPM is possible, so both the sink and the
LTTPRs must support AUX-less ALPM.

LOBF enable/disable are only called based on has_lobf in the crtc state,
which is computed using alpm_is_possible(), so drop the capability check
from there. This also avoids leaving ALPM_CTL enabled on hot-unplug, as
the sink capabilities are reset before LOBF is disabled.

v2: Drop DISPLAY_VER() check as intel_alpm_source_supported
already checking and populating dpcd info. [Jouni]
v3:
- Check ALPM capability bits of sink and LTTPR. [sashiko]
- Drop alpm_is_possible() check from LOBF enable/disable. [Jouni, sashiko]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 30 +++++++++++++++++------
 drivers/gpu/drm/i915/display/intel_alpm.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 4e761022485d..205f1ae10d43 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -76,6 +76,25 @@ void intel_alpm_init(struct intel_dp *intel_dp)
 	mutex_init(&intel_dp->alpm.lock);
 }
 
+bool intel_alpm_is_possible(struct intel_dp *intel_dp)
+{
+	u8 lttpr_alpm_caps;
+
+	if (!(intel_dp->alpm_dpcd & (DP_ALPM_CAP | DP_ALPM_AUX_LESS_CAP)))
+		return false;
+
+	if (drm_dp_lttpr_count(intel_dp->lttpr_common_caps) <= 0)
+		return true;
+
+	/* With LTTPRs only AUX-less ALPM is possible and LTTPRs must support it */
+	lttpr_alpm_caps =
+		intel_dp->lttpr_common_caps[DP_LTTPR_ALPM_CAPABILITIES -
+					    DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	return intel_alpm_aux_less_wake_supported(intel_dp) &&
+	       lttpr_alpm_caps & DP_LTTPR_AUX_LESS_ALPM_SUPPORTED;
+}
+
 static int get_silence_period_symbols(const struct intel_crtc_state *crtc_state)
 {
 	return SILENCE_PERIOD_TIME * intel_dp_link_symbol_clock(crtc_state->port_clock) /
@@ -537,7 +556,7 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	if (intel_dp->alpm.sink_alpm_error)
 		return;
 
-	if (!intel_dp_is_edp(intel_dp))
+	if (!intel_alpm_is_possible(intel_dp))
 		return;
 
 	if (DISPLAY_VER(display) < 20)
@@ -829,9 +848,6 @@ void intel_alpm_lobf_disable(const struct intel_crtc_state *new_crtc_state)
 
 		intel_dp = enc_to_intel_dp(encoder);
 
-		if (!intel_dp_is_edp(intel_dp))
-			continue;
-
 		mutex_lock(&intel_dp->alpm.lock);
 		intel_de_write(display, ALPM_CTL(display, cpu_transcoder), 0);
 		drm_dbg_kms(display->drm, "Link off between frames (LOBF) disabled\n");
@@ -870,10 +886,8 @@ void intel_alpm_lobf_enable(const struct intel_crtc_state *new_crtc_state)
 
 		intel_dp = enc_to_intel_dp(encoder);
 
-		if (intel_dp_is_edp(intel_dp)) {
-			intel_alpm_enable_sink(intel_dp, new_crtc_state);
-			intel_alpm_configure(intel_dp, new_crtc_state);
-		}
+		intel_alpm_enable_sink(intel_dp, new_crtc_state);
+		intel_alpm_configure(intel_dp, new_crtc_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 1cb226bc342a..9319572c221e 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -17,6 +17,7 @@ struct intel_crtc;
 
 int intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
+bool intel_alpm_is_possible(struct intel_dp *intel_dp);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state);
 void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
-- 
2.43.0

