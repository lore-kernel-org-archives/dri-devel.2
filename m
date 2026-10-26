Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22302606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eReuzFOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A4310E965;
	Mon, 26 Oct 2026 05:41:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C085510E966;
 Mon, 26 Oct 2026 05:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993266; x=1824529266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=klgCkTEwqS6p+3s3GEwsr7HS/3rSdab9i//vi5YUo2w=;
 b=eReuzFOvFSM3wG1t5/tF6/zQbsfNr42oZb89EzIYenn7uCovTgvFb09j
 SsLpw+tOjH0ehxmghNwi6omEDUFVUMJp8z+wM1C4FeDt1sE+yWRkvVK17
 qQP/TQg2QvbydlV7ijOG/P4HZ/OcrOLakkyQVUHhqhpCdEToqthGvEx4L
 Cl1d9vIKjmd5iGJzVB/ql1EduJAiqZCEAc+vKB4PvxqtjQzuA4cUZLiyH
 x1b9CzzlAgZpkkGpvVxtflFpEgNobKFH7EkxLQiw2/1LOBozeFUP4xwkX
 tHbKSuKPwfFlaK8MKvjx/Jx9SNQ1YmhivFKif+3fKWKhrluWU+u/XNsXs g==;
X-CSE-ConnectionGUID: wi41brnZTE2NOmNQIc2QFA==
X-CSE-MsgGUID: gKczbAukQNGOt8c+xdN+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550221"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550221"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:41:06 -0700
X-CSE-ConnectionGUID: Jq1RgwObT4iOzxhP1ju/SA==
X-CSE-MsgGUID: zDe7HpJuTHK/i2d2rdowSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6002034"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:41:04 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 17/20] drm/i915/alpm: Disallow ALPM for UHBR link rate
Date: Mon, 26 Oct 2026 11:09:28 +0530
Message-ID: <20261026054001.799894-18-animesh.manna@intel.com>
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

DP2.1 ALPM is not supported on UHBR (128b/132b) link rates on the NVL
platform. Report ALPM as not possible in intel_alpm_is_possible() for
external DP running at a UHBR rate on display version 35, so that ALPM
and the features relying on it are not enabled in that case. eDP is
excluded so eDP ALPM keeps working at any link rate.

v2:
- Move the check into intel_alpm_is_possible(). [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 11 +++++++++--
 drivers/gpu/drm/i915/display/intel_alpm.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 205f1ae10d43..3123296df6b2 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -76,13 +76,20 @@ void intel_alpm_init(struct intel_dp *intel_dp)
 	mutex_init(&intel_dp->alpm.lock);
 }
 
-bool intel_alpm_is_possible(struct intel_dp *intel_dp)
+bool intel_alpm_is_possible(struct intel_dp *intel_dp,
+			    const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
 	u8 lttpr_alpm_caps;
 
 	if (!(intel_dp->alpm_dpcd & (DP_ALPM_CAP | DP_ALPM_AUX_LESS_CAP)))
 		return false;
 
+	/* DP2.1 ALPM is not supported on UHBR (128b/132b) link rates on NVL. */
+	if (DISPLAY_VER(display) == 35 && !intel_dp_is_edp(intel_dp) &&
+	    intel_dp_is_uhbr(crtc_state))
+		return false;
+
 	if (drm_dp_lttpr_count(intel_dp->lttpr_common_caps) <= 0)
 		return true;
 
@@ -556,7 +563,7 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	if (intel_dp->alpm.sink_alpm_error)
 		return;
 
-	if (!intel_alpm_is_possible(intel_dp))
+	if (!intel_alpm_is_possible(intel_dp, crtc_state))
 		return;
 
 	if (DISPLAY_VER(display) < 20)
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 9319572c221e..24c319bc5eff 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -17,7 +17,8 @@ struct intel_crtc;
 
 int intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
-bool intel_alpm_is_possible(struct intel_dp *intel_dp);
+bool intel_alpm_is_possible(struct intel_dp *intel_dp,
+			    const struct intel_crtc_state *crtc_state);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state);
 void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
-- 
2.43.0

