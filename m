Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40667C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8F710F37C;
	Fri,  7 Aug 2026 04:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GekkoROX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998F710F37A;
 Fri,  7 Aug 2026 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077129; x=1817613129;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hGCdCTNnH1VPTlc5l8J33xfbQTVkEAa0+LNqLobwMyU=;
 b=GekkoROXbqRXdF/Zb71yUsoTpRPEyj6r4Dy94rHyVZ1EAlei6K7kmvpM
 pDBa2Aq7AY95MvFJZL70Ms1QVmOZBNFys4nxSTjtpUoP11XQjcpekuZBL
 ayImcnmdUq9a0hcnhsdrCYw6O7gf1mTbG89tMeXdPYVOfz+33iw6AxqHo
 9G5nZPtNeY7cKLPDr0wT/vgBVCMAxGKCH/Gs9zUz97FneAhjXNMSqLVVo
 FBigirgZ2GnEySVv9BGumLM0GC21B1SiyC14k5JC3U9BIrOVZ3oOCzK6E
 XiX0ySm82L2wZqdLcUhANM+Valw7IJbhAmxCN9OOdhuJNKM43s7IaQksL w==;
X-CSE-ConnectionGUID: tIrfGZ8YQDaLFf4CIE2+fw==
X-CSE-MsgGUID: 8nwn+nxXTwiflOgWUf/NQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619271"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619271"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:08 -0700
X-CSE-ConnectionGUID: m6cme1PoShqh1BzK4ZMNEA==
X-CSE-MsgGUID: P5ieKCK3QparWk0iDSQzqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666174"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:04 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 15/44] drm/i915/intel_hdmi: Add helper to disable FRL
Date: Fri,  7 Aug 2026 09:44:00 +0530
Message-ID: <20260807041430.229038-16-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Add function to reset the SCDC FRL configuration and
Transcoder FRL configuration registers.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 28 +++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ff200d662a3f..fe4923c82463 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3781,3 +3781,31 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 
 	return -EINVAL;
 }
+
+static void intel_hdmi_frl_ltsl(struct intel_encoder *encoder,
+				const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct i2c_adapter *adapter =
+		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
+
+	drm_scdc_disable_frl(adapter);
+	drm_scdc_clear_update_flags(adapter, SCDC_FLT_UPDATE);
+}
+
+void intel_hdmi_disable_frl(struct intel_encoder *encoder,
+			    const struct intel_crtc_state *crtc_state)
+{
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+	struct intel_display *display = to_intel_display(encoder);
+	enum transcoder trans = crtc_state->cpu_transcoder;
+
+	if (!crtc_state->frl.enable)
+		return;
+
+	intel_hdmi_frl_ltsl(encoder, crtc_state);
+	intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, trans),
+		     TRANS_HDMI_FRL_ENABLE | TRANS_HDMI_FRL_TRAINING_COMPLETE, 0);
+
+	intel_hdmi_reset_frl_config(intel_hdmi);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 1724e6075a9b..59a561ad28e0 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -66,6 +66,8 @@ bool intel_hdmi_is_frl(u32 clock);
 void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state);
 int intel_hdmi_start_frl(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state);
+void intel_hdmi_disable_frl(struct intel_encoder *encoder,
+			    const struct intel_crtc_state *crtc_state);
 void hsw_write_infoframe(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state,
 			 unsigned int type,
-- 
2.50.1

