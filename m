Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D5606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNmVUnm2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EC710E976;
	Mon, 26 Oct 2026 05:40:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3703910E961;
 Mon, 26 Oct 2026 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993222; x=1824529222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dNYfKr400dPrPqKdsY3LZv514byHCswMslm0NzuEgJ8=;
 b=YNmVUnm20PNnT1tx7EWD1Z98lHaeICQ8ToN3c/ohxUZO9CwPn0IvmJ2o
 4uIJ5GfAONE57UXgdkOwIRVysjEIGduaPKU7Nf+jO1sKAqewBLWqx/Q50
 3quQfn5K4UP9KRI8WhvH4rzl1Gkuy7HyERDuzBfdDXVtkQHdJ4F6fKpAI
 LSqmGULLsgb8+e5JXTTtllS60WcaD5vw0tjNq3Z75RW2nO/drGrlikQhZ
 NnwT7iVMHCkOeFeh0Pjf4FwMmhmRQ8uv/q86YVUVYtORdpHJ46PVoF6Sx
 IRTPLPjAgrvAZiAWLhh7I0UNThnG+IdM4hLSMpPdrCTZic0lepIPaY1y5 Q==;
X-CSE-ConnectionGUID: GQ8+THYWQj2ChtzoBwlKtA==
X-CSE-MsgGUID: ySzY33NOR9qIROSfoMWOow==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550163"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550163"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:22 -0700
X-CSE-ConnectionGUID: wkRVsH1/Qf+JdNDDXQIr5A==
X-CSE-MsgGUID: lM6I6VdgTn+2qXVZjpHFGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001848"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:20 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 03/20] drm/i915/alpm: Move alpm sink capability readout
 into a separate function
Date: Mon, 26 Oct 2026 11:09:14 +0530
Message-ID: <20261026054001.799894-4-animesh.manna@intel.com>
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

Abstract ALPM DPCD initialization into its own function.

v2:
- Improve commit description. [Suraj, Jouni]
- Handle error value of intel_alpm_init_dpcd() with an early exit
  in intel_edp_init_dpcd(). [Jouni]
v3:
- Return int and propagate the original error instead of
  flattening it to bool. [Jani]

Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 14 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_alpm.h |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c   |  5 +----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 8542bd9c9666..cb1d68fef198 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -43,6 +43,20 @@ bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
 		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
 }
 
+int intel_alpm_init_dpcd(struct intel_dp *intel_dp)
+{
+	u8 dpcd;
+	int ret;
+
+	ret = drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP, &dpcd);
+	if (ret < 0)
+		return ret;
+
+	intel_dp->alpm_dpcd = dpcd;
+
+	return 0;
+}
+
 void intel_alpm_init(struct intel_dp *intel_dp)
 {
 	mutex_init(&intel_dp->alpm.lock);
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index f8f605d94f96..1cb226bc342a 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -15,6 +15,7 @@ struct intel_connector;
 struct intel_atomic_state;
 struct intel_crtc;
 
+int intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index bf5e87a72108..816337efeb91 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5057,10 +5057,7 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector
 	 */
 	intel_dp_init_source_oui(intel_dp);
 
-	/* Read the ALPM DPCD caps */
-	ret = drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CAP,
-				    &intel_dp->alpm_dpcd);
-	if (ret < 0)
+	if (intel_alpm_init_dpcd(intel_dp))
 		return false;
 
 	/*
-- 
2.43.0

