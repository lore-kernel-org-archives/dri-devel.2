Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F86CCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7939E10E44A;
	Mon, 12 Oct 2026 04:14:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8D110E438;
 Mon, 12 Oct 2026 04:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778475; x=1823314475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xgxcnjV4uh/tdCtKc+bLq0ptU1Z9ye2D9CXJ6cGXWts=;
 b=ME+djwDOANSAx5ZsT2B9kHRjpKB1UR7VFiVbQGhgILSRTKR48q4cG//I
 erD+G/qatXI2QnnNC9RWErbezgDeLBG4LSPwNcNyTaXzFweHMgoIpdlOt
 ci/BLbk2PsrTFBqJ/syGGwKs3bWV+ZOZNDRmOkXF71rebeLGzxQfech/0
 vCvH+c5OR8hoaE4EIwpxBgYnwf7NiaJxJv47pqjIIyTtlnrA5XzqzpihJ
 sjftRUvPhPiKCAqJMti7uQCrzORkP+Z3rcC+0NY5TFdMWwpnPNr51VskE
 tuNkDaTM/YNMcgTvQnpYIlKbpzKAaRUEWeaSl4nS8iI/7NpR2fE38QQEd w==;
X-CSE-ConnectionGUID: 218iwFhWSaijkNFpO0MPag==
X-CSE-MsgGUID: AVN/R00xRDGqzgDo8T8EpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380838"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:34 -0700
X-CSE-ConnectionGUID: apj5/BQkQBm5A0DCxH+vtA==
X-CSE-MsgGUID: uYFY0rDeSueRfwCZGTMOIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256363"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:33 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 09/56] drm/i915/hdmi: Enable Scrambling only for TMDS mode
Date: Mon, 12 Oct 2026 09:27:18 +0530
Message-ID: <20261012035806.3361439-10-ankit.k.nautiyal@intel.com>
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

Enable scrambling in SCDC only for TMDS mode. For FRL mode scrambling
is handled as part of the FRL protocol and should not be configured
via the TMDS scrambling path.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 5c57f81d971b..ac655d9e4d79 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2430,7 +2430,8 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 
 	pipe_config->lane_count = 4;
 
-	if (scdc->scrambling.supported && source_supports_scrambling(encoder)) {
+	if (scdc->scrambling.supported && source_supports_scrambling(encoder) &&
+	    !pipe_config->frl.enable) {
 		if (scdc->scrambling.low_rates)
 			pipe_config->hdmi_scrambling = true;
 
-- 
2.50.1

