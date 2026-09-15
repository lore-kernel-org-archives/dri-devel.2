Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9367EC982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F4910E879;
	Tue, 15 Sep 2026 18:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EDVqjtae";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D491A10E4C0;
 Tue, 15 Sep 2026 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497564; x=1821033564;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bIdI2iCQpw0asbXUucKB25jMAjgVM2wvcs3ks7/Q9zo=;
 b=EDVqjtaezfHIgRnA8Eb7B7t+jYl9U5JAP1W5oCsO/CrKacDMFgNL4FuP
 YvHTN1XvBfkxxekTk8rhBhaUPZjjCqZOPwgxphBW2VmpjYJlNfXvVBhuK
 58Cub9C40Mnz0widqkFBcZajE/Agpja0oHdd0IJ62el5EqMmX+xKKOEep
 g6TR/GVehB90CQ844+HTzKTSttobslgttGgLu1jan07sg2nox9xGVbeFG
 s82Djhq9ZOBJLvk0n0HsrwYbhRz7J6/GbJCbeGVFFJEjoujLw2VnyEy8y
 RkzNPYuGe5zlPsSnj6VQYKGXHSu17xg6UrglyXBsgfIu3srPv94ExiBlb w==;
X-CSE-ConnectionGUID: /DOcPWz+TEaxdG4dSkZQIA==
X-CSE-MsgGUID: QK7X66c1QDGU5jxfuboBJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380301"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:24 -0700
X-CSE-ConnectionGUID: H+XfMcX8QRSnuPMNTYIRIA==
X-CSE-MsgGUID: ZDYG2lP3RL+g9JkWyOcdKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148503"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:21 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 09/18] drm/i915/alpm: Half LFPS cycle calculation
Date: Tue, 15 Sep 2026 23:34:40 +0530
Message-Id: <20260915180449.277933-10-animesh.manna@intel.com>
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

Add support for half LFPS cycle calculation for DP2.1 ALPM as dependent
parameters got changed.

v1: Initial version.
v2: Avoid returning early. [Jani]
v3: Use intel_crtc_has_type(). [Suraj]
v4: Split in separate function based on HAS_LT_PHY() check. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 41 ++++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index cb24bba801a1..14ecb27095b2 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -74,24 +74,49 @@ static int get_silence_period_symbols(const struct intel_crtc_state *crtc_state)
 		1000 / 1000;
 }
 
-static void get_lfps_cycle_min_max_time(const struct intel_crtc_state *crtc_state,
-					int *min, int *max)
+static void lnl_get_lfps_period_min_max_time(const struct intel_crtc_state *crtc_state,
+					     int *min, int *max)
 {
-	if (crtc_state->port_clock < 540000) {
-		*min = 65 * LFPS_CYCLE_COUNT;
-		*max = 75 * LFPS_CYCLE_COUNT;
-	} else {
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
+		if (crtc_state->port_clock < 540000) {
+			*min = 65 * LFPS_CYCLE_COUNT;
+			*max = 75 * LFPS_CYCLE_COUNT;
+		} else {
+			*min = 140;
+			*max = 800;
+		}
+	}
+}
+
+static void xe3plpd_get_lfps_period_min_max_time(const struct intel_crtc_state *crtc_state,
+						 int *min, int *max)
+{
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
 		*min = 140;
 		*max = 800;
+	} else {
+		*min = 320;
+		*max = 1600;
 	}
 }
 
+static void get_lfps_period_min_max_time(const struct intel_crtc_state *crtc_state,
+					int *min, int *max)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+
+	if (HAS_LT_PHY(display))
+		xe3plpd_get_lfps_period_min_max_time(crtc_state, min, max);
+	else
+		lnl_get_lfps_period_min_max_time(crtc_state, min, max);
+}
+
 static int get_lfps_cycle_time(const struct intel_crtc_state *crtc_state)
 {
 	int tlfps_cycle_min, tlfps_cycle_max;
 
-	get_lfps_cycle_min_max_time(crtc_state, &tlfps_cycle_min,
-				    &tlfps_cycle_max);
+	get_lfps_period_min_max_time(crtc_state, &tlfps_cycle_min,
+				     &tlfps_cycle_max);
 
 	return tlfps_cycle_min +  (tlfps_cycle_max - tlfps_cycle_min) / 2;
 }
-- 
2.29.0

