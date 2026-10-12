Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EFCCA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C285A10E494;
	Mon, 12 Oct 2026 04:15:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB4510E486;
 Mon, 12 Oct 2026 04:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778497; x=1823314497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pl7CtPeukKzq5UAy/Qrnn2ULCIsTVsQo1Q9dTiMNqOA=;
 b=Pec6226Fwhm6i2bsp9KbaY26JFeFjBKBp9wMU6FwzJLTcoi5x1kwGrJR
 OAsM0yxilBgVCKefMWYWJSHmMj8ErhslCzJ2cwQvo8oeupt1lHGHASrcz
 2FlhCZiDTRsAZpQelYRquBdhCyaVJjYzvNwq+n53T2XZpx2IyAX9QaOYz
 eurwVVcNcWdmAxxWqkUxMDSC4YCBHfMk5wW+VMphsJG4Ja4spbQjnfkNQ
 k3EvBXzcsM8Rh1pypzTuSZSut08nBfMqUpduHI20GsEKlOnxWxVaP6wtK
 XvYgeZ/TkS04hfOGw+vut9S1tO4BhQ7H+3VVGiEVHdArDJANUU3F+fTfe g==;
X-CSE-ConnectionGUID: Db/B2oP7Q0GmJ/8Fv1qa7w==
X-CSE-MsgGUID: 8I95lUyETveQJ5jzf5IWkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380856"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380856"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:57 -0700
X-CSE-ConnectionGUID: ysN0jHRUSx+qGnXqrIYiFg==
X-CSE-MsgGUID: yxVdOF5YRaigProX248DxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256427"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:56 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 19/56] drm/i915/ltphy: Add PLL tables for HDMI FRL
Date: Mon, 12 Oct 2026 09:27:28 +0530
Message-ID: <20261012035806.3361439-20-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
index 86492651b01d..61bad87eefec 100644
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

