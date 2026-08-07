Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6C9C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228CE10F38A;
	Fri,  7 Aug 2026 04:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IL3aQwxo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9092010F37A;
 Fri,  7 Aug 2026 04:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077130; x=1817613130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pWRELeUPzDls68T8C5CG7z6YNQLtrvJKMe0JjSjempE=;
 b=IL3aQwxoblA+adBmHc4KHVbzjsXPAC68Z4orDZxtwnpwMvqSNkBvLa5s
 r6QTITF8vD+0mbrw/p8q3L0BX3lS4ZqT3Ij45bYjBytyctzOtS7y2F24m
 JTt6krtzJ7NsiF8B+/eDl1d0gBMOCl3ji0N+LBxx1or9C0GfVbN0GXTLZ
 glSHbI/s9OKgLSzM8501xcTcIRYH7IdAMWvBbqSypWUAdnSsoDpC3P2k4
 VTntCoogJIH82QGgERKT0lPXt94vpzjnQThO8tqKAgJLZLxSRpElJh+eG
 CnF32rkq/3yn6bb4jG3Ey52ZFkaG8jM58vT2DYB3O1g0cMmOBCQAlQM2N Q==;
X-CSE-ConnectionGUID: 6VAjaJH7RBurSjSdfBCgAQ==
X-CSE-MsgGUID: h1VCcO0PQ9qy5hjeDydkng==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619273"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619273"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:09 -0700
X-CSE-ConnectionGUID: u1NQCuIFR/iOfF0xb8uHrw==
X-CSE-MsgGUID: 6MDLKRqiTxunCF88Q4g/OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666185"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:07 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 16/44] drm/i915/hdmi: Reduce FRL rate cap on rate change
 during training
Date: Fri,  7 Aug 2026 09:44:01 +0530
Message-ID: <20260807041430.229038-17-ankit.k.nautiyal@intel.com>
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

If the sink requests a rate change during FRL Link training, reduce
frl.rate_cap to the next lower FRL rate. The next mode compute then
uses this lower rate cap, so we do not attempt the failing rate again.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index fe4923c82463..2b0cdb0719e2 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3720,6 +3720,18 @@ intel_hdmi_frl_train_lts3(struct intel_encoder *encoder,
 	return frl_train_complete_ltsp(encoder, crtc_state);
 }
 
+static int get_next_frl_rate(int curr_rate_gbps)
+{
+	int valid_rate[] = { 48, 40, 32, 24, 18, 9 };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_rate); i++)
+		if (valid_rate[i] < curr_rate_gbps)
+			return valid_rate[i];
+
+	return -EINVAL;
+}
+
 static int get_ffe_level(int rate_gbps)
 {
 	return 0;
@@ -3736,6 +3748,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	int req_rate = crtc_state->frl.required_lanes * crtc_state->frl.required_rate;
 	int ffe_level = get_ffe_level(req_rate);
 	enum frl_lt_status status;
+	int next_rate = -EINVAL;
 
 	if (!crtc_state->frl.enable)
 		return 0;
@@ -3769,10 +3782,22 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 			    connector->base.id, connector->name,
 			    intel_hdmi->frl.rate_gbps);
 		return 0;
-	default:
+	case FRL_TRAIN_STOP:
+		next_rate = 0;
+		break;
+	case FRL_CHANGE_RATE:
+		next_rate = get_next_frl_rate(req_rate);
 		break;
+	case FRL_TRAIN_RETRAIN:
+		fallthrough;
+	default:
+		goto ltsl_tmds_mode;
 	}
 
+	if (next_rate >= 0)
+		intel_hdmi->frl.rate_cap = next_rate;
+
+ltsl_tmds_mode:
 	if (crtc_state->frl.enable && !intel_hdmi->frl.trained)
 		drm_err(display->drm,
 			"[CONNECTOR:%d:%s] FRL Training Failed with rate=%d\n",
-- 
2.50.1

