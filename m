Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F94CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E50B10EF5D;
	Mon, 12 Oct 2026 08:38:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5705810EF52
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794298; x=1823330298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UEJ5c6Lsjx+kBBdnp3DbCk3HEz5MDeLpwil4rqeau1g=;
 b=ePx7ZUGGNACOPd5pW9LPMig95WKVgq+w9TU8tyNAZ4lG3s5zbnQM6dqD
 tDvcBjVuzwEU26tGUsOrl5xzg2fn1j2qoUw+6z0SVfdGadLGK9NYhCalV
 v3bSAeIW/wRbC1zGKuvugZKVXrwxOWFpnQxBBi9Rtw2GPiwVZ+E8fctfX
 fIkbFgxqPVWPTEUb0Pg6xPVhWPUqAKrsLfg+YvFclcJGIOAYLHkpJleTu
 sxR5olzeJRN6QPn4rRjVyjhTH+xn+3ilg54h0qq4ROQ0JCBxSJllZficQ
 MTCpJC5U0Cm0mWlOqQ1zVQTQDPWUEKVdk2npLUZSk/M1nWiVKQtG/VdIE w==;
X-CSE-ConnectionGUID: uyYtoEXWSt+Jiv9Ou3UH+Q==
X-CSE-MsgGUID: JtgDdsYYTOi2oQrA3d9Dfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="501029"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="501029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:18 -0700
X-CSE-ConnectionGUID: PwjrFA5tSZ2cTYt0UkkD0w==
X-CSE-MsgGUID: oS/kWvUPRhehyitMmzwcPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1030774"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:17 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 5/5] accel/ivpu: Extend tile fuse config to 7 bits
Date: Mon, 12 Oct 2026 10:38:02 +0200
Message-ID: <20261012083802.2778448-6-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
References: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
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

The buttress code that reads the tile fuse register is shared by all
generations, so the register field definition should not differ between
them. Extend the TILE_CONFIG mask from [6:1] to [7:1] and use it
everywhere, instead of having a different field width per generation.

The tile count range check in tile_disable_check() depended on the
previous field width. It only logs a warning, and it would now warn on a
valid value, so drop it together with the tile count defines it used.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_btrs.c     | 7 -------
 drivers/accel/ivpu/ivpu_hw_btrs_reg.h | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index 5851d83dc36e..840983a618ca 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -45,9 +45,6 @@
 #define BTRS_MTL_TILE_FUSE_ENABLE_BOTH 0x0
 #define BTRS_MTL_TILE_SKU_BOTH         0x3630
 
-#define BTRS_LNL_TILE_MAX_NUM          6
-#define BTRS_LNL_TILE_MAX_MASK         0x3f
-
 #define WEIGHTS_DEFAULT                0xf711f711u
 #define WEIGHTS_ATS_DEFAULT            0x0000f711u
 
@@ -99,13 +96,9 @@ void ivpu_hw_btrs_freq_ratios_init(struct ivpu_device *vdev)
 
 static bool tile_disable_check(u32 config)
 {
-	/* Allowed values: 0 or one bit from range 0-5 (6 tiles) */
 	if (config == 0)
 		return true;
 
-	if (config > BIT(BTRS_LNL_TILE_MAX_NUM - 1))
-		return false;
-
 	if ((config & (config - 1)) == 0)
 		return true;
 
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs_reg.h b/drivers/accel/ivpu/ivpu_hw_btrs_reg.h
index 8e20eed15967..b9628bd9cb56 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs_reg.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs_reg.h
@@ -151,7 +151,7 @@
 
 #define VPU_HW_BTRS_LNL_TILE_FUSE				0x00000150u
 #define VPU_HW_BTRS_LNL_TILE_FUSE_VALID_MASK			BIT_MASK(0)
-#define VPU_HW_BTRS_LNL_TILE_FUSE_CONFIG_MASK			GENMASK(6, 1)
+#define VPU_HW_BTRS_LNL_TILE_FUSE_CONFIG_MASK			GENMASK(7, 1)
 
 #define VPU_HW_BTRS_LNL_VPU_STATUS				0x00000154u
 #define VPU_HW_BTRS_LNL_VPU_STATUS_READY_MASK			BIT_MASK(0)
-- 
2.43.0

