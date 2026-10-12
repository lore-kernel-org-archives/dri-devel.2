Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF6CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B387A10E480;
	Mon, 12 Oct 2026 04:15:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B9F10E421;
 Mon, 12 Oct 2026 04:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778491; x=1823314491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bHpF7rnx79q5+D3VbOjZL/KegwWhbwt8v9e40Tot9/k=;
 b=QTf4h4JOADMUKn/dfjubix9sPwftN0/ObYVbX60vQWra52M/nneK5Ipa
 nM+qSnPNj2OTY7U05F7RSowFtNUxurBSJ6sbGliWvk0ZHhp40Fr46fYAN
 XjC8XFi5RsJ2dsgbtLpwT+jlZJyt98fP9dRlUSRwG5f1bnfiorbqXAqaW
 SP4d2vTI1yh1tjFf3y8nasWmB/IaLnZTPlb9RoX5Fb6DUod4NTz7wd5AO
 cVgiN7AX0Y7PQ2Ab9oTQ4s7lt3RryuiqkdnUgpMfIyxYKNXvVfcYJGj01
 4px2CaBcvSce7p1FEEHzNr8x4R3gimJBz2mncdzp6nMHzINBTXSGu0YkQ g==;
X-CSE-ConnectionGUID: d6WHnQIRQOG1Ue4TUEQmug==
X-CSE-MsgGUID: I12RdE3bSjmBpq2yBipQMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380851"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380851"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:50 -0700
X-CSE-ConnectionGUID: U/0YCkewQoiZRZ2vN/GeOw==
X-CSE-MsgGUID: 9InlV3vmT1S+DGZAoHmkOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256407"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:49 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 16/56] drm/i915/hdmi: Reduce FRL rate cap on rate change
 during training
Date: Mon, 12 Oct 2026 09:27:25 +0530
Message-ID: <20261012035806.3361439-17-ankit.k.nautiyal@intel.com>
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

If the sink requests a rate change during FRL Link training, reduce
frl.rate_cap to the next lower FRL rate. The next mode compute then
uses this lower rate cap, so we do not attempt the failing rate again.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index fa4e5f0f567b..11b4554e87bd 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3763,6 +3763,18 @@ intel_hdmi_frl_train_lts3(struct intel_encoder *encoder,
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
@@ -3779,6 +3791,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	int req_rate = crtc_state->frl.required_lanes * crtc_state->frl.required_rate;
 	int ffe_level = get_ffe_level(req_rate);
 	enum frl_lt_status status;
+	int next_rate = -EINVAL;
 
 	if (!crtc_state->frl.enable)
 		return 0;
@@ -3812,10 +3825,22 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
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

