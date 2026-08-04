Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D14C56203
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D80310EA42;
	Tue,  4 Aug 2026 12:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SiQI5kvs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F20610EA40;
 Tue,  4 Aug 2026 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848112; x=1817384112;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aaks0wpECXnb79Uhc4Q+pz8k2tEj0mvJXqhXPUsHb/4=;
 b=SiQI5kvsJzdVdJHlB2IQekFsquuq099iLw7HosSJf/kAf1pVa/z9stHc
 8IRx4eoZT7zC24Jl1Zvef3sYDYEepfMk/kocwYa+Pojog5htaTsB83RCH
 oTEnIMvfilPkN3RRLrxtEetunjeosZAqtRSmP3C9UthDWzHvZqx9/yzV1
 8wCNVC8aIcqfEsRhDtEyyK3de50ENEhindeU/DV/8EHQE/2cXqOA1Br9F
 7dpnfpl+nb6u8/h8MjEr3SThz6sNDMVB1jSiaCPJo2iRDIcxgB32Y+xFK
 2PfU0GYlVrM2p4+uphawvd8jSPCiL5jjHH3Zuy5nK7yYUv0hZdG3q5d6r A==;
X-CSE-ConnectionGUID: ruc2+F3oS1esU3W/Br306g==
X-CSE-MsgGUID: KiN/4fBdStKMWeDUiLgO1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073228"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073228"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:12 -0700
X-CSE-ConnectionGUID: PfcEzvjORdO0jYgeTT8nlg==
X-CSE-MsgGUID: xQ/FeeO5QJWYeyh5Paqngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108380"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:55:10 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
Date: Tue,  4 Aug 2026 18:01:04 +0530
Message-ID: <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
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

Extend the SDR plane color pipeline to post-CSC 1D LUT block.

v2:
 - In preparation of a simple pipeline
	[YUV Full/Limited -> RGB] -> [1D LUT]
   Drop pre-CSC LUT from the pipeline as it has no use in a YUV -> RGB
   pipeline. This makes the pipeline simple since the block lies between
   the YUV range correct block and Fixed function CSC. It can be added back
   when [RGB709 -> RGB2020] capability is added. Then it can be used for
   linearization.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index efd4375c4331..53e55ce0a5a3 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -45,6 +45,7 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 
 static const enum intel_color_block sdr_plane_yuv_pipeline[] = {
 	INTEL_PLANE_CB_CSC_FF,
+	INTEL_PLANE_CB_POST_CSC_LUT,
 };
 
 static const u64 intel_plane_supported_csc_ff =
-- 
2.50.1

