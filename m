Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D3606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hLDzb8gf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B560C10E987;
	Mon, 26 Oct 2026 05:40:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2722410E986;
 Mon, 26 Oct 2026 05:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993247; x=1824529247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=va/VkHwvjY9gcUfOG9ySDVmMNiqg4pgeFi9Gf4Tw8EY=;
 b=hLDzb8gfa4MYTbrxqDXk2FtAMcvG+edWfJSsC/aOQTaAy9Tlf7MBizYQ
 uy0OBJ7oOjwpEVkg1qXzGrV51yRNmvsjgegfpH97lEUwC6cZ223selQT2
 ccue0+bB5iIorrmkSd75pHiWkqYoQoRcgcxJ3ohaFl0v6F2QGPdXNc3GB
 jwsCRC4IwnMjUFYW3m8db+nn381qk7aQu0DoIerDmLMlekRA737N+Yepb
 dQ2Ra8ZEcmcxlXj6pdHLO226cJEYgSFtm/x+6jDKBySSDO+P9te2lMvwD
 pZ9tejhvzB2X0OOycXy9mQKCvGQRW4Jvn+ox+8SDNHkDWuE7INg9AqHoP A==;
X-CSE-ConnectionGUID: 5E8uPZj4QBqtZC7jI6t3mQ==
X-CSE-MsgGUID: rxwN3U8sS8OhzJ0av9E2MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550202"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550202"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:47 -0700
X-CSE-ConnectionGUID: MxGSS7P6Qw+gYEGdYtAb9w==
X-CSE-MsgGUID: 60/mqlydQESO78WzD+bijg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001937"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:45 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 11/20] drm/i915/alpm: Modify LFPS cycle count for DP ALPM
Date: Mon, 26 Oct 2026 11:09:22 +0530
Message-ID: <20261026054001.799894-12-animesh.manna@intel.com>
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

For DP minimum LFPS count is set to minimum 16.

Also use the link symbol clock instead of the link rate when computing
the half LFPS cycle in symbols. Both are the same for 8b/10b, which was
the only case so far with eDP, but they differ for 128b/132b.

v2:
- Drop unneeded comment. [Jouni]
- Use intel_dp_link_symbol_clock() for half LFPS cycle calculation. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index b6de938990dd..1fd528cb7fe6 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -24,7 +24,8 @@
 				(SILENCE_PERIOD_MAX_TIME -	\
 				 SILENCE_PERIOD_MIN_TIME) / 2)
 
-#define LFPS_CYCLE_COUNT 10
+#define LFPS_CYCLE_COUNT	10
+#define LFPS_CYCLE_COUNT_DP	16
 
 bool intel_alpm_aux_wake_supported(struct intel_dp *intel_dp)
 {
@@ -128,10 +129,19 @@ static int get_lfps_cycle_time(const struct intel_crtc_state *crtc_state)
 	return tlfps_cycle_min +  (tlfps_cycle_max - tlfps_cycle_min) / 2;
 }
 
+static int get_lfps_cycle_count(const struct intel_crtc_state *crtc_state)
+{
+	if (!intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP))
+		return LFPS_CYCLE_COUNT_DP;
+
+	return LFPS_CYCLE_COUNT;
+}
+
 static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
 {
-	return get_lfps_cycle_time(crtc_state) * crtc_state->port_clock / 1000 /
-		1000 / (2 * LFPS_CYCLE_COUNT);
+	return get_lfps_cycle_time(crtc_state) *
+		intel_dp_link_symbol_clock(crtc_state->port_clock) / 1000 /
+		1000 / (2 * get_lfps_cycle_count(crtc_state));
 }
 
 #define ML_PHY_LOCK_LEN		252
@@ -742,7 +752,7 @@ void intel_alpm_port_configure(struct intel_dp *intel_dp,
 			PORT_ALPM_CTL_MAX_PHY_SWING_HOLD(0) |
 			PORT_ALPM_CTL_SILENCE_PERIOD(
 				crtc_state->alpm_state.silence_period_sym_clocks);
-		lfps_ctl_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(LFPS_CYCLE_COUNT) |
+		lfps_ctl_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(get_lfps_cycle_count(crtc_state)) |
 			PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(
 				crtc_state->alpm_state.lfps_half_cycle_num_of_syms) |
 			PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(
-- 
2.43.0

