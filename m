Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74505FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D8910EA7C;
	Tue, 28 Apr 2026 07:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FNsDb7sa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3E710EA5C;
 Tue, 28 Apr 2026 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363192; x=1808899192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nq7oMvzeaG6TqJ759bpQoSJlgropyWawzu99eqQv8N0=;
 b=FNsDb7saogprQcZXjD9JEmmZCwEEjlUTHAJsrMUmTyffmrfw6Ak3tFUI
 MBMmV1rnGIfwGBC8yu7b1aYyJ2R92l+3qzPtOQLAZKg0y1VEWsTk5mE5W
 sbrFrWVuW5XYvJVrSF+N03E8uOmFqjJWCUdg7ogNG6mGOCOjy5E8/wOIz
 8o2ouI0FdmbsAuWWh59mNCkI8wvswb49cOkMxxgd4zzLU8IgPdKArsQ8H
 9ATK3s47PoDThynj+wuTGbF2vLKgK86k6UzrqhLBW8ig2b8pGa6WP9CEi
 n65x/dJ7yubmgpeYmTSI7nRp5nASMj/OMdD5WLNp8CY1xj2tYuYq7C8w3 Q==;
X-CSE-ConnectionGUID: /m9yfTXhQX+XJcH+y8VYwA==
X-CSE-MsgGUID: 79CUztzERmqBiinVSISVBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82115915"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="82115915"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:52 -0700
X-CSE-ConnectionGUID: SSxcRmGdQrO/277oHyFi4g==
X-CSE-MsgGUID: 2YbkKY7vRc6zZwfWIkoJVA==
X-ExtLoop1: 1
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:50 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 7/9] drm/dp: Add a helper to get the SDP type as a string
Date: Tue, 28 Apr 2026 13:14:55 +0530
Message-ID: <20260428074457.3566918-8-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260428074457.3566918-1-ankit.k.nautiyal@intel.com>
References: <20260428074457.3566918-1-ankit.k.nautiyal@intel.com>
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

Introduce dp_sdp_type_get_name() to get the SDP type as a string.
Use this to log the SDP type based on the sdp_type fields of the
VSC and AS SDPs instead of the hardcoded strings.

v2: Modify the SDP names to match the DisplayPort Spec. (Ville)

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 36 ++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 5f523d0514a5..654be04431ad 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3487,10 +3487,38 @@ static const char *dp_content_type_get_name(enum dp_content_type content_type)
 	}
 }
 
+static const char *dp_sdp_type_get_name(unsigned char type)
+{
+	switch (type) {
+	case DP_SDP_AUDIO_TIMESTAMP:
+		return "Audio_TimeStamp";
+	case DP_SDP_AUDIO_STREAM:
+		return "Audio_Stream";
+	case DP_SDP_EXTENSION:
+		return "Extension";
+	case DP_SDP_AUDIO_COPYMANAGEMENT:
+		return "Audio_CopyManagement";
+	case DP_SDP_ISRC:
+		return "ISRC";
+	case DP_SDP_VSC:
+		return "VSC";
+	case DP_SDP_PPS:
+		return "PPS";
+	case DP_SDP_VSC_EXT_VESA:
+		return "VSC_EXT_VESA";
+	case DP_SDP_VSC_EXT_CEA:
+		return "VSC_EXT_CEA";
+	case DP_SDP_ADAPTIVE_SYNC:
+		return "Adaptive-Sync";
+	default:
+		return "Unknown";
+	}
+}
+
 void drm_dp_vsc_sdp_log(struct drm_printer *p, const struct drm_dp_vsc_sdp *vsc)
 {
-	drm_printf(p, "DP SDP: VSC, revision %u, length %u\n",
-		   vsc->revision, vsc->length);
+	drm_printf(p, "DP SDP: %s, revision %u, length %u\n",
+		   dp_sdp_type_get_name(vsc->sdp_type), vsc->revision, vsc->length);
 	drm_printf(p, "    pixelformat: %s\n",
 		   dp_pixelformat_get_name(vsc->pixelformat));
 	drm_printf(p, "    colorimetry: %s\n",
@@ -3505,8 +3533,8 @@ EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
 
 void drm_dp_as_sdp_log(struct drm_printer *p, const struct drm_dp_as_sdp *as_sdp)
 {
-	drm_printf(p, "DP SDP: AS_SDP, revision %u, length %u\n",
-		   as_sdp->revision, as_sdp->length);
+	drm_printf(p, "DP SDP: %s, revision %u, length %u\n",
+		   dp_sdp_type_get_name(as_sdp->sdp_type), as_sdp->revision, as_sdp->length);
 	drm_printf(p, "    vtotal: %d\n", as_sdp->vtotal);
 	drm_printf(p, "    target rr: %d\n", as_sdp->target_rr);
 	drm_printf(p, "    duration increase ms: %d\n", as_sdp->duration_incr_ms);
-- 
2.45.2

