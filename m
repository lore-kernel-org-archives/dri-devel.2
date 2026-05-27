Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6750ACD6E47
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 11:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763C910E789;
	Wed, 27 May 2026 11:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S1MP0JVA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E3310E152;
 Wed, 27 May 2026 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779880357; x=1811416357;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bOK3L4pPhyRkYKfjEqE6s4PnKovf4DdzHS9FwpkDgwY=;
 b=S1MP0JVAExpLZIqUXCPD8k8GETb5HMPiWAJWtc5M6RLRUb0lBDOMuFfD
 detLujg3b2S80838ncQIc+cW52muN9dl4WISOXRUBJooo6T/ZEWdDl1jS
 TuIZxMZb2oU5aE9Xy0rvEQYrO911bRNX+nup03Y3KIVTSXScpwrKTNIkW
 xjUHltl63lPJCznqbLwzDW9F8V6AmY7cLvkOYRJEqwkuri/GcVBBHNlnc
 MFTLbmpYfPx1bxQXAnSO+DgF5IiGui6+TrPx5rN7LFdcYrBlU6woRaBMt
 gkW0mm996yeCBjNXtvesmIFYdyObLA7njP78URNeTk9Kn9VptoEk1KKiS w==;
X-CSE-ConnectionGUID: ehQ2t/ugRlGSCQ2Es6gblw==
X-CSE-MsgGUID: pPW8w/pUTDegIi6Ij3MV2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80818510"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80818510"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 04:12:37 -0700
X-CSE-ConnectionGUID: +kE7aS5kRrSAHnDmXpjvNA==
X-CSE-MsgGUID: znYCrxhvR0yESLDd9qp1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="265803147"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa002.fm.intel.com with ESMTP; 27 May 2026 04:12:35 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 1/4] drm/dp: Add DP_DSC_MAX_BPP_DELTA register
Date: Wed, 27 May 2026 16:38:46 +0530
Message-Id: <20260527110849.3943338-2-nemesa.garg@intel.com>
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
index 829e4d98d61c..e65aafcccf99 100644
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

