Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A7FD5F99
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BCA10E5B5;
	Wed,  8 Apr 2026 08:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CAmUUaux";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AC510E5B2;
 Wed,  8 Apr 2026 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638673; x=1807174673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HE73IoN21SAiR407neVozQ8QA+lJHkcqoWp2mIAwHRo=;
 b=CAmUUauxARmLjuKabGe3+MLldt3e1wpcpRbbQjAFNn6uh2kk4fYb8pD0
 YZjzm2EvqFRuToNCWjHAJpD9yfmemiwtUN1iJu30xvLO5jyyQqIa28HQ+
 ieB2ChHlyvJTfXt5lGhQLEka7okpbTNhccYmD58ZJJGjwVmBB7TRfbUlJ
 EMJQXDo7UoS5QrVyNbTE4gVhe9BZ3EI8Rjuh7V8wRZJgw6dwiVxtu3zyM
 zS1tnxllx+Ux+INwKYyAkXZuDWsOE8ejhnNXBMTPh9axQo9OxDYBPT94a
 x8e3n0MtWi1HsQVR5gWmDMjbwW5LYqPw/gKVFGbDfNsy4tORBnVDfEBSB A==;
X-CSE-ConnectionGUID: FdddiY1uQ9W61IndzDA9nQ==
X-CSE-MsgGUID: OA9qfQFATXGbfPZDWGOdYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516625"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516625"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:53 -0700
X-CSE-ConnectionGUID: df44PC0jTQW6fIlXwNNFGA==
X-CSE-MsgGUID: ggoViMrdQcCThLAJPE+tXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572499"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:50 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 06/26] drm/dp: Add a helper to get the SDP type as a string
Date: Wed,  8 Apr 2026 14:12:18 +0530
Message-ID: <20260408084239.1295325-7-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
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

While at it, rename "SDP : AS_SDP" to "SDP : Adaptive Sync"

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 36 ++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e29958f8b0b6..102328d9022d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3487,10 +3487,38 @@ static const char *dp_content_type_get_name(enum dp_content_type content_type)
 	}
 }
 
+static const char *dp_sdp_type_get_name(unsigned char type)
+{
+	switch (type) {
+	case DP_SDP_AUDIO_TIMESTAMP:
+		return "Audio Timestamp";
+	case DP_SDP_AUDIO_STREAM:
+		return "Audio Stream";
+	case DP_SDP_EXTENSION:
+		return "Extension";
+	case DP_SDP_AUDIO_COPYMANAGEMENT:
+		return "Audio Copy Management";
+	case DP_SDP_ISRC:
+		return "ISRC";
+	case DP_SDP_VSC:
+		return "VSC";
+	case DP_SDP_PPS:
+		return "PPS";
+	case DP_SDP_VSC_EXT_VESA:
+		return "VSC EXT VESA";
+	case DP_SDP_VSC_EXT_CEA:
+		return "VSC EXT CEA";
+	case DP_SDP_ADAPTIVE_SYNC:
+		return "Adaptive Sync";
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
 	drm_printf(p, "    target_rr: %d\n", as_sdp->target_rr);
 	drm_printf(p, "    duration_incr_ms: %d\n", as_sdp->duration_incr_ms);
-- 
2.45.2

