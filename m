Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC7C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B100C10E7A0;
	Mon, 13 Jul 2026 05:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Kam+rE0A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED91C10E79F;
 Mon, 13 Jul 2026 05:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921185; x=1815457185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QXM6kN8y0jm0X/adCMbIt+oj2kR++CxjonAU0QJOvhs=;
 b=Kam+rE0A3PTCKqbAu+aGnrL02qgSiD+4jJTolebueeOd+lPr3hGn1/fJ
 MMxECDEdtu5Ym+67hVNmY+iSX3JOqcimFb/DUUbeX9Zc9R6CWu1WEGtEk
 ocfR/VFlej9LoAKVk64Z0ZfTeXJ0V+4K3BiZF76jmYNijgqxtUq39YEK3
 biAOETPJiFsn5SP98L9dXJl2j82+J4WOrosAUZZnrcmFKJuvuWPKQXyhw
 MJkKbG3B8j274Gz0SGnHabw/3Y+3r9tB47qOz9A92WbHXMwhqAe/4mVvl
 nISFURr/Es9gZvhje220wq7CrDEJ3EMaSGi6YMjo+FQu1vBkZ94XuQ9Sf w==;
X-CSE-ConnectionGUID: ULL1ZzK8TNy52bbOjZnRXA==
X-CSE-MsgGUID: clUJik6GQkqaYX8L/l7k5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95670009"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95670009"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:45 -0700
X-CSE-ConnectionGUID: cES7nrCiTGqgTelfxN4bKQ==
X-CSE-MsgGUID: XYGgV8RKSJy/uaktO0MvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066360"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:43 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 14/14] drm/i915/color: Add color pipeline support for SDR
 planes
Date: Mon, 13 Jul 2026 10:45:16 +0530
Message-Id: <20260713051516.4087420-15-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
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
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 136b9378ca48..a99b6eb20448 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -188,17 +188,11 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 
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

