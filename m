Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8488FF589DF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E0110F188;
	Thu, 23 Apr 2026 14:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RRtQSiyM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE7410F17B;
 Thu, 23 Apr 2026 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776954868; x=1808490868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j0fq6zhyM+HUrDq8hM0qw1e4nT6lvGm/3ZJcs6HROIc=;
 b=RRtQSiyMZ3ZFX6XvQes2A1Nf+eYvZowoR0VHN8reCJ7reKJo3J6hEW/9
 ptZBUNmWT3bQ17jfOAObCc+u6OWW5zbEKpUOtRmU6YirVLO+2MwECZtOW
 OtWhYXfiCgO+MuzmPeY0M5LMH/AqU1wyfOlAd6S/O/7Z2fRuJp0idAwzW
 Vfwy1gUjzU9qDoj1erVbNpZ7uP1RErXPwqeOecJQJfi0OlExol5BtcvP1
 mzF+16KHR4K7g/Ld1rR/DQ3IkYgtryZ8/W/XcJYd2YLY1nV0USRQ79Krs
 ZDZknbauzEjVaaJBuv3FUaBPwAey35EeniN3JLm6UPC7e81Lfw/RT3m5t Q==;
X-CSE-ConnectionGUID: bMiilCamSNu4wUwqA2h4eQ==
X-CSE-MsgGUID: Z+Sf1txXQrqT2w4cpGffjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="76957635"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="76957635"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 07:34:28 -0700
X-CSE-ConnectionGUID: XB0r4v3iRUyme95e0B6ISg==
X-CSE-MsgGUID: WHS4PmCPTC6LvEdl7a07sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="256170452"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa001.fm.intel.com with ESMTP; 23 Apr 2026 07:34:27 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>
Subject: [PATCH 1/3] drm/dp: Add DP_DSC_MAX_BPP_DELTA register
Date: Thu, 23 Apr 2026 20:00:33 +0530
Message-Id: <20260423143035.2267634-2-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260423143035.2267634-1-nemesa.garg@intel.com>
References: <20260423143035.2267634-1-nemesa.garg@intel.com>
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

The dsc max bpp delta masks were incorrectly placed
under the DP_DSC_BITS_PER_PIXEL_INC(0x06F) register.
Move these under correct DP_DSC_MAX_BPP_DELTA(0x06E)
register.

v2: Separate patch for correcting register. [Ankit]

Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
---
 include/drm/display/drm_dp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 8b15d3eeb716..520490ac6778 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -354,9 +354,11 @@
 # define DP_DSC_20_PER_DP_DSC_SINK          (1 << 1)
 # define DP_DSC_24_PER_DP_DSC_SINK          (1 << 2)
 
-#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
+#define DP_DSC_MAX_BPP_DELTA		    0x06E
 # define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
 # define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
+
+#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
 # define DP_DSC_BITS_PER_PIXEL_1_8          0x1
 # define DP_DSC_BITS_PER_PIXEL_1_4          0x2
-- 
2.25.1

