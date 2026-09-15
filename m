Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC81C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154B310F190;
	Tue, 15 Sep 2026 18:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L2Yq2cum";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7951D10F107;
 Tue, 15 Sep 2026 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497578; x=1821033578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+ZYn37Gy5DOa2WIDqHtxIUOSqmoOd+5/jBq4rJ8tfks=;
 b=L2Yq2cumWkZ2aMY9N09Kq+/WxvXbNDLO3OiMa6YGPatF3SFtYZQGAY7B
 0OgdxunvVLxsYnn/JCxA4tn1d7vqIyOxSbMAuhgPcwmrW3kQMDXshW/19
 zuATRFWbU4OE1e/d0VMv/D/fXEQxMY2y3C8W4upON+rzv4WOCQo+HixK0
 JPfgiM/OpMUWl9QzH7BHAP2rim4bqBmaG2BwRza+WojbWJqud86FVIXe5
 ToSV8xPh8cHnEQLF68veYlZIB2PQs6m+aOxHEzF23C7UhLI3YBdtNURNw
 o7SWTsszNukvpx1/lT4bCxasrN1nZHcJ9Wd+5c92mvhwL+6X4JcNOffZ+ g==;
X-CSE-ConnectionGUID: OpYEw0hVRV+x438zupmwzA==
X-CSE-MsgGUID: p+xdYATOQD62Vx3LqBo9vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380340"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:38 -0700
X-CSE-ConnectionGUID: IDrzGRa8SWi9A79Q6r7vow==
X-CSE-MsgGUID: PdEZ/BOCSsqj+gk46IIaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148547"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:36 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 14/18] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
Date: Tue, 15 Sep 2026 23:34:45 +0530
Message-Id: <20260915180449.277933-15-animesh.manna@intel.com>
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

Add a separate alpm_is_possible() which will check for alpm
capability from dpcd info.

v2: Drop DISPLAY_VER() check as intel_alpm_source_supported
already checking and populating dpcd info. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 13 ++++++++++---
 drivers/gpu/drm/i915/display/intel_alpm.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 06c1a59aa2c5..29a93a252fe9 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -69,6 +69,13 @@ void intel_alpm_init(struct intel_dp *intel_dp)
 	mutex_init(&intel_dp->alpm.lock);
 }
 
+bool intel_alpm_is_possible(struct intel_dp *intel_dp)
+{
+	return (intel_dp->alpm_dpcd ||
+		intel_dp->lttpr_common_caps[DP_LTTPR_ALPM_CAPABILITIES -
+					    DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV]);
+}
+
 static int get_silence_period_symbols(const struct intel_crtc_state *crtc_state)
 {
 	return SILENCE_PERIOD_TIME * intel_dp_link_symbol_clock(crtc_state->port_clock) /
@@ -546,7 +553,7 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	if (intel_dp->alpm.sink_alpm_error)
 		return;
 
-	if (!intel_dp_is_edp(intel_dp))
+	if (!intel_alpm_is_possible(intel_dp))
 		return;
 
 	if (DISPLAY_VER(display) < 20)
@@ -832,7 +839,7 @@ void intel_alpm_lobf_disable(const struct intel_crtc_state *new_crtc_state)
 
 		intel_dp = enc_to_intel_dp(encoder);
 
-		if (!intel_dp_is_edp(intel_dp))
+		if (!intel_alpm_is_possible(intel_dp))
 			continue;
 
 		mutex_lock(&intel_dp->alpm.lock);
@@ -873,7 +880,7 @@ void intel_alpm_lobf_enable(const struct intel_crtc_state *new_crtc_state)
 
 		intel_dp = enc_to_intel_dp(encoder);
 
-		if (intel_dp_is_edp(intel_dp)) {
+		if (intel_alpm_is_possible(intel_dp)) {
 			intel_alpm_enable_sink(intel_dp, new_crtc_state);
 			intel_alpm_configure(intel_dp, new_crtc_state);
 		}
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 9a02fa386ee3..ea90eba76ca7 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -18,6 +18,7 @@ struct intel_crtc;
 bool intel_alpm_source_supported(struct intel_connector *connector);
 bool intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
+bool intel_alpm_is_possible(struct intel_dp *intel_dp);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state);
 void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
-- 
2.29.0

