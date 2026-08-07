Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510DAC5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA3410F3F9;
	Fri,  7 Aug 2026 04:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nk30JXEV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E7E10F3F5;
 Fri,  7 Aug 2026 04:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077199; x=1817613199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5yHJCxYqhA9nAG6K7illmrW/E/n49XOJGW9yZjuHEwU=;
 b=Nk30JXEVNjxKRN+Tnnvmd8KI0uOMDWDkQMqEiSgRq27+ebR6uS45lvDY
 udJuLo+lvirbyAn52o0ADKjZzXF6KFYtRmmI+cBbxwGF+5GbkiQvLvAHk
 /qG8c5241wKEN5AP8tU9MN43szNtYmRjPnSbbZ+6UhqunjYn7cyw7J9pt
 +uOq+xI/cQBEoHCr57k9M7KegHYojwV8Hqi6KsUPhloavnV09az8l3y+g
 j4D1dRIPoNlxTbS2mHde8MjFY/dgEhIJhs2FX9KsFr9i/VHATtlYtQpXu
 oyiGUzjXaVagKv9HZ2rLhA/myd1PE15muU6o0yYSIL9HGvyMZdEeET+8l g==;
X-CSE-ConnectionGUID: 7WQKgn2ESTmPZ5O5dF6f7Q==
X-CSE-MsgGUID: LzeHT0C+TViona2lNp8dJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619411"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619411"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:19 -0700
X-CSE-ConnectionGUID: 1EgCgqP9RUGM3hVaOoyjwg==
X-CSE-MsgGUID: yqDGL88hSfuePeEFJe24Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666626"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:16 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 44/44] drm/i915/hdmi: Enable FRL based mode clock valid
Date: Fri,  7 Aug 2026 09:44:29 +0530
Message-ID: <20260807041430.229038-45-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Compute frl_mode based on the sink HDMI FRL capability and the maximum
FRL rate, and pass it through intel_hdmi_mode_clock_valid() so that
modes can be validated for FRL transmission.

Higher resolution modes like 8K@60, 4K@120 need FRL support. Platforms
before MTL do not support FRL, so allow modes requiring more than 600MHz
dotclock to be enumerated only on MTL+ where FRL is supported.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 1773b2096e9f..09e48314c34c 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2091,6 +2091,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 	struct intel_connector *connector = to_intel_connector(_connector);
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_hdmi *hdmi = intel_attached_hdmi(connector);
+	bool frl_mode = hdmi->has_sink_hdmi_21 && hdmi->max_frl_rate;
 	enum drm_mode_status status = MODE_OK;
 	int bpc;
 
@@ -2100,7 +2101,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 	 * least one color depth is accepted.
 	 */
 	for (bpc = 12; bpc >= 8; bpc -= 2) {
-		int hdmi_clock = intel_hdmi_clock(clock, bpc, sink_format, false);
+		int hdmi_clock = intel_hdmi_clock(clock, bpc, sink_format, frl_mode);
 
 		if (!intel_hdmi_source_bpc_possible(display, bpc))
 			continue;
@@ -2109,7 +2110,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 						  sink_format))
 			continue;
 
-		status = hdmi_port_clock_valid(hdmi, hdmi_clock, true, has_hdmi_sink, false);
+		status = hdmi_port_clock_valid(hdmi, hdmi_clock, true, has_hdmi_sink, frl_mode);
 		if (status == MODE_OK)
 			return MODE_OK;
 	}
@@ -2195,12 +2196,10 @@ intel_hdmi_mode_valid(struct drm_connector *_connector,
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
+	if (!HAS_HDMI_FRL(display) && clock > 600000)
 		return MODE_CLOCK_HIGH;
 
 	if (drm_mode_is_420_only(info, mode)) {
-- 
2.50.1

