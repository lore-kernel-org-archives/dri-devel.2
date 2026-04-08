Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059C6FD5F9B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A80510E5CA;
	Wed,  8 Apr 2026 08:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HqKSeR6X";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F7510E5C9;
 Wed,  8 Apr 2026 08:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638696; x=1807174696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WNIHG1HsX6jv2XSLPi6WCj2FNiuXRxwgH88OlJmw9iw=;
 b=HqKSeR6XRVSX3fGBY9Hv/ZpDS4BxxmD1qpyOHNoQD7tkOv6nrSuQoB6e
 PGKe50XJcm0beqmPzRDePdbWhoECr3X0DaKEbH1b5XeH5FAmG7fmUPTRU
 JzKNsbCMHH5o3Hfx+wE692rFTOfYVyJwmKmY3sNhvCues/Rj3XtAVy5XO
 buyU+drI6gKMaDxa3y9pYQvTEuhGum5VqbbPChXgNiFpsBB4nEoSlQHc6
 GoFO9tD4krSqNIA3dYcvYKMoeRrIChj1jnNR2/JV5FjJTGsvKfIuXDa70
 mTQEydhglf4iiXJkdgmguRJ8HQnvVmCEDhL1BdRQ/+qJZns1O6bupeXTa w==;
X-CSE-ConnectionGUID: zFLW/jwdR9GwJ5V0kR2wug==
X-CSE-MsgGUID: MAVvCID4RF+TBY17LQi0xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516668"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:16 -0700
X-CSE-ConnectionGUID: ez6jlPDJQEiEoG0/eNmEMg==
X-CSE-MsgGUID: +8WzLjHvT52SjahRrrTT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572579"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:13 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 15/26] drm/i915/dp: Include all relevant AS SDP fields in
 comparison
Date: Wed,  8 Apr 2026 14:12:27 +0530
Message-ID: <20260408084239.1295325-16-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
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

Add missing drm_dp_as_sdp header fields to intel_compare_dp_as_sdp()
comparison.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 57870baebfa5..a0e7ef2574b2 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -4906,11 +4906,14 @@ static bool
 intel_compare_dp_as_sdp(const struct drm_dp_as_sdp *a,
 			const struct drm_dp_as_sdp *b)
 {
-	return a->revision == b->revision &&
+	return a->sdp_type == b->sdp_type &&
+		a->revision == b->revision &&
+		a->length == b->length &&
 		a->vtotal == b->vtotal &&
 		a->target_rr == b->target_rr &&
 		a->duration_incr_ms == b->duration_incr_ms &&
 		a->duration_decr_ms == b->duration_decr_ms &&
+		a->target_rr_divider == b->target_rr_divider &&
 		a->mode == b->mode;
 }
 
-- 
2.45.2

