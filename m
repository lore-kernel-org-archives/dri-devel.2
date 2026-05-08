Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6A4CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE0A10F3D0;
	Fri,  8 May 2026 08:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mJACxvEx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C357410F3D0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778227368; x=1809763368;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mAlJiO7kF8KNPcH09DS3MXpdHnM7Sne5b9NuZHcS3oI=;
 b=mJACxvExVs4JjfLSEtqbqfkUmxXIhHAocRuM69mwYN7+wB0a9BrzB0Si
 i0jjJahwfmxX++FFgnsmQs74Y9i1m/sIyaXcgB+FaT/QnXkO2At2aQfVl
 3eKRPdWI+HWR3+0ygSnDYvvnQvVz+Z9fgZnHaKaa3SBYSGoE0+acdJ+kC
 VcjKIj4bI2QOiQ64zVS6m52SvsBO/BipcU52bclbNlmfoKoB6E5zPsHIT
 6Vy/z34ah2NGIrD3LFq/9TnVFVVKKwwAWrCF7NBD2cf3EvyoEpkf/1Mo4
 q01XeDuc70vkXGr5TKYVGoN2BPq2kLbKPeNX4pifIm1MzXW9KTu8CHFky Q==;
X-CSE-ConnectionGUID: mf25sZ+LTOivgLiV9wG3mA==
X-CSE-MsgGUID: Hz0LCcOfTs+BendG9LxIlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78337326"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="78337326"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 01:02:47 -0700
X-CSE-ConnectionGUID: T0ZtUn8PQwCwCTUPLBiCWg==
X-CSE-MsgGUID: /s5BPRZPQwySOJ/wjwT7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="274819509"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa001.jf.intel.com with ESMTP; 08 May 2026 01:02:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 68CF498; Fri, 08 May 2026 10:02:44 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/repaper: simplify with spi_get_device_match_data()
Date: Fri,  8 May 2026 10:02:43 +0200
Message-ID: <20260508080243.1144046-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/tiny/repaper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..a05b81992d47 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -941,24 +941,14 @@ MODULE_DEVICE_TABLE(spi, repaper_id);
 static int repaper_probe(struct spi_device *spi)
 {
 	const struct drm_display_mode *mode;
-	const struct spi_device_id *spi_id;
 	struct device *dev = &spi->dev;
 	enum repaper_model model;
 	const char *thermal_zone;
 	struct repaper_epd *epd;
 	size_t line_buffer_size;
 	struct drm_device *drm;
-	const void *match;
 	int ret;
 
-	match = device_get_match_data(dev);
-	if (match) {
-		model = (enum repaper_model)(uintptr_t)match;
-	} else {
-		spi_id = spi_get_device_id(spi);
-		model = (enum repaper_model)spi_id->driver_data;
-	}
-
 	/* The SPI device is used to allocate dma memory */
 	if (!dev->coherent_dma_mask) {
 		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -1023,6 +1013,7 @@ static int repaper_probe(struct spi_device *spi)
 		}
 	}
 
+	model = (enum repaper_model)(uintptr_t)spi_get_device_match_data(dev);
 	switch (model) {
 	case E1144CS021:
 		mode = &repaper_e1144cs021_mode;
-- 
2.50.1

