Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F22C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B3310E715;
	Tue, 15 Sep 2026 18:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LQFHxRIh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DF510E2B4;
 Tue, 15 Sep 2026 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497546; x=1821033546;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mveKwjeCsuuwsNz2Ea+05jvRGa7r6KEuuVf/zH0hfu8=;
 b=LQFHxRIh/eT26zDs87qsFFwnQcMg0L/Q+amzg9Jh7i15Ic/GxmWo1mQD
 TeXd8AIusDP/QgQw6y8XsS2RMJQfA9J9NyFEJrjsqXM8eVyuUkom032mi
 qov3BXmq1yTpexz+8TaFjkh4KT4ZyZA8vtpjEBVD+wlr8srsIt4mU5Ua9
 lQFdoD4Zs4sF1q/uyHPhxUT5pTknCpaS2PDGfmIuWKLEEkjzhOIds4cT+
 8KcJ+STpAa/grZekWMqDEMSzrWIUBMJ9x3V1rdzBU4K/mpmPus5QTo2UV
 7x40WCBgtlbfbhbHda4BRdrVQmoN1iE2Hy+R/tKFxbqDZFwEIvswX9u54 A==;
X-CSE-ConnectionGUID: QBHIAlgNT8mjMTQalC96eQ==
X-CSE-MsgGUID: XIDC/fiBSOm66olwiDlXfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380270"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380270"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:05 -0700
X-CSE-ConnectionGUID: CYefUYoHSd6plvaYgd9d1w==
X-CSE-MsgGUID: TTuZQCmgSc+bxn9+Rtd89g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148465"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:03 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 03/18] drm/i915/alpm: alpm_init() for DP2.1
Date: Tue, 15 Sep 2026 23:34:34 +0530
Message-Id: <20260915180449.277933-4-animesh.manna@intel.com>
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

Initialize ALPM for DP2.1 and separate out ALPM mutex-init
from alpm-init.

v2: Separate out mutex-init. [Jani]
v3: Refactor further to avoid DISPLAY_VER check in multiple places. [Jani]
v4: Cosmetic changes. [Suraj]
v5: Reset alpm_dpcd and simplify source-supported check.
v6: Drop display-version check for eDP for backward compatible.

Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 9 +++++++++
 drivers/gpu/drm/i915/display/intel_alpm.h | 1 +
 drivers/gpu/drm/i915/display/intel_dp.c   | 9 +++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index a6743fe62d48..4801fc6bade2 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -43,6 +43,15 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
 		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
 }
 
+bool intel_alpm_source_supported(struct intel_connector *connector)
+{
+	struct intel_display *display = to_intel_display(connector);
+
+	return (connector->base.connector_type == DRM_MODE_CONNECTOR_DisplayPort &&
+		DISPLAY_VER(display) >= 35) ||
+	        connector->base.connector_type == DRM_MODE_CONNECTOR_eDP;
+}
+
 bool intel_alpm_init_dpcd(struct intel_dp *intel_dp)
 {
 	u8 dpcd;
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 56c3e1482e37..9a02fa386ee3 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -15,6 +15,7 @@ struct intel_connector;
 struct intel_atomic_state;
 struct intel_crtc;
 
+bool intel_alpm_source_supported(struct intel_connector *connector);
 bool intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 650c8b39270b..b4742bd33cb4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6354,6 +6354,7 @@ intel_dp_detect(struct drm_connector *_connector,
 		connector->dp.panel_replay_caps.su_support = false;
 		connector->dp.panel_replay_caps.dsc_support =
 			INTEL_DP_PANEL_REPLAY_DSC_NOT_SUPPORTED;
+		intel_dp->alpm_dpcd = 0;
 
 		intel_dp_mst_disconnect(intel_dp);
 
@@ -6376,6 +6377,9 @@ intel_dp_detect(struct drm_connector *_connector,
 	if (ret == 1)
 		connector->base.epoch_counter++;
 
+	if (intel_alpm_source_supported(connector))
+		intel_alpm_init_dpcd(intel_dp);
+
 	if (!intel_dp_is_edp(intel_dp))
 		intel_psr_init_dpcd(intel_dp, connector);
 
@@ -7019,8 +7023,6 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	 */
 	intel_hpd_enable_detection(encoder);
 
-	intel_alpm_init(intel_dp);
-
 	/* Cache DPCD and EDID for edp. */
 	has_dpcd = intel_edp_init_dpcd(intel_dp, connector);
 
@@ -7235,6 +7237,9 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 
 	intel_psr_init(intel_dp);
 
+	if (intel_alpm_source_supported(connector))
+		intel_alpm_init(intel_dp);
+
 	return true;
 
 fail:
-- 
2.29.0

