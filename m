Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974BECD98F1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFD310EF36;
	Wed, 17 Jun 2026 09:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IKQAIbnb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579E510EF25;
 Wed, 17 Jun 2026 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781688772; x=1813224772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hXRIXYwzreVUsLlB6mcXIQK+qfTNL2/Nk99X+a7Z+AM=;
 b=IKQAIbnbOY6+URoijqzRjME9ZQIeUFAJMgsrKwTwbXiWsq00/wyRaFRn
 +ZRwQMynl1oeeDcdX2ZQ7CxlMNdMyHtwloE+qC3O+NhyQNqQo4c0ZMdHd
 yZCvkfQrA2/16ZDJBMl4OMSDe7s+sOkZWB84lJkFt0T4lBbpYSqyswxzY
 jUkMX7BeY8bPqWu+eU2HdQtRqwKs8TPixFWNUawCLjPOjGyyhqBpkcBE4
 pdy015vKtuIE5A3enqnHpmk+974Yu+/SJa4DgPkw470nTBaD5tBHlz2U0
 QCfEsIiTdqu0F9H78h9wpMTB0p+0FmVSnP7+zVshUOUlLwPYdQQTWegSi g==;
X-CSE-ConnectionGUID: bnbojfAUSOymuICVbJ7+hg==
X-CSE-MsgGUID: /VEj9U/HR/+jmj14jGTYuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81605281"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="81605281"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:32:52 -0700
X-CSE-ConnectionGUID: GzRKnt85QYKcdG3h13m7EA==
X-CSE-MsgGUID: ibK6cEn1Sy2/KS0wJFHIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="245114455"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 17 Jun 2026 02:32:51 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [v3 08/14] drm/i915/color: Add YUV range correction to SDR plane
 pipeline
Date: Wed, 17 Jun 2026 14:38:13 +0530
Message-Id: <20260617090819.1735153-9-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617090819.1735153-1-chaitanya.kumar.borah@intel.com>
References: <20260617090819.1735153-1-chaitanya.kumar.borah@intel.com>
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
index 7d25f4fbfa9b..7457fa51cb97 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -44,6 +44,7 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 };
 
 static const enum intel_color_block sdr_plane_pipeline[] = {
+	INTEL_PLANE_CB_YUV_RANGE_CORRECT,
 	INTEL_PLANE_CB_CSC_FF,
 };
 
-- 
2.25.1

