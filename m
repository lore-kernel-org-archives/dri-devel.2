Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62951C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A327D10E792;
	Mon, 13 Jul 2026 05:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h5iep9UX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD09F10E556;
 Mon, 13 Jul 2026 05:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921174; x=1815457174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nkd2O1E3fX+r/k7Iw4fqWBOCJhWDIMnCqcv57IslaRY=;
 b=h5iep9UXx+VkeJeNjIgtaLQ/+tcufhW1o57XwMr5ybPT+hVK6x4IvlN+
 ANlK5KdvLOwHfbiXD2VkMoACCJYd5Pf+xcYl4T1riSkf4fH8WlegaEkZ3
 urZsHRJZHeGqExom9TrANwjWDwnpHKPSBCqJQAIbN1hPOWP8CCL4BguUD
 zgMCt50lyS4agUx8WSDSau7BRbGeZ3shLAMf3B5dX3upEDliKXaLKsIIn
 mmQy+YdZB5UNa5czh+lgqE8/OeEPqBFLQ9S955sb8ovFImAUr1aUxLl1U
 LSy3cmjZ0CZA8WjrmjuvqB9xLJDyHCuo45W+ujC8ZmJnswfWVF/IFRNJY w==;
X-CSE-ConnectionGUID: Y2VdzO5jR4qmlbi60RATqA==
X-CSE-MsgGUID: t0GAlY/PT+ieeVK6cKI40A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95669998"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95669998"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:34 -0700
X-CSE-ConnectionGUID: WKhZoUDZQTaJ7H1zas0kOw==
X-CSE-MsgGUID: xnmkxS7LQFmvcO8dkFuHaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066336"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:32 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 08/14] drm/i915/color: Add YUV range correction to SDR plane
 pipeline
Date: Mon, 13 Jul 2026 10:45:10 +0530
Message-Id: <20260713051516.4087420-9-chaitanya.kumar.borah@intel.com>
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

Insert the INTEL_PLANE_CB_YUV_RANGE_CORRECT color block into the SDR
plane color pipeline. This enables YCbCr limited-to-full range expansion
ahead of the CSC block that expects full range pixel data. With this,
the pipeline can accept limited range framebuffers.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
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

