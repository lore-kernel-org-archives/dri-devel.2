Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FADC5AC81
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311E610F343;
	Fri,  7 Aug 2026 04:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hTANYyne";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E017410F343;
 Fri,  7 Aug 2026 04:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077103; x=1817613103;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MXBHNJTn+pABlsYb4DhE0xmFOLHyVnnPYqPLQvxDsyc=;
 b=hTANYyneRj7fDEUC7p+2m1s9n13ljpUu8cERvjaPQbSU2VbyyIOFrtpy
 wM0Hhz5v66odabrcrb4IrJO8KeczNWqyKtX5MuGy708+/BMxoag4RIJLn
 kfUkUeMPJ3NAOMRBi2XYK5ZRpNLDCoFgbWM6yCBXkwZ18qYVcopQfoXoj
 jgttG3O9luxwM8WdjRmC1zWxbhxdhNMuhXy3wuvRe6FMTci+C/O1OE/e5
 hXyRkdp7TRwXPXl6nYvAbxvLU7wwGCXwk/rzwSEODtJleEk1ZaL4PetmR
 LUn6wB6VGj7B76WnTJZ1Mq7MZnTJDbtoC6OZJDrnCsgD14vDxY/QD9Czc w==;
X-CSE-ConnectionGUID: 1Eg/cfLPSyu75vr+HYoDYA==
X-CSE-MsgGUID: L+7fCRs1SMCHEdoJ9mx7/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619251"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619251"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:43 -0700
X-CSE-ConnectionGUID: rVVHnGRXQQGPOz8KxuRheQ==
X-CSE-MsgGUID: nEfYEKPaSEOxAGUmCsZutw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666087"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:40 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 06/44] drm/i915/display: Add new members in crtc_state for FRL
 configuration
Date: Fri,  7 Aug 2026 09:43:51 +0530
Message-ID: <20260807041430.229038-7-ankit.k.nautiyal@intel.com>
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

Add new struture to store FRL related configurations for a pipe.
These members to be calculated during compute config phase, when FRL
mode is to be used.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../drm/i915/display/intel_display_types.h    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index ba51de6c4e57..00775ad9019c 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1445,6 +1445,32 @@ struct intel_crtc_state {
 
 	/* to track changes in plane color blocks */
 	bool plane_color_changed;
+
+	struct {
+		/* Go for FRL training */
+		bool enable;
+
+		/* Enable resource based scheduling */
+		bool rsrc_sched_en;
+
+		/* can be either 3 or 4 lanes */
+		u8 required_lanes;
+
+		/* required rate - can be 3, 6, 8, 10, 12 Gbps */
+		u8 required_rate;
+
+		/* FRL DFM Parameters */
+		u32 tb_borrowed, tb_actual, tb_threshold_min, active_char_buf_threshold;
+
+		/* FRL DFM DSC Tribytes */
+		u32 hcactive_tb, hctotal_tb;
+
+		/* Clock parameters in KHz */
+		u32 div18;
+
+		/* link m/n */
+		u32 link_m, link_n;
+	} frl;
 };
 
 enum intel_pipe_crc_source {
-- 
2.50.1

