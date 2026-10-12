Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AE1CA9EDB
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1896A10E7B9;
	Mon, 12 Oct 2026 04:15:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C3A10E609;
 Mon, 12 Oct 2026 04:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778534; x=1823314534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ew802xLXNQYl7n9/7eBoFTQAbXviiiIF+QvhsS+oV/Q=;
 b=KfeaKFUCyPccm91MxwahXfQLdwlE0FMzX+MhPC/sTtxQXyNyUuh+vQnb
 dIN2b6MLZ7QPxjUkmX1b1FAJpWjDta8oOeZP+3lHv1HlaLq7GuSEc1WjJ
 R8q1LGFYJFZpmGnwBZ6s8p/0mronWbdREJkkZjhlAZBKORVB4dqFoo6mc
 AcTJOvI7V8BsIytee45IS2rLJU4nZFwSBZz5/jE4iWVisuRxdrgJmDx5f
 DJzD0tbs5N28U4hP1yMm388elY9hrkWaE6A8/BuLaiLWAf9LjqdA3xdt9
 LNmobeaxP8AxOj8/V8CH5EY4Dw6H15zydEnU8txQektSU/6qIMQpLqae5 A==;
X-CSE-ConnectionGUID: vZeV16hqSfKMJq/G+O7ZiA==
X-CSE-MsgGUID: IgReZmZaRFaD1LVUCMz4aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380923"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:31 -0700
X-CSE-ConnectionGUID: AAIT8Tg3R8qabF+Cb6xiBw==
X-CSE-MsgGUID: UBcUx3bDRnKG32+RkK2CwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256582"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:30 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 34/56] drm/i915/hdmi: Rename port clock valid to specify
 tmds clock
Date: Mon, 12 Oct 2026 09:27:43 +0530
Message-ID: <20261012035806.3361439-35-ankit.k.nautiyal@intel.com>
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

The existing port clock valid function takes care of the TMDS mode of
transmission. Specify the port clock valid type explicitly as tmds.
This will pave way to add a separate port clock valid function for
FRL mode.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 7aee10ae2e1c..01476f659717 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1884,9 +1884,9 @@ static int hdmi_port_tmds_clock_limit(struct intel_hdmi *hdmi,
 }
 
 static enum drm_mode_status
-hdmi_port_clock_valid(struct intel_hdmi *hdmi,
-		      int clock, bool respect_downstream_limits,
-		      bool has_hdmi_sink)
+hdmi_port_tmds_clock_valid(struct intel_hdmi *hdmi,
+			   int clock, bool respect_downstream_limits,
+			   bool has_hdmi_sink)
 {
 	struct intel_display *display = to_intel_display(hdmi);
 	struct intel_encoder *encoder = &hdmi_to_dig_port(hdmi)->base;
@@ -2010,7 +2010,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 						  sink_format))
 			continue;
 
-		status = hdmi_port_clock_valid(hdmi, tmds_clock, true, has_hdmi_sink);
+		status = hdmi_port_tmds_clock_valid(hdmi, tmds_clock, true, has_hdmi_sink);
 		if (status == MODE_OK)
 			return MODE_OK;
 	}
@@ -2186,9 +2186,9 @@ static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
 						       crtc_state->sink_format);
 
 		if (hdmi_bpc_possible(crtc_state, bpc) &&
-		    hdmi_port_clock_valid(intel_hdmi, tmds_clock,
-					  respect_downstream_limits,
-					  crtc_state->has_hdmi_sink) == MODE_OK)
+		    hdmi_port_tmds_clock_valid(intel_hdmi, tmds_clock,
+					       respect_downstream_limits,
+					       crtc_state->has_hdmi_sink) == MODE_OK)
 			return bpc;
 	}
 
-- 
2.50.1

