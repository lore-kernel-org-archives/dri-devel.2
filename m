Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C778CA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36ECF10E4CC;
	Mon, 12 Oct 2026 04:15:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FC210E5AE;
 Mon, 12 Oct 2026 04:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778533; x=1823314533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7/GhvrZg6vuyI8cldj8+snGLh3hugFIZSlCry8RyeS8=;
 b=RkTZmlZUiSTt4XrbLcb59DRiyQRbWA4qeCM4RrqjGxdq2LBI4RiXLXcb
 EC5hXO3+xGqal46T4nrCU/5cvbV6i2I44EnFspC2AHFE+TRHNuKpXRHUy
 9cDyH5vlU91F7D+6s3V2SeqGJgTPo9GV3fu+wwyzOGQPWX3FHtI9umtOs
 jDNE5KBF3Jwi/1GD43KBYvc5zmCL4tGaWhSSay6QHKUULPCiB+x716Iz2
 lZaAfz5hcjAfzBCUGj4723KuC3A59s2DyN6g3VxK6G8kYQNefNa6nMdOf
 U+EVVj3hBN/6qqnbCa+Alks0UaUJ7xZQSHkq5W0dN7VX/pUbjVUd4o4uk A==;
X-CSE-ConnectionGUID: HmdbvOWZR/C4mvpcdDs3Dw==
X-CSE-MsgGUID: eScs646QSECGoq28czjY7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380920"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380920"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:29 -0700
X-CSE-ConnectionGUID: ZpZ7/7S+TuWwViQExKzrow==
X-CSE-MsgGUID: Ga88b0DFSbOKCH1Fbt+gAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256576"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:28 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 33/56] drm/i915/hdmi: Rename port clock limit to specify
 tmds clock
Date: Mon, 12 Oct 2026 09:27:42 +0530
Message-ID: <20261012035806.3361439-34-ankit.k.nautiyal@intel.com>
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

The existing port clock limit function takes care of the TMDS mode of
transmission. Specify the port clock limit type explicitly as tmds.
This will pave way to add a separate port clock limit function for
FRL mode.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index db996b696847..7aee10ae2e1c 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1858,9 +1858,9 @@ static bool intel_hdmi_is_ycbcr420(const struct intel_crtc_state *crtc_state)
 	return crtc_state->output_format == INTEL_OUTPUT_FORMAT_YCBCR420;
 }
 
-static int hdmi_port_clock_limit(struct intel_hdmi *hdmi,
-				 bool respect_downstream_limits,
-				 bool has_hdmi_sink)
+static int hdmi_port_tmds_clock_limit(struct intel_hdmi *hdmi,
+				      bool respect_downstream_limits,
+				      bool has_hdmi_sink)
 {
 	struct intel_encoder *encoder = &hdmi_to_dig_port(hdmi)->base;
 	int max_tmds_clock = intel_hdmi_source_max_tmds_clock(encoder);
@@ -1893,8 +1893,8 @@ hdmi_port_clock_valid(struct intel_hdmi *hdmi,
 
 	if (clock < 25000)
 		return MODE_CLOCK_LOW;
-	if (clock > hdmi_port_clock_limit(hdmi, respect_downstream_limits,
-					  has_hdmi_sink))
+	if (clock > hdmi_port_tmds_clock_limit(hdmi, respect_downstream_limits,
+					       has_hdmi_sink))
 		return MODE_CLOCK_HIGH;
 
 	/* GLK DPLL can't generate 446-480 MHz */
-- 
2.50.1

