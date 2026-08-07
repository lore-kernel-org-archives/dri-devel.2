Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2066C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58C610F34B;
	Fri,  7 Aug 2026 04:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oB3BUpkO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5C810F349;
 Fri,  7 Aug 2026 04:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077105; x=1817613105;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3tFqH4PAk2Gsd8vpV659z+s1V3qx0vtIs2Rp/Rs/1SA=;
 b=oB3BUpkObPSKTJU9KaevdzW+qFe9vuKFSsQ43mFGSGfVe7Ga2WZwfWWe
 yZzvIDD+UEJeD5C/2FdlyUfBpSbbHX99ATbfnfJ2E3tJT8kmTsJROmT+T
 w8HAZO+vja4w/kidgZL+VD+0+uSFYzRzPWimVu4dBe4GiXGJmiSDVTZ5n
 G/d6upwaN51dlYylhToX0DCILa3iqtQh5eKzL+vH8KficZbXKe1pA+QIO
 AZKwTnr0hn5YL9XIad8rl5Vxq1CPkhdtCv5jCsHsN8Zi8H5sgQym/Pq02
 lfI172hGa6m3Vk4NsHy2YK7tlAmIx+f9exsn2M/uduYkc7ReKn2DjPEwd g==;
X-CSE-ConnectionGUID: jpobYZpxQeuGpOJZbERr+g==
X-CSE-MsgGUID: wYQMVG+QS9KPFrb79BoClA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619253"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:45 -0700
X-CSE-ConnectionGUID: piiKa3wDTa2DeBXbjARJtg==
X-CSE-MsgGUID: jb6DXfMASISjqDKXD5Ml3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666094"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:42 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 07/44] drm/i915/intel_cx0_phy_regs: Add HDMI FRL SHIFT EN bit
 in PORT_BUF_CTL_1
Date: Fri,  7 Aug 2026 09:43:52 +0530
Message-ID: <20260807041430.229038-8-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Add HDMI_FRL_SHFTR_EN bit in PORT_BUF_CTL_1.
This bit enables the HDMI FRL 18b to 20b shifting and data output.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h b/drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h
index 152a4e751bdc..64fdf84b98ab 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h
@@ -112,6 +112,7 @@
 #define   XELPDP_TCSS_POWER_REQUEST			REG_BIT(5)
 #define   XELPDP_TCSS_POWER_STATE			REG_BIT(4)
 #define   XELPDP_PORT_WIDTH_MASK			REG_GENMASK(3, 1)
+#define   XELPDP_PORT_HDMI_FRL_SHFTR_EN			REG_BIT(0)
 #define   XELPDP_PORT_WIDTH(width)			REG_FIELD_PREP(XELPDP_PORT_WIDTH_MASK, \
 								       ((width) == 3 ? 4 : (width) - 1))
 
-- 
2.50.1

