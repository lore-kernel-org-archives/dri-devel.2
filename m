Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82331CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C08910E433;
	Mon, 12 Oct 2026 04:14:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72E610E457;
 Mon, 12 Oct 2026 04:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778488; x=1823314488;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3SgvJpnzVWDCkN1G2OD6YT6isoAwK4s3pzLA8c0JX7Q=;
 b=fAK4ABm0g/PQkBKt1eG4LlopNb/pljEAbyaXPzY/vdRx+b+RobrhJsgH
 WDjH5/cXfUKAfN8VtU6dL8UVnDgjCuHTwn/WgeTOUeOdHlE0iirv8xnPp
 Rcy3ycCAkzqijn1Dz60cz/ns3yt9ua3AdlboKiEOrfyGar1d35dObPE+Q
 LlgSSfqHj0jYs9d6lv7fDLEgFw1CjSpfZn3jNZaFHyDWHXR6oYvA5siQ6
 py+UyEoxPk9DpFjpmxVEKKcfGRxstCl5r9i5YNBn1ZhjPhjqb+5oiZ7pU
 rY6zQ5giZztnaae2PcY667pex8C9rEvrEcQWHRRdYv1CQb9mMW1S5fjp7 A==;
X-CSE-ConnectionGUID: +SXEcsO4SAWO4YnVmGFrJQ==
X-CSE-MsgGUID: Ps8MyqzVSDKmkPtULH9f1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380850"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:48 -0700
X-CSE-ConnectionGUID: 1Zx80JMqSzaiAnnEcJlsEw==
X-CSE-MsgGUID: plFterajShmiK0cLlk5ILQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256402"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:47 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 15/56] drm/i915/intel_hdmi: Add helper to disable FRL
Date: Mon, 12 Oct 2026 09:27:24 +0530
Message-ID: <20261012035806.3361439-16-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
index 47d10ae0b07f..fa4e5f0f567b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3824,3 +3824,31 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 
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

