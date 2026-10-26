Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BAE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UcWYIEqn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F71C10E983;
	Mon, 26 Oct 2026 05:40:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989FB10E971;
 Mon, 26 Oct 2026 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993244; x=1824529244;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AAe1ryxfVnxH2VouO/OHiOvPf+oz51YkwWE9Xoo5LdE=;
 b=UcWYIEqnmJrzcEP3Lb5CZtX8nbdeqZ1CuOXv9VWAVN518X7rRWsM+VDf
 kjDqkUiI65dhGfxjiT6SLlod4q/70OEHVAQympffuHgtGcGDJvsSMIdo4
 yEorHRhu9p5fxhvyOD2GpDUgF3IhQknvJMV/4/tqTbUhLFF1aK6VK2SDz
 YAayh6cR/uKzkAkgXvr5LCngEED8m6ma88r55dMh2rV3BKi2x9nmkdaBt
 EJNPXmP/Cd6Qwm2F9C1PQ9yR1mhYnT8ftkhGRXayteOR8uMumNRw4zEt0
 LCAWKaqSe1WSeAMPWrB2XZ8yUCoEUzLTB0BhslqMCL1FbByHPy15oiGR3 A==;
X-CSE-ConnectionGUID: j1oKikM8Tmq7NVMqTRx4xg==
X-CSE-MsgGUID: gupkR7/CSseWF7L3clvENw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550200"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550200"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:44 -0700
X-CSE-ConnectionGUID: V7Poud2vQZuNRO4oxed+lg==
X-CSE-MsgGUID: j5kWhOj7T3CXVZQbC51KhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001927"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:42 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 10/20] drm/i915/alpm: Half LFPS cycle calculation
Date: Mon, 26 Oct 2026 11:09:21 +0530
Message-ID: <20261026054001.799894-11-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for half LFPS cycle calculation for DP2.1 ALPM as dependent
parameters got changed.

v1: Initial version.
v2: Avoid returning early. [Jani]
v3: Use intel_crtc_has_type(). [Suraj]
v4: Split in separate function based on HAS_LT_PHY() check. [Jouni]
v5: Use lt_ prefix for the HAS_LT_PHY() specific helper. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 41 ++++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 2bf2ca956439..b6de938990dd 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -81,24 +81,49 @@ static int get_silence_period_symbols(const struct intel_crtc_state *crtc_state)
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
+static void lt_get_lfps_period_min_max_time(const struct intel_crtc_state *crtc_state,
+					    int *min, int *max)
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
+		lt_get_lfps_period_min_max_time(crtc_state, min, max);
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
2.43.0

