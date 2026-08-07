Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BDDC5AC81
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C6B10F390;
	Fri,  7 Aug 2026 04:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hvwf5n8W";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2C710F391;
 Fri,  7 Aug 2026 04:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077138; x=1817613138;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HoVLfiX/3irH4ra+Z5Mf+l7uGsFJhiH1q8jEoRn2PcY=;
 b=hvwf5n8WRgDfE14c5fONQrSMc5hsSYPY0LdSY3fNEFu+xD5QtG6sHfks
 uU7E7GS3KkheIeaB+nTJACCZ+BkiNyPh40dqax61bc6WAMjVNUDNnEQ1D
 Z5TP1Ef1ASSk9zB2/8mLJDjoqDCcNG9gdGv7Knkr5QBNkRdfVds3EEmmE
 oPJjh2xpt5goFmxxmi1lKKQJaOWEO/Y77RMTaqbj+3KoPW7bnpZsC2M3K
 uQbnNXXn65nh+ud23cBuLy7Jr1YChVixwnLW+pIKVqUS2Mmg+mUYrTUOn
 Uuj704vmJVuxFVyxXKDrlvuAx7sm7ebizmh1D1oggV7r3uZ34SjxfUgbN Q==;
X-CSE-ConnectionGUID: wdsoK//dSeeSZ5XQbSF7Cw==
X-CSE-MsgGUID: yDwUxbp7QAylijK5aW25ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619293"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:17 -0700
X-CSE-ConnectionGUID: a28ivlH2Rg+jjGOU8yb+jQ==
X-CSE-MsgGUID: x8mXxKTQRZS3iHAhnx/MnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666209"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:14 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 19/44] drm/i915/ltphy: Add PLL tables for HDMI FRL
Date: Fri,  7 Aug 2026 09:44:04 +0530
Message-ID: <20260807041430.229038-20-ankit.k.nautiyal@intel.com>
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

Add HDMI FRL Tables for LT PHY i.e for the rates of 3G, 6G, 8G,
10G and 12G.

Bspec: 74667
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 270 ++++++++++++++++++++
 1 file changed, 270 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 8fc6d230493f..a16401e42ed9 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -950,11 +950,281 @@ static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_5p94 = {
 	},
 };
 
