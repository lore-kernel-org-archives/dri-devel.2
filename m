Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA7CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA3310E43D;
	Mon, 12 Oct 2026 04:14:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681AC10E414;
 Mon, 12 Oct 2026 04:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778470; x=1823314470;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3tFqH4PAk2Gsd8vpV659z+s1V3qx0vtIs2Rp/Rs/1SA=;
 b=ieMQLbEFapiX6QUN+eStkpmedOmovyLRnXXpfvLHf4BCb2B71KyultLH
 p5kd4rD+xPOkxk7b+TJSNW0ZMflrTr7iA3bGYm7T6mr69zm/oVwxnIQvB
 yJMu5zfGlxc7vKJF5jBRqXjO22PiBPMVjw482xuNk9o19Zud65llLtoRo
 tQzhc9LGyskmAi+lxxmEcL0ci+n5/6gbrNdJfsZrSQOZ+buemT2/lQvw9
 fjUEvactoPoP71dNYgCiO+2u3Cp1wtk3b2NgUYwyLlnJN/4chTIT+XXxb
 ciOkEq9ZpCdvBqgOAT1E/1QAEfTkZTUfePwSQupl3a/pcFYIbZtO96m1N A==;
X-CSE-ConnectionGUID: yeWxmwZuSnuoy4EhTbp3Hw==
X-CSE-MsgGUID: I2vf3SunRfuznnQxABL1LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380832"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380832"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:30 -0700
X-CSE-ConnectionGUID: d96gSU09RpqVxd29tlkvhw==
X-CSE-MsgGUID: XWPnNHkxQxyiJpReyU1BOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256349"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:29 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 07/56] drm/i915/intel_cx0_phy_regs: Add HDMI FRL SHIFT EN
 bit in PORT_BUF_CTL_1
Date: Mon, 12 Oct 2026 09:27:16 +0530
Message-ID: <20261012035806.3361439-8-ankit.k.nautiyal@intel.com>
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

