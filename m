Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gYuo+Duw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E0110E963;
	Mon, 26 Oct 2026 05:40:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5D310E95D;
 Mon, 26 Oct 2026 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993217; x=1824529217;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vzy4M2hxG4xtCQGvD+B1WiKKDG0s9v90jpMYZDYidWs=;
 b=gYuo+DuwZ5UkPMeAp9+/REzi83rDnvslc/s/9/WVObKtOWaKa67op9Vq
 rw6kJNRnvgCn4QkkwHuVNO8Q5xanIMy2qAkxm50Ps7bID6wUx+BKDqb/c
 ds8mcZBcOabgnqNtcYfS2W6qo29ee3ZEFb7md/deJh7G8qE1TYZ5WFFQ5
 0CxdqMRqg/FYVigl4es9T+7eBASrM5jTV2eGoOhEB0I/Z2Xk9yMUlbM4k
 dLmEo9CCBiji613bIP5uZVIzmaKNVbmU5IDHDRP4cHf0kUvpwYyW7n52X
 6nXpNFw13TMezmNI7Fw4eNy5VXMWGmPrser2MdK6BHCy9zOBZLD2tOHX2 g==;
X-CSE-ConnectionGUID: yW1o8n3MRiWrsOryDkcuDg==
X-CSE-MsgGUID: kGZewE/NRRGuh4o+gttXGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550151"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550151"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:16 -0700
X-CSE-ConnectionGUID: vPpzF73RRRmrITobz4xzxw==
X-CSE-MsgGUID: fEqZNR44SjS93x1W3yPc5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001835"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:14 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 01/20] drm/i915/alpm: Program zero-based LFPS half cycle
 duration
Date: Mon, 26 Oct 2026 11:09:12 +0530
Message-ID: <20261026054001.799894-2-animesh.manna@intel.com>
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

The LFPS Half Cycle Duration field, as well as the First and Last LFPS
Half Cycle Duration fields, in PORT_ALPM_LFPS_CTL are zero-based: per
Bspec the value programmed must be N_Symbol - 1. The number of symbols
was programmed directly, making each half cycle one symbol clock too
long.

Subtract one in the PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION,
PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION and
PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION field macros so the
programmed value matches the zero-based field encoding.

Since the fields now encode 1 to 32 symbols, update the bounds check
in _lnl_compute_aux_less_alpm_params() to accept a half cycle of 32
symbols and reject 0, which cannot be encoded.

v2: Adjust half cycle bounds check for zero-based encoding. [sashiko]

Bspec: 71632
Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     |  3 ++-
 drivers/gpu/drm/i915/display/intel_psr_regs.h | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index f54b29e193ee..8542bd9c9666 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -134,7 +134,8 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 
 	if (aux_less_wake_lines > ALPM_CTL_AUX_LESS_WAKE_TIME_MASK ||
 	    silence_period > PORT_ALPM_CTL_SILENCE_PERIOD_MASK ||
-	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK)
+	    lfps_half_cycle < 1 ||
+	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK + 1)
 		return false;
 
 	if (display->params.psr_safest_params)
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index a57bc111290d..78a05387eab5 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -335,11 +335,17 @@
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK		REG_GENMASK(27, 24)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN		7
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(val)		REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
+/*
+ * The LFPS half cycle duration fields (including the first and last half
+ * cycle) are zero-based, i.e. the value programmed is N_Symbol - 1.
+ *
+ * Bspec: 71632
+ */
 #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(20, 16)
-#define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
 #define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(12, 8)
-#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
 #define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(4, 0)
-#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, val)
+#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)
 
 #endif /* __INTEL_PSR_REGS_H__ */
-- 
2.43.0

