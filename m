Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB28606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cQr54xma
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F9D112062;
	Wed, 18 Nov 2026 21:47:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6282C112063
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038419; x=1826574419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EXB2NoXA6MeZnH2rWbnsokLAI4ztjY39cwi7mHoJhhQ=;
 b=cQr54xmaS6V2G0ocsL+MDjXZZMK0CPKcF2OS0WhYXk6B+kMPiHQi1mNM
 5QA41UfgEl4kZnjvbf0YrajPFTUW3LtcH9v3SlqlqM7Wxvufif3Q0pULw
 NHAmJ0x2I8Wxi7i+ehZV8zsG8kffKK15jsFEQXPkwpTbsNUwbHK1XYuMD
 XSGBAREohBDpMOjlcdjmplkd/H6YDH9PUHljwNy7ZjlUvjQrKwwZr4sC+
 P/4mu4/ZnSeecoaeH9caTqJhnudlEpbOHCl6uB45Inmn3sVPMgeYs4Rbg
 ZmATa8GyascnkxCpu/uOXoRj3EUWe69UVzaTEmAf5RrCIvCmrj5yXWQdp w==;
X-CSE-ConnectionGUID: SlsGPTmsQbmXa4aCUcBQHg==
X-CSE-MsgGUID: K6MEjWXnSIu3nYRntMfikA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3881021"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3881021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:59 -0800
X-CSE-ConnectionGUID: dA8G4BQYR8GF+QDZVIrCyQ==
X-CSE-MsgGUID: 5xzNfAKXRASTd1gwBN5XWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10258579"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:57 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	linux-mips@vger.kernel.org
Subject: [PATCH v4 18/20] drm/ingenic: Allow ingenic-dw-hdmi build with
 COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:15 +0200
Message-ID: <20261118214518.29317-19-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Allow DRM_INGENIC_DW_HDMI to be built with COMPILE_TEST=y for greater
coverage. The rest of the ingenic driver already allows this. Builds
fine on x86, x86_64, arm and arm64 at least.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/ingenic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
index 987ed42f6f7a..60bff9ebee5d 100644
--- a/drivers/gpu/drm/ingenic/Kconfig
+++ b/drivers/gpu/drm/ingenic/Kconfig
@@ -31,7 +31,7 @@ config DRM_INGENIC_IPU
 
 config DRM_INGENIC_DW_HDMI
 	tristate "Ingenic specific support for Synopsys DW HDMI"
-	depends on MACH_JZ4780
+	depends on MACH_JZ4780 || COMPILE_TEST
 	select DRM_DW_HDMI
 	help
 	  Choose this option to enable Synopsys DesignWare HDMI based driver.
-- 
2.56.0

