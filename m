Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696F606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M4yz/d21
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A4C11204F;
	Wed, 18 Nov 2026 21:46:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D0111201C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038372; x=1826574372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81vtE4tZdGnnawpHpAcbidRRevOgtNiLQnOzenCz2mI=;
 b=M4yz/d2116E0rmEBpZjCg4uF4zPrthpjDSMVjbGxUkXRN4vsyMdPmx1S
 Rlssyn20PNw3ZcteChZDCyaV0YWPw/No5bb30z9StUyw9LCd/wTDMy/fF
 Ry6P3b2FG5HwfXqoC8mo8JM0yyjcHtSd2g9yq4VNfPtDVF/P0gy8zFMGi
 cyL7ZckxsOCfVVwu/siX5CC+Yl+EGxuv74CoUslKuySRGQ0G/oUKezZSu
 CiGxwa1bg2vMvecAlt36Dxt47NCzpbk2vrhQwvuR3wGuoy8KgAR8uauER
 3UzTklgu3QtXeNTdAGLuvEbEmxr1R2WNKaxKxYUxWrW64ZmK/Fxzqa54l A==;
X-CSE-ConnectionGUID: jQ6HapaiQQ+EI2CuOcj95A==
X-CSE-MsgGUID: w5vBHz5eQhG5i2yYPAy2kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3758178"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3758178"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:12 -0800
X-CSE-ConnectionGUID: u8YU7pPSTl27NnPRgnswjA==
X-CSE-MsgGUID: wrlROdWWQIaiKbQBMXcFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10647109"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:12 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 09/20] drm/armada: Allow build with COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:06 +0200
Message-ID: <20261118214518.29317-10-ville.syrjala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Allow armada to be built with COMPILE_TEST=y for greater coverage.
Builds fine on x86, x86_64, arm and arm64 at least.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/armada/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
index b22c891a670b..1376337548da 100644
--- a/drivers/gpu/drm/armada/Kconfig
+++ b/drivers/gpu/drm/armada/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_ARMADA
 	tristate "DRM support for Marvell Armada SoCs"
-	depends on DRM && HAVE_CLK && ARM && MMU
+	depends on DRM && HAVE_CLK && MMU && (ARM || COMPILE_TEST)
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
-- 
2.56.0

