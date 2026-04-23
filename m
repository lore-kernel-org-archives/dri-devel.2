Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9455F589D9
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C820010F189;
	Thu, 23 Apr 2026 14:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZcJU837W";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F82810F188;
 Thu, 23 Apr 2026 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776954871; x=1808490871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A4NFHpjCL2Xuj3pWAcpsv16ECbSk8WtfE33gA7SctI0=;
 b=ZcJU837WNv9SdEA0PIRMwnYQJPFR4juWSzyu0KjFaWQBW8ju9PC4n6WW
 toD1js3Y9oShPTUIbw7j7lQm/RwhfbVQ++qF1uQG1cQeRBQJ6n/QjdSH1
 I1QRmJvdEEW56+CnY/twiU5emBb+PXTwTY/gEHDTun4GEN/ZauMsSCNnO
 IJw2NnCqtoZvYQhChrK4FbekUlDTvTO+KQ0I1M8xg9Nv4jsIuvpIq0bG3
 h9VHHBUdCyIGTVIt5GFsZocQmzWn8nzAvzthDwq3WBzcYsN8Vp95/ssbm
 PDTPGggpK0KYmN4Sep0AoaFabUtvv+bteLaK/t8AVPFOrepFvGHx/ucEC A==;
X-CSE-ConnectionGUID: Ys1s+zFjRwipw5odfdjlcw==
X-CSE-MsgGUID: lYhohHYeTdai6EJ4cbTGJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="76957644"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="76957644"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 07:34:31 -0700
X-CSE-ConnectionGUID: oJeoHWyOSQKc2kqDaGaViQ==
X-CSE-MsgGUID: L4mPOuSqS8aqQ2CYPzSDrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="256170455"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa001.fm.intel.com with ESMTP; 23 Apr 2026 07:34:30 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>
Subject: [PATCH 2/3] drm/dp: Add max bpp delta computation constants
Date: Thu, 23 Apr 2026 20:00:34 +0530
Message-Id: <20260423143035.2267634-3-nemesa.garg@intel.com>
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

These constants are used when decoding dsc max delta
values from the sink dpcd. Also add version_1 as suffix
to MAX_DELTA_BPP.

v2: Move constants under 0x6E register. [Ankit]
    Add mask for Native 422 also. [Ankit]

Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
---
 include/drm/display/drm_dp.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 520490ac6778..c29b391453cd 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -354,17 +354,22 @@
 # define DP_DSC_20_PER_DP_DSC_SINK          (1 << 1)
 # define DP_DSC_24_PER_DP_DSC_SINK          (1 << 2)
 
-#define DP_DSC_MAX_BPP_DELTA		    0x06E
+#define DP_DSC_MAX_BPP_DELTA_VERSION_1		0x06E
 # define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
 # define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
-
-#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
-# define DP_DSC_BITS_PER_PIXEL_1_16         0x0
-# define DP_DSC_BITS_PER_PIXEL_1_8          0x1
-# define DP_DSC_BITS_PER_PIXEL_1_4          0x2
-# define DP_DSC_BITS_PER_PIXEL_1_2          0x3
-# define DP_DSC_BITS_PER_PIXEL_1_1          0x4
-# define DP_DSC_BITS_PER_PIXEL_MASK         0x7
+# define DP_DSC_BPP_DELTA_444			16
+# define DP_DSC_BPP_DELTA_420			12
+# define DP_DSC_BPP_DELTA_SHIFT_420		5
+
+#define DP_DSC_BITS_PER_PIXEL_INC		0x06F
+# define DP_DSC_BITS_PER_PIXEL_1_16		0x0
+# define DP_DSC_BITS_PER_PIXEL_1_8		0x1
+# define DP_DSC_BITS_PER_PIXEL_1_4		0x2
+# define DP_DSC_BITS_PER_PIXEL_1_2		0x3
+# define DP_DSC_BITS_PER_PIXEL_1_1		0x4
+# define DP_DSC_BITS_PER_PIXEL_MASK		0x7
+# define DP_DSC_NATIVE4222_MAX_BPP_DELTA_MASK	0x78
+# define DP_DSC_BPP_DELTA_NATIVE_422		16
 
 #define DP_PSR_SUPPORT                      0x070   /* XXX 1.2? */
 # define DP_PSR_IS_SUPPORTED                1
-- 
2.25.1