+static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_3g0 = {
+	.config = {
+		0x85,
+		0x2d,
+		0x0,
+	},
+	.addr_msb = {
+		0x87,
+		0x87,
+		0x87,
+		0x87,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+	},
+	.addr_lsb = {
+		0x10,
+		0x0c,
+		0x14,
+		0xe4,
+		0x0c,
+		0x10,
+		0x14,
+		0x18,
+		0x48,
+		0x40,
+		0x4c,
+		0x24,
+		0x44,
+	},
+	.data = {
+		{ 0x0,  0x4c, 0x2,  0x0  },
+		{ 0x5,  0xa,  0x27, 0x0  },
+		{ 0x80, 0x0,  0x0,  0x0  },
+		{ 0x4,  0x9,  0x1,  0x28 },
+		{ 0xf2, 0x2e, 0x83, 0x10 },
+		{ 0x80, 0x0f, 0xf9, 0x53 },
+		{ 0x84, 0x24, 0x0,  0x0  },
+		{ 0x0,  0xe0, 0x1,  0x0  },
+		{ 0x4b, 0x48, 0x0,  0x0  },
+		{ 0x27, 0x8,  0x0,  0x0  },
+		{ 0x5a, 0x13, 0x29, 0x13 },
+		{ 0x0,  0x40, 0xa0, 0x0  },
+		{ 0x0,  0x0,  0x0,  0x0  },
+	},
+};
+
+static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_6g0 = {
+	.config = {
+		0x8d,
+		0x2d,
+		0x0,
+	},
+	.addr_msb = {
+		0x87,
+		0x87,
+		0x87,
+		0x87,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+	},
+	.addr_lsb = {
+		0x10,
+		0x0c,
+		0x14,
+		0xe4,
+		0x0c,
+		0x10,
+		0x14,
+		0x18,
+		0x48,
+		0x40,
+		0x4c,
+		0x24,
+		0x44,
+	},
+	.data = {
+		{ 0x0,  0x4c, 0x2,  0x0  },
+		{ 0x2,  0x8a, 0x27, 0x0  },
+		{ 0x80, 0x0,  0x0,  0x0  },
+		{ 0x4,  0x4,  0x80, 0xa8 },
+		{ 0xf2, 0x2e, 0x83, 0x10 },
+		{ 0x80, 0x0f, 0xf9, 0x53 },
+		{ 0x84, 0x24, 0x0,  0x0  },
+		{ 0x0,  0xe0, 0x1,  0x0  },
+		{ 0x4b, 0x48, 0x0,  0x0  },
+		{ 0x27, 0x8,  0x0,  0x0  },
+		{ 0x5a, 0x13, 0x29, 0x13 },
+		{ 0x0,  0x40, 0xa0, 0x0  },
+		{ 0x0,  0x0,  0x0,  0x0  },
+	},
+};
+
+static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_8g0 = {
+	.config = {
+		0x95,
+		0x2d,
+		0x0,
+	},
+	.addr_msb = {
+		0x87,
+		0x87,
+		0x87,
+		0x87,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+	},
+	.addr_lsb = {
+		0x10,
+		0x0c,
+		0x14,
+		0xe4,
+		0x0c,
+		0x10,
+		0x14,
+		0x18,
+		0x48,
+		0x40,
+		0x4c,
+		0x24,
+		0x44,
+	},
+	.data = {
+		{ 0x0,  0x4c, 0x2,  0x0  },
+		{ 0x2,  0x8a, 0x34, 0x0  },
+		{ 0xaa, 0xaa, 0xaa, 0xaa },
+		{ 0x5,  0x4,  0x80, 0xa8 },
+		{ 0xf2, 0x22, 0x83, 0x10 },
+		{ 0x80, 0x0f, 0xf9, 0xb5 },
+		{ 0x84, 0x24, 0x0,  0x0  },
+		{ 0x0,  0xe0, 0x1,  0x0  },
+		{ 0x4b, 0x48, 0x0,  0x0  },
+		{ 0x27, 0x8,  0x0,  0x0  },
+		{ 0x5a, 0x13, 0x29, 0x13 },
+		{ 0x0,  0x40, 0xa0, 0x0  },
+		{ 0x0,  0x0,  0x0,  0x0  },
+	},
+};
+
+static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_10g0 = {
+	.config = {
+		0x1d,
+		0x2d,
+		0x0,
+	},
+	.addr_msb = {
+		0x85,
+		0x85,
+		0x85,
+		0x85,
+		0x86,
+		0x86,
+		0x86,
+		0x86,
+		0x86,
+		0x00,
+		0x86,
+		0x86,
+		0x86,
+	},
+	.addr_lsb = {
+		0x10,
+		0x0c,
+		0x14,
+		0xe4,
+		0x0c,
+		0x10,
+		0x14,
+		0x18,
+		0x48,
+		0x00,
+		0x4c,
+		0x24,
+		0x44,
+	},
+	.data = {
+		{ 0x0,  0x4c, 0x2,  0x0  },
+		{ 0x1,  0x49, 0x20, 0x80 },
+		{ 0x6a, 0xaa, 0xaa, 0xab },
+		{ 0x0,  0x6,  0x4,  0x94 },
+		{ 0xfa, 0x1c, 0x83, 0x11 },
+		{ 0x80, 0x0f, 0xf9, 0x53 },
+		{ 0x84, 0x26, 0x4,  0x4  },
+		{ 0x0,  0xe0, 0x1,  0x0  },
+		{ 0x45, 0x48, 0x0,  0x0  },
+		{ 0x27, 0x8,  0x0,  0x0  },
+		{ 0x5a, 0x14, 0x2a, 0x14 },
+		{ 0x0,  0x5b, 0xe0, 0x8  },
+		{ 0x0,  0x0,  0x0,  0x0  },
+	},
+};
+
+static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_12g0 = {
+	.config = {
+		0xa5,
+		0x2d,
+		0x0,
+	},
+	.addr_msb = {
+		0x87,
+		0x87,
+		0x87,
+		0x87,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+		0x88,
+	},
+	.addr_lsb = {
+		0x10,
+		0x0c,
+		0x14,
+		0xe4,
+		0x0c,
+		0x10,
+		0x14,
+		0x18,
+		0x48,
+		0x40,
+		0x4c,
+		0x24,
+		0x44,
+	},
+	.data = {
+		{ 0x0,  0x4c, 0x2,  0x0  },
+		{ 0x1,  0x49, 0x27, 0x0  },
+		{ 0x80, 0x0,  0x0,  0x0  },
+		{ 0x8,  0x4,  0x80, 0xb2 },
+		{ 0xf2, 0x2e, 0x83, 0x10 },
+		{ 0x80, 0x0f, 0xf9, 0x53 },
+		{ 0x84, 0x24, 0x0,  0x0  },
+		{ 0x0,  0xe0, 0x1,  0x0  },
+		{ 0x4b, 0x48, 0x0,  0x0  },
+		{ 0x27, 0x8,  0x0,  0x0  },
+		{ 0x5a, 0x14, 0x29, 0x14 },
+		{ 0x0,  0x40, 0xa0, 0x0  },
+		{ 0x0,  0x0,  0x0,  0x0  },
+	},
+};
+
 static const struct intel_lt_phy_pll_params xe3plpd_lt_hdmi_tables[] = {
 	LT_PHY_PLL_HDMI_PARAMS(25200, xe3plpd_lt_hdmi_252),
 	LT_PHY_PLL_HDMI_PARAMS(74250, xe3plpd_lt_hdmi_742p5),
 	LT_PHY_PLL_HDMI_PARAMS(148500, xe3plpd_lt_hdmi_1p485),
 	LT_PHY_PLL_HDMI_PARAMS(594000, xe3plpd_lt_hdmi_5p94),
+	LT_PHY_PLL_HDMI_PARAMS(300000, xe3plpd_lt_hdmi_3g0),
+	LT_PHY_PLL_HDMI_PARAMS(600000, xe3plpd_lt_hdmi_6g0),
+	LT_PHY_PLL_HDMI_PARAMS(800000, xe3plpd_lt_hdmi_8g0),
+	LT_PHY_PLL_HDMI_PARAMS(1000000, xe3plpd_lt_hdmi_10g0),
+	LT_PHY_PLL_HDMI_PARAMS(1200000, xe3plpd_lt_hdmi_12g0),
 	{}
 };
 
-- 
2.50.1

