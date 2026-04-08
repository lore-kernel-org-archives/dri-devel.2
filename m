Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3E1FD5F7B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D8E10E53D;
	Wed,  8 Apr 2026 05:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mjIZNoSD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E298110E53A;
 Wed,  8 Apr 2026 05:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775626853; x=1807162853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pJKHk2vMVCKjWEohaVgMrTUZS47quOy9V1pn6kGHbMU=;
 b=mjIZNoSD9dELCnX8ahOcKl/31gjLJFih9+Scr1wGemc+fxIWv7FLaMxW
 J1v8lP+DoHnsdJcKbA2k1wD+5Zjlranb2yp65QRU/JFDgD7knWroLuABq
 6agVZHgT5fAZwgEU+82QALH1qHIIrves/UyDn3M8Px/rimK+/nV4KEwUB
 FWZneH4Ix2riIwlHbQ8RiwLYiT0IdR+I7NPftgv3d6Pyw3n6e1Dl8odbE
 gV1mKupKslou/rmoDohuEcxa/sOTAA4s4H3LDF68ttE6kbXT6Z0OAeM3I
 ziwLaU1wC2AKyR/f5y8U4p/26Q2j1/0PViW+J6zt5/7gFOTVpjPL2hwNx w==;
X-CSE-ConnectionGUID: b/bi5EKUTcqcKAB1IlTQOg==
X-CSE-MsgGUID: 2qBGsbUYSduTeHOZ1af4Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80194954"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="80194954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:40:53 -0700
X-CSE-ConnectionGUID: h8EddY8xRgOcYEdr96DV0A==
X-CSE-MsgGUID: /0/416rsT4eOSk+/ohZstw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="251518117"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa002.fm.intel.com with ESMTP; 07 Apr 2026 22:40:48 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: harry.wentland@amd.com, louis.chauvet@bootlin.com, mwen@igalia.com,
 contact@emersion.fr, alex.hung@amd.com, daniels@collabora.com,
 uma.shankar@intel.com, maarten.lankhorst@intel.com,
 pekka.paalanen@collabora.com, pranay.samala@intel.com,
 swati2.sharma@intel.com, chaitanya.kumar.borah@intel.com
Subject: [PATCH v2 13/13] drm/i915/color: Add YUV range correction to SDR
 plane pipeline
Date: Wed,  8 Apr 2026 10:45:14 +0530
Message-Id: <20260408051514.608781-14-chaitanya.kumar.borah@intel.com>
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

Insert the INTEL_PLANE_CB_YUV_RANGE_CORRECT color block into the SDR
plane color pipeline. This enables YCbCr limited-to-full range expansion
ahead of the CSC block that expects full range pixel data. With this,
the pipeline can accept limited range framebuffers.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 17cbbbc839af..301ee3bdc4b0 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -45,6 +45,7 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 };
 
 static const enum intel_color_block sdr_plane_pipeline[] = {
+	INTEL_PLANE_CB_YUV_RANGE_CORRECT,
 	INTEL_PLANE_CB_PRE_CSC_LUT,
 	INTEL_PLANE_CB_CSC_FF,
 	INTEL_PLANE_CB_POST_CSC_LUT,
-- 
2.25.1

