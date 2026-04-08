Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5443FD5F6E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC26410E533;
	Wed,  8 Apr 2026 05:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Dx8ONcUX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F315810E52D;
 Wed,  8 Apr 2026 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775626841; x=1807162841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3JkXcowSYHJMIQqN2Wyj+9a4MGuXyOV/PQSx02KA58Q=;
 b=Dx8ONcUXRgp3kZOHwvY0YVnP6cO7ZWkDuwYYhLsuXVMAhk/YAPUbPsnN
 mI8U3+qJZzhllyEb1UY9JQmeG+BL6LpYW1K7tIgN4ffdeK4GSJLvDwM24
 8omxVXA7mtUdZxse3nQz/zypvzzB8pgcyNfFfEGMXVovPkO4wClnWUaP1
 vhxKcMTKjjwovKqM67xfhCdfYtIkXIsegXoqmTdLrwLVDkKWetRcRBm1Q
 OCiij48QefS1xI1IiPvLs0gUVaEYzL018iVkoNfjC9ueKPDkw+LGlQasm
 esKmKem89lMkuhJ5PUy5+mCn3lnkv7n93oXniNjhbiKLmBtJqGmvbbbzy Q==;
X-CSE-ConnectionGUID: il4wbftuQH+Rd4QPGYHhzA==
X-CSE-MsgGUID: bEYKgoH2Q9GtevnfA2f3Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80194935"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="80194935"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:40:41 -0700
X-CSE-ConnectionGUID: d5n/eFn8RwKtexdDQC8tRg==
X-CSE-MsgGUID: oq9n5qBnS/+eB0+epdCiJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="251518068"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa002.fm.intel.com with ESMTP; 07 Apr 2026 22:40:37 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: harry.wentland@amd.com, louis.chauvet@bootlin.com, mwen@igalia.com,
 contact@emersion.fr, alex.hung@amd.com, daniels@collabora.com,
 uma.shankar@intel.com, maarten.lankhorst@intel.com,
 pekka.paalanen@collabora.com, pranay.samala@intel.com,
 swati2.sharma@intel.com, chaitanya.kumar.borah@intel.com
Subject: [PATCH v2 10/13] drm/i915/color: Add color pipeline support for SDR
 planes
Date: Wed,  8 Apr 2026 10:45:11 +0530
Message-Id: <20260408051514.608781-11-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260408051514.608781-1-chaitanya.kumar.borah@intel.com>
References: <20260408051514.608781-1-chaitanya.kumar.borah@intel.com>
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

Now that everything is in place expose the SDR plane color pipeline
to user-space.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 20f5e0e83496..9e5891338f31 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -182,17 +182,11 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 
 int intel_color_pipeline_plane_init(struct drm_plane *plane, enum pipe pipe)
 {
-	struct drm_device *dev = plane->dev;
-	struct intel_display *display = to_intel_display(dev);
 	struct drm_prop_enum_list pipelines[MAX_COLOR_PIPELINES] = {};
 	int len = 0;
 	int ret = 0;
 	int i;
 
-	/* Currently expose pipeline only for HDR planes */
-	if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
-		return 0;
-
 	/* Add pipeline consisting of transfer functions */
 	ret = _intel_color_pipeline_plane_init(plane, &pipelines[len], pipe);
 	if (ret)
-- 
2.25.1

