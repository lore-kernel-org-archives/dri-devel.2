Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111ABCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFD110EA52;
	Tue, 23 Jun 2026 09:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cuCLPq/L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEA410EA46;
 Tue, 23 Jun 2026 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782207981; x=1813743981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vIzbeQrtWE5qIRQSSEhX/A+ooyiPoznkmGkQUg9Ezds=;
 b=cuCLPq/L1t2ewEa/h4eX6uIyNrMXXrOOgZf9mmlPpOhnh8eTmS5TJPA3
 w+i2fh9wFGg0LH4NMsFLlvPJAGuVTorjIavHvIlsWYMW9a7a0zj+iMuV9
 GXNAS4InwWTcko2tYQagiZ6qzqthrOIrrVxocs+pSGu4jmZmtREy7JbxW
 qGcYdUGwpuOC0/fydkOjjrMZywKID4G/uOYh6AwyqrmxskMmMkUiGBtZO
 xE1WB0/QP8PMjdXULVKkJYrPk23huVAEKpFkMAR6OWpDfttifVsJ0EwJk
 2iOS9F534RiiI6G/addKeaVUyhtlBelwFVa7tgmGlRLWmw31FoE7Qcjby g==;
X-CSE-ConnectionGUID: NqYegfXzQxqkboiHqmMcAw==
X-CSE-MsgGUID: 2kji9mfDRCWomP1jCZ1H2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94336268"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="94336268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 02:46:21 -0700
X-CSE-ConnectionGUID: g2yxWILSRt+lhFC7tQMr0Q==
X-CSE-MsgGUID: l+XYLS7WT/usXYp8hn144w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="247130355"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2026 02:46:18 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [RESEND 1/4] drm/dp: Add DP_DSC_MAX_BPP_DELTA register
Date: Tue, 23 Jun 2026 15:12:33 +0530
Message-Id: <20260623094236.1586318-2-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623094236.1586318-1-nemesa.garg@intel.com>
References: <20260623094236.1586318-1-nemesa.garg@intel.com>
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
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 include/drm/display/drm_dp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 829e4d98d61c..f34161078622 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -354,9 +354,11 @@
 # define DP_DSC_20_PER_DP_DSC_SINK          (1 << 1)
 # define DP_DSC_24_PER_DP_DSC_SINK          (1 << 2)
 
-#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
+#define DP_DSC_MAX_BPP_DELTA_VERSION_1		0x06E
 # define DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK 0x1f
 # define DP_DSC_RGB_YCbCr420_MAX_BPP_DELTA_MASK 0xe0
+
+#define DP_DSC_BITS_PER_PIXEL_INC           0x06F
 # define DP_DSC_BITS_PER_PIXEL_1_16         0x0
 # define DP_DSC_BITS_PER_PIXEL_1_8          0x1
 # define DP_DSC_BITS_PER_PIXEL_1_4          0x2
-- 
2.25.1

