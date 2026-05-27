Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB01FCD5BC9
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 11:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB29210E794;
	Wed, 27 May 2026 11:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nN5+paSG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2011A10E782;
 Wed, 27 May 2026 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779880359; x=1811416359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tbkAkqSUgNucXOgDiL3AbWspjmjtTNaR1s98YZe9eUE=;
 b=nN5+paSG4lc5BlsygApBXNbIq88lOQoTQ7jVkY6HeQJSa2fV3R2Y+WMD
 P7IEoy4OGfiRVB/aH7Aqp5rupYBMtXEalAFVSc18Hmnu1yzK4FIU8O0GC
 iS/7tzQRCkGUHPc3jJWg5wphU3OhAw9u6pWrWmaE41lN4M9UChT5km254
 AE1HNe1Vvf3jPn7ZTcGw2cgvkfGGe77qhrjtKVVbS0SCgtxMY/gtNgo5b
 t6x2GYgQ2yKmIflvYQGhIVesernzsDcEz6GqTHjFPXALkypfw4et9mJw8
 NnBMzicds+tsZG+9pc7gLU4NfBU4U5H0p8ozi7hwuu1vfx9L/PLuwrVPg Q==;
X-CSE-ConnectionGUID: iv/PjFXLTLqDyhFckq7M6Q==
X-CSE-MsgGUID: vNWWCO4XRri/NXFAA+P7EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80818512"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80818512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 04:12:39 -0700
X-CSE-ConnectionGUID: SbWGTTLiTuuO14J8dmDPFQ==
X-CSE-MsgGUID: EcLj/i8oQe6Etsxe23lrJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="265803156"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa002.fm.intel.com with ESMTP; 27 May 2026 04:12:37 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>
Subject: [PATCH 2/4] drm/dp: Rename YCbCr420 bpp delta mask to native
Date: Wed, 27 May 2026 16:38:47 +0530
Message-Id: <20260527110849.3943338-3-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527110849.3943338-1-nemesa.garg@intel.com>
References: <20260527110849.3943338-1-nemesa.garg@intel.com>
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

Rename DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK to
DP_DSC_NATIVE_YCbCr420_MAX_BPP_DELTA_MASK to align with
the DP DSC specification, where the field represents the
native YCbCr 4:2:0 format.

Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
---
 include/drm/display/drm_dp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e65aafcccf99..dce290acf735 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -356,7 +356,7 @@
 
 #define DP_DSC_MAX_BPP_DELTA		    0x06E
 # define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
-# define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
+# define DP_DSC_NATIVE_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
 
 #define DP_DSC_BITS_PER_PIXEL_INC           0x06F
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
-- 
2.25.1

