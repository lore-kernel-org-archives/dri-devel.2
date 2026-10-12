Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2A3CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6034C10E4DB;
	Mon, 12 Oct 2026 04:16:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B47310EB45;
 Mon, 12 Oct 2026 04:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778570; x=1823314570;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xhEocHiFOuAzBuRkyKzkWlM8eQuFdv1ThXcWvEvQYbo=;
 b=HL+qzwNDKKj41uTQKK+lzQ3LsF2FKibD5VtLasEkRNuy5TsIbpq0bwmN
 4GE7E126XgeoLJuJiPDHY0hNvEx4sLJuEuvDQsxMBBiQVN39mgQiOWK79
 NqIQ2zSXuWH76ucA4a0P5S2LnEH+p5q6wtZPXA1+4Lnm0nFcuvESH9aCD
 QH0B9VIoa1TLdWppRIkwwQLGD+4Bo+J7yqUDZV442aEacck+TINxcaU8C
 D1OXLOjZsX2YqruysuIv94bXu/Php9/HbZuqCNTQrFtEtRIyzPfdVJgvL
 HGMigGfkkpnGV2d+JPbF6/bHsABvOcTKVpFRvm5bD6Lw9rJvVnqL3RDC6 w==;
X-CSE-ConnectionGUID: 1wECaXQwSYaAZVL3n/hsTA==
X-CSE-MsgGUID: RI1/ObHiRceEluE8wUX/zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366199"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:09 -0700
X-CSE-ConnectionGUID: 7JmNEpheQqu3FZPg1H31iw==
X-CSE-MsgGUID: w9HEB0W5SZmTLT0HTJNJMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256770"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:07 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 50/56] drm/i915/hdmi: Enable FRL based mode clock valid
Date: Mon, 12 Oct 2026 09:27:59 +0530
Message-ID: <20261012035806.3361439-51-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Higher resolution modes like 8K@60, 4K@120 need FRL support. Platforms
before MTL do not support FRL, so allow modes requiring more than 600MHz
dotclock to be enumerated only on MTL+ where FRL is supported.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index c57d99195ed0..e3dbd71a3652 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2115,8 +2115,11 @@ intel_hdmi_sink_format_valid(struct intel_connector *connector,
 static bool
 intel_hdmi_can_support_frl(struct intel_hdmi *intel_hdmi)
 {
-	/* TODO check for FRL support */
-	return false;
+	struct intel_display *display = to_intel_display(intel_hdmi);
+
+	return HAS_HDMI_FRL(display) &&
+	       intel_hdmi->has_sink_hdmi_21 &&
+	       intel_hdmi->max_frl_rate;
 }
 
 static enum drm_mode_status
@@ -2176,12 +2179,10 @@ intel_hdmi_mode_valid(struct drm_connector *_connector,
 	}
 
 	/*
-	 * HDMI2.1 requires higher resolution modes like 8k60, 4K120 to be
-	 * enumerated only if FRL is supported. Current platforms do not support
-	 * FRL so prune the higher resolution modes that require doctclock more
-	 * than 600MHz.
+	 * Platforms < MTL do not support FRL so prune the higher resolution
+	 * modes that require doctclock more than 600MHz.
 	 */
-	if (clock > 600000)
+	if (!intel_hdmi_can_support_frl(hdmi) && clock > 600000)
 		return MODE_CLOCK_HIGH;
 
 	if (drm_mode_is_420_only(info, mode)) {
-- 
2.50.1

