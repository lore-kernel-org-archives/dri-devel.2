Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B66DF55810
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BC510E4FD;
	Mon, 20 Apr 2026 11:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="csVqu00h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DABF10E4F9;
 Mon, 20 Apr 2026 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776684657; x=1808220657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+hwSvWb4S9geX0wZbeGIGKy/wINtU8Sfn7NNy3j7gkc=;
 b=csVqu00hKzP5XpkFe/gSfzwnuRGucbAgG+jAGjxJUPa/2Y5A86ZwZrd5
 spgMiTv8b6hhaZx6xDXRWnLMy/cruq+oXzFGJwKQSJQfzWeMcUeW38AcL
 Fq+EJUW1vTkRQQUrrc+eugS2OymeF/wIcpTwsKD4gswYCOEqcJTojOCya
 v43DXcgE40M0J/KMbKxAyMQu1b6alTSw2hlftVGIQjRMSAzf+RejrMxZd
 sajn7+AVa1PvjnaImYAHGpc+N1hP0bVLzZDOHhn2oQcIIJdf8RHmOeBMr
 YTbaWSS4BvJCmHtqGcff2pAonyE6GdnQnS2DiOtsn6MSo8q0qgtyknllm A==;
X-CSE-ConnectionGUID: GId+1cYTS62fcCjt6hUbtQ==
X-CSE-MsgGUID: BpanFt5MRDq7CYMlZ9Lg5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77722739"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="77722739"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 04:30:57 -0700
X-CSE-ConnectionGUID: uUlQ/d0wTZ6T1hemZ3MHlg==
X-CSE-MsgGUID: 3uHnYVtdSe+w5P0rXr54CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="236690594"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by orviesa005.jf.intel.com with ESMTP; 20 Apr 2026 04:30:56 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>
Subject: [PATCH 1/2] drm/dp: Define DSC bpp delta DPCD fields
Date: Mon, 20 Apr 2026 16:56:10 +0530
Message-Id: <20260420112611.1481530-2-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420112611.1481530-1-nemesa.garg@intel.com>
References: <20260420112611.1481530-1-nemesa.garg@intel.com>
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

Add DP_DSC_MAX_BPP_DELTA and related field and mask helper
macros for RGB/YCbCr444 delta and YCbCr420 delta encoding.

Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
---
 include/drm/display/drm_dp.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 8b15d3eeb716..2afd33d90a0e 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -354,9 +354,15 @@
 # define DP_DSC_20_PER_DP_DSC_SINK          (1 << 1)
 # define DP_DSC_24_PER_DP_DSC_SINK          (1 << 2)
 
-#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
+#define MIN_DSC_BPP_DELTA_444 16
+#define MIN_DSC_BPP_DELTA_420 12
+#define BPP_DELTA_SHIFT_420 5
+
+#define DP_DSC_MAX_BPP_DELTA			0x06E
 # define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
 # define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
+
+#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
 # define DP_DSC_BITS_PER_PIXEL_1_8          0x1
 # define DP_DSC_BITS_PER_PIXEL_1_4          0x2
-- 
2.25.1

